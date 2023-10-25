Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387637D6F74
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjJYOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjJYO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:28:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5691BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso4905615b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698244134; x=1698848934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=IbFrlO1q1IRLg9KJdY4YdwXCNPZ6p9LFwh5ho84gZfYYXJVhcQK98W4YAvYYT98A4N
         L77j2bBCG6id+d8xwPOeRpU2JLRF8y469rV16O1SC5j9V8shgLg3TygD6BRHxUvO30p0
         jVlCKGDyIH8LLZrPfwKB4ox9B/hHHCH2xV3VgmtGiM4q/Tv6MKlmn919QTG0EY3Cufrq
         FwXoqge0GuOiUFihcWSeEb440nfIbvNEEsAfjPMqQRyjxf9O6HNVdPDP3Vcd+Fue+tI/
         jljLRYsJswYcG1IZjqW7w0xkbUhNyQYvqWOhOt724YIeTLy5uoepN8o429wAB1gDm24Z
         X8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244134; x=1698848934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=JHnrQLxMsOCeZssG277/4UqGj8lVoM5paVUTcoT3GRRh6Q6OSe+T5hdJH0WpOvrZfM
         u8Lix2jA+cWq3IpUynOxJZxPZkva4U+mZLAxR5tbr45H0eQMt9GGzBxj5CXOjLDddFV5
         DwSfM/QzgoBESnojecy7dGuGPXQtvNEjt4vh7//BWOWI0Sbe2dgFoWWCRlaJbRpxuFUp
         U3EiSe8XdzdT/0oU5cz0X1WlK3F/hEf/KJGSqq+PUbXwd5dhvlbtQALxCSH/kgR5Mfwo
         xMRFEOX2zCYGB392Kk+Jr7LFgC5uvk3m3MROzLGjmUOgESlzpF2UoJDwCc12iwsWYv7L
         bcNQ==
X-Gm-Message-State: AOJu0Yyl5O1a36UQSE2YjRsJKO3mFYI3vqf2gjmvDjiKiPJyu6rfj3kj
        veSW8bnJj7Ckl9cC6CqkbMcJiQ==
X-Google-Smtp-Source: AGHT+IGHCSEg7Io7oj+lSNy3jedLTxF0ufcFdVxgxPqyNpxvjQpIXsr2HA/g8AyNGEr3ud2qdGJrTw==
X-Received: by 2002:a05:6a00:990:b0:690:c887:8cd8 with SMTP id u16-20020a056a00099000b00690c8878cd8mr14948358pfg.32.1698244133835;
        Wed, 25 Oct 2023 07:28:53 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id g2-20020aa796a2000000b0068ff6d21563sm9817411pfk.148.2023.10.25.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:28:53 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 3/3] irqchip/sifive-plic: Fix syscore registration for multi-socket systems
Date:   Wed, 25 Oct 2023 19:58:20 +0530
Message-Id: <20231025142820.390238-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025142820.390238-1-apatel@ventanamicro.com>
References: <20231025142820.390238-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On multi-socket systems, we will have a separate PLIC in each socket
so we should register syscore operation only once for multi-socket
systems.

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index e1484905b7bd..5b7bc4fd9517 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -532,17 +532,18 @@ static int __init __plic_init(struct device_node *node,
 	}
 
 	/*
-	 * We can have multiple PLIC instances so setup cpuhp state only
-	 * when context handler for current/boot CPU is present.
+	 * We can have multiple PLIC instances so setup cpuhp state
+	 * and register syscore operations only when context handler
+	 * for current/boot CPU is present.
 	 */
 	handler = this_cpu_ptr(&plic_handlers);
 	if (handler->present && !plic_cpuhp_setup_done) {
 		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
+		register_syscore_ops(&plic_irq_syscore_ops);
 		plic_cpuhp_setup_done = true;
 	}
-	register_syscore_ops(&plic_irq_syscore_ops);
 
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
-- 
2.34.1

