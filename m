Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C877FD515
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjK2LJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjK2LIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59BA02127;
        Wed, 29 Nov 2023 03:08:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45CA22F4;
        Wed, 29 Nov 2023 03:09:21 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADF103F5A1;
        Wed, 29 Nov 2023 03:08:31 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 12/23] PM: EM: Add helpers to read under RCU lock the EM table
Date:   Wed, 29 Nov 2023 11:08:42 +0000
Message-Id: <20231129110853.94344-13-lukasz.luba@arm.com>
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

To use the runtime modifiable EM table there is a need to use RCU
read locking properly. Add helper functions for the device drivers and
frameworks to make sure it's done properly.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 520a8c8ad849..ae3ccc8b9f44 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -341,6 +341,20 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 	return pd->nr_perf_states;
 }
 
+static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
+{
+	struct em_perf_table __rcu *runtime_table;
+
+	rcu_read_lock();
+	runtime_table = rcu_dereference(pd->runtime_table);
+	return runtime_table->state;
+}
+
+static inline void em_put_table(void)
+{
+	rcu_read_unlock();
+}
+
 #else
 struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
@@ -387,6 +401,11 @@ int em_dev_update_perf_domain(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
+{
+	return NULL;
+}
+static inline void em_put_table(void) {}
 #endif
 
 #endif
-- 
2.25.1

