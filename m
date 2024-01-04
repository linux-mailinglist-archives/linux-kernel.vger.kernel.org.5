Return-Path: <linux-kernel+bounces-17023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DCD824743
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF03B2153A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D934555;
	Thu,  4 Jan 2024 17:15:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAF328CA;
	Thu,  4 Jan 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86DC153B;
	Thu,  4 Jan 2024 09:16:28 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D5393F64C;
	Thu,  4 Jan 2024 09:15:40 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com
Subject: [PATCH v6 19/23] drivers/thermal/devfreq_cooling: Use new Energy Model interface
Date: Thu,  4 Jan 2024 17:15:49 +0000
Message-Id: <20240104171553.2080674-20-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104171553.2080674-1-lukasz.luba@arm.com>
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


