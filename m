Return-Path: <linux-kernel+bounces-146523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD48A6687
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE431C21941
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07484D06;
	Tue, 16 Apr 2024 08:56:30 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BD85624
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257790; cv=none; b=sufet+6W6jwwX89iuXIKQkyAQdHxRzKvgqTxve/SP1VqJTMGNKNpWYSi0ziEi8cn8pyXs+6FBaW1kp80EUx+GnZeelnIYy9ATFqhdoWOnOTXVY5Ce22vxjhEAEkN0Wa07F1mws4LXI7aNlxfSpQLL50g2pEbqKviAQtJCv+XC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257790; c=relaxed/simple;
	bh=gFUBkPlzF5cDQT9LC54zRf5as74tcIexLd50RAv299g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFsvO5ivxBeVkGQ9+FMRh1Ij7EwNtJ8I+va7L+x0H8tBn981bQjm0kp8CgaRNYhagUFFGIXdL44COe95sIrQFx+A0XFmT8UO0TYPxp30+N93HyuWwlQFhR1o7DnOA2nCcIflviifQEq5Zb06PKVE46crATeFdQ2PtvPDZDp6PdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1713257748t7w1efza
X-QQ-Originating-IP: iB8jNr9pX2jhXwgd8XhH1up9iEzNHUnblpbgKs1WA9Y=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:46 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: oxALfFWpRnDqVrd8haq0aa8Vu7sBhcvD8Jczawzp6iG4QVrsPhEHjyNqYU4vm
	jUaTLQJCGHeRlwrIGlU5MBZNl+puPXBKLAkHwsdLqKqbuYwa+eezJ/OEHvC4PMx5mkNwBY+
	X/j6Napv/Q9twdqZqER0E6w+CxA2ZBOOz6s2kxpzE3++q9xLSTQObcaY/SKbc4DDkwbamoS
	1tCV0tl7NTQOM+aeUl7KnSDbQTPzwq3XW0bed08kGFhri1AvjEbVYvSHGuvoLEUYsF2aeA6
	wmYaRsqwsKNfO5ZCDOkrGB6bKuejTx/0yK+jQCGwwRhunQgVHPZxxMEobptjZEjIL0MZj85
	1Uyex8aTBZqI0AWbe2vSdV5+JuwaLAiFdTLRsqEJmRHPZXqHG4VCzllpO1CvMgI+WbzVFni
	YrPlU/KVTr3xGY23pEhzNmbDJqLkjWQD
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15208664375220775892
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com,
	rafael@kernel.org
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 5/7] irqchip/riscv-aplic-direct: Avoid explicit cpumask allocation on stack
Date: Tue, 16 Apr 2024 16:54:52 +0800
Message-Id: <20240416085454.3547175-6-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416085454.3547175-1-dawei.li@shingroup.cn>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
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

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 06bace9b7497..4a3ffe856d6c 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -54,15 +54,12 @@ static int aplic_direct_set_affinity(struct irq_data *d, const struct cpumask *m
 	struct aplic_direct *direct = container_of(priv, struct aplic_direct, priv);
 	struct aplic_idc *idc;
 	unsigned int cpu, val;
-	struct cpumask amask;
 	void __iomem *target;
 
-	cpumask_and(&amask, &direct->lmask, mask_val);
-
 	if (force)
-		cpu = cpumask_first(&amask);
+		cpu = cpumask_first_and(&direct->lmask, mask_val);
 	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
+		cpu = cpumask_first_and_and(&direct->lmask, mask_val, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
-- 
2.27.0


