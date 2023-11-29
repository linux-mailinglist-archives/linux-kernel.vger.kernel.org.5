Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822907FD52C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjK2LLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjK2LKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:10:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5031E1FE1;
        Wed, 29 Nov 2023 03:09:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F6E2F4;
        Wed, 29 Nov 2023 03:09:48 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E0913F5A1;
        Wed, 29 Nov 2023 03:08:58 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 22/23] PM: EM: Add em_dev_compute_costs() as API for device drivers
Date:   Wed, 29 Nov 2023 11:08:52 +0000
Message-Id: <20231129110853.94344-23-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device drivers can modify EM at runtime by providing a new EM table.
The EM is used by the EAS and the em_perf_state::cost stores
pre-calculated value to avoid overhead. This patch provides the API for
device drivers to calculate the cost values properly (and not duplicate
the same code).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 ++++++++
 kernel/power/energy_model.c  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 9c47388482a0..836622b1a0a1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -170,6 +170,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
 void em_free_table(struct em_perf_table __rcu *table);
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -355,6 +357,12 @@ static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
 	return NULL;
 }
 static inline void em_put_table(void) {}
+static inline
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 234823c0e59d..fadfdefbe5f0 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -286,6 +286,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
+/**
+ * em_dev_compute_costs() - Calculate cost values for new runtime EM table
+ * @dev		: Device for which the EM table is to be updated
+ * @table	: The new EM table that is going to get the costs calculated
+ *
+ * Calculate the em_perf_state::cost values for new runtime EM table. The
+ * values are used for EAS during task placement. It also calculates and sets
+ * the efficiency flag for each performance state. When the function finish
+ * successfully the EM table is ready to be updated and used by EAS.
+ *
+ * Return 0 on success or a proper error in case of failure.
+ */
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return em_compute_costs(dev, table, NULL, nr_states, 0);
+}
+
 /**
  * em_dev_update_perf_domain() - Update runtime EM table for a device
  * @dev		: Device for which the EM is to be updated
-- 
2.25.1

