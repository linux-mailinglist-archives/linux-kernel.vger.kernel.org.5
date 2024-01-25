Return-Path: <linux-kernel+bounces-38528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19583C110
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8341C20ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5050A7F;
	Thu, 25 Jan 2024 11:36:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1CC5024C;
	Thu, 25 Jan 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182596; cv=none; b=VX9/Ipdr2oErbG9vn0s2osSaVUHxChMoGSwGj7aF0sZYM6jqr2JVEW1sgJQRymezWAjhaxYv3YWfDdfUViMMFMT8UJenTJvjVKq/I7LjxFWJjSuyR1GDYkUcqBNxVrKTEJ53BZFumOhobt94uwxfilBAf4CmiEs6V0GDipwRA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182596; c=relaxed/simple;
	bh=4HZ6LMP37IcwPkXqZh1K7dcLuHsGoI/e2qFkxyf+aCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=th/JcoqWd3CzLMLCURYzHAOf+1SrX2I3TUIh2L59qVFnB+EGh44ZzLd+XIeeRLLJmK1aHxOIIMFiNfzYfGR5vQINZ/7NcgtU/hce0OV/4JNq0xj95QnM0LYwgqvT16PwYDFMTuehq6wPQjwqFCj9qmC8hYNi06tHZKbl0Ykalqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxF+i4R7Jl3ZcFAA--.1237S3;
	Thu, 25 Jan 2024 19:36:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXs23R7Jl9W0ZAA--.41879S2;
	Thu, 25 Jan 2024 19:36:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn
Subject: [PATCH v4 0/3] irqchip/loongson-eiointc: Refine irq affinity setting during resume
Date: Thu, 25 Jan 2024 19:36:20 +0800
Message-Id: <20240125113623.2043061-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXs23R7Jl9W0ZAA--.41879S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWUAFWxCFy8trWrWF1xJFc_yoW8Xr1fpr
	WfCasIkr4DAry29a4fGw18K3WSvrsYvrZrJa95G3yxAwn8u34DKr4rtF10vrW7CrW7Ja12
	qF45Wr48uFn8C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

During suspend and resume, other CPUs are hot-unpluged and IRQs are
migrated to CPU0. So it is not necessary to restore irq affinity for
eiointc irq controller.

Also there is small optimization for the interrupt dispatch function
eiointc_irq_dispatch. For example there are 256 IRQs supported for
eiointc on Loongson 3A5000 and 2K2000 system, 128 IRQs on 2K0500 platform,
eiointc irq handler reads the bitmap and find pending irqs when irq
happens. So there are four times of consecutive iocsr_read64 operations
for all the bits to find all pending irqs. If the pending bitmap is zero,
it means that there is no pending irq for the this irq bitmap range, we
can skip handling to avoid some useless operations such as clearing hw ISR.

---
 Changes in v4:
  1. Adjust order of the patch and put the simple patch as first one.
  2. Modify comments in function eiointc_irq_dispatch suitable for all
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


base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
-- 
2.39.3


