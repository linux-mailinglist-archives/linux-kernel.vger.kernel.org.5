Return-Path: <linux-kernel+bounces-27114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087C82EAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573A21C22D02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55211CBE;
	Tue, 16 Jan 2024 08:06:07 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F95125AD;
	Tue, 16 Jan 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxjuvkOKZl1Z8AAA--.2844S3;
	Tue, 16 Jan 2024 16:05:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbs3jOKZlf5wDAA--.16456S2;
	Tue, 16 Jan 2024 16:05:55 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvjianmin@loongson.cn
Subject: [PATCH v2] irqchip/loongson-eiointc: Refine irq affinity setting during resume
Date: Tue, 16 Jan 2024 16:05:55 +0800
Message-Id: <20240116080555.409215-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbs3jOKZlf5wDAA--.16456S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFWDGrykJF1rAw13Xr43urX_yoW5WF4xpa
	y5A3Z0vr4UJFyUXry3Kr4DX34avFn5X3y7tFZxWayfZFs8Gw1DKF4FvF1vvF40krW7JF12
	vF4Yqr1ru3W5C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

During suspend and resume, other CPUs are hot-unpluged and IRQs are
migrated to CPU0. So it is not necessary to restore irq affinity for
eiointc irq controller.

Also there is some optimization for the interrupt dispatch function
eiointc_irq_dispatch. There are 256 IRQs supported for eiointc, eiointc
irq handler reads the bitmap and find pending irqs when irq happens.
So there are four times of consecutive iocsr_read64 operations for the
total 256 bits to find all pending irqs. If the pending bitmap is zero,
it means that there is no pending irq for the this irq bitmap range,
we can skip handling to avoid some useless operations sush as clearing
hw ISR.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 Changes in v2:
   Modify changelog and comments
---
 drivers/irqchip/irq-loongson-eiointc.c | 29 +++++++++++---------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1623cd779175..1a25e0613d50 100644
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
@@ -241,7 +252,7 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int ret;
 	unsigned int i, type;
 	unsigned long hwirq = 0;
-	struct eiointc *priv = domain->host_data;
+	struct eiointc_priv *priv = domain->host_data;
 
 	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
 	if (ret)
@@ -304,23 +315,7 @@ static int eiointc_suspend(void)
 
 static void eiointc_resume(void)
 {
-	int i, j;
-	struct irq_desc *desc;
-	struct irq_data *irq_data;
-
 	eiointc_router_init(0);
-
-	for (i = 0; i < nr_pics; i++) {
-		for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
-			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
-			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
-				raw_spin_lock(&desc->lock);
-				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
-				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
-				raw_spin_unlock(&desc->lock);
-			}
-		}
-	}
 }
 
 static struct syscore_ops eiointc_syscore_ops = {

base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
-- 
2.39.3


