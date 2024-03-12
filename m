Return-Path: <linux-kernel+bounces-100806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE0879D79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DE4B235DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520914373D;
	Tue, 12 Mar 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HLSdg+pE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08436143731
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278896; cv=none; b=CMt2RcN+gevOmryNdri+e0Szvug23T3kRIor1VblGOD3FCr/77e236MSD3jmaIbjvbkMRIdHAhl1L8Inzn4xB84zFYxIK9WDK6QdTqfPleXxx4IaSMzHWUfvu5xiWEpup4xoTYrDtArwvcK1MtWvpa3lY8ZzwDvhiJC6R9NWYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278896; c=relaxed/simple;
	bh=Gksb9wyj/vOpkuNOlaVDMtiNhk0Vrj7lyZpxMDcI6OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I57o/qzn98K5daPys53n+WIzxp+pR5gjrOyPE3acv+mDhadSbP8cZuDE1rfXVrjTY2PqLqjngkeXzXfhX6mmU/wZumR9MK16ZOOYY2ccSem2GN8EM8n3wfm0F2IutMF7jpow2+z/fiE4nNS+eA+YrQObr43hIu4Q71q0DAzlSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HLSdg+pE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ddbad11823so9431355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710278894; x=1710883694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J07qi3Pm6IWKJCmXkuIy6slfTmc3cDOIJrvkEFADZ84=;
        b=HLSdg+pEyVyFP+z7jLqjPRwn//hWJNztBBtlw99tf3tn5Exrzw/N7WrTG25LQc/iv1
         XW2qnb/UBPt1SQbcPyIjUavXeq9RrKwxCLHP3j9mWC9wsio4cpEhXzeKMCT67Sidnlb2
         aInkKHX4ZvAyOes6JDt4GYplpihzOOPguzDILh1bELPCWlSgjRf8qjgZEljXJobta+sV
         WxCrBatUCI6GBN9gLMwPB2vONuJMqFlihZqDy8S7A1R44plX1a4aQlOMLYyrGHt7Ynus
         bwqk3Fvi1G5ZRgrKDHtCf2B/Uht4TcN0lX2z839wD3Bju4TI9fQ3PWLmFJxnktO8FBmB
         6Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710278894; x=1710883694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J07qi3Pm6IWKJCmXkuIy6slfTmc3cDOIJrvkEFADZ84=;
        b=D3Ju81dG0ak5uL5aZRZucbxNlPy9U/Eh4Ul8WYWMYZkJYN2n2cMZF9gNT6vGlSnI00
         zE/m7JDHWyNWAt+6Plfbqz5wm2UQLPBDMm7k8rswo16S1VGPs/6NeevjzNWPkSpLN+ph
         KdMqAJYmOtrVMHVeW4eu2a/i+++aHyV0rQlZTJaR0sTvQsWMRY3zs3R/GJtH6+cbDUQb
         RiP/NPx/c7FrpEJKwN/PkMcaC2Iq3eqUiNfUzQNAqMYRsfcTpVeU9zsZ6gYoLUFNXLpH
         KX2xdD71zIoHZio1okeesGvLtg1YRfNs+aHNLBdGHYloD7YbIsbRsr9bD3HFyg1w2trI
         9rWw==
X-Forwarded-Encrypted: i=1; AJvYcCUMGlepf5pNRMIe5Zu0iamUE7GGlAYOJ2DNU/j+dboBCg8qvOF8I9XMaDR+NbsqMHCv/1O4VvSgTqTEraTyjoUN2NlNrZw6fMU27M5S
X-Gm-Message-State: AOJu0YyJfJH8GzI8nCizQ5ab2Sebpdp5ubmrHrCmr8jEhrzHcs49oEFk
	1HOOc+4MUAlBW/O0ylORO/oND2u+xAukWU7teHS9eLvKdO0cS7pU0PS+tQIEZ0Q=
X-Google-Smtp-Source: AGHT+IHUbA2fkuidigz0aEHwAs7BBlFBOtglNgjvKDQ2scnMN4VpbFIoE44l+8Y0xPIP9t2+5WWAFA==
X-Received: by 2002:a17:902:b58b:b0:1db:edfa:7713 with SMTP id a11-20020a170902b58b00b001dbedfa7713mr11533807pls.18.1710278894337;
        Tue, 12 Mar 2024 14:28:14 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b001db5fc51d71sm7222248plh.160.2024.03.12.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:28:13 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] irqchip/riscv-intc: Fix use of AIA IRQs 32-63 on riscv32
Date: Tue, 12 Mar 2024 14:28:08 -0700
Message-ID: <20240312212813.2323841-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv_intc_custom_base is initialized to BITS_PER_LONG, so the second
check passes even though AIA provides 64 IRQs. Adjust the condition to
only check the custom IRQ range for IRQs outside the standard range, and
adjust the standard range when AIA is available.

Fixes: bb7921cdea12 ("irqchip/riscv-intc: Add support for RISC-V AIA")
Fixes: e6bd9b966dc8 ("irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-riscv-intc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f87aeab460eb..9e71c4428814 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -149,8 +149,9 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
 	 * Only allow hwirq for which we have corresponding standard or
 	 * custom interrupt enable register.
 	 */
-	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
-	    (hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
+	if (hwirq >= riscv_intc_nr_irqs &&
+	    (hwirq < riscv_intc_custom_base ||
+	     hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
 		return -EINVAL;
 
 	for (i = 0; i < nr_irqs; i++) {
@@ -183,10 +184,12 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 		return -ENXIO;
 	}
 
-	if (riscv_isa_extension_available(NULL, SxAIA))
+	if (riscv_isa_extension_available(NULL, SxAIA)) {
+		riscv_intc_nr_irqs = 64;
 		rc = set_handle_irq(&riscv_intc_aia_irq);
-	else
+	} else {
 		rc = set_handle_irq(&riscv_intc_irq);
+	}
 	if (rc) {
 		pr_err("failed to set irq handler\n");
 		return rc;
@@ -195,7 +198,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
 	pr_info("%d local interrupts mapped%s\n",
-		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs,
+		riscv_intc_nr_irqs,
 		riscv_isa_extension_available(NULL, SxAIA) ? " using AIA" : "");
 	if (riscv_intc_custom_nr_irqs)
 		pr_info("%d custom local interrupts mapped\n", riscv_intc_custom_nr_irqs);
-- 
2.43.1


