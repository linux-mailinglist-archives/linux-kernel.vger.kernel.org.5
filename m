Return-Path: <linux-kernel+bounces-130157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A808974F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755BEB30496
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26814BFB2;
	Wed,  3 Apr 2024 16:02:10 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133C14BFA7;
	Wed,  3 Apr 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160130; cv=none; b=hX6eLDFsbO/1KrXbE6hQ9jvxhlm2zQZif3pMbwlhOpg2wW3Qh43TjI8pPKRE4tvQu9kD3dlUCIVgKBuXUWx6joXa1r+TYS1DWQrk9o3szi07DrIULCe2fhcerRjkMTs0dxjVQQpbzFIS6Ri5FKRyZ6oA84Ba+Id+4hcPYn2zHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160130; c=relaxed/simple;
	bh=OuclGvf17Qtp8ZoN6WPGf46/G7p3+QoCFfcQPvbAKEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGpQ8WUhOztWiXjMS145JxceCksxbR7V4juuyM1/HM7KwcJ3om87vRDT18R4zy6Ij9jjQJ2aHaxNRF3tusDe5M+WXVnY4VsxZKdG6lET3S/P/ufwh5wbfNYtzF/xpNeeZbYhanojx9tHXRErT0icEd7cA0s2rn3TaWRq0Lgk44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1712160029tjvds1fh
X-QQ-Originating-IP: ZFNF2jA6cUhBsI/Sw6U94tybbGBm1JvJxYu/t+ErlO0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:00:28 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: aEYUFldOyMo79sI+i2iQkeP3nF60xbGGh2UOzK77EjojVlrSHRhcR3+A+wTue
	Vaun393p3G192Wzag0HG9f/pEbpcG8ewZy5sNNFX8ayyUGwKjCrKGPGIBMHVzgpx4+Yd4/d
	RhZIiiBfiKw2maD0iQxAGLsh6VfshF8K9bHkRnzzGX3vuoee64Qd6RmF7BIQjjBfpc/E1LH
	J5qD1ZlJmcG+gYnTKg+gh3ihBxtHntQaaNm/2OcuAzHj7oKg3fR/a7YUmgr5Hz2YYcFwYrN
	zYxa4V6kHNuOpTPQO6Lu00GbO9h5iIlY4YKUCOIdBzhVmONHkdlxtDG24C6Esxgfo7bF8e6
	saDwSwAFsT31Vl596phE/Ndnfxgx+d2uYk1pDcYl9Ef4gHsf2MzI7MTCHooOQUzoRYnbvFV
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3567389364509929858
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
Subject: [PATCH v3 02/10] perf/alibaba_uncore_drw: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:42 +0800
Message-Id: <20240403155950.2068109-3-dawei.li@shingroup.cn>
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
 drivers/perf/alibaba_uncore_drw_pmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index a9277dcf90ce..d4d14b65c4a5 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -746,18 +746,14 @@ static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	struct ali_drw_pmu_irq *irq;
 	struct ali_drw_pmu *drw_pmu;
 	unsigned int target;
-	int ret;
-	cpumask_t node_online_cpus;
 
 	irq = hlist_entry_safe(node, struct ali_drw_pmu_irq, node);
 	if (cpu != irq->cpu)
 		return 0;
 
-	ret = cpumask_and(&node_online_cpus,
-			  cpumask_of_node(cpu_to_node(cpu)), cpu_online_mask);
-	if (ret)
-		target = cpumask_any_but(&node_online_cpus, cpu);
-	else
+	target = cpumask_any_and_but(cpumask_of_node(cpu_to_node(cpu)),
+				     cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target >= nr_cpu_ids)
-- 
2.27.0


