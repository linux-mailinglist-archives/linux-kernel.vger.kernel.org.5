Return-Path: <linux-kernel+bounces-28786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79440830306
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F041C20AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E520325;
	Wed, 17 Jan 2024 09:56:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49488200DE;
	Wed, 17 Jan 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485408; cv=none; b=VtuV9Ll3pIcVxzx+9+9KSYTHzhAkhm8cEsEOhGbLvoNma673yuIejENXijhQ9M34FikOQIy2iqzAU3AMpiaYlY47YQdsBylrsZhCQ1d2RiUB5dmsp5iLIVbrI1afjj5y42EgzyNyoCfY/mxLEU/mhc8KKkkGOVnj9kge/fX1XnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485408; c=relaxed/simple;
	bh=R+EU2GY58M/j/ii4vNcgfNYGRUEyBnU6e2Oit2pqrKM=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=NWaYQQvpQKBupWIfDlk9eJy4aXRMcGHXes14Bf2SL4b8cnKxzqEPgR0mtsHySyR41g/7+H8QcwiXJ1DQzd1L5MFk2bprlG9nXpKGMUVRN3uExolItMzmbcqohGosKpORjeCCs2jhMX+cOeKP0Ns4CE20VWn90zwKaS+e6PgpQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E04AEDA7;
	Wed, 17 Jan 2024 01:57:31 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A4F23F5A1;
	Wed, 17 Jan 2024 01:56:42 -0800 (PST)
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
Subject: [PATCH v7 16/23] powercap/dtpm_cpu: Use new Energy Model interface to get table
Date: Wed, 17 Jan 2024 09:57:07 +0000
Message-Id: <20240117095714.1524808-17-lukasz.luba@arm.com>
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
values. Use the new EM table API which is protected with RCU. Align the
code so that this RCU read section is short.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c | 39 +++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9193c3b8edeb..ee0d1aa3e023 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -42,6 +42,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
+	struct em_perf_state *table;
 	struct cpumask cpus;
 	unsigned long freq;
 	u64 power;
@@ -50,20 +51,22 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		power = pd->table[i].power * nr_cpus;
+		power = table[i].power * nr_cpus;
 
 		if (power > power_limit)
 			break;
 	}
 
-	freq = pd->table[i - 1].frequency;
+	freq = table[i - 1].frequency;
+	power_limit = table[i - 1].power * nr_cpus;
+	rcu_read_unlock();
 
 	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power * nr_cpus;
-
 	return power_limit;
 }
 
@@ -87,9 +90,11 @@ static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
+	struct em_perf_state *table;
 	struct em_perf_domain *pd;
 	struct cpumask *pd_mask;
 	unsigned long freq;
+	u64 power = 0;
 	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
@@ -98,33 +103,43 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		if (pd->table[i].frequency < freq)
+		if (table[i].frequency < freq)
 			continue;
 
-		return scale_pd_power_uw(pd_mask, pd->table[i].power);
+		power = scale_pd_power_uw(pd_mask, table[i].power);
+		break;
 	}
+	rcu_read_unlock();
 
-	return 0;
+	return power;
 }
 
 static int update_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
+	struct em_perf_state *table;
 	struct cpumask cpus;
 	int nr_cpus;
 
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
-	dtpm->power_min = em->table[0].power;
+	rcu_read_lock();
+	table = em_perf_state_from_pd(em);
+
+	dtpm->power_min = table[0].power;
 	dtpm->power_min *= nr_cpus;
 
-	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
+	dtpm->power_max = table[em->nr_perf_states - 1].power;
 	dtpm->power_max *= nr_cpus;
 
+	rcu_read_unlock();
+
 	return 0;
 }
 
@@ -180,6 +195,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
+	struct em_perf_state *table;
 	struct em_perf_domain *pd;
 	char name[CPUFREQ_NAME_LEN];
 	int ret = -ENOMEM;
@@ -216,9 +232,12 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
-				   pd->table[pd->nr_perf_states - 1].frequency);
+				   table[pd->nr_perf_states - 1].frequency);
+	rcu_read_unlock();
 	if (ret)
 		goto out_dtpm_unregister;
 
-- 
2.25.1


