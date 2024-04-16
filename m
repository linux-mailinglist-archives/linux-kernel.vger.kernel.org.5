Return-Path: <linux-kernel+bounces-146526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDD8A668B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D1281195
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9784FC9;
	Tue, 16 Apr 2024 08:56:46 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD028529B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257806; cv=none; b=HoiacL7B5Que3W1m6/vs1yQX+0j0UsohIi3ofq+mTzCv8F6AqnYgrCesUioSENNOiqRYIjJnKWxzT3RMlqAjwLOZlfFVGWETdg7y5REyiZjVyGobJ+x+5foEgTr5QAo9LO3ogc+wDVZA2iFi9IQ86kXEBfhyv0kN0DOTkBP/69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257806; c=relaxed/simple;
	bh=aNS2CCSzwy6ql/BY4RSh2zfr6aw6EJPA7jfE3nYT5Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIaViq0A84cu9Sj+1fk9LDA3rmC2rnTqeM4bcNrOwvRUBPBWf2W1nH3LeLGFIh4fTh73nR6uiq8kHuAp9cYAiFr4R9wAj0m27irAwhnwsE/IOX0hIj57N7LoTkO8pmqqM57ThbCQAxumysssa75oMNrMpyvsJaGqu1nX94JrsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1713257741thn5yuho
X-QQ-Originating-IP: b3mBBxw99vad6QHkIMchUCO3f6t5t/SWDS++WDSk0GY=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:39 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: oxALfFWpRnAGgHKq5PYOCdKNobJCSzITHPy+s17xVkuOuS8ISpwiXbZ0go368
	3DYT2PnvxGELUqHxh975F+zBNMwkoI7n3JZ0zDQPunAZfrrd96hWcEf7CsBhOY1uMX6uxaa
	vUKVvn5dWomgr5fTnB194u047Rg2hhQSwj9d6sqOdR9Q5inA1MBBidHwAGIxo8MN0D33SCb
	tWRLEqOxvgOjqlfT5ZvF0gCGZeK8QRefPqfYADeuDTtlUWf1zx/vgivLV1GgTaPqFx3DQjL
	vuUqUJiW6v6U8YcWlsorr8jhxuMDHwoU/l57qd4BtK9Hqxm+i2uUhqC2VthiQXrUEE4OrRN
	LQT/Iav8YcXmYY2npfr8+FLyHgHeAaxl4FUAfBVBF7xEa78hSJWcg+G2KpxV92ds6frST21
	HZoiVykqT/sD8R3paRKdrA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9847811538725789897
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
Subject: [PATCH v2 4/7] irqchip/loongson-eiointc: Avoid explicit cpumask allocation on stack
Date: Tue, 16 Apr 2024 16:54:51 +0800
Message-Id: <20240416085454.3547175-5-dawei.li@shingroup.cn>
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
 drivers/irqchip/irq-loongson-eiointc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 4f5e6d21d77d..c7ddebf312ad 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -93,19 +93,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
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
+	cpu = cpumask_first_and_and(&priv->cpuspan_map, affinity, cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
 		raw_spin_unlock_irqrestore(&affinity_lock, flags);
 		return -EINVAL;
 	}
-	cpu = cpumask_first(&intersect_affinity);
 
 	vector = d->hwirq;
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
-- 
2.27.0


