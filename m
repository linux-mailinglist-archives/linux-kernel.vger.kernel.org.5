Return-Path: <linux-kernel+bounces-30090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E30831900
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EAE1F279A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08025579;
	Thu, 18 Jan 2024 12:15:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B124217;
	Thu, 18 Jan 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580148; cv=none; b=qLHeUaU7edoCD6vYj3XyvwNbarDmAcFWEWU7ZsQ9hjy0rKlpKjiu0U3l4JhXoVo9cQK22xCAAqVFYx8QRPMsvq/BCmYr6YiwjCRAn71wuR8IqJKrRvvsl1TBhwMLYKRleyDzLhZz8Q57dVOA66fOxWrmmtOiLylx7iLxij9hDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580148; c=relaxed/simple;
	bh=CwoOixwB0+Md0QqJN1aOruXZCUE84hJzfBNpRthpE0U=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam; b=Ie/hD2XmVuwBxEAS8eDlF7buVLEdNFMP8YxRokBaRo7d6emTpe+EKQ8HMRnxaqM2H3kqG1PFvfq5QDSUgUb6kPi1YLo+JSkBvMYDQFUWa4m8GQzfjoU1JQDf9xZeOKmIb4otz59VzfAcr60X2ikl1f9Ey4ncRFmlNKymu34MpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxfetvFqllcaEBAA--.7716S3;
	Thu, 18 Jan 2024 20:15:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc9vFqllhX0IAA--.43256S3;
	Thu, 18 Jan 2024 20:15:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn
Subject: [PATCH v3 1/3] irqchip/loongson-eiointc: Skip handling if there is no pending irq
Date: Thu, 18 Jan 2024 20:15:40 +0800
Message-Id: <20240118121542.748351-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118121542.748351-1-maobibo@loongson.cn>
References: <20240118121542.748351-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc9vFqllhX0IAA--.43256S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw45Kw1kAF4xCFWUZrWftFc_yoW8Xr4Upa
	y5CF90krW5J34jy343KFWDXF1Yv3ZYgFZFkFZ3Way3Zr98Jas0kF4FkF1qvrs2kr4fJa12
	9F45WF45Ca15C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU2-txDUUUU

There is one simple optimization in the interrupt dispatch function
eiointc_irq_dispatch. There are 256 IRQs supported for eiointc, eiointc
irq handler reads the bitmap and find pending irqs when irq happens.
So there are four times of consecutive iocsr_read64 operations for the
total 256 bits to find all pending irqs. If the pending bitmap is zero,
it means that there is no pending irq for the this irq bitmap range,
we can skip handling to avoid some useless operations such as clearing
hw ISR.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1623cd779175..6143adb1b73b 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -198,6 +198,17 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 
 	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+
+		/*
+		 * Get pending eiointc irq from bitmap status, there are 4 times
+		 * consecutive iocsr_read64 operations for 256 IRQs.
+		 *
+		 * Skip handling if pending bitmap is zero
+		 */
+		if (!pending)
+			continue;
+
+		/* Clear the IRQs */
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
 			int bit = __ffs(pending);
-- 
2.39.3


