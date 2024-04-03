Return-Path: <linux-kernel+bounces-130163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2868974CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE21C26326
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31A14F9C2;
	Wed,  3 Apr 2024 16:02:42 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C314BF93;
	Wed,  3 Apr 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160162; cv=none; b=aEShQ1UIG1YsiYwYMii83767NnswdKFG0g5/FTFWdtqcURmn7VkQnp0u5lCBbMzIOC9uJwTxOCSWjGRoJaWDsXW6w2GEzcy/w8xDYn/FinS7gYV2xZqkuKoyKUEla2T9/XfoM22jxFBJLQWRLdxZ8tjFffZ4uAxmOJBk1f2le0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160162; c=relaxed/simple;
	bh=8+OYRSORViS6wySTstWl7xfxnB2a4TnBx6JvdVLKcfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPCjprckKhlarj/c4euJ9WGYL3YMM7vHwrlrLG+l6egWABMSC3ZZtNp4nvbomdDBNBwHgIeykD+6RJuVzTaCuaAMTEUEbgvNqqjrS5ktddXVqX3LcZG0PRNpqPKsB6iKddcsn9mE2hw8XQQ8k7hll/ci0dWhecjLZSVABzaXPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1712160058tfp0piqp
X-QQ-Originating-IP: Ouhgj9rA715Lf14sjGY4MXBFcA61tryPUPt6BPHBb+4=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:00:56 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: U7OmrCiPqqAgGcIcJ4EQJge2PyZ+Km+JBHB9boBCbf4mSuiiyYEUsd+w/udnM
	E7a/NmH+Oort1p9ZFUTj4CtxjgralxR/Er0+Hk49Mn/bs+XR84/D5Uf1pFHvvcQDMuLMT3a
	5xXIl3qGyYF2vQd2Q5e6AOkiDBGa5MVEimdiFzHC/L5EFmsvRBaBffOxkBe8y9iokTgblL7
	i1zBC/ofvh0nEpyACdt+VIWU8V4ahIWwrK0ZLDaB3EPl2qDZpbQ3PTZkGXu7ipS3g38rKNQ
	tKVDPbtb84LoxzqquMMi4Nu/Y6kEVJFoonWbqTtZnr6iqhnSwbap26eDM4nOk9OMvDy+riy
	iFKuH1Xc/FDZoLAm9mO4pa4BdyDccpJO6+hHNzt5hzK9AEX7QpRSX0DQPMRo7y3wd5v1eLA
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11768828956102275694
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
Subject: [PATCH v3 05/10] perf/arm_dsu: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:45 +0800
Message-Id: <20240403155950.2068109-6-dawei.li@shingroup.cn>
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


