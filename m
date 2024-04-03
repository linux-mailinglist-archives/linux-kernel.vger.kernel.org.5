Return-Path: <linux-kernel+bounces-129756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCBB896F8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1EB1C26288
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D431487CB;
	Wed,  3 Apr 2024 12:54:16 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A214F613;
	Wed,  3 Apr 2024 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148856; cv=none; b=aggEJW+tGuEEgnFDymsGJnMiu2GvVHM8ZaoQ5chr6t9KndWKjmg25XqnujVOpNSgQyOChhSnncnOtDZcKR7+m9J18OIn5JVwmchF+BvoWIrOs+/NT7fA94TPC8cuimDg7PvVrWSmtleB5c5M+LbtJBLwy5UHExbQxQMrzwST9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148856; c=relaxed/simple;
	bh=eD3mfKYgc+nRUPkrE3ZTzbALwXtkGiDfBxjh0ZWxoIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuA2ugI9STldshcrKDQcoUbFUOaeX2nfG8Zcxx5puFNBFG2bc/DKubvxzsXO9wHJ8MRN2YiSf2YaJ1FQqXoz7FsbZn3eZJdVygSu2B2P6Bcftc79+POzcIs8Wqj6mpeZqele5xOVdZlTWXjPCl7nDSEb3aSLei+9BqES0VFHVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz14t1712148757trdpo7
X-QQ-Originating-IP: DSTvJb15+fliyf2zWUZJBYnhPlXY5kA800cxsWCzZAk=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:36 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: DoD8xN2rKoyVx7iKxegRViP9yMHQO4PaK1xU/ZRFnWvi6EHTmFXXoEI0Tq+YG
	VGPFDOfLxJqbT+UZl66iAoaeAMjri+NbDF9MK+kIvkjGPQu5hREf2A4wLewIUWa5U7TNPVf
	vSDKXMrntzyaD6bwhCpjQiIPt2Rtz+gxZRQnirHyzS/Lz3XfECT1b902pBjGETAHk+t5qp5
	DILh6DAT2KGSocqoB4sJWqzKV0DB4YcD4ObXhuKmANDEkGX7yrae25xH7MV8443POuc0gYP
	wFtLo4KuUmtHU2GlaaqqHmRsYYJa360fBY4jnCVDfGkSh5NSP/Z9q3m0aKWGamL4BZKY/WG
	iqFFIoZ/4qTBWDH5G7aez/K0eOcIN6qjoohy70tTEsOWkSuqey5Kmata83VI9Ox9Ijj0J2H
	79lmb0hIr7MukC8G8+W7D4iY7ei5TGnN
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15651604539771351507
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk
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
Subject: [PATCH v2 07/10] perf/hisi_pcie: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:06 +0800
Message-Id: <20240403125109.2054881-8-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403125109.2054881-1-dawei.li@shingroup.cn>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
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
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

But dynamic allocation in cpuhp's teardown callback is somewhat problematic
for if allocation fails(which is unlikely but still possible):
- If -ENOMEM is returned to caller, kernel crashes for non-bringup
  teardown;
- If callback pretends nothing happened and returns 0 to caller, it may
  trap system into an in-consisitent/compromised state;

Use newly-introduced cpumask_any_and_but() to address all issues above.
It eliminates usage of temporary cpumask var in generic way, no matter how
the cpumask var is allocated.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 5d1f0e9fdb08..06b192cc31d5 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -673,7 +673,6 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
 	unsigned int target;
-	cpumask_t mask;
 	int numa_node;
 
 	/* Nothing to do if this CPU doesn't own the PMU */
@@ -684,10 +683,10 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	/* Choose a local CPU from all online cpus. */
 	numa_node = dev_to_node(&pcie_pmu->pdev->dev);
-	if (cpumask_and(&mask, cpumask_of_node(numa_node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
-	else
+
+	target = cpumask_any_and_but(cpumask_of_node(numa_node),
+				     cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target >= nr_cpu_ids) {
-- 
2.27.0


