Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624ED76D0DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjHBPBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjHBPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:01:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA5930DF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:01:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-563f4e49ff9so4143947a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690988459; x=1691593259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVa9hJzP2APKbmQpyeCR0W7lcMtt7PzRbdh31HXulM=;
        b=ZmG/EBVlm1FNTd6nKEXSRojtM28r94q1gev+cUpY5PKAKQNHAjlXzxyYrfPqjK/zGs
         Ic6gKNmPLgk12c53IlzJU23AR9znjJG7+Y9BcSWDpEGji1BQTePM+HGhIDNqmuOXnlHt
         VfdS/y9Tv2ryKoDVLRwjix4kBCSUG0Wp2CFgzjWCJRHLtcarxvD4aY1L+DvfROQI54BV
         z9wFpGp4VqFCwwauwYveoxT4BgMPDchgOpCXLDcV5xuemXqYsm8QkrINBLFq0KXTrpdI
         tn0t8YkAuSGhx5/Vb1votX92KL+GfrKBxSNyIv76Em/S/7SihaSCifZvJgLBGRowhEcl
         PT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988459; x=1691593259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCVa9hJzP2APKbmQpyeCR0W7lcMtt7PzRbdh31HXulM=;
        b=iKGFcA/RCLt73j0/jHoVn51vrz5qOeGBgCQMMY+nRlm42cGr4zLToUy2r5pWEZknpf
         gY4XVSTi1SJRji1HI3SpykhJszp56Vzf6BcqRmACsROZYgSILr4GkCGfiOppVHEv3HXk
         FAZICTxxD6G5GqCsftNtJK4KPWdvZF4XHdUtGgekrP2P4HLaAxkHdZMTGqd49c85r91b
         otFpOx2RVWnFhWsa/e1Ognfecy8fxMyOTsLZc4fUoYO7n4MPNBe08a2TqM+i78b5noPH
         qfJ1vm8vPpUG6+0iZrrxoFYr31Dcn7IrejgSK8pnvx9504pEm7H6I3E+DTXOUY6HO+tQ
         qZHA==
X-Gm-Message-State: ABy/qLbblSZPrcGzOob/KkxIsfprht18UgReMOT2r1VF8XCTSUrg1REg
        4OToRoVfnYVBvTqxR3WUjToHLw==
X-Google-Smtp-Source: APBJJlH8WmII5x8NpCWqAjBeVUllPxLp7iFaK0LpUj/2K69WW4pj6P6pxkO+/x2tXraADNeTJPZZ/A==
X-Received: by 2002:a17:90a:4f0a:b0:267:717f:2f91 with SMTP id p10-20020a17090a4f0a00b00267717f2f91mr13327287pjh.40.1690988458942;
        Wed, 02 Aug 2023 08:00:58 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001bb99e188fcsm12503963plo.194.2023.08.02.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:00:58 -0700 (PDT)
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
Subject: [PATCH v7 04/15] irqchip/sifive-plic: Fix syscore registration for multi-socket systems
Date:   Wed,  2 Aug 2023 20:30:07 +0530
Message-Id: <20230802150018.327079-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802150018.327079-1-apatel@ventanamicro.com>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

