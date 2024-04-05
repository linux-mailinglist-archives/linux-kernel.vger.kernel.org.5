Return-Path: <linux-kernel+bounces-133070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4978899E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA77B23025
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1B16DEA1;
	Fri,  5 Apr 2024 13:33:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAEF16D9BB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324026; cv=none; b=UdmjxZy79u4jERGKZq72x0kpX8C2i4JpgsFx1YNkshIaWt0oGcOLCjQePJ5CermPylotlNiLgSLkTcTUQEJJQHyzUTKKLr0tcZejSVVnqvxH8ADt9Ms3MuhHdql2FWICYkeVdn85U2UpJFhqTnkdGt2ObyMob9oDCjA7pVAmtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324026; c=relaxed/simple;
	bh=kz+tEnMtEhdbWTieH6GG8+9bRVOB65r+zQVMDMg3TnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbtvZY4PX+oz9Ay3GZliPzoytDFYOesdimqMiXLZ1ACp4PxHcTUbdo2N4tgtMszFQ2im92wcsWmStog1qDhHlPOxv0ZrXxXDjzYymCokrasoLOMDJfeq3wlfgCpNp2XSJVFRDyBCfjfWaIKulO0wRFPcjfXRZH9LNlpRyPllksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161BB169E;
	Fri,  5 Apr 2024 06:34:15 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B3983F7B4;
	Fri,  5 Apr 2024 06:33:42 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com
Cc: sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: [PATCH v4 3/4] arm64: Update AMU-based frequency scale factor on entering idle
Date: Fri,  5 Apr 2024 14:33:18 +0100
Message-Id: <20240405133319.859813-4-beata.michalska@arm.com>
In-Reply-To: <20240405133319.859813-1-beata.michalska@arm.com>
References: <20240405133319.859813-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the frequency scale factor has been activated for retrieving
current frequency on a given CPU, trigger its update upon entering
idle. This will, to an extent, allow querying last known frequency
in a non-invasive way. It will also improve the frequency scale factor
accuracy when a CPU entering idle did not receive a tick for a while.
As a consequence, for idle cores, the reported frequency will be the
last one observed before entering the idle state.

Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b03fe8617721..f204f6489f98 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -207,6 +207,19 @@ static struct scale_freq_data amu_sfd = {
 	.set_freq_scale = amu_scale_freq_tick,
 };
 
+void arch_cpu_idle_enter(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
+		return;
+
+	/* Kick in AMU update but only if one has not happened already */
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
+	    time_is_before_jiffies(per_cpu(cpu_amu_samples.last_update, cpu)))
+		amu_scale_freq_tick();
+}
+
 #define AMU_SAMPLE_EXP_MS	20
 
 unsigned int arch_freq_get_on_cpu(int cpu)
@@ -232,8 +245,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * this boils down to identifying an active cpu within the same freq
 	 * domain, if any.
 	 */
-	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
-	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) || (!idle_cpu(cpu) &&
+	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))) {
 		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 		int ref_cpu = cpu;
 
-- 
2.25.1


