Return-Path: <linux-kernel+bounces-130164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9958974F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1926FB3152A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAC15099B;
	Wed,  3 Apr 2024 16:02:49 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890B14A0A0;
	Wed,  3 Apr 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160169; cv=none; b=JUL0Q7tOySQDECsc8DL+FM/ePZE7pbUceg2BgcxWhsSYiUiN7wLOPnAtvxZUdLQopj2+Qq9Xmd/TUlfRJJHMgO0HFTEaRR22lsYZjFbU1HHBi23NmjKis1FedXRquT9e1JzyMqu1VIAGRuHXh7k8jRPzKn3aArzxUWA/i1q9eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160169; c=relaxed/simple;
	bh=JER5mHSZGhD0udPKWpH+F+JeOasxCW1BBaV/SoNA/uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cI7zWHgCDsplzCI4VcNukaKzAMk3mn9nf80UWFI/k+vkDuGHCDE8fiIPo7q8QGH5eyK4L9ND9/7mXJprKHuMYv0v0fKB3J3UxwFRqneZ57sybly2r2W+UI9I+PWoTzK822373IGAuD4zFBzjnAwgTVcf2o4jkDWhaBSTT0BoLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1712160085tos1143
X-QQ-Originating-IP: Otqadma0z07KqqIZT+FduXyNos/JdYlfYRqjDNsvzu0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:01:23 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: aLjW147EVxPnQ/6oOU8GRSgWLTrRNYcNhCWJZET1WPtO8Qce7Z4NMwuqtGPkX
	UUS3z/3CASpxB6M5/VH9zBnCe7QFb7YNCl9rsPnFZER/Z83rqNBmLBtpuWrQPVbqSoZ6COx
	qOV83QlvLohg0t4UIJmsKlPkkoTEu3l5L0y8iy7f/gOeAJ4dRdZoUj3glWemVvJmF4IXxYG
	wcwJKGyQXr1BrvBOK+oAK5n8A5o0mQjEp+UGufTnTm+qH6Pv+bwp5AKuhYShO0aQmDhApP7
	620gWfxVCpp57XZ5LOcqd1IaaeqyMrynZoTuMBkLsaWtObJ7VfQE3CYjFyNtR1Hsxr6VqX1
	qVJvmStqdkulI8FFHILuxq4M7nAQII4RwJ3oeOAKsG+Gvpm//K1YUB85tObqmz9fOhpqLSm
	3L7jZ5WiHoA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17025534961024682546
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
Subject: [PATCH v3 09/10] perf/qcom_l2: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:49 +0800
Message-Id: <20240403155950.2068109-10-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_any_and_but() to avoid the need for a temporary cpumask on
the stack.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/qcom_l2_pmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 148df5ae8ef8..b5a44dc1dc3a 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -801,9 +801,8 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
-	struct cluster_pmu *cluster;
 	struct l2cache_pmu *l2cache_pmu;
-	cpumask_t cluster_online_cpus;
+	struct cluster_pmu *cluster;
 	unsigned int target;
 
 	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
@@ -820,9 +819,8 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	cluster->on_cpu = -1;
 
 	/* Any other CPU for this cluster which is still online */
-	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
-		    cpu_online_mask);
-	target = cpumask_any_but(&cluster_online_cpus, cpu);
+	target = cpumask_any_and_but(&cluster->cluster_cpus,
+				     cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids) {
 		disable_irq(cluster->irq);
 		return 0;
-- 
2.27.0


