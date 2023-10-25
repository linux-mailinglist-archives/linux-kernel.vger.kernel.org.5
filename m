Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25DC7D66EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjJYJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJYJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:33:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37311CE;
        Wed, 25 Oct 2023 02:33:43 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SFkF46rL7z15NKS;
        Wed, 25 Oct 2023 17:30:48 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 25 Oct
 2023 17:33:39 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <broonie@kernel.org>, <joey.gouly@arm.com>, <will@kernel.org>,
        <amit.kachhap@arm.com>, <rafael@kernel.org>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <mark.rutland@arm.com>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
        <yang@os.amperecomputing.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>
Subject: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when reading its cpufreq rate
Date:   Wed, 25 Oct 2023 17:38:46 +0800
Message-ID: <20231025093847.3740104-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025093847.3740104-1-zengheng4@huawei.com>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ARM AMU's document says, all counters are subject to any changes
in clock frequency, including clock stopping caused by the WFI and WFE
instructions.

Therefore, using smp_call_on_cpu() to trigger target CPU to
read self's AMU counters, which ensures the counters are working
properly while cstate feature is enabled.

Reported-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fe08ca419b3d..321a9dc9484d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -90,6 +90,12 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
 
+struct fb_ctr_pair {
+	u32 cpu;
+	struct cppc_perf_fb_ctrs fb_ctrs_t0;
+	struct cppc_perf_fb_ctrs fb_ctrs_t1;
+};
+
 /**
  * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
  * @work: The work item.
@@ -840,9 +846,24 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 	return (reference_perf * delta_delivered) / delta_reference;
 }
 
+static int cppc_get_perf_ctrs_pair(void *val)
+{
+	struct fb_ctr_pair *fb_ctrs = val;
+	int cpu = fb_ctrs->cpu;
+	int ret;
+
+	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
+	if (ret)
+		return ret;
+
+	udelay(2); /* 2usec delay between sampling */
+
+	return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
+}
+
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	struct fb_ctr_pair fb_ctrs = { .cpu = cpu, };
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 delivered_perf;
@@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	cpufreq_cpu_put(policy);
 
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-	if (ret)
-		return 0;
-
-	udelay(2); /* 2usec delay between sampling */
+	if (cpu_has_amu_feat(cpu))
+		ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_pair,
+				      &fb_ctrs, false);
+	else
+		ret = cppc_get_perf_ctrs_pair(&fb_ctrs);
 
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
 	if (ret)
 		return 0;
 
-	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
-					       &fb_ctrs_t1);
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data,
+					      &fb_ctrs.fb_ctrs_t0,
+					      &fb_ctrs.fb_ctrs_t1);
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
-- 
2.25.1

