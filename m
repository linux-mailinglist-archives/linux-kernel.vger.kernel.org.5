Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A097B600D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbjJCEpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbjJCEo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:44:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF6F0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:44:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565e395e7a6so254508a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696308293; x=1696913093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=OUIhVTg0w3otEiz9JTv35uLP4rCDXwqmTVC9TLZZLxpZSds3ylqEsc0otktFPMXBux
         BWNwGSTcITMP+EOZT9LrvPRI5kTENgMy6s7wx7ar25T+C6rrAHDBG6RjhwTo2cqyFWDh
         98rIC8Tqi5A6cNG8uc93TvngDHYCqt+HQnPm5JKUFu/Q5x5JdZMmZPD6ZSYgLQuFC2Fs
         HblaY3qkc1wm9GrV9oj026WnZbXJ0oyTl4PnYG+kd82rjl9UsIiSnW/r8THYuRy/UU1I
         xGmDGeB+DFK/XH+XUU5XwmZHHBoc7cSjhKsbf6GPQVI6gvpbnkhUs60AILAxMccjjYxU
         qiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308293; x=1696913093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=IsFLFvvP4toTEY0/UeuwAYNEiVl07Ffm58Zg5Cj6mOy6FfU4x5a6xWWfjTxDyNEMs8
         +TXlInEsY0VZwHgpG0g8XoKrCxu0SqM8aNLFUsz9r16x/kUBNwviuGsMCqNhW/aHyfc3
         WiQiwB5B09kmMHS0a3i1NFwBImMAXSzAxpVVYD19sHrLR2n5P5eT/HUxiKTZymcHDpJW
         lkME6SjkN8D9ma2pa750ySyj/bzxXt9+7s8tF/pBD2qbbBpVTzvFel5xjsgdB9hXwoZF
         TBn5AKX2fMKZ/T1dhiREeqQ64erfXPZyN3sFcD9xFd5VD8srO7pC5BKzZ8AMLxZgsIE5
         gF4Q==
X-Gm-Message-State: AOJu0YwZbmvS294w4OQmOJ77aKqMbKlVW+RBArBTCeEFSjYEGSvcUpPq
        zbQ18F/SADxJWmCFQpWUE13w1w==
X-Google-Smtp-Source: AGHT+IErIGwew/5bRYW1/++ahAiYLbcPWxK+l3oardRgJZqLBMo54T3jsTCtBmg9kGmFkIXSEs5qEg==
X-Received: by 2002:a05:6a21:81a0:b0:15d:ae4a:9a72 with SMTP id pd32-20020a056a2181a000b0015dae4a9a72mr11250884pzb.61.1696308293211;
        Mon, 02 Oct 2023 21:44:53 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0068e49cb1692sm346421pfo.1.2023.10.02.21.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:44:52 -0700 (PDT)
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
Subject: [PATCH v10 04/15] irqchip/sifive-plic: Fix syscore registration for multi-socket systems
Date:   Tue,  3 Oct 2023 10:13:52 +0530
Message-Id: <20231003044403.1974628-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003044403.1974628-1-apatel@ventanamicro.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

