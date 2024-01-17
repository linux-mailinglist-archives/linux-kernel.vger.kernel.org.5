Return-Path: <linux-kernel+bounces-28773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034C8302E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2247286FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999E1CF90;
	Wed, 17 Jan 2024 09:56:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A7D1BF31;
	Wed, 17 Jan 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485367; cv=none; b=aghV5UU97222RDWACjsXtyYNGJa9sxg8ooVRToODNVFSe89IPtTn1dgQVrLD7gTAcTBe5H91uKQxjD3iXLBWo54b2uO+N+dCWdj0n1jVO5oCQcH0YOOZ1YXE49R1svOBuRuA7F0zSCVX4hZOcUz+bW1bRT1yCzFm7tX/o87KvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485367; c=relaxed/simple;
	bh=F95ZfpYEK24miPqt4g6SQTKtaEf9bFaTmeWUelc2lTo=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=KyevuwI5bZMk1or8LpeqNJJGOVLHyz631RzkFlzb0GiiLzQe56VOATW82QKaCX9+XqBbXqaK+mpIqEFDDp8JOEgca6orbLnRU0CKSHZxY7Eb/dLapq5gnCPnq8T2soU4wS4RaYbYp4E5aTfXVehchgCEMZ18/ZXq7cPnUpKEim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114E3DA7;
	Wed, 17 Jan 2024 01:56:52 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AC273F5A1;
	Wed, 17 Jan 2024 01:56:03 -0800 (PST)
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
Subject: [PATCH v7 03/23] PM: EM: Find first CPU active while updating OPP efficiency
Date: Wed, 17 Jan 2024 09:56:54 +0000
Message-Id: <20240117095714.1524808-4-lukasz.luba@arm.com>
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

The Energy Model might be updated at runtime and the energy efficiency
for each OPP may change. Thus, there is a need to update also the
cpufreq framework and make it aligned to the new values. In order to
do that, use a first active CPU from the Performance Domain. This is
needed since the first CPU in the cpumask might be offline when we
run this code path.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 42486674b834..aa7c89f9e115 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 	struct em_perf_domain *pd = dev->em_pd;
 	struct cpufreq_policy *policy;
 	int found = 0;
-	int i;
+	int i, cpu;
 
 	if (!_is_cpu_device(dev) || !pd)
 		return;
 
-	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
+	/* Try to get a CPU which is active and in this PD */
+	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
+	if (cpu >= nr_cpu_ids) {
+		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
+		return;
+	}
+
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy) {
 		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
 		return;
-- 
2.25.1


