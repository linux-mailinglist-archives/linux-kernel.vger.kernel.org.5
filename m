Return-Path: <linux-kernel+bounces-118945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A9188C1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56C02E0DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798474BED;
	Tue, 26 Mar 2024 12:11:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3166071731
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455099; cv=none; b=THF6WKljZ0hCyVugeG20wgwbu5I3zMAf4Z+UlH/uK31v9umf8EQ4JvYN7VGnzokddilbaw2F1NM1qH+qe5r1/L1tWWKieQvnwtwFQgjj7Sskf/OlxYaNJh4eilHfLmAuE2hi+M5ceqAFCR0RJyjvZ8Ml3TNFk+eNiF6GhndnxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455099; c=relaxed/simple;
	bh=5m4BnN7yVidmxnCnJgX/ChA9bEUto3lM71CJzMUOCf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6qdudiNs7Otn6Hghz/vaI/M3oFHkj0bQHxivqTuPWLw6meXMM1jBX0FTsH3LaIzpD9Lj6DEcrtB0Z1nm7Jshsv7GEFs90TbdD2v21dFpzqRU77lLm0DNNmEwoDEsG137EP+fyNTQngg7Kr4xVr4a0eKhLuB/x0CoVAZ64waMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx77t3uwJmCF0eAA--.51725S3;
	Tue, 26 Mar 2024 20:11:35 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs1zuwJm8eVoAA--.8693S5;
	Tue, 26 Mar 2024 20:11:34 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 3/3] irqchip: Set CPU affinity only on SMP machines for LoongArch
Date: Tue, 26 Mar 2024 20:11:30 +0800
Message-ID: <20240326121130.16622-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240326121130.16622-1-yangtiezhu@loongson.cn>
References: <20240326121130.16622-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs1zuwJm8eVoAA--.8693S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW3WrW8Zr4UAr1UJFWUGFX_yoW8Gw4fpr
	WUCFn0vr43Ja4UWr9YkayDJryakr9IqrW7taya9a97ZFZ8Ja1DWF4rAF9xZF10k3y8GF12
	gFs7WFW8ua15JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

According to the code comment of "struct irq_chip" in include/linux/irq.h,
the member "irq_set_affinity" is to set the CPU affinity on SMP machines,
so define and call eiointc_set_irq_affinity() only under CONFIG_SMP.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index b64cbe3052e8..4f5e6d21d77d 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -59,6 +59,7 @@ static int cpu_to_eio_node(int cpu)
 	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
 }
 
+#ifdef CONFIG_SMP
 static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode, nodemask_t *node_map)
 {
 	int i, node, cpu_node, route_node;
@@ -126,6 +127,7 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 
 	return IRQ_SET_MASK_OK;
 }
+#endif
 
 static int eiointc_index(int node)
 {
@@ -238,7 +240,9 @@ static struct irq_chip eiointc_irq_chip = {
 	.irq_ack		= eiointc_ack_irq,
 	.irq_mask		= eiointc_mask_irq,
 	.irq_unmask		= eiointc_unmask_irq,
+#ifdef CONFIG_SMP
 	.irq_set_affinity	= eiointc_set_irq_affinity,
+#endif
 };
 
 static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.42.0


