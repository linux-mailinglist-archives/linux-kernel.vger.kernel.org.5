Return-Path: <linux-kernel+bounces-130160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 430678974C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66F71F237E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174D14BF96;
	Wed,  3 Apr 2024 16:02:30 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7414A621;
	Wed,  3 Apr 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160150; cv=none; b=KdlmzNWxeU9uThxxajm29cks2Q9T3lM8LaMfiBE1geFmoojhxoRdPwDFlN+47oXnQK8Qb4dIcWskE6y/tfBxemWYWrK6EgSzLJTMsw6vi1TaYS6BaPSEvo2Z2p1OvMNkvcmWbwJXRaVbwJgmlFNAL0kSfYxLcmklJUQ2Dd+IeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160150; c=relaxed/simple;
	bh=oPySJ8p+mlKJinHcQ1fw83hQfHtdra/wOhXRyCGkxPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHlIPVYJ1+QJJgUj9cFVFiexe+q/SFQPJOJwS9BhZGz8rrfTJrco5E/Bn064yncmUN0bhYaH5CtS9N78Uj9S9w5YiC03WQn9epT7HoMt9oCnKapSpg42FlBRNiaRQk8J9H9ZFEls69XPcrwRaP3PZGAgxbHvS4b0hkSdSIe6TCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1712160071t7uhmx0c
X-QQ-Originating-IP: qWz66tfgfwR7lXO4Eucb0cwGAgI7XkPPskmUeAOD8Mg=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:01:10 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: sA5XmpK2fX6Ryuah/qO3FiPxqgkvCZ5z71zXIbnGQZLnJ6EqGLmAAYywsR7Cu
	P6qfAYW7DHnc4fT29tjQec4spra/4RtUJmPFR8bQo77//JKx/9APNwHwFKzSHdbvOq3Qgfe
	JR8hzGoT0LEN9HNz3rNnvuFP/x39/RUtumFc/A5znst/Jxc9FdM2dP2vxohsxqJaqeixIJv
	POzRSNifr/cTK9HNVoRDkJie3tW754Sjy/zla9u+QH/XAm0Ke16Kf8U8UtABY9Z6UsAN+Rr
	Lj2DdCaDioLZ7rDf9jly4ajHXVgjYG2jxRWUUhVaUvRkl3OLhI8uez29SkHguM8Y5edYnHm
	vkDBNkZEkJ8CWceHD8hNm6g/L/hrrTUE3xdRxcPDcBa6vLweRggWMsP2BZNe4QhDROXWDsE
	ofYsCTg25wk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9547336712593428100
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
Subject: [PATCH v3 07/10] perf/hisi_pcie: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:47 +0800
Message-Id: <20240403155950.2068109-8-dawei.li@shingroup.cn>
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


