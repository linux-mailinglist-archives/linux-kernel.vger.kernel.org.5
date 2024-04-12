Return-Path: <linux-kernel+bounces-142544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C28A2CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28102286AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD75490C;
	Fri, 12 Apr 2024 11:00:00 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD5548E3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919600; cv=none; b=WPES0sUxHLH+2e42eti1g+uUFSvfW6sUQSOIiuALKBSOWxxyYM169UZVqp+YMxLeFauGrFFSICtth8JczjHOvcgsT+MLOK35LHSfluXXmdut7BWBTXHF1F1tk9FXlLOPBZI5k15KWnEwgh2Qf+efDC+dQbUV7aRwKdNA0vPbFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919600; c=relaxed/simple;
	bh=07NTM88QwRzoo390ZLemINoqh6/jCN/PfEP7yU0wEwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtaSO6fF5bIN/MYCa2SB4S4zu5n5HAAIt1j4AVFHPnkGEqTszQTPdzJvqcVH+BMqRkTCVx5ZASOwvH0NH950Pa4BrBDIJcxTDt5HmuKrxnWfEYNnk4L9Kt6Qn5/jsCMSEg7C/cDvcZ7DgdqzdWFi3Vk1z8PmnGWbu17PvULgIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz2t1712919573t6idgx7
X-QQ-Originating-IP: epgQDvPTX2f4nlnGaXUhvRLzY2bOY8814GkkAA2Z0gE=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:59:31 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: aEYUFldOyMp/nydjx6hhyShFrAjETMenuO2m1lkToK8BDMN65Wz87U1LGva1P
	SJTxf4Tys6KTeVMEnKTjN+lnkdO9yEuULZWIp0ivGAYN0ye4g/JW/eCpgKAXXc7gs8f2u2/
	oOhl3Iv5F1Mmvel5E/u2SV1DrvTAUOBQNDcwE+APnG+EU5+LeJAladVFSygvYvQmI58v6Fa
	/7LBGexoai35+1NGyhmsFqVaUVm63IsCoLqM9CxbmzTy2KHPY3iJIULqdWKzqEdlVDYGrEs
	gRvLgWIVMfR780jHJA1ADL2afvR42kvanTByg7gVYVEgovPui4/LRgyCRwHzmhEDUKj02OU
	UatbOK/N6Jh94CbV338lW1zS5t/yNKVW2FyHbQ4pJQVfuN6etlydIUV2q+hhYlrJHl01Kt9
	6B9N1DNgnTVU78jfyC8DdaHHfZ97Y5g5
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11278858222069621144
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
Subject: [PATCH 6/6] irqchip/sifive-plic: Avoid explicit cpumask allocation on stack
Date: Fri, 12 Apr 2024 18:58:39 +0800
Message-Id: <20240412105839.2896281-7-dawei.li@shingroup.cn>
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
 drivers/irqchip/irq-sifive-plic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f3d4cb9e34f7..bf5d2fc6396e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -164,15 +164,13 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
-	struct cpumask amask;
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	cpumask_and(&amask, &priv->lmask, mask_val);
-
 	if (force)
-		cpu = cpumask_first(&amask);
+		cpu = cpumask_first_and(&priv->lmask, mask_val);
 	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
+		cpu = cpumask_first_and_and(&priv->lmask, mask_val,
+					    cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
-- 
2.27.0


