Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F517AD2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjIYIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIYIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:12:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA983121;
        Mon, 25 Sep 2023 01:11:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5C2DA7;
        Mon, 25 Sep 2023 01:12:31 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3B753F5A1;
        Mon, 25 Sep 2023 01:11:50 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 15/18] PM: EM: Adjust performance with runtime modification callback
Date:   Mon, 25 Sep 2023 09:11:36 +0100
Message-Id: <20230925081139.1305766-16-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance value may be modified at runtime together with the
power value for each OPP. They both would form a different power
and performance profile in the EM. Modify the callback interface
to make this possible.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 24 +++++++++++++++---------
 kernel/power/energy_model.c  |  7 ++++---
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 37fc8490709d..65a8794d1565 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -174,24 +174,29 @@ struct em_data_callback {
 			unsigned long *cost);
 
 	/**
-	 * update_power() - Provide new power at the given performance state of
-	 *		a device
+	 * update_power_perf() - Provide new power and performance at the given
+	 *		performance state of a device
 	 * @dev		: Device for which we do this operation (can be a CPU)
 	 * @freq	: Frequency at the performance state in kHz
 	 * @power	: New power value at the performance state
 	 *		(modified)
+	 * @perf	: New performance value at the performance state
+	 *		(modified)
 	 * @priv	: Pointer to private data useful for tracking context
 	 *		during runtime modifications of EM.
 	 *
-	 * The update_power() is used by runtime modifiable EM. It aims to
-	 * provide updated power value for a given frequency, which is stored
-	 * in the performance state. The power value provided by this callback
-	 * should fit in the [0, EM_MAX_POWER] range.
+	 * The update_power_perf() is used by runtime modifiable EM. It aims to
+	 * provide updated power and performance value for a given frequency,
+	 * which is stored in the performance state. The power value provided
+	 * by this callback should fit in the [0, EM_MAX_POWER] range. The
+	 * performance value should be lower or equal to the CPU max capacity
+	 * (1024).
 	 *
 	 * Return 0 on success, or appropriate error value in case of failure.
 	 */
-	int (*update_power)(struct device *dev, unsigned long freq,
-			    unsigned long *power, void *priv);
+	int (*update_power_perf)(struct device *dev, unsigned long freq,
+				 unsigned long *power, unsigned long *perf,
+				 void *priv);
 };
 #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)	\
@@ -199,7 +204,8 @@ struct em_data_callback {
 	  .get_cost = _cost_cb }
 #define EM_DATA_CB(_active_power_cb)			\
 		EM_ADV_DATA_CB(_active_power_cb, NULL)
-#define EM_UPDATE_CB(_update_power_cb) { .update_power = &_update_power_cb }
+#define EM_UPDATE_CB(_update_pwr_perf_cb)		\
+	{ .update_power_perf = &_update_pwr_perf_cb }
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index c7ad42b42c46..17a59a7717f7 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -217,11 +217,11 @@ int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
 			      void *priv)
 {
 	struct em_perf_table *runtime_table;
-	unsigned long power, freq;
+	unsigned long power, freq, perf;
 	struct em_perf_domain *pd;
 	int ret, i;
 
-	if (!cb || !cb->update_power)
+	if (!cb || !cb->update_power_perf)
 		return -EINVAL;
 
 	/*
@@ -262,13 +262,14 @@ int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
 		 * Call driver callback to get a new power value for
 		 * a given frequency.
 		 */
-		ret = cb->update_power(dev, freq, &power, priv);
+		ret = cb->update_power_perf(dev, freq, &power, &perf, priv);
 		if (ret) {
 			dev_dbg(dev, "EM: runtime update error: %d\n", ret);
 			goto free_runtime_state_table;
 		}
 
 		runtime_table->state[i].power = power;
+		runtime_table->state[i].performance = perf;
 	}
 
 	ret = em_compute_costs(dev, runtime_table->state, cb,
-- 
2.25.1

