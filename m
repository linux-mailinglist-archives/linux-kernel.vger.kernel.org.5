Return-Path: <linux-kernel+bounces-129755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3486E896F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06CFB2A8BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0B149E15;
	Wed,  3 Apr 2024 12:53:52 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0771482EC;
	Wed,  3 Apr 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148831; cv=none; b=jdXtfhxornDM5N7ob6xBCleVIOlcAASf8ai9U3Eo5ZSzjOO7kdfnPQ3H4P20X22xRv1yhZQd5Bdi3ew+P8GX/yTudnpbKsn0Qv56I1h5Ze45U9kXuNBLMWOfKlnCam4Yj1GmtQkKJSgPNY+nKLVtROsJeak/7BAGuhMdom+fu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148831; c=relaxed/simple;
	bh=+44ocduMZ3arrVTyEvNGTfJn/pXNlZB4i16mdgLoFoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qk/yc9V6ECXRJhb/hXPI9FR0RJ54nFHQtjN0ucKt7xnK54lyXG1XLIIpv6lowKFOk9CsM4c9FRaHHKE3fCucII7Q5x5hgXMxs87O5wpbxUvu8TCs9ojPV9QSLluA+b6M+I1dAs6qyJrwuIsxB8CPS3yw+/OILl47KHRlwBZ7L8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1712148745t2zdelq
X-QQ-Originating-IP: gtG85rrBFgYquVhBEXaQuedD1lYsKNbDnucmL+QbTUs=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:23 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3hYBn6c6xv94OOmj7QRwjjI90PZMYk07rq6fUKYPq7jtfpesKrxM
	Hp/NCAse2sa30t5lFPhi4nzJDvtpqAREDZEm9kXuZkZBS54HuzXSTNSOoqy+N7OMGmwZJvB
	W4N/IGrBxUN2fvl664QjB8Nn2vfTBlWIpxRgfSormkTkhdKMO/jcas8amuGmvm04xhg3JSV
	GveXZ3D3mDREigPfWnjS+QZuH1I4fZz2QQbba9y4ssVNmO7eka9dFoEPA3d8nZtXlUfC4c6
	A/9fdw9FWHqe/O7A13cNIGAhKa/a14mzCAXCc9BTO2seoQFWrVqVRfqFZu8wNV6hlamFZnK
	SgfFscX3PpNOc+ZCkoVTmrJtTuqoNuht8yQd+/JeuhBz2e9W1wGkyCbwwmommR9Au9KdFWq
	GQcGDvL6aPh2ZQeszSbdeH0WMml+cW0m
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8972781227681254528
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
Subject: [PATCH v2 05/10] perf/arm_dsu: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:04 +0800
Message-Id: <20240403125109.2054881-6-dawei.li@shingroup.cn>
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
 drivers/perf/arm_dsu_pmu.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index bae3ca37f846..adc0bbb5fafe 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -230,15 +230,6 @@ static const struct attribute_group *dsu_pmu_attr_groups[] = {
 	NULL,
 };
 
-static int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
-{
-	struct cpumask online_supported;
-
-	cpumask_and(&online_supported,
-			 &dsu_pmu->associated_cpus, cpu_online_mask);
-	return cpumask_any_but(&online_supported, cpu);
-}
-
 static inline bool dsu_pmu_counter_valid(struct dsu_pmu *dsu_pmu, u32 idx)
 {
 	return (idx < dsu_pmu->num_counters) ||
@@ -827,14 +818,16 @@ static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 
 static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 {
-	int dst;
-	struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
-						   cpuhp_node);
+	struct dsu_pmu *dsu_pmu;
+	unsigned int dst;
+
+	dsu_pmu = hlist_entry_safe(node, struct dsu_pmu, cpuhp_node);
 
 	if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
 		return 0;
 
-	dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
+	dst = cpumask_any_and_but(&dsu_pmu->associated_cpus,
+				  cpu_online_mask, cpu);
 	/* If there are no active CPUs in the DSU, leave IRQ disabled */
 	if (dst >= nr_cpu_ids)
 		return 0;
-- 
2.27.0


