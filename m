Return-Path: <linux-kernel+bounces-148261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BC8A7FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7161C21668
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0EA13C3FA;
	Wed, 17 Apr 2024 09:39:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863913C3D4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346750; cv=none; b=bLhPyHQz4dKCcVB4PxgcLEzIIOeA6imbJRHmYH874wxmpvzm11Ee2OQXDobHJHRMjWlDsIaX70E4Kqc5TLBuEwPJMr6Fx+Iwhu7aU9FfgS6WcFxUQ6NIrkXeKgjJmGzozxSipSic/sSab0U645CjkH4DwoztxszCDna2N4Yab9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346750; c=relaxed/simple;
	bh=oXmgWIERdtu2ZOsYZHNdeoQxmqdBja1PnXgu2ziTMEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQgKblDFhGJz4TizfZ8hdHHQmbaQiGsy0IuyT3H/L0arE35k7LYgnomY9ykQq0wN6ZOYmmkYZcmoM0jg2Re4mAgwhHpOMg1ltI0lc3kKEPPKtNvENM2fXXs3F95r6gvX5sD5Ple6SN0KytdAljWzkK6g6gqxST45KqvORmgh00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EA7DA7;
	Wed, 17 Apr 2024 02:39:36 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A741E3F64C;
	Wed, 17 Apr 2024 02:39:06 -0700 (PDT)
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
	lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: [PATCH v5 4/5] arm64: Update AMU-based frequency scale factor on entering idle
Date: Wed, 17 Apr 2024 10:38:47 +0100
Message-Id: <20240417093848.1555462-5-beata.michalska@arm.com>
In-Reply-To: <20240417093848.1555462-1-beata.michalska@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
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
index 475fdbf3032a..3110863ee18c 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -213,6 +213,19 @@ static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
 		cpumask_test_cpu(cpu, amu_fie_cpus);
 }
 
+void arch_cpu_idle_enter(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!amu_fie_cpu_supported(cpu))
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
@@ -239,8 +252,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
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


