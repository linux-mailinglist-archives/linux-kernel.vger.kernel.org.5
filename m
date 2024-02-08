Return-Path: <linux-kernel+bounces-58012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF084E038
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1601F2D02A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522C7E595;
	Thu,  8 Feb 2024 11:57:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F87E568;
	Thu,  8 Feb 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393422; cv=none; b=ijaxbsgvpG6m29QBj7BCwwLgEmOqdLEeAhXHUP9qMP7MUpPV2JOFbYHvbn/KzIKIk99ygNPghqQfMVjEmRsDj8icFc62u6L1ijohgkDjHvTBpNUOLd3MZZizHZwCNDqYwT+Qt9nd2lfTC+Um66FPzAsikGhFOWa/JeonLZ8Wm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393422; c=relaxed/simple;
	bh=dnosOVP4e99Yo+cDanGIs3VtsbRgfhA+nmQCzHbYbTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZprnhXRwdacpqXhc375PvUuGhm7VAQ0gwn6GMAQ08yYNYdu4gcVcRPp15Xm6catG/bH/SDMMEBXaDnTXfi0uptE35580K/E69Ek4l32EupOZn+cL7Lve+Y8ArBfzls92neUrZY8aYNhhRDACrUwuo/+qYPMsKawhwlr3p3z6Ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C440D1FB;
	Thu,  8 Feb 2024 03:57:41 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E57F63F5A1;
	Thu,  8 Feb 2024 03:56:56 -0800 (PST)
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
Subject: [PATCH v8 18/23] drivers/thermal/cpufreq_cooling: Use new Energy Model interface
Date: Thu,  8 Feb 2024 11:55:52 +0000
Message-Id: <20240208115557.1273962-19-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
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

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 45 +++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e2cc7bd30862..9d1b1459700d 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -91,12 +91,16 @@ struct cpufreq_cooling_device {
 static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 			       unsigned int freq)
 {
+	struct em_perf_state *table;
 	int i;
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(cpufreq_cdev->em);
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
-		if (freq > cpufreq_cdev->em->table[i].frequency)
+		if (freq > table[i].frequency)
 			break;
 	}
+	rcu_read_unlock();
 
 	return cpufreq_cdev->max_level - i - 1;
 }
@@ -104,16 +108,20 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 freq)
 {
+	struct em_perf_state *table;
 	unsigned long power_mw;
 	int i;
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(cpufreq_cdev->em);
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
-		if (freq > cpufreq_cdev->em->table[i].frequency)
+		if (freq > table[i].frequency)
 			break;
 	}
 
-	power_mw = cpufreq_cdev->em->table[i + 1].power;
+	power_mw = table[i + 1].power;
 	power_mw /= MICROWATT_PER_MILLIWATT;
+	rcu_read_unlock();
 
 	return power_mw;
 }
@@ -121,18 +129,24 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 power)
 {
+	struct em_perf_state *table;
 	unsigned long em_power_mw;
+	u32 freq;
 	int i;
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(cpufreq_cdev->em);
 	for (i = cpufreq_cdev->max_level; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
-		em_power_mw = cpufreq_cdev->em->table[i].power;
+		em_power_mw = table[i].power;
 		em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (power >= em_power_mw)
 			break;
 	}
+	freq = table[i].frequency;
+	rcu_read_unlock();
 
-	return cpufreq_cdev->em->table[i].frequency;
+	return freq;
 }
 
 /**
@@ -262,8 +276,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
 {
-	unsigned int freq, num_cpus, idx;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	unsigned int freq, num_cpus, idx;
+	struct em_perf_state *table;
 
 	/* Request state should be less than max_level */
 	if (state > cpufreq_cdev->max_level)
@@ -272,7 +287,12 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
 	idx = cpufreq_cdev->max_level - state;
-	freq = cpufreq_cdev->em->table[idx].frequency;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(cpufreq_cdev->em);
+	freq = table[idx].frequency;
+	rcu_read_unlock();
+
 	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 
 	return 0;
@@ -378,8 +398,17 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	/* Use the Energy Model table if available */
 	if (cpufreq_cdev->em) {
+		struct em_perf_state *table;
+		unsigned int freq;
+
 		idx = cpufreq_cdev->max_level - state;
-		return cpufreq_cdev->em->table[idx].frequency;
+
+		rcu_read_lock();
+		table = em_perf_state_from_pd(cpufreq_cdev->em);
+		freq = table[idx].frequency;
+		rcu_read_unlock();
+
+		return freq;
 	}
 #endif
 
-- 
2.25.1


