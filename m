Return-Path: <linux-kernel+bounces-156185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEADD8AFEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EFDB25117
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51348137C2F;
	Wed, 24 Apr 2024 02:57:00 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4D13048C;
	Wed, 24 Apr 2024 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927419; cv=none; b=B2BRgIdM6odMh1Xhe5+tlKL7yoZpWmgvC8mP2ZMaKknW0Wq7qyi2qN3FFNWYhxsjnjzM6sou2n35P2RUkVtcJB91J9hl96bKinp34Ep3UDZQioNol+rECXaqxW7gB1/b9HA7MsqNqhvEUfERSH9LE2skJpgjQ1OkT6wxUpFeYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927419; c=relaxed/simple;
	bh=DpRE7d0qbgrqp8GpN4Vpf85og/19uGFkdh9xUEEgvXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpzy3w97zW6OQ9tKwgNXgG7RGObCTU4virY0NQk+pwhQB/TPC6HTYdiiRDDMqT537AoOj9hUaJBVvcU7xVIo1Kr3czSQ50MVd+Vd/zMz+avZOtxjg5kez6XtslRewC6C87VAhV1nJAbG5wsj6WKTpC4YuDO1s8wNZy6CZt5eAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz8t1713927385t6ckiom
X-QQ-Originating-IP: ShAjM5kLOVI6wdrEVKrX7oeOucxUtrnz1cdbZovp/n8=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Apr 2024 10:56:24 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 3M0okmaRx3hadG4MSLwqFSCH4XKhrSS9faZakU2v5lNcTIqY5jkbdZnwwOb0K
	S20X3O7uHmejtrGwPN5aaoOdOSxiGew4mYGYfUl/UaOz14XBXiiYZEHXCCfeMQdiLTfPrtf
	uzwJloQp9shmCs8CQ+T+rA90vCaZaz6Fn/oiXsrzFoXn1D5ISi5C7aF+gpW2Bm4LV2WBjNx
	0VRSAf4qucWnoM7xQccSBrHtAG5cSl+p2xW4w99UY5/lTnR2Tsor4z3mNr9/t4cbWlsb0D0
	4IF8U15Tb+wCl8MLS/JRTmEOv0Qu1Jrf8n4bP36bz2ksYXTIkQZZyhWkqvNWr6WMKppb1y/
	O6Lz+RZMkmFlHOlocOmUbmbmexZ6j+BRzWSnbL2/y5iZOlOAv7pGfnN71FZRgVUjw4ZzEWF
	fs0KMO9hnvhRwCt8DHkMig==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12935631000440679921
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v4 5/5] sparc/leon: Remove on-stack cpumask var
Date: Wed, 24 Apr 2024 10:55:48 +0800
Message-Id: <20240424025548.3765250-6-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240424025548.3765250-1-dawei.li@shingroup.cn>
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
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

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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


