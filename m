Return-Path: <linux-kernel+bounces-127799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DD895122
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FDC286A58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094065BAA;
	Tue,  2 Apr 2024 10:58:01 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC497FBA6;
	Tue,  2 Apr 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055481; cv=none; b=oOpgKyyi+7rQKmlZvf6XprodE01Hp2iBjm1vtAuOPOzI23F47Hplme4BuZYfvXJ5/zwhF+ue6RkOB5xO1vVETd4yWSqFmM1QiQr41fxZ3Cprwm599UbahPo6+7A2epeQIjPc7BqLOYNjuxjdL4scEUXgWFDzRxThcnWKHRB05pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055481; c=relaxed/simple;
	bh=ZvjQTwcwJWrNuKxZ/U40Rg12tZQV5ecf7TdNFA4g0vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VljmaX7HoA0tEio3HGrn+HAK95Y+hY7KX36PynaYIXweV1ATtcVUR0KG+OICLwglH90JnLLtN4i1MTV7MpfIi9JQhXsRbwAApJQ26YwNT4eECwHiFKSwUQZgLla1R3Oy6FdWdvFYn+VQrqlYQGdd4c0xNtuQ+sduueqgjhUbBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz11t1712055412t3i2gh
X-QQ-Originating-IP: F6TQ7P//4zKCDA4lZjfDOIcvWwLHa3rkwI4TauOF850=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:56:50 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: RrZlkntZBfnEBj5q3ATNBISnIDtwBbucJTGdzlgBBvrPwGxeSdaQrY2O7BNVi
	YN80SJcxNGBKWF0mruul/SsnAWrUS8ddgudFE1oKLS+jEevXvqDVNOKV7qFTXJ2rWhaiVwC
	wf53ZcO6SmAMsC3C1CJHDBF0dfZYwzSqn0K+iSYk5demHoOL9cBAnCJAZLi6wUcHGD/LLkb
	nVxeOLJ5wurYne7LYr/EDn7GE3nhxzVQNsZwtVJ0OsawWR+2wb6uTrsCVaOXr0rW+h88K9e
	9WMOEptV2D/kJIUNt9z/2S5zmeqg9SEFNX4sRK/OfM1KWB9BocIU/Yyhz/wDFrUP6WiT3gP
	mXvRveYfpPSpxV/c+Z54oWRjyV5azHp3mf2Md5hIZtywx43saDBp89NTzKklvOo8k71L/49
	1Vp4X/aU9ie3lhYq4qg9zQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8890398727476667611
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com
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
Subject: [PATCH 2/9] perf/arm-cmn: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:03 +0800
Message-Id: <20240402105610.1695644-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240402105610.1695644-1-dawei.li@shingroup.cn>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
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
cpumask var in config- neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/arm-cmn.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7ef9c7e4836b..7278fd72d3da 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1949,21 +1949,26 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
 {
 	struct arm_cmn *cmn;
 	unsigned int target;
+	cpumask_var_t mask;
 	int node;
-	cpumask_t mask;
 
 	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
 	if (cpu != cmn->cpu)
 		return 0;
 
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return 0;
+
 	node = dev_to_node(cmn->dev);
-	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
+	if (cpumask_and(mask, cpumask_of_node(node), cpu_online_mask) &&
+	    cpumask_andnot(mask, mask, cpumask_of(cpu)))
+		target = cpumask_any(mask);
 	else
 		target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target < nr_cpu_ids)
 		arm_cmn_migrate(cmn, target);
+
+	free_cpumask_var(mask);
 	return 0;
 }
 
-- 
2.27.0


