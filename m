Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A27D3DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjJWR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjJWR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3610F6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5ad5178d1bfso2583668a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082105; x=1698686905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=Vj8O3yXj48ezfKEVXZH6OQyv1S30Aao9NdA6oLxtvtclpgtOCXCrm8UTgpFJOqp3cO
         /eKUomcuxxUZXDHV5YlfaOJqdbbDYY4ZHE2RPqRChyaMHogtlCgEOuvJ8BmdRMcntD+t
         jUNFhiHzxkOnfS9MEnTusVHZuvnS+MFMph/avmp/JeMognpuFDUoKJoR1zwCtVolgj+y
         asIcHW9XMvcoTgBtrckRP6tHrCMY7VkwUs4HeYzaGWyKNdD4o06YN7hAlk2VPzav412L
         Dttk72f8RfpUjDK0RqWLxGdfgeQrI2Y6XuQIewgQi/iq6UvZqbg6SOABBli1zGMQ7zHi
         9GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082105; x=1698686905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=Asp03whLT2ZUWaStjt7ny8afDIyPSIqdbJU8D3NgDvCMeAqYmCt17D98SiXmPCx0KW
         sgoE9bNuNJh6/Wa9iYX2OUoP2ljbv0fZeIm5C5UXYMwch4txaUeGxfcjq2DiJy6rUmOF
         m6sKEGRWp7IDVFpiN26FnkNYcymiy3RICyAfUGK0c9ebmcaU5N+1Y1HiUkXoqjzdQmlE
         lUpOPdV+ELA2/DZqeUQ96Bq4Y3Elf52hnOx6zwcAIEaHGwumFm+pcdyPjexg+stBaGmI
         4O4lpsnCsIWngGZqOQNSW2RiEphZXleCWEDa1L2viJXwCAkmrPYaiv7nWDMmY9k2xsX+
         lV8w==
X-Gm-Message-State: AOJu0Yx4KKoo2Xj8nQtnxKdNTD4Offyk42OPoLTCj12SNWsQBlR5vAKO
        ObctNwjnWvFyxI1QnBHa84Tjnw==
X-Google-Smtp-Source: AGHT+IEnHahVw3qnJm1+n/UjAUiTilQ3VeBFGYVhtzAuitdx99t+7TC49sKKyAJtXJ+4NIsGQtReyw==
X-Received: by 2002:a05:6a21:3d83:b0:17b:cfed:52ac with SMTP id bj3-20020a056a213d8300b0017bcfed52acmr225463pzc.49.1698082105149;
        Mon, 23 Oct 2023 10:28:25 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:28:24 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v11 03/14] irqchip/sifive-plic: Fix syscore registration for multi-socket systems
Date:   Mon, 23 Oct 2023 22:57:49 +0530
Message-Id: <20231023172800.315343-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023172800.315343-1-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

