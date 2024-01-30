Return-Path: <linux-kernel+bounces-44132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37136841DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635DA1C27C67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C615787F;
	Tue, 30 Jan 2024 08:27:29 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B295786C;
	Tue, 30 Jan 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603248; cv=none; b=TdcZpAdqJ4BoTb/mryXbYcNbNXlaeck1g/qK4b0RiHfyenHP35GFjtC89C0M80UV7AJVcAqvkxPUAKur6DgKikBAPjuNKx2lTtG6Jk7Q3VeE1USWxLfyn3Sz0VmIrg7TcRlUab7C7hmPCY8WHjGQFqHD1t87y9i1xqOjy750Mv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603248; c=relaxed/simple;
	bh=qL7hORQYeSREqK7YSRmECZja3+xBXa6/EVKUPw8ODts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BAPKysRNGcqVNAtKYIxN7W3TkjPHvmVxc3XWBnyNGuVvtPg0mcMtCUkDiusHhgFIrmGvcNY0nQGLunEhCxFC7oNx8FGA/dLHg6gY16rUiDRzI0qqdyZFnvoTcNwbreyfEGqc2J7ZEydQhqhjpU3ddzwr6eeLWGyReyeVKKfjIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxbOnrsrhlYEEIAA--.15198S3;
	Tue, 30 Jan 2024 16:27:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs_qsrhl4KcnAA--.23872S2;
	Tue, 30 Jan 2024 16:27:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn
Subject: [PATCH v5 0/3] irqchip/loongson-eiointc: Refine irq affinity setting during resume
Date: Tue, 30 Jan 2024 16:27:19 +0800
Message-Id: <20240130082722.2912576-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs_qsrhl4KcnAA--.23872S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW8Aw4kKw4fCF1UXFy3Jrc_yoW8XFW3p3
	yfCasIkr4DAryI9a4fGw10qw1fZrsYvrZrJws5K3yxA3s8u34DKr4rtF1rZrW7CrW7Ja12
	qFW5uF48uFs8C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8CksDUUUUU==

During suspend and resume, other CPUs except CPU0 are hot-unpluged and
IRQs are migrated to CPU0. So it is not necessary to restore irq
affinity for eiointc irq controller.

Also there is small optimization for the interrupt dispatch function
eiointc_irq_dispatch(). For example there are 256 IRQs supported for
eiointc on Loongson Loongson-3A5000 and Loongson-2K2000 system, 128 IRQs
on Loongson-2K0500 platform, eiointc irq handler reads the bitmap and find
pending irqs when irq happens. So there are four times of consecutive
iocsr_read64 operations for all the bits to find all pending irqs. If the
pending bitmap is zero, it means that there is no pending irq for the this
irq bitmap range, we can skip handling to avoid some useless operations
such as clearing hw ISR.

---
 Changes in v5:
  1. Refine changlog

 Changes in v4:
  1. Adjust order of the patch and put the simple patch as first one.
  2. Modify comments in function eiointc_irq_dispatch() suitable for all
hw platforms.

 Changes in v3:
   Split the patch into three small patches

 Changes in v2:
   Modify changelog and comments
---

Bibo Mao (3):
  irqchip/loongson-eiointc: Typo fix in function eiointc_domain_alloc
  irqchip/loongson-eiointc: Skip handling if there is no pending irq
  irqchip/loongson-eiointc: Refine irq affinity setting during resume

 drivers/irqchip/irq-loongson-eiointc.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.39.3


