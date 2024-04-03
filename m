Return-Path: <linux-kernel+bounces-129758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0197896F90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E13B28B48C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE1148856;
	Wed,  3 Apr 2024 12:54:33 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFC148841;
	Wed,  3 Apr 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148872; cv=none; b=etdSqiokWwlHIkc14jXmIONFQTyH7lH+wISD5R3i5SCbTiToQloK3XnLhaWIUl7fhcqvpxRXoEXXtMHlm+VpjS65sHL+aU3hG6SOUX18Xjl0PQUVuFGXzpY4BTMs6lKHKktZQkgniyabkBs/J53FzVKNjTajF0ZnKkPGr80eVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148872; c=relaxed/simple;
	bh=PbJpsS6QV6+Tp3EXxgnNlfow6jJ418jVf9NSjPKQhoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAkdkJ6z3aSVjZAb9CsokNIYd5BZNGl+3LLjaGhy/we1Hhk7sRNBK++YFsHnAJQWAyDhB6qPs9c+l/oJFGLuFt5IZsGrFmyspkZtMTy1sw5nWf5DKbQvNXFRV7sd4Va2c8rZe+g37CrjLY7DLw9xCWsx3AA2PR0xyaTHAqy+nQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1712148769tl9mcxo
X-QQ-Originating-IP: 7CdYVYVG2lr2tEe8hqubrWolD6g2IXhFkGfHpfc1Z0U=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:48 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: y5UFFkuhlmKejcdNDiyPEy64+ZXAkB4rPf1NixYuJI1SXyXDlruyNpd1pFpL3
	jqEY/qff9Bm7byyGiXyXEFxIqzzNDAaoKAc5bTsV7M5PeaDXwSWFpCdZGrOciKiEX71G/oA
	bvvQjNPJzBYtAIIpPv83YOE8tBIIM87ny5yDiiuGwc8VSrlhYpqzhrYDs5rGhHhEbFwC7F8
	WbAcUgLi/O80xmeiX9SAQtUGb2as5pv/+gxJuTesuLpZkatZDgBVHlD9ruI+5WvZiMTLAjB
	7azxBO+RrcKlZo5iedTqWWeFG/UiGXEONRoAQJiYXF6xCR+ExdBuXuplaqwOVw54NSOYyTT
	HZaadLo6vy75jPpbVRtg3z1oN/SmkvlrwQrWrK5uF7un+AQMh+LuffRffPy/+InRlhsb31q
	M6IezlmJOHxAITAwhuAxEGeS5qll5p0R
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12696791724111325395
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
Subject: [PATCH v2 08/10] perf/hisi_uncore: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:07 +0800
Message-Id: <20240403125109.2054881-9-dawei.li@shingroup.cn>
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
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..ccc9191ad1b6 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -504,7 +504,6 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct hisi_pmu *hisi_pmu = hlist_entry_safe(node, struct hisi_pmu,
 						     node);
-	cpumask_t pmu_online_cpus;
 	unsigned int target;
 
 	if (!cpumask_test_and_clear_cpu(cpu, &hisi_pmu->associated_cpus))
@@ -518,9 +517,8 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	hisi_pmu->on_cpu = -1;
 
 	/* Choose a new CPU to migrate ownership of the PMU to */
-	cpumask_and(&pmu_online_cpus, &hisi_pmu->associated_cpus,
-		    cpu_online_mask);
-	target = cpumask_any_but(&pmu_online_cpus, cpu);
+	target = cpumask_any_and_but(&hisi_pmu->associated_cpus,
+				     cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
-- 
2.27.0


