Return-Path: <linux-kernel+bounces-129754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E16896F87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029FC1F24822
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC331487FE;
	Wed,  3 Apr 2024 12:53:49 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7531419BA;
	Wed,  3 Apr 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148828; cv=none; b=XCdBgS1oTOWnIJCgzAgijfUsMb+7wYttsPAZbvVd3cf6ooCSqaWDtnB8FFzqV0raeS/c7GPz0Cm44KgSsGXY88SC81rl22bAaTOzeEcqxqIh4G6II5UYsE83S6aVFrc8jm1HXrJDQvbnD0IB108GN/2v3Uia3aQYbPp4JC9HVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148828; c=relaxed/simple;
	bh=S+gSs3P8kYIhVuA52RH41jqATpZYmqcABCpEPESAl4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JH6XxvIiJUhawHZ3wFhXjiQPaIoASEIvudkriZ+oupXsyzRyvpGHUodkpBdRN7+omNb0vfxDRwHH/PDKp+HSbtq9viCTCICh8+/NRPsDA+6arl08PkT5Aj/6j6lXPBSwshYGkO0imfUd1EMUUWWECxBv8Qhg1veYivVdA7uKNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1712148739t33bir
X-QQ-Originating-IP: /irmT9DMA2SI2O2WlAVGo2CSYyzhlc/q+/tf3r54I/g=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:17 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: aEYUFldOyMpnMPufkNBznPS4Aas2kZA5zBLS7tmWS34PWtWpMkn9hhp62fMs+
	qv79+3DP+69PQTlQfkAgQY0ED7wBXqqh3Ar1lXvmOJMve/vm1qWrNPyYM4+8q0iSB8n7OHM
	VefijYqxcc3b49cm5Iz1IxuGfG0fd8poD28VHBSga5/1WXiW7+Gkjd+iZ2LYmdYpaGNOJzj
	VZbWuITnu+Ka3GE8I232wB3OVVTb6aJyj1hukdiaJGYk7rpR5Id3dIT0KjP+/0aNlcl58Oh
	TLxD3eVy/iNysJ9ozTnipAbOL1p8DhtRoDlq7q6AofO1ISMT+9L7eaZChWE0l8gWjp33Jvr
	G7QaPMeQU78rTBoIRxTJTu2lKtOalJD7rYBftPhnNU/tbO+SotshjMWhcH/HP7+VSFqf3Yt
	rFdTt5/SfrKgH2fqHem3lVdUi6bM1u0dLgT7EK+xpzo=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8095462230992217133
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
Subject: [PATCH v2 04/10] perf/arm_cspmu: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:03 +0800
Message-Id: <20240403125109.2054881-5-dawei.li@shingroup.cn>
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
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index b9a252272f1e..fd1004251665 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1322,8 +1322,7 @@ static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 
 static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 {
-	int dst;
-	struct cpumask online_supported;
+	unsigned int dst;
 
 	struct arm_cspmu *cspmu =
 		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
@@ -1333,9 +1332,8 @@ static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	/* Choose a new CPU to migrate ownership of the PMU to */
-	cpumask_and(&online_supported, &cspmu->associated_cpus,
-		    cpu_online_mask);
-	dst = cpumask_any_but(&online_supported, cpu);
+	dst = cpumask_any_and_but(&cspmu->associated_cpus,
+				  cpu_online_mask, cpu);
 	if (dst >= nr_cpu_ids)
 		return 0;
 
-- 
2.27.0


