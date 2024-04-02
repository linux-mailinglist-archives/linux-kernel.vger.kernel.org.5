Return-Path: <linux-kernel+bounces-127804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0972A895130
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0001C23371
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC246997A;
	Tue,  2 Apr 2024 10:58:16 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9F984A35;
	Tue,  2 Apr 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055496; cv=none; b=eXZm6GZv8U24Qa7vn+lHej4F8yck9bI0OZBJ/JZJboWz6uruv+OTY6phfdrWZQ59coMqBlnITYVNQsEhOHvO85AYb43OqT/0o0ck1/MRvss7C0rr87+wNeTuT1/Q6aHYiGp1375jyVeXINpSmc0QnhWYMtYLgJisX+WCNEwP7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055496; c=relaxed/simple;
	bh=Hp5Kotv+V9yNIc4Tg2u+vJrrmMQdftSMs1SkQH7KC+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBVg/vprAE12NBAMLPH4AzWQyE2FnMxlN+mXvbYxd4KNaoR28fSmdy2YAbCm7AWvJVmvXaTahw4OqIueDQmrFTc8Z6O56390i00OCruTIZVHC9qOIIDNCAS53RDV2y6jKnIa2dcp+/ct3+p2v9RyCC/Tl5/Xk670n86GdEY7twA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz8t1712055405t6jdpo5
X-QQ-Originating-IP: zMSS9njKLfe5qpNl4MMAMhdArcJiYg0YoFBp8ktzVXQ=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:56:43 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: /gpUuYPpeIUOZ5s4aenzg3ecAzQ5K7SRWRK0Che4X0DDJnKnqcBFQ3cHWYAn9
	cC/dPwRl0hcLzexcfoeO00x98gWN2YFe9xxEMIqqAwMtfS8gs12iNpMKdpHocr0FdLJwbcq
	+emWo5zvWekdtysQtOjjfOBqCVqCfJEKNxB7kSUUL5lvNVHQDOk5JBAOiw7Iu26y6O0B4Gb
	9DqRc22fi4nNYUaDy7fftLuAwpVhNm/7Hl5Kc7rzSsPwn/riyxIOjFFO+hPOlPUqtHgqkGy
	cfrEyy2vTIS6l3JFKTwalV/DRu7+29DUKticbHws+GMLWcAshAdfwnhqvt86apeFvFyTLCU
	UCdFTaAMhQQNh9KermXJV28Vn3+Y7NnwJK3FE37g9nkVKf413DQMY49v7TfCA57vzfc6hWk
	VLW+wSF7XBU0RP/V2c0OmQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5033886388015913016
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
Subject: [PATCH 1/9] perf/alibaba_uncore_drw: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:02 +0800
Message-Id: <20240402105610.1695644-2-dawei.li@shingroup.cn>
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
 drivers/perf/alibaba_uncore_drw_pmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index a9277dcf90ce..251f0a2dee84 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -743,25 +743,28 @@ static void ali_drw_pmu_remove(struct platform_device *pdev)
 
 static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
+	cpumask_var_t node_online_cpus;
 	struct ali_drw_pmu_irq *irq;
 	struct ali_drw_pmu *drw_pmu;
 	unsigned int target;
 	int ret;
-	cpumask_t node_online_cpus;
 
 	irq = hlist_entry_safe(node, struct ali_drw_pmu_irq, node);
 	if (cpu != irq->cpu)
 		return 0;
 
-	ret = cpumask_and(&node_online_cpus,
+	if (!alloc_cpumask_var(&node_online_cpus, GFP_KERNEL))
+		return 0;
+
+	ret = cpumask_and(node_online_cpus,
 			  cpumask_of_node(cpu_to_node(cpu)), cpu_online_mask);
 	if (ret)
-		target = cpumask_any_but(&node_online_cpus, cpu);
+		target = cpumask_any_but(node_online_cpus, cpu);
 	else
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target >= nr_cpu_ids)
-		return 0;
+		goto __free_cpumask;
 
 	/* We're only reading, but this isn't the place to be involving RCU */
 	mutex_lock(&ali_drw_pmu_irqs_lock);
@@ -772,6 +775,8 @@ static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
 	irq->cpu = target;
 
+__free_cpumask:
+	free_cpumask_var(node_online_cpus);
 	return 0;
 }
 
-- 
2.27.0


