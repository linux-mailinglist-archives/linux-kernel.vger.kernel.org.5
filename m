Return-Path: <linux-kernel+bounces-127800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC9895125
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DDAB26B92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E280BFF;
	Tue,  2 Apr 2024 10:58:06 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F580BEE;
	Tue,  2 Apr 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055486; cv=none; b=GblwOrhjw46lmpMwQjhDaSbUJ2j5ZudxMwA1LuJ2Ac4xY5WplPM+RNVPMJxi/+4j+EZzBVs5GYWjoUPPGCFIOhqmoTES+RVaYYJ5kBUAUEu6LD9NubOisIlwPWPgf6CzkekQ1IDxP2WqVaj9r17HFKQ5s75JnsJtkGF44cMPRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055486; c=relaxed/simple;
	bh=UD78b+Ao8lKwjj50NaM+HsEbsQALsMtRe09N+rD98HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qsu1xdcYNdtH78rvyJVQ+eE/1Kkf3N8u/uObu5xe6hWeVDv+XvNJsYzjKNGqytGBio4CPmtMebhZA4nry2zJTkj8yLr9WeP3LNjZax0L2XtrctVtzwpsWtx+X7D9v7JXvLVwMUP9GkorUFsLEd1gY4g54088gUle7aBwjMfpP+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz10t1712055431tb6jud
X-QQ-Originating-IP: f5R2VecJRELIO4EhbfBbAraDQpJloHN0LErZyEBfGhk=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:57:10 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: /gpUuYPpeIVF+4ZT8cHhA8f1Nym8iAKHB9yJxhFcqQIPnmtaClBuJ5UBbVQNM
	IEJIVlWFCEiAVpwNgfL3+wEC5zAc/v9VNgPtpLb2Nu3+hz6dKboZRGdqZdHMQ+0N03cwH1U
	zVW6Lnh9JP2B21xzyMzX4/G9WzXGa52g1YHpSnC0Isz9wvC5dj9j2bOfmvkLAQf5FlEqiES
	3g3ZAYRiaoNPZtKNGHMAJUclEz/FQpDvQ149pbnEMoJXyK6y3OvsZgNwjprBKrmuQko0DPU
	LvKZeMuT9YpXKTLfbsfnewbG78wA8D7cvlmuhEOFjjbMQ1IgdJQe1MIXr+dJhuPRp9ram+i
	Ywxf5T8dqPqMU22rXG10pxPgy2AOnT62LcI09jlb2GiAeHzl5WAN8xrhXa5vwRYJSp2ybSK
	Mn62VFjduUiRVx/st/ykZg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7950645969911555121
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
Subject: [PATCH 5/9] perf/dwc_pcie: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:06 +0800
Message-Id: <20240402105610.1695644-6-dawei.li@shingroup.cn>
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
 drivers/perf/dwc_pcie_pmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 957058ad0099..97037b6aaa97 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -690,33 +690,38 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 {
 	struct dwc_pcie_pmu *pcie_pmu;
 	struct pci_dev *pdev;
-	int node;
-	cpumask_t mask;
 	unsigned int target;
+	cpumask_var_t mask;
+	int node;
 
 	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
 	/* Nothing to do if this CPU doesn't own the PMU */
 	if (cpu != pcie_pmu->on_cpu)
 		return 0;
 
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return 0;
+
 	pcie_pmu->on_cpu = -1;
 	pdev = pcie_pmu->pdev;
 	node = dev_to_node(&pdev->dev);
-	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
+	if (cpumask_and(mask, cpumask_of_node(node), cpu_online_mask) &&
+	    cpumask_andnot(mask, mask, cpumask_of(cpu)))
+		target = cpumask_any(mask);
 	else
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target >= nr_cpu_ids) {
 		pci_err(pdev, "There is no CPU to set\n");
-		return 0;
+		goto __free_cpumask;
 	}
 
 	/* This PMU does NOT support interrupt, just migrate context. */
 	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
 	pcie_pmu->on_cpu = target;
 
+__free_cpumask:
+	free_cpumask_var(mask);
 	return 0;
 }
 
-- 
2.27.0


