Return-Path: <linux-kernel+bounces-30086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803748318FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FEA28900B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC124A1E;
	Thu, 18 Jan 2024 12:15:47 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09124214;
	Thu, 18 Jan 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580146; cv=none; b=pPM1WJVE4AChm29P+i+pAv6MQmNO4SRx4rqKNbtaMb2hr11qyzqhR1ycBp31VN4XpvMhQKqsm68SEtgcg99mxGSpP1qpMB14ox6+C00JrUZ+fAVItdupGz7mEtmT3D0k6lWEvVq4tQ/VcUkWv1zCUlfQbVJSy2K4plPuG2+ATkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580146; c=relaxed/simple;
	bh=lJonT7GG/6TvNPs8K6JrEe+ywpeClThCGZjjQOYiQ/Y=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam; b=V1k3tn1zgWdoShLkNwGDiAqp0U9+JLGT/+ho2Bx9oBpwbs7D/47toEktwyA5+44OrY6J06icWO8M2i4TkFDKomdCk0KQmJ1epzEEktWT186YFGbK3xtnIjK6QZ7+xDDoeXJT6PilQrCTuJ+ul9ntQoOXXdk5LMhHpnjJdesMQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxXetvFqllcqEBAA--.7671S3;
	Thu, 18 Jan 2024 20:15:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc9vFqllhX0IAA--.43256S2;
	Thu, 18 Jan 2024 20:15:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn
Subject: [PATCH v3 0/3] irqchip/loongson-eiointc: Refine irq affinity setting during resume
Date: Thu, 18 Jan 2024 20:15:39 +0800
Message-Id: <20240118121542.748351-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc9vFqllhX0IAA--.43256S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKFWxJFy8AFyfXFyfXw4rXrc_yoW8Jr48p3
	ySkasI9r4DAry7Za4Sqr48K3WSvwsYvrZrJa97K3yxAwn8CryUKr4rtF1YvrWUC3y7JF42
	qF45WF4Uuan8C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU2puWDUUUU

During suspend and resume, other CPUs are hot-unpluged and IRQs are
migrated to CPU0. So it is not necessary to restore irq affinity for
eiointc irq controller.

Also there is some optimization for the interrupt dispatch function
eiointc_irq_dispatch. There are 256 IRQs supported for eiointc, eiointc
irq handler reads the bitmap and find pending irqs when irq happens.
So there are four times of consecutive iocsr_read64 operations for the
total 256 bits to find all pending irqs. If the pending bitmap is zero,
it means that there is no pending irq for the this irq bitmap range,
we can skip handling to avoid some useless operations such as clearing
hw ISR.

---
 Changes in v3:
   Split the patch into three small patches

 Changes in v2:
   Modify changelog and comments
---
Bibo Mao (3):
  irqchip/loongson-eiointc: Skip handling if there is no pending irq
  irqchip/loongson-eiointc: Refine irq affinity setting during resume
  irqchip/loongson-eiointc: Typo fix in function eiointc_domain_alloc

 drivers/irqchip/irq-loongson-eiointc.c | 29 +++++++++++---------------
 1 file changed, 12 insertions(+), 17 deletions(-)


base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
-- 
2.39.3


