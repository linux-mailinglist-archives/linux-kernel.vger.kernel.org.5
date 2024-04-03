Return-Path: <linux-kernel+bounces-130162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2018974C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DED28A945
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2314F114;
	Wed,  3 Apr 2024 16:02:38 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971C14E2ED;
	Wed,  3 Apr 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160158; cv=none; b=ljyaupipfjlSuQNgCy+a6K2GE0corA1Fw+Rxe4Y9G1/Y4nMES9jfkbBPiNbgcLJrWWAjKYvBi5ei+7NBC8oJUg8Lyagk3otmHbS8MF2b3TD4eU+5iUQGO3PY+kKRbn6g0N7CjhYa7741e08l7rDa4+qaSaC2f2ldzYb7fWnZvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160158; c=relaxed/simple;
	bh=2gZGqJEEY99DLe96JWtP4r1e3iIbQEwQIjMYpymCPOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLuDgJYT3KwtWzAeJIuk/X2e4e/v0JX5GxI39Fv20WJL/X8MiOR9HcNHFeN1Ilnl/Pyy7MV20LLhWD6stSys3qcJZer4gIra3vpHlJxIIYr3J0EcUsdbR5Y1JSVJmgIX0Kn99AyzEA37VT5reBAFyTGHvL3fPV69g1vA7YW7Rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1712160066ti40h7sx
X-QQ-Originating-IP: DvULAx1StrQaECGtZkLwQSDZXJf4l5bDKNsceKVOmOI=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:01:04 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 1BvA+ZmMmIjAEtQoP2oPXSiXVY/97usB/QPPchiMcsC6rtcO+A5D/B3LJ/GHp
	Ojf4INTX426zc25OtA2p2OqB7tOfvd4UQWwNicGlSWUPnkac9H8WLufb7rsS6VBZPEXBYIE
	p7L1ZYjR2PSLyqH8juqcV2rwEMN7fTfc3fWR7wmOcadwxvRR49Uoyu2KnYd2pW2ojeSyoNU
	kDs/X3cByR1UEedXUTOq5ymjDrw9poz3wHxGWhdV7FIrV6bDSNLEeScwfhspIzgSdnfbUZ3
	DqdBWMqL3mOsFmNskDokqrl5lu7x1QajNq/6HkGPnrZ2qWlqnj2jucCZU/EFDvpDikbbTFo
	14Hu2qPOHsVD9dzB/7GZi6OKqtO5Be4scITJJEKyumwXNfILQ1tTe5AngU59P8W6sz4wkZ0
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5560736431858210466
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
Subject: [PATCH v3 06/10] perf/dwc_pcie: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:46 +0800
Message-Id: <20240403155950.2068109-7-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403155950.2068109-1-dawei.li@shingroup.cn>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_any_and_but() to avoid the need for a temporary cpumask on
the stack.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/dwc_pcie_pmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 957058ad0099..c5e328f23841 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -690,9 +690,8 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 {
 	struct dwc_pcie_pmu *pcie_pmu;
 	struct pci_dev *pdev;
-	int node;
-	cpumask_t mask;
 	unsigned int target;
+	int node;
 
 	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
 	/* Nothing to do if this CPU doesn't own the PMU */
@@ -702,10 +701,9 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 	pcie_pmu->on_cpu = -1;
 	pdev = pcie_pmu->pdev;
 	node = dev_to_node(&pdev->dev);
-	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
-	else
+
+	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target >= nr_cpu_ids) {
-- 
2.27.0


