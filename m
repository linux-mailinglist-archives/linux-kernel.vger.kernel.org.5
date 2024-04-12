Return-Path: <linux-kernel+bounces-142542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90898A2CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649A9B22E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FF56448;
	Fri, 12 Apr 2024 10:59:35 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C754F83
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919575; cv=none; b=pqA44nC+ciXKjLjSMwSijcFgT2ZNqYadweN7PKRr0FpNSreLV43x1OdycoQvvdQW//Rka2r2ApQpogVQgkBq44kBIgpDaSdqY5+yaDDIULd7fuPFPPQz7znTwDI/mSeCNQVIBVIsuOZvdT4i8yysAw7y1sprMWMlJ9Apxzmv8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919575; c=relaxed/simple;
	bh=YU9GY9kwwCwrYvzSsJ4J9pmYsZAzvBbQ+w74pN74GBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZ+HH0TvKXKyDaFpw9CddZTM+ktQlfMHdgEQPUxcq3Bc3LDoncC4QekRFzWov+2ucxPx3YASdUviOQ2qeasARQMF/oIKCd5lZkV65Qunp6xsaJy85HP3mz/+ZLYGlN8SOBCrPX/XjdHhqqs3a2tiaHGwJpTA0d1cIjagt1dE5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz8t1712919561ta68hir
X-QQ-Originating-IP: ZWB/B4IyZ0qUnNOZL+Tpusla3oVf3Lb8ZOYZb7lrUJE=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:59:19 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: RrZlkntZBfm95kGRViz3aLor3/0FhwLyKZAXNIWQAgktxGh8r1b1zwap8vw9f
	Sm7//RYKxkWd50EwrJamIXK/afovqE2m1EnTP1keOpm2u6LKwYAlec6U8lCuxCFoNbEqLFK
	JMJYDu/+a/G8St6t/wgv1GGjPxkI12MNlRFKu/YLQxitghtm0MLzWi9QUUI/P1HxoCslPtG
	yiTwRDkVWzneMoNTAnx5Tfc18AlWPitA/HWMHCoYtigHAn4Cw6CV1ao9mECd3JmzvltHDTg
	10w60sutnatI1p88Xyy6bihEWyLqaqDDw44AE0gCacHTJW0+vIS2anqKRyZN7JuzAqTQxIt
	fyMMzqxGr6r7A2hxvDU670s6a7nmYTc7a0XrqSgkqepMamFlhOk6zrP0lklCnYEHvuvdhFC
	ODD5wSMhesmr5DJ8GCH79rEIhfQoowb3
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 845724314838511748
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 4/6] irqchip/loongson-eiointc: Avoid explicit cpumask allocation on stack
Date: Fri, 12 Apr 2024 18:58:37 +0800
Message-Id: <20240412105839.2896281-5-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240412105839.2896281-1-dawei.li@shingroup.cn>
References: <20240412105839.2896281-1-dawei.li@shingroup.cn>
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

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index b64cbe3052e8..c9f30e96b5b5 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -92,19 +92,16 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	unsigned int cpu;
 	unsigned long flags;
 	uint32_t vector, regaddr;
-	struct cpumask intersect_affinity;
 	struct eiointc_priv *priv = d->domain->host_data;
 
 	raw_spin_lock_irqsave(&affinity_lock, flags);
 
-	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
-	cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
-
-	if (cpumask_empty(&intersect_affinity)) {
+	cpu = cpumask_first_and_and(&priv->cpuspan_map, affinity,
+				    cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
 		raw_spin_unlock_irqrestore(&affinity_lock, flags);
 		return -EINVAL;
 	}
-	cpu = cpumask_first(&intersect_affinity);
 
 	vector = d->hwirq;
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
-- 
2.27.0


