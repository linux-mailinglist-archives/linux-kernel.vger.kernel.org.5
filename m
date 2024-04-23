Return-Path: <linux-kernel+bounces-154691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE88ADFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06541F23B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE455E48;
	Tue, 23 Apr 2024 08:32:02 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6D5914A;
	Tue, 23 Apr 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861122; cv=none; b=q2XZ2Rs0P00mnjQ+Y/e4H6ibRts31sTgjVRvEyPzr7oiECxREVVOVT7aCAWu0w4SAbzYWt/G0Wg626hE6AIOvFS0YxzDX0C0tlar4bHaSJ/Lve9B6mEvOxY7ilkIMGhBsHm+fWfPu6NZwyJVXeqFemIFELlEHKdvuCmopgZbGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861122; c=relaxed/simple;
	bh=HWaOv2WaYtGj0iTIw2G2YzAPc0ZR6ectSGNf9jiMO48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6jNjwaofswmkNxCZRThwZbOmxZFuwWH6n4eM/MlmIefoH5AYogruzAD+32ZNJTai418GlzX/Se2xgxdc3gRMEE0RTVx3tvl4CiEVG6dlTX85dyZ6MZrwozukxZ92ZiNCXMQ6N9vaEYIlmpq2sKsbrdRfC9Lb7EL3e4l2IoSC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz7t1713861094tqgo9ne
X-QQ-Originating-IP: lutf5bzmJ+wbPedIhfSab7lj8PN8lQro23AoaHRKdWM=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:31:33 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: uGhnJwy6xZIizkFrb/rVCurMDKP/+zTB8OFqsvNeXejTj8VZ9Sxq8g+ekbZUt
	PMba5l+JTWxdLtFbdtdCDmH34yN51tjkxmHh1s2QrrTCHn2wO+I6GnCo1bgbkKxtw/ZqFg2
	tANj+CHcr/JctFwzpeP3bugRDzA0VPk6NdOP5fvDnFg5GvEXtfCbHameZpNmzU5CC2VGXdO
	9V8bzKevFVcgNjZWH/Qh0IfnEOFC8elDcpcQrvNZVTk5DxC3cDhRpywfWAyknsb3ea5/tOR
	DH4CgpC09gvWomJ+jvCOyPp38Kc/ZpitxJKqUmh91NU88pU3/7I09pOrZYXlYdxxm/ELOuc
	tTU9LpVYpTM5V0Uh4yQYa9ckPrW8ENfEIAQ4TBjzodHZi8SJYYCFTXTTZfziOY2uSFKDUIT
	fzCXbr5VavSmxRTybMT/cfUodPiO0rTV
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4735814251220725647
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 6/6] sparc/leon: Remove on-stack cpumask var
Date: Tue, 23 Apr 2024 16:30:43 +0800
Message-Id: <20240423083043.3735921-7-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423083043.3735921-1-dawei.li@shingroup.cn>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
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

Use cpumask_subset() and cpumask_first_and() to avoid the need for a
temporary cpumask on the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/leon_kernel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 4c61da491fee..a43cf794bb1e 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -106,13 +106,12 @@ unsigned long leon_get_irqmask(unsigned int irq)
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(const struct cpumask *affinity)
 {
-	cpumask_t mask;
+	unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
 
-	cpumask_and(&mask, cpu_online_mask, affinity);
-	if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
+	if (cpumask_subset(cpu_online_mask, affinity) || cpu >= nr_cpu_ids)
 		return boot_cpu_id;
 	else
-		return cpumask_first(&mask);
+		return cpu;
 }
 #else
 #define irq_choose_cpu(affinity) boot_cpu_id
-- 
2.27.0


