Return-Path: <linux-kernel+bounces-142543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87868A2CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4943286AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948B4437D;
	Fri, 12 Apr 2024 10:59:51 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257BDDC5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919590; cv=none; b=RxLwPfUmSDDgX1+c1k4Qd8s61rbWnoLHh9EpH+4BQTMPd4L6W3Y0D1WDQvbJnJHvovg/AsjhZhYvIqHEsOm6cRBBSqnkm/uLyRMxqK4kAlD3G8mrsGN7HP4hnUzPe0Kb7W0ZlY3r0XVYMuqJSgK+RZVchgfPc7NpMqo3f2cMZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919590; c=relaxed/simple;
	bh=ggMgO+rPt995T4KEcdHnayNEfdGMBP7YG5dHKBPxkoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEEBuuj54AyNsrCfBHAGR2z52GwxiRQms23o8XPRMK74NQrBZpcrNbBvel/982ncgBHwK1iiPh6wjr/Utxch6VjoY/JPhrK2tyfDrKYP5QCx/WR+h+L7dS3BPyPacm98DSbdOwjNVWW0G3ucF6HvXDexK5/35PSQ8i2qG5Ivsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1712919567tlajsji
X-QQ-Originating-IP: psS1oMW7E8PBAWnFJBeHeyKOLljD1luV7VQtmuiQGkw=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:59:25 +0800 (CST)
X-QQ-SSF: 01400000000000903000000B0000000
X-QQ-FEAT: W+onFc5Tw4PeenFYVlUR8av8LbV2OBRzlmy0ixoe643FNskMz0uQ9ivffAsVd
	4mWzHF/s0tdV7VhrpWwjIZ2rgSxhGPk6Y7ERINCjxfgv9sgxAGIk+1nROFRtw+C14wvKukN
	1mz2maxW9/6Hf46dMfisbAbwJZ0xeXUoHeb5FYGhyrQPp4LysbBwZdrHUWixnkzWAOgbeLH
	5hXnxXCdACikme/nqhEuURbEm9aY2mgQEN1ADiNdfLURJo3YrcxqDuVTIRv9sJgtIrjtzSi
	T7RK/RF/cfuoDH6jsRF/2q+ZS14wR7iyY43I6HzEq3YEMWfEQw1R5VBqmmQrh6A+EknE9DW
	HT26qX+cAqhx7MpDONdtxxzMMmJ3MUnl7b3F4pdQHujq7PLgSDs+TgdHytqEaCpFHnaQUcc
	zzaZR0LW+egQrjQcgZyj4h9xcYqfLOM/
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10082534612301943581
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
Subject: [PATCH 5/6] irqchip/riscv-aplic-direct: Avoid explicit cpumask allocation on stack
Date: Fri, 12 Apr 2024 18:58:38 +0800
Message-Id: <20240412105839.2896281-6-dawei.li@shingroup.cn>
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
 drivers/irqchip/irq-riscv-aplic-direct.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 06bace9b7497..5cb7d74d0927 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -54,15 +54,13 @@ static int aplic_direct_set_affinity(struct irq_data *d, const struct cpumask *m
 	struct aplic_direct *direct = container_of(priv, struct aplic_direct, priv);
 	struct aplic_idc *idc;
 	unsigned int cpu, val;
-	struct cpumask amask;
 	void __iomem *target;
 
-	cpumask_and(&amask, &direct->lmask, mask_val);
-
 	if (force)
-		cpu = cpumask_first(&amask);
+		cpu = cpumask_first_and(&direct->lmask, mask_val);
 	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
+		cpu = cpumask_first_and_and(&direct->lmask, mask_val,
+					    cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
-- 
2.27.0


