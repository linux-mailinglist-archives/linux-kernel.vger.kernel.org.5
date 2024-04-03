Return-Path: <linux-kernel+bounces-129760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF72896F94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EA81F291A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669C1494A2;
	Wed,  3 Apr 2024 12:54:49 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88E14900F;
	Wed,  3 Apr 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148889; cv=none; b=OUXBnnmTn9hPCRNj8yv0oE2XW87uo2hb338t/23YAzVurpC+bANO+sA8UPNG1p9PakelgCtwYP6g5UTlgiqMNkh0LW+9W37nvmy8PMPcPlehiIkIoWzZHvHygMcQq6RfvVTLNLGxC0uOz9FBLjA9EBk63Kd71uibf9pIdEVkIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148889; c=relaxed/simple;
	bh=xXJvc27158uMzeJNX4bgx6mUDVSgnlq9ce9aZe5v3B4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlYhUpU2w0C4JRLtPrXLij458ZEHLIltfTx0VH6eDn2MK7D/kDeza49HLXhKmxtppc8Vf8RydM4Ut9udDFOaXUKlbXA06Qd/U3U3J9ghKRYpPFEHIKwsVpnIiGDXqpjHPZlymczP0Gt2TvHlOomqxFzxHWuFm1bEoKmLwQ4KC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1712148785t9jh8zy
X-QQ-Originating-IP: glNtj0eRp0IOBFLCOi1CaGqaaEumMkerNThHocu9b+k=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:53:04 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: +ynUkgUhZJkR1+2Xpbw3pa6lG4d42cKOBYOKy4eBM/Jbqbkv0AiQwK85DK9n1
	983cnBzJioQLx2jW5n10h586uD5pFDBsC+v12PpxJYaKBi3CSH/AmSm88+X9mOQQH8/QZ63
	PG3ju17FiN2Dd4TWCF7X1iXJfg63o8upsKBrlHBlhEbSbLEySN06aN/oYGc5jgiBcG8X5Bp
	1lABsa0QVpzkBNFCbrjCZcdBy7xoNDq1ADjdWQkMU0CNhITXi0yskRVq33PqVBthi6fTNSt
	IzpNnzIqNNQRwXPQN80AGwyXXnm3YBgOIxP8o71LF5W4AFOgcKSD/GXhC0ne4Zx83dF2qUs
	DVPirTGQv4Rbo7GV7MzZpG3r4bkNn+xF135c0YgkOHUZKhO9xWOsAz+OjtOg5jvd7rZuX1h
	qA68Tfvh8S+vNUKQNWDDAAbW7BaVf2NZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17308809335922861107
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
Subject: [PATCH v2 10/10] perf/thunderx2: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:09 +0800
Message-Id: <20240403125109.2054881-11-dawei.li@shingroup.cn>
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
 drivers/perf/thunderx2_pmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index e16d10c763de..b3377b662ffc 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -932,9 +932,8 @@ static int tx2_uncore_pmu_online_cpu(unsigned int cpu,
 static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 		struct hlist_node *hpnode)
 {
-	int new_cpu;
 	struct tx2_uncore_pmu *tx2_pmu;
-	struct cpumask cpu_online_mask_temp;
+	unsigned int new_cpu;
 
 	tx2_pmu = hlist_entry_safe(hpnode,
 			struct tx2_uncore_pmu, hpnode);
@@ -945,11 +944,8 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 	if (tx2_pmu->hrtimer_callback)
 		hrtimer_cancel(&tx2_pmu->hrtimer);
 
-	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
-	new_cpu = cpumask_any_and(
-			cpumask_of_node(tx2_pmu->node),
-			&cpu_online_mask_temp);
+	new_cpu = cpumask_any_and_but(cpumask_of_node(tx2_pmu->node),
+				      cpu_online_mask, cpu);
 
 	tx2_pmu->cpu = new_cpu;
 	if (new_cpu >= nr_cpu_ids)
-- 
2.27.0


