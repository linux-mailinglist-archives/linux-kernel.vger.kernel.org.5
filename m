Return-Path: <linux-kernel+bounces-28790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA574830310
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B6B24446
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9020DC4;
	Wed, 17 Jan 2024 09:56:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E020B0F;
	Wed, 17 Jan 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485418; cv=none; b=JHPJQKY46EbAMuAkeFbNHFZcHgPYqiQ23PZyeYN5XTtIjZkwwuSGJJBPCS6YQgqrpW/ljFA5nDJNfi9xuncWsXd2UINaxvrB4Xby91LiKttPIO2qF/CypkXUGVziNX8LVW03xGWCvFCrOJMJzFxgeT1PO/EuLq6s6L6Xv4EDMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485418; c=relaxed/simple;
	bh=5K7gISXX62HNVE1FSJeNqRKheeaXiyyvuPDJbM0dDys=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=p8QX5B7qXQkFEsvSK3X4il9/RdigyRiuKG05/Umk4RKSVNxtIGtAPmrImGIrd58AnQLAMLdih5uLxKNrPt/ZU2RHApQWTgGImkZp+2qP0OQtzrzTm9btsfH353NHr8cRE0yL1SLdF5oE0Pt3N4V/TyYWe6j5yY00pXG6qVDElaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C66DA7;
	Wed, 17 Jan 2024 01:57:42 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF8AA3F5A1;
	Wed, 17 Jan 2024 01:56:51 -0800 (PST)
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
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v7 19/23] drivers/thermal/devfreq_cooling: Use new Energy Model interface
Date: Wed, 17 Jan 2024 09:57:10 +0000
Message-Id: <20240117095714.1524808-20-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Energy Model framework support modifications at runtime of the power
values. Use the new EM table which is protected with RCU. Align the
code so that this RCU read section is short.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 49 +++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 262e62ab6cf2..50dec24e967a 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -87,6 +87,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
+	struct em_perf_state *table;
 	unsigned long freq;
 	int perf_idx;
 
@@ -100,7 +101,11 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 
 	if (dfc->em_pd) {
 		perf_idx = dfc->max_state - state;
-		freq = dfc->em_pd->table[perf_idx].frequency * 1000;
+
+		rcu_read_lock();
+		table = em_perf_state_from_pd(dfc->em_pd);
+		freq = table[perf_idx].frequency * 1000;
+		rcu_read_unlock();
 	} else {
 		freq = dfc->freq_table[state];
 	}
@@ -123,14 +128,21 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
  */
 static int get_perf_idx(struct em_perf_domain *em_pd, unsigned long freq)
 {
-	int i;
+	struct em_perf_state *table;
+	int i, idx = -EINVAL;
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(em_pd);
 	for (i = 0; i < em_pd->nr_perf_states; i++) {
-		if (em_pd->table[i].frequency == freq)
-			return i;
+		if (table[i].frequency != freq)
+			continue;
+
+		idx = i;
+		break;
 	}
+	rcu_read_unlock();
 
-	return -EINVAL;
+	return idx;
 }
 
 static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
@@ -181,6 +193,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
+	struct em_perf_state *table;
 	unsigned long state;
 	unsigned long freq;
 	unsigned long voltage;
@@ -204,7 +217,11 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 			state = dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
-			dfc->res_util = dfc->em_pd->table[state].power;
+			rcu_read_lock();
+			table = em_perf_state_from_pd(dfc->em_pd);
+			dfc->res_util = table[state].power;
+			rcu_read_unlock();
+
 			dfc->res_util /= MICROWATT_PER_MILLIWATT;
 
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
@@ -225,7 +242,11 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		_normalize_load(&status);
 
 		/* Convert EM power into milli-Watts first */
-		*power = dfc->em_pd->table[perf_idx].power;
+		rcu_read_lock();
+		table = em_perf_state_from_pd(dfc->em_pd);
+		*power = table[perf_idx].power;
+		rcu_read_unlock();
+
 		*power /= MICROWATT_PER_MILLIWATT;
 		/* Scale power for utilization */
 		*power *= status.busy_time;
@@ -245,13 +266,19 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
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
+	rcu_read_lock();
+	table = em_perf_state_from_pd(dfc->em_pd);
+	*power = table[perf_idx].power;
+	rcu_read_unlock();
+
 	*power /= MICROWATT_PER_MILLIWATT;
 
 	return 0;
@@ -264,6 +291,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
 	unsigned long freq, em_power_mw;
+	struct em_perf_state *table;
 	s32 est_power;
 	int i;
 
@@ -288,13 +316,16 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	 * Find the first cooling state that is within the power
 	 * budget. The EM power table is sorted ascending.
 	 */
+	rcu_read_lock();
+	table = em_perf_state_from_pd(dfc->em_pd);
 	for (i = dfc->max_state; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
-		em_power_mw = dfc->em_pd->table[i].power;
+		em_power_mw = table[i].power;
 		em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (est_power >= em_power_mw)
 			break;
 	}
+	rcu_read_unlock();
 
 	*state = dfc->max_state - i;
 	dfc->capped_state = *state;
-- 
2.25.1


