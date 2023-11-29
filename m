Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85A7FD520
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjK2LKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjK2LJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:09:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E121FCE;
        Wed, 29 Nov 2023 03:08:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4CFC15;
        Wed, 29 Nov 2023 03:09:37 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA4E83F5A1;
        Wed, 29 Nov 2023 03:08:47 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 18/23] drivers/thermal/cpufreq_cooling: Use new Energy Model interface
Date:   Wed, 29 Nov 2023 11:08:48 +0000
Message-Id: <20231129110853.94344-19-lukasz.luba@arm.com>
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

