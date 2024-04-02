Return-Path: <linux-kernel+bounces-127807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C70895139
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C16128674E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE477F2C;
	Tue,  2 Apr 2024 10:58:54 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8F612E1;
	Tue,  2 Apr 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055533; cv=none; b=OKIGEzM+GNlF0ajmfXapWjvtMiwfanCsEDeD628r52OWbO4bm6djhiN8LfZVv95TEiRs6GhrPMnaNBb/IyXpjNB15WElBzQ1bQXZPblpoYDQlicFfjguSw9DNDkmoAZBCo9OanmeNCq5A4LeZ689E0jCqE+JorDHGxorkUn55E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055533; c=relaxed/simple;
	bh=ShsobMlYFwfwHqa29pcXbmIcP14z7/wd2QAvOg8eylM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtXC6OgNg7exTU0TW2cdygT3xsnrW44GUSSKtXdw0YoLz7XMx61VQBN+fA1Jhu5ze3KTIyFxEkpa6gxowV4lGslnjbOwub/GcFdMcAoKMITIb6YrIcY+8Oc1gDvmVRWZv1xRfSuXC22ScODS2fWpKcng0NABWpKG7saCz/2irpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz7t1712055482t8hhr29
X-QQ-Originating-IP: AIcr+JMMiHNAe9ivs3l6hnjCuJ93m5xNH9hw9O48loQ=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:58:00 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3jDSki7LRBGbMl6eVjhJrP7hy+2d57Zwz9+hkzPLSG00e+1ByNRJ
	xCUqV/VaOH9XPhyMNY6fXwGTZkOUIOF7FwM9vxUNJTyzeHF+BJ7JjtJ443q4nZzWvAFRe89
	5q6ewnYehc0YZfYalerNRGY19Re1KFcJ7z2BrSuBDEWvqVKiYyr9CNnhDeTfnKq142ZVAHv
	4C9u0f5MohXsc3rTyWoYZlXRKC7yJWlyqUJgSxEN5ardzQSwc7WjJ3VtJhXemJzTDWqbQRW
	6yCjzYBZrAzM1dAY6tOfZLAeBxOAc6O+3d4Y6rB6KRcldI1/Kr9C4a6CtRV9ABWwdGc57D5
	Wihf/pxeEVr5f4qy20Gqh7kF2Ekt1q9Pkg3Ke/b+VumTe+eyU93WGAXd8BBtzTbChLjA4b9
	+bVJTMCVliEvQxnRyGxyWA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17135480200508921622
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 9/9] perf/thunder_x2: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:10 +0800
Message-Id: <20240402105610.1695644-10-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240402105610.1695644-1-dawei.li@shingroup.cn>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config- neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/thunderx2_pmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index e16d10c763de..8a02a4533b32 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -932,9 +932,9 @@ static int tx2_uncore_pmu_online_cpu(unsigned int cpu,
 static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 		struct hlist_node *hpnode)
 {
-	int new_cpu;
+	cpumask_var_t cpu_online_mask_temp;
 	struct tx2_uncore_pmu *tx2_pmu;
-	struct cpumask cpu_online_mask_temp;
+	int new_cpu;
 
 	tx2_pmu = hlist_entry_safe(hpnode,
 			struct tx2_uncore_pmu, hpnode);
@@ -945,17 +945,21 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 	if (tx2_pmu->hrtimer_callback)
 		hrtimer_cancel(&tx2_pmu->hrtimer);
 
-	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
-	new_cpu = cpumask_any_and(
-			cpumask_of_node(tx2_pmu->node),
-			&cpu_online_mask_temp);
+	if (!alloc_cpumask_var(&cpu_online_mask_temp, GFP_KERNEL))
+		return 0;
+
+	cpumask_copy(cpu_online_mask_temp, cpu_online_mask);
+	cpumask_clear_cpu(cpu, cpu_online_mask_temp);
+	new_cpu = cpumask_any_and(cpumask_of_node(tx2_pmu->node),
+				  cpu_online_mask_temp);
 
 	tx2_pmu->cpu = new_cpu;
 	if (new_cpu >= nr_cpu_ids)
-		return 0;
+		goto __free_cpumask;
 	perf_pmu_migrate_context(&tx2_pmu->pmu, cpu, new_cpu);
 
+__free_cpumask:
+	free_cpumask_var(cpu_online_mask_temp);
 	return 0;
 }
 
-- 
2.27.0


