Return-Path: <linux-kernel+bounces-130156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8C8974BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1517F1C25BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6928114B074;
	Wed,  3 Apr 2024 16:01:58 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E67149C48;
	Wed,  3 Apr 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160118; cv=none; b=hHLQ4wb6n0IgC6Q6OyITl5uy/XRBLZ/p0f+L0DCs2/wb5xOwHpAyeGQ4W8cfIaJPbvV2pA9sDChkfm/0y0F4bMBU8OCfaVekmvKvl7/a/pofWBHpYk4HbEvP5CNmnA1dVVGUOkh5dpDTQ+XNgMJg6de69Kffpldmvw6oenjOuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160118; c=relaxed/simple;
	bh=LOH7VS37EK6ouw03EFhLhGPtaI7NGJ8+K47QutU/h5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPoBEvRe0K0AuF330VhlGa0txE4K3gaUoZmszNS8QEhKW1WQ6rfe4V9oAAdsXSlrEUV0oF33DvBeLA7nU1dKdkac31xWYfvhfUEa2MthNnhvjoVjUqgTY5bgITQ/8+ptwL89i7k/HwYsSSua6aQqeIva91QzWYCMsjJudFyV5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1712160036thxmnz8p
X-QQ-Originating-IP: ffIYyfKtI7MEVmnEJYj0yTPiEbfNw9YcDBSN59vzuIU=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:00:35 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: /rrU+puPB7Ts3zb4GQHm/jElpaPN2fhf2qdiTWU8xhv0BMCe7+CIXQJiXcfYR
	ubewNRzUSPlZvYRHv0TPGpOn4i9b8+/UUm0dLbZCfrJgCsPkebvx2ndKvMo141tmndI5K6l
	lyLUDdMvdNLoG9C0QkySP1zyHLygAwFHMEjhczOvGwRusiuWgtdGPDHSQ5MawTrNWCIRcZb
	q1HCABKiKsvMwNHoQzUcykHpn6LYRzhPBGIq1ZIRRY/nqhpKqG8FPBv0fu7khpgxt+3kBv5
	EK5cZz+qMQgL2tKfa64c23UcLftPotDzW7HOjf4VvmAk3APbZrW0xTCTN3NFg/OScD7zwJc
	hWNX13Cp31VbADNd2YnG93ZIsl0+ypaW8jtgBljRWtMwr3vewhjQJoDw+Hm65vzCzeMFwcu
	Y90WXSmKYMc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8707137984463615440
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
Subject: [PATCH v3 03/10] perf/arm-cmn: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:43 +0800
Message-Id: <20240403155950.2068109-4-dawei.li@shingroup.cn>
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
 drivers/perf/arm-cmn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7ef9c7e4836b..6bfb0c4a1287 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1950,20 +1950,20 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
 	struct arm_cmn *cmn;
 	unsigned int target;
 	int node;
-	cpumask_t mask;
 
 	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
 	if (cpu != cmn->cpu)
 		return 0;
 
 	node = dev_to_node(cmn->dev);
-	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
-	else
+
+	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
+
 	if (target < nr_cpu_ids)
 		arm_cmn_migrate(cmn, target);
+
 	return 0;
 }
 
-- 
2.27.0


