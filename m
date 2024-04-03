Return-Path: <linux-kernel+bounces-129752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA3896F83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729471F22FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4374149C74;
	Wed,  3 Apr 2024 12:53:27 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F61487C4;
	Wed,  3 Apr 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148807; cv=none; b=OMupfjbCDPorgiz24xigQUug8DFx8+7Kn/r+GLiVaQWRALs/56aehukwcYiFaedhkem37uHPuK95jB/jS730ztJHun7N29Nye3vtyw9mROdgu4dMd68r+vOFsfzF5xCt9lV+zfpDx74A5E2ykPzkbi/sQW3W6IK/xi/r2CTY9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148807; c=relaxed/simple;
	bh=ND5sQn5AjH0gDPbniVnc+41oWPSZKhZ2+RSnBwR/Fts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6eT2E99gPEnaXb+vYyqdBGYqxOfZX6EGHZEmsDvxv6H+Ln8hOMOHomOw/LINAYNE5uG0n5qIFdXoP4Xdv/ramL/6SitGkKDkjt8EEyl9zETp9FO6YPoFO2dgcU/5+5gS6QVQYidMDJZTs8sQlVmmtK0eKMSwQb5HlY9d9CFAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp85t1712148720twwg6aua
X-QQ-Originating-IP: 30EARy7HPLustGG8zN6V2G7XFr0eATYLgWtd0FyeGf4=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:51:59 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: +ynUkgUhZJkgUFfCe2bZDZl3Ri73/Gulvgj5ReUjIICIsO+wcseceAglPbjLH
	3PHvR2DU4av5Yr2xF58cto1I4u6+5S8iL319QcXUZRbWHkEih/Q9u4Lac2fFbYySwtR/DhG
	SVEfS/UgL34ApymCot4ec+R198/YtQ8nsHRJXWk3Zq4Bwew7sFkfrDWeWcqCZbo0cUI9W6y
	cdt31EdW1zWFapPt4FTc3MmfFkcgrUG/LfS8yVZoySp/fssPUhv1oNBjBpshNsNq392kVq5
	IttFr+KOOAJimM/vM0VmzEbwRYjMMQBWDiehgT4Qhpt3xadGhZQH5mLQDGeeRqxSsi/EfMh
	eaOiBP+db83941cZTmV5YX/rYWRyK83ISKUzqM0qPCQPzxOM6BEpbhVXlH501arQf3aCLYT
	feip3C/29R/9J/1FJldJOTNiAub3MPIj
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8084547237473899834
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
Subject: [PATCH v2 02/10] perf/alibaba_uncore_drw: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:01 +0800
Message-Id: <20240403125109.2054881-3-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

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


