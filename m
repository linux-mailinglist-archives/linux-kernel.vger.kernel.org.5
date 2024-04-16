Return-Path: <linux-kernel+bounces-146522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C28A6686
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744A5B24435
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839B84FC9;
	Tue, 16 Apr 2024 08:56:26 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98284A41
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257785; cv=none; b=TnOPvnuRq9hvwc5pLCTVXLMWGUyAtpmuxdgT9sUUII4S/4cA0OquUqpNAY4xhuXbcRBfQ3P4hWjDC0QM3iyHKwAharpsXmUqaYL/acCNi96yghOI5An7mAT7sNwWipPEMvqf/MC4upTDcD+57mxUSQ18Zfelj0Vkvbe5iBVOA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257785; c=relaxed/simple;
	bh=YNQij0CAkhxascxaORo+jbO41NVurarXUSkvZb/98lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOPhdYhhZp6t9vF5ilNg1nXOOCDxfvIhfB8EVb0J26IAEANJDZLVy487fh0Za1fQrPwl+8mvaJdHhDrzYvs/82v3CPyG++NGGwLLufnQ5X6Fuya7WskfrTbJBxDXgS+qhaWLmvyccKyUmKDVBxnOTbBz1UyFKJvo3UlhsVtnuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1713257729tie0wd9g
X-QQ-Originating-IP: G5B4DcVSsayk7alsXd74AVbjTRprl6JewlhKa/j5xRo=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:27 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: oxALfFWpRnA7UlOqvALHwj9SpDjYFTCYtiorMn/wLLZVTuR0Fc794SqPklTt4
	mVVj6CEoYkVS5tFQ+XXM9yS97ikcnJEk5GtrOngvuGq7Fs8SCIpxjXbxKuKW/QlhcqU+YlQ
	LQFat0Wo8EVV77rlWs0uzCkAAW46TESOZlAhOUKr7RqQKOX0hbpkuxoo8Ke2j8+yAzFSQUN
	kmYKOIcs0nprIdt2nalqtGHoPLaQGPeLKyLND5sFlENAB8nIGIn3ZlfNap5HsMlPc1JGgCC
	FvoxmKeLf24PaQjFvmEKyP1WUae+aslu09tEKWSZym9X7r4Cf3PCgkq5VX0j5q+WTrOjIdb
	BPNKykklzj6gywa62jAprx3f+nIX0wF+we6gJDLGX0/Un7MSelNTOFwOuYNSI5blUfw/DLV
	GisvipT8z5SpS9mqSioPX8J4tav2OKQU
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17820891928850758812
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
Subject: [PATCH v2 2/7] irqchip/irq-bcm6345-l1: Avoid explicit cpumask allocation on stack
Date: Tue, 16 Apr 2024 16:54:49 +0800
Message-Id: <20240416085454.3547175-3-dawei.li@shingroup.cn>
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
 drivers/irqchip/irq-bcm6345-l1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index eb02d203c963..90daa274ef23 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -192,14 +192,10 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
 	unsigned int old_cpu = cpu_for_irq(intc, d);
 	unsigned int new_cpu;
-	struct cpumask valid;
 	unsigned long flags;
 	bool enabled;
 
-	if (!cpumask_and(&valid, &intc->cpumask, dest))
-		return -EINVAL;
-
-	new_cpu = cpumask_any_and(&valid, cpu_online_mask);
+	new_cpu = cpumask_first_and_and(&intc->cpumask, dest, cpu_online_mask);
 	if (new_cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-- 
2.27.0


