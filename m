Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67075944A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGSLgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGSLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:36:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E11BF5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686c74183cso6768745b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689766570; x=1690371370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQiwHLQTp/8j8gItu3f4LCSePQxOFgN8ncFMh196Onk=;
        b=WAO50NkUFcJNAH38hHesi1r+AhVYkQ3T7HiabLtaPKGo+n8KaN9dQ1BPiWlPZaxre0
         ghmIUYzEflFP9s1yN4PmzDbFFZ3yLfhMG/c525rbrL0geQ7j3gmj9QA7MFxracRRnpBX
         swRP3S5w3ETO+2wgm4HsU9zgSReM4HzTxHPhVJueMsqDmzQB68lzUJSCRdWMCqMX8X/R
         ESSNoscvZvcfLh3V+F3fWiIh306v+SdhgYkHCByFQf48Ij43zRqR2DU8rKIfB4sm53sL
         qNGiTx+lgH0c4HPRODh5UqpGjqiqeOtcK8xM3/ADfyHamb9TmsVtx+JvUkIAHYKjWcK+
         FK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766570; x=1690371370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQiwHLQTp/8j8gItu3f4LCSePQxOFgN8ncFMh196Onk=;
        b=R1qugW2uOEGXRLb4ZzseozbA0BX+jHog8PFjx5foPhJf2vIMNAyOvN++6mmONHXpg1
         J4ktrg3s6Prblgg+KePskCis3aAzFyooo6YMEL4AcyrSPLzAmcEr9HRYgsVTmYjtPuxg
         HR51q3nBufcHNTHAaBuN+S90u3gL371ZNkApSrNobKJUDcQ6Ka6WZnP615vO0zKtjjmk
         e3h9fUebftCze6znHR+beKClj8Nxibu4Zj/X12uPktz8O9wm1ixfzlINYduSP0gqvDJK
         QVTHpjc2b1kOIQwNydjH6fhIrKKXYhS6TbReH6ARXCInTq5hIvOdgFvuAZpBoI2R3ewb
         qjjA==
X-Gm-Message-State: ABy/qLZ9uag0I2/NkAd7xP9jNl4LUD1xkGj0d5gXcVfaMerdDv6EwWKm
        3Hc9DD6oOvekgMG8142RsB4TmOiMalbVvP3hckk=
X-Google-Smtp-Source: APBJJlFmLFGryKpfzKpUE3V98g17+lc5UaKu+zvNUvTPMAceFo6f/UbuUr/F/yrJsP0AJyC70N/57w==
X-Received: by 2002:a05:6a20:8e10:b0:132:87da:5b57 with SMTP id y16-20020a056a208e1000b0013287da5b57mr22614317pzj.59.1689766570147;
        Wed, 19 Jul 2023 04:36:10 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.130])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00669c99d05fasm3050408pfn.150.2023.07.19.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:36:09 -0700 (PDT)
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
Subject: [PATCH v6 03/14] drivers: irqchip/riscv-intc: Mark all INTC nodes as initialized
Date:   Wed, 19 Jul 2023 17:05:31 +0530
Message-Id: <20230719113542.2293295-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719113542.2293295-1-apatel@ventanamicro.com>
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V INTC local interrupts are per-HART (or per-CPU) so
we create INTC IRQ domain only for the INTC node belonging to
the boot HART. This means only the boot HART INTC node will be
marked as initialized and other INTC nodes won't be marked which
results downstream interrupt controllers (such as IMSIC and APLIC
direct-mode) not being probed due to missing device suppliers.

To address this issue, we mark all INTC node for which we don't
create IRQ domain as initialized.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 65f4a2afb381..4e2704bc25fb 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as IMSIC and APLIC direct-mode)
+		 * so we should mark an INTC node as initialized if we are
+		 * not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
 
 	return riscv_intc_init_common(of_node_to_fwnode(node));
 }
-- 
2.34.1

