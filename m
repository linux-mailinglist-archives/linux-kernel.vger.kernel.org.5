Return-Path: <linux-kernel+bounces-99955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461A878FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753E8B218F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7C7826F;
	Tue, 12 Mar 2024 08:35:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44377F2F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232514; cv=none; b=l2lQ2F9udIDpM2o2azIcApy/wAA8olKJ8ETufvYuRBaSuw9Yb4OuBvs7XvzHvq8dUtHxHTSpj5SXenoSs/NQQbd4awF9F8sIuwMUSszYBIrCDUUv/RFgxRCufwJTxFdg1qMk8eQKVUmrIuupJM7bRzSgI2ESWbx81+9q1QlOAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232514; c=relaxed/simple;
	bh=obNxM+jdCswBMQq3mcAD9vZ6SCw4b+ZDqGiuc200Y2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcH6zcOfGYDzq6ymC0rUVxonSuIG6WlJg3GAiFnU6BM9JDsxItNx1d2lN/CEwBpY7Yxql3tIk0JNAN6yvSdfRtOJbKck4ZwHFNUsXrFnrEr2MuI7REM4gyIus4DyEhD9GwvpBfDV7lvbWkaGWcXjrjIFnOWAPW0C8M8GedaoYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE8515A1;
	Tue, 12 Mar 2024 01:35:49 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54A093F73F;
	Tue, 12 Mar 2024 01:35:10 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64: Update AMU-based frequency scale factor on entering idle
Date: Tue, 12 Mar 2024 08:34:31 +0000
Message-Id: <20240312083431.3239989-4-beata.michalska@arm.com>
In-Reply-To: <20240312083431.3239989-1-beata.michalska@arm.com>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
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

Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 42cb19c31719..77c6ac577cef 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -215,6 +215,18 @@ static struct scale_freq_data amu_sfd = {
 	.set_freq_scale = amu_scale_freq_tick,
 };
 
+void arch_cpu_idle_enter(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
+		return;
+
+	/* Kick in AMU update but only if one has not happned already */
+	if (time_is_before_jiffies(per_cpu(cpu_amu_samples.last_update, cpu)))
+		amu_scale_freq_tick();
+}
+
 #define AMU_SAMPLE_EXP_MS	20
 
 unsigned int arch_freq_get_on_cpu(int cpu)
@@ -242,7 +254,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * try an alternative source for the counters (and thus freq scale),
 	 * if available for given policy
 	 */
-	if (time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
+	if (!idle_cpu(cpu) &&
+	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
 		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 		int ref_cpu = nr_cpu_ids;
 
-- 
2.25.1


