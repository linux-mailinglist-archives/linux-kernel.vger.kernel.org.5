Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8479D7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjILRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjILRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:50:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318710F6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1e780aa95so40604855ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541049; x=1695145849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVa9hJzP2APKbmQpyeCR0W7lcMtt7PzRbdh31HXulM=;
        b=J/HhH35/a0s/pYGuGN46/ZdMOfdSLAEHJcR2bFhimQDzbQUvGBOrwnHWnBODOVzQuA
         kU9qdnajPm28W9yJXa/02zm0UJqh6bSNi+jhVoW/5tvAIM0QGZ3D32d3nsIPVBGer5vI
         JCx0XsKO8xElDpqiqB7BYfVzt9mn2MxicA0gmkcAoD3pfB29bBjrgxQSEcW7gnmXhH5B
         JitwDEvCyy02rWu/fzQR2smgwl+kG61WY3/5szSmdTQLNk69nnedMLvsFohtw1WenPEs
         ADfoRD9RX4Hwti5o61hGjgDZ2LCGMH55QWKKPmKRjWAFF9dN+lyp4xk8TxHEm1RQemxn
         5KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541049; x=1695145849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCVa9hJzP2APKbmQpyeCR0W7lcMtt7PzRbdh31HXulM=;
        b=P/xnvh0uecqp6T/s/pTmJy3NdVEhid/o9GFrLzE4bdixUhRVJF7kfRA+5cwe13CtZC
         WB/QEgxXZ4qZrBuu/iH2764/KDMdklBtdJvp2dAFxSZCmU0qCPA7uG3DhgknDhWYlZNw
         3nLnW8Z0gw8vpA72XlbbXD/fGsRo7KCHiqAiTO/cXLgySwlu2mCRpWblDOt/7kawOY/W
         B/pwrm+2fp523ti3ctJRaP3riDHd+Ay+QDaSuPdt9nCqaJv61m033dnIgtlMTaeSXnaK
         Go0ERseCO4OmPWIpwY5Zb4coSt8j5D3EFkCpT2t2n6RkPhyMx1wApmFgglrAo8yXY4fG
         GIDQ==
X-Gm-Message-State: AOJu0Yx1W23Ylhal6njScAH4anoDWxdPTLFtscqICVa9Zh2KcBn8kUo0
        hyDlWspcMZYDSbdYA6Ca8U2AGA==
X-Google-Smtp-Source: AGHT+IFCPlDBNQl9A2NXvNyQAQsJVM9d+czenWRCIBPffU6YSIMvNmS34Ur0vjA0HgmnPj5+MBTNxA==
X-Received: by 2002:a17:902:ec89:b0:1c3:9632:f144 with SMTP id x9-20020a170902ec8900b001c39632f144mr578158plg.31.1694541048828;
        Tue, 12 Sep 2023 10:50:48 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:50:48 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 05/16] irqchip/sifive-plic: Fix syscore registration for multi-socket systems
Date:   Tue, 12 Sep 2023 23:19:17 +0530
Message-Id: <20230912174928.528414-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 56b0544b1f27..62ba27553cc3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -533,17 +533,18 @@ static int __init __plic_init(struct device_node *node,
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

