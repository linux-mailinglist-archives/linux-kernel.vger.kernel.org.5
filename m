Return-Path: <linux-kernel+bounces-146524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767B8A6689
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14C72842AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD2986243;
	Tue, 16 Apr 2024 08:56:32 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077783CDE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257792; cv=none; b=jI9TtxD+JmMPTEtJETE2q+pPBTZhhCI6tf5vy48qWchKQo5DbCk3w5Jnu/ZDnWSRQIwHOXYER5xK126yyH3GFuT3bEBam0FYmzPAdSCEE7qqAtAIXkZPW4hLm3ZSim1tDZibVyZMx8rL9w5ICpFbF1jH59w0IKmvQLIjmSnUQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257792; c=relaxed/simple;
	bh=WxvSvpe1lEWpQjmS4qBdmYUOUCHYYKCx3os69mqe4Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNT5uvjQH5BEarMYnUiepzgWxq7NCzW/Ahdhrk0uUC4JEDPIshNi8qsc+I4kJqVVwOQruSVvnikvljLFkwHHvOlJoP/AutNeDTTRdRawzKGk4BnSBxbSMWaeXEDLisTcCO0iIsVCuyP+hpdlH+yuWOJjxo2tVg/SW4wjkisoT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1713257756tl8n6h1v
X-QQ-Originating-IP: Ufr4iPF8/V5sUCDLB2j/wwxLjOniD0k25Tch4xBqe5A=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:55 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: iBxuBmNAXy0+U+zFlkEd8DsB2q5NB3y9GTEuVyNJPCOAmphA/z8pDDd4FmTPM
	XnuF+ah3SSiTFgnnSbB8lxEjDQWpRatETNDlr51hJPrGWeIq31MF4W9HWhxhwjip+8xwPTX
	mllW7Yq+phqy6YbTYAFklalRqTzlQjj5/8KPXyo6FWhlf/Xx9pCf42PychtVK6WqPEe6BgW
	DfPft85HReJVLVzVm70S7PZsu6zcCQmtYeE3SqFhZlOrsXoFBDntOvvxjyYl3z04Eox85kI
	DuJI1kd4p5pl8GauzI63G48gYufRASlswSqINGIJ2HRpeokE+9IpE/fgQzJS/+cpCH1R8fH
	5oCkormUu+9byPSx28mRw2dashv2yYxuijCR3EkNqjjrByTw8PvxICGQLFwbI0R4SW3kOJV
	jwOpNFagROayyWibirA9eYGbvU1sUNHC
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16523450954059161192
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
Subject: [PATCH v2 6/7] irqchip/sifive-plic: Avoid explicit cpumask allocation on stack
Date: Tue, 16 Apr 2024 16:54:53 +0800
Message-Id: <20240416085454.3547175-7-dawei.li@shingroup.cn>
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
 drivers/irqchip/irq-sifive-plic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f3d4cb9e34f7..8fb183ced1e7 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -164,15 +164,12 @@ static int plic_set_affinity(struct irq_data *d,
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
+		cpu = cpumask_first_and_and(&priv->lmask, mask_val, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
-- 
2.27.0


