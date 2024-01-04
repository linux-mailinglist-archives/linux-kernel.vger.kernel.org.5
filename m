Return-Path: <linux-kernel+bounces-17022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1310824741
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913FBB20A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E358328B6;
	Thu,  4 Jan 2024 17:15:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B26321BF;
	Thu,  4 Jan 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5EEC1007;
	Thu,  4 Jan 2024 09:16:25 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D6CE3F64C;
	Thu,  4 Jan 2024 09:15:37 -0800 (PST)
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
Subject: [PATCH v6 18/23] drivers/thermal/cpufreq_cooling: Use new Energy Model interface
Date: Thu,  4 Jan 2024 17:15:48 +0000
Message-Id: <20240104171553.2080674-19-lukasz.luba@arm.com>
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
 drivers/thermal/cpufreq_cooling.c | 40 ++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e2cc7bd30862..c32d8dfa4fff 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -91,12 +91,15 @@ struct cpufreq_cooling_device {
 static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 			       unsigned int freq)
 {
+	struct em_perf_state *table;
 	int i;
 
+	table = em_get_table(cpufreq_cdev->em);
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
-		if (freq > cpufreq_cdev->em->table[i].frequency)
+		if (freq > table[i].frequency)
 			break;
 	}
+	em_put_table();
 
 	return cpufreq_cdev->max_level - i - 1;
 }
@@ -104,16 +107,19 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 freq)
 {
+	struct em_perf_state *table;
 	unsigned long power_mw;
 	int i;
 
+	table = em_get_table(cpufreq_cdev->em);
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
-		if (freq > cpufreq_cdev->em->table[i].frequency)
+		if (freq > table[i].frequency)
 			break;
 	}
 
-	power_mw = cpufreq_cdev->em->table[i + 1].power;
+	power_mw = table[i + 1].power;
 	power_mw /= MICROWATT_PER_MILLIWATT;
+	em_put_table();
 
 	return power_mw;
 }
@@ -121,18 +127,23 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 power)
 {
+	struct em_perf_state *table;
 	unsigned long em_power_mw;
+	u32 freq;
 	int i;
 
+	table = em_get_table(cpufreq_cdev->em);
 	for (i = cpufreq_cdev->max_level; i > 0; i--) {
 		/* Convert EM power to milli-Watts to make safe comparison */
-		em_power_mw = cpufreq_cdev->em->table[i].power;
+		em_power_mw = table[i].power;
 		em_power_mw /= MICROWATT_PER_MILLIWATT;
 		if (power >= em_power_mw)
 			break;
 	}
+	freq = table[i].frequency;
+	em_put_table();
 
-	return cpufreq_cdev->em->table[i].frequency;
+	return freq;
 }
 
 /**
@@ -262,8 +273,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
 {
-	unsigned int freq, num_cpus, idx;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	unsigned int freq, num_cpus, idx;
+	struct em_perf_state *table;
 
 	/* Request state should be less than max_level */
 	if (state > cpufreq_cdev->max_level)
@@ -272,7 +284,11 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
 	idx = cpufreq_cdev->max_level - state;
-	freq = cpufreq_cdev->em->table[idx].frequency;
+
+	table = em_get_table(cpufreq_cdev->em);
+	freq = table[idx].frequency;
+	em_put_table();
+
 	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 
 	return 0;
@@ -378,8 +394,16 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	/* Use the Energy Model table if available */
 	if (cpufreq_cdev->em) {
+		struct em_perf_state *table;
+		unsigned int freq;
+
 		idx = cpufreq_cdev->max_level - state;
-		return cpufreq_cdev->em->table[idx].frequency;
+
+		table = em_get_table(cpufreq_cdev->em);
+		freq = table[idx].frequency;
+		em_put_table();
+
+		return freq;
 	}
 #endif
 
-- 
2.25.1


