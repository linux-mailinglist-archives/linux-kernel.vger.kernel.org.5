Return-Path: <linux-kernel+bounces-129757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B894896F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC871B2AAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB7148826;
	Wed,  3 Apr 2024 12:54:28 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E7146A9D;
	Wed,  3 Apr 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148867; cv=none; b=Yme7K/fLW41G6ovto5zi7zID1tuJO86HkhnxxsOke9cDVMfHhWRy3emspl4V3AS9F6i562s8X0DjLeWvWz5yL8GLTiFKOoDmeII6UO2KaJMxrC35jRz3derOVNk6XgkUatrcUbOSQiL7s9p/owoMVdQj4NUEj067CTWvq2ES6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148867; c=relaxed/simple;
	bh=DuvQOR4vsP78Wm5NVq8AOQUFUfQcm9T0pyka2X4Hhp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vq6wcXB8KZAtZJJN81wkzoGEFfLLDgjH0XHVU6MHPoRm9klc7lthG1QFd5ud4Rlu4lgdSXfrY1//AE9ZYGCngow4gWKsHYp4lFKM9++8wD8gf+3Kd3WAbuQf5aqsz7JyV/NtEP+ituFXmEUue0QMrxhQl0GROVWYwU2mLFO5yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1712148751thjp14
X-QQ-Originating-IP: PN96WD6+s0f0fHNZoIaqwlrHcfY0nVQajJhi8FUfFuM=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:30 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: zcLa5zqvhxgf/5JXWZ8twfXFCazlSAsrySVLuhjEZMYToUkKWNsAJmBBYfDe+
	NsLkXC+chAgf1GKnj0xs+cjveEn376+2q5jqMLFhczeZpSps2N19LEoRD2EbL4GsthwKh2A
	ZyAM+BPRilAQekCh1hGwcIFu4x73e4p44a+fel0VgLqjLCpdTtAIDgjrdSd5diS1y57wy88
	hDyTUongOVf12A2X/IV7LhSD94AniI9zUmfBXtROAXHdcHcYaWhLWsEoBZGrY2TnkpQM+My
	W/ls2X2G2eB/4CVV13mfkN8eKhXbh+2+EZslaoWjqF2Vpw/mamsDazphJq5suJJVWI/apJG
	AD/bzvFButsgFqs8fNhD38vhGupDFjLpN6Juab9D/+ynsLdXRwsXrr+Bl9JrApdbDjgOxeM
	oLfxxIRlYsInBfAA6uV2dWzExTT2ldHB
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11098512972322688443
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
Subject: [PATCH v2 06/10] perf/dwc_pcie: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:05 +0800
Message-Id: <20240403125109.2054881-7-dawei.li@shingroup.cn>
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


