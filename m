Return-Path: <linux-kernel+bounces-127803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE089512E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BA61C2337F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45A83CD8;
	Tue,  2 Apr 2024 10:58:11 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77881679FE;
	Tue,  2 Apr 2024 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055490; cv=none; b=VdPceFnslBt3fCy2+cRUF/TE4nfwWfhpL6GPQXXBUS2ngDnPCss/lq8qgwsp2a0DGB8jan5jWQqYc6adXGbCvmdSefO/Q0SPLFnaTjDko3Sec85MAG7OkPuje7zEDF0Z7EFQ97Dk4+vvfyWmosFbZRn8m20xCOl3nNlgLRCFscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055490; c=relaxed/simple;
	bh=9SMagf4ekuVVWbkzGuSoqtWRQyTjn1UdNYmj02yzq0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgaYjad7/RmK7dNIWnAScxtF6LDieXC1QwBS4wUc6lW5TPHgz+CCtBeQbQ2iXh+QFqqVbrHL+zXRIS8LrNJ68UVY7kH5BQrYzmC5B/lxfYEVKnBYTisoXzfPr5yh9eV4ujBZkwbY5mG2nuz6Cy/Pokk3Ld8p3wBSYzQSWvG69rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz4t1712055438t100kkc
X-QQ-Originating-IP: a5WUCvce6dh0AODow/y0bafKjSIzl0D3SGfsgjaK8rw=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:57:16 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: xQoAiglG4R7OzHcG3WRIL6bRJptP9X4BvxCofIJYBT8FiM2BTyzff5hJU5bed
	eaCrWLkzdr6ZQcZ1J/m11oqaAXCxzlbLodPL6HusvHXm5ue5MeWF650CVMB51fG99wJmU7x
	++vWK1WJA9kR4gKQEWX/PHBD7CI+c1TdERTNDkWcLU04xi8ly6zMRoeR7ihTTFEcBvBkE/d
	sIUEm5kGHeYuOX3ouLbZgHQpFexDECSq+XBUf72oqJgUDw2SXKRqy0gi3Grq1jXLVMHR2G+
	wro2e2kIpVwBmFoDITBcEbJZkNjV4FSXWTgsZrfJsyYMIkDg5lvXiCzds38v//Thm1QYP5U
	zG3+Sxn9/bpYWgorM2qhT+jy7/1wXu3k3HjgCYiORuXTXm21v3KDQdhAHKMmm/EGeDWQ/ra
	aDVzxfIpZeKxvlmrSu08PQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16629059824936598308
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
Subject: [PATCH 6/9] perf/hisi_pcie: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:07 +0800
Message-Id: <20240402105610.1695644-7-dawei.li@shingroup.cn>
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
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 5d1f0e9fdb08..0183640db2de 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -673,26 +673,29 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
 	unsigned int target;
-	cpumask_t mask;
+	cpumask_var_t mask;
 	int numa_node;
 
 	/* Nothing to do if this CPU doesn't own the PMU */
 	if (pcie_pmu->on_cpu != cpu)
 		return 0;
 
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return 0;
+
 	pcie_pmu->on_cpu = -1;
 
 	/* Choose a local CPU from all online cpus. */
 	numa_node = dev_to_node(&pcie_pmu->pdev->dev);
-	if (cpumask_and(&mask, cpumask_of_node(numa_node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
+	if (cpumask_and(mask, cpumask_of_node(numa_node), cpu_online_mask) &&
+	    cpumask_andnot(mask, mask, cpumask_of(cpu)))
+		target = cpumask_any(mask);
 	else
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target >= nr_cpu_ids) {
 		pci_err(pcie_pmu->pdev, "There is no CPU to set\n");
-		return 0;
+		goto __free_cpumask;
 	}
 
 	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
@@ -700,6 +703,8 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	pcie_pmu->on_cpu = target;
 	WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
 
+__free_cpumask:
+	free_cpumask_var(mask);
 	return 0;
 }
 
-- 
2.27.0


