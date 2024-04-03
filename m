Return-Path: <linux-kernel+bounces-130161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169A8974C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BB11F2186E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3914BF80;
	Wed,  3 Apr 2024 16:02:33 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1C14AD06;
	Wed,  3 Apr 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160153; cv=none; b=Tv1ARfz7d6K/VcCLDYC4jbPYxCm9IUG17dmCAeOK8S61NUhPnriZVP4hIT1PngNVRJ7gtEZsUdNcn+vJCNHSM6/zNuhplC2MB9u2KUCFCeoXX3RoTvaiqj7Vj9obY3I6hITpYteAa4UH89ntgyv5WvJr25MJDFbWUxkGzfiqMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160153; c=relaxed/simple;
	bh=6RjiRy1tamloYmX5bk5dRxBUhMW9rniCbND/hRMWqnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDQ4ygq1Yyf7yi1qn0daJT6jYKy/CXgQ9OEb34kDPAdtMxFa463cmw7/nMf2O25b/niex2s+cd5Du4ikAYub9DmD6686js4j8JqJqs+PFXH1Aq79g4uLz7kO+8jTfnroTg14/zHS/RIdHcmZ0F50LQ7Jz3JpRd7sOHgEtwy5p3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1712160051t70qzemv
X-QQ-Originating-IP: Oo4ukKkdjd17r5jhqu8+60Tput81uspxOdY3X3VlDnY=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:00:50 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: FS9dDLprKnLjfIfqSlSBb3P/B9xD0O4QGjyRvlcJsMwQ4F5ZjMgb9BpsLWDCJ
	C7H+C8HevGdtR71kImRZ7zPfl58ezrpV6zpqs9sAenuqtG+DVLYppJFgk0Mcpa1/Y629W5Z
	9h5B5Hj5hF/hnxNaJ/VUqeWKWKwk/7zOc6G9KRQ5JFluEgcu3t2mxf+sNPzkTOdtNczbn/D
	/zte8mBNMTQe24hPD2fgysSufvF+kpad8OjGYLojRbXMhFOGpJYetnqdOvn4X+Hz9fGhuQP
	TLJg6w24feAryXzE9y/CMRZmPuJd8u96wyFPa26CTaJmCHGHpexZz65oMx5fSk6NUGoOn8J
	7VAtTW9UUruzgxrtfZ2IBYKNWrCLPVG5S+3PyuterpE+uodn7uknQ4WpXwFZMHO9v1bEHZY
	JK0xHXHvJ7Y=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2181088627799291
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
Subject: [PATCH v3 04/10] perf/arm_cspmu: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:44 +0800
Message-Id: <20240403155950.2068109-5-dawei.li@shingroup.cn>
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


