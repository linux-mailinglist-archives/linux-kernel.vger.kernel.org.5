Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECD77FD521
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjK2LKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjK2LJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:09:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4611B2712;
        Wed, 29 Nov 2023 03:08:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32BE62F4;
        Wed, 29 Nov 2023 03:09:40 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 976813F5A1;
        Wed, 29 Nov 2023 03:08:50 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 19/23] drivers/thermal/devfreq_cooling: Use new Energy Model interface
Date:   Wed, 29 Nov 2023 11:08:49 +0000
Message-Id: <20231129110853.94344-20-lukasz.luba@arm.com>
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

Energy Model framework support modifications at runtime of the power
values. Use the new EM table API which is protected with RCU. Align the
code so that this RCU read section is short.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 43 ++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 262e62ab6cf2..b7aed5a3810e 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -87,6 +87,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
+	struct em_perf_state *table;
 	unsigned long freq;
 	int perf_idx;
 
@@ -100,7 +101,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 
 	if (dfc->em_pd) {
 		perf_idx = dfc->max_state - state;
-		freq = dfc->em_pd->table[perf_idx].frequency * 1000;
+
+		table = em_get_table(dfc->em_pd);
+		freq = table[perf_idx].frequency * 1000;
+		em_put_table();
 	} else {
 		freq = dfc->freq_table[state];
 	}
@@ -123,14 +127,20 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
  */
 static int get_perf_idx(struct em_perf_domain *em_pd, unsigned long freq)
 {
-	int i;
+	struct em_perf_state *table;
+	int i, idx = -EINVAL;
 
+	table = em_get_table(em_pd);
 	for (i = 0; i < em_pd->nr_perf_states; i++) {
-		if (em_pd->table[i].frequency == freq)
-			return i;
+		if (table[i].frequency != freq)
+			continue;
+
+		idx = i;
+		break;
 	}
+	em_put_table();
 
-	return -EINVAL;
+	return idx;
 }
 
 static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
@@ -181,6 +191,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
+	struct em_perf_state *table;
 	unsigned long state;
 	unsigned long freq;
 	unsigned long voltage;
@@ -204,7 +215,10 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 			state = dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
-			dfc->res_util = dfc->em_pd->table[state].power;
+			table = em_get_table(dfc->em_pd);
+			dfc->res_util = table[state].power;
+			em_put_table();
+
 			dfc->res_util /= MICROWATT_PER_MILLIWATT;
 
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
@@ -225,7 +239,10 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		_normalize_load(&status);
 
 		/* Convert EM power into milli-Watts first */
-		*power = dfc->em_pd->table[perf_idx].power;
+		table = em_get_table(dfc->em_pd);
+		*power = table[perf_idx].power;
+		em_put_table();
+
 		*power /= MICROWATT_PER_MILLIWATT;
 		/* Scale power for utilization */
 		*power *= status.busy_time;
@@ -245,13 +262,18 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 				       unsigned long state, u32 *power)
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
+	struct em_perf_state *table;
 	int perf_idx;
 
 	if (state > dfc->max_state)
 		return -EINVAL;
 
 	perf_idx = dfc->max_state - state;
-	*power = dfc->em_pd->table[perf_idx].power;
+
+	table = em_get_table(dfc->em_pd);
+	*power = table[perf_idx].power;
+	em_put_table();
+
 	*power /= MICROWATT_PER_MILLIWATT;
 
 	return 0;
@@ -264,6 +286,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
 	unsigned long freq, em_power_mw;
+	struct em_perf_state *table;
 	s32 est_power;
 	int i;
 
@@ -288,13 +311,15 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	 * Find the first cooling state that is within the power
 	 * budget. The EM power table is sorted ascending.
 	 */
+	table = em_get_table(dfc->em_pd);
 	for (i = dfc->max_state; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
-		em_power_mw = dfc->em_pd->table[i].power;
+		em_power_mw = table[i].power;
 		em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (est_power >= em_power_mw)
 			break;
 	}
+	em_put_table();
 
 	*state = dfc->max_state - i;
 	dfc->capped_state = *state;
-- 
2.25.1

