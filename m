Return-Path: <linux-kernel+bounces-44135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA49841DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263C31F2B915
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312F59170;
	Tue, 30 Jan 2024 08:27:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B357886;
	Tue, 30 Jan 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603252; cv=none; b=cwwV7uKZu3TOxVr9vt5t3xb+G344Kcpz5pQ45bci3d6OWn8jxBPjBweQL7Iye4v6eGobsbaWMppinqPyGezyHi7vmLZB4T4/WQlWTujjQUYHtlvCfZTL7lDgQbQJ5pyHt1Kw07b4UuyAc1DygAmACGMFS0+TFQmJQwZloKPJ5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603252; c=relaxed/simple;
	bh=rUFMw1iMjrV6a0T0yOC1gMUOEPZTRRkGB2tBNWmbmNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAz4i0olqnPuS3+C7jHgsS7+lT6nfNRXBfYBWN6SPyeO24FJVYSMPO/TvFKRF1zmGDaz0OF/Yr3NzdHUK7e2Ex1S0fEJQVG6np2UoxYQ83rzHAWuOO/QYEP64VlvkMSlKW6/TEy3VRaAUZdn+xHzxyC/UYlqcAwLavTWqBRYS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx3+vusrhlbUEIAA--.25295S3;
	Tue, 30 Jan 2024 16:27:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs_qsrhl4KcnAA--.23872S4;
	Tue, 30 Jan 2024 16:27:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v5 2/3] irqchip/loongson-eiointc: Skip handling if there is no pending irq
Date: Tue, 30 Jan 2024 16:27:21 +0800
Message-Id: <20240130082722.2912576-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130082722.2912576-1-maobibo@loongson.cn>
References: <20240130082722.2912576-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs_qsrhl4KcnAA--.23872S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr13Cr4DWr18try8uw47WrX_yoW8Xr1Dp3
	y5C3Wqkr45GFWjkF9xKrW8JF1YvwnYgFZFka95G3y3Zrn8Jwn0kF4rA3WqvrsrCr4fG3W2
	9F45WF48Ca15CwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jz2NtUUUUU=

It is one simple optimization in the interrupt dispatch function
eiointc_irq_dispatch(). There are 256 IRQs supported for eiointc on
Loongson-3A5000 and Loongson-2K2000 platform, 128 IRQs on Loongson-2K0500
platform, eiointc irq handler reads the bitmap and find pending irqs
when irq happens. So there are several consecutive iocsr_read64
operations for the all bits to find all pending irqs. If the pending
bitmap is zero, it means that there is no pending irq for the this
irq bitmap range, we can skip handling to avoid some useless operations
such as clearing hw ISR.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index b3736bdd4b9f..6a71a8c29ac7 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -198,6 +198,12 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 
 	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+
+		/* Skip handling if pending bitmap is zero */
+		if (!pending)
+			continue;
+
+		/* Clear the IRQs */
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
 			int bit = __ffs(pending);
-- 
2.39.3


