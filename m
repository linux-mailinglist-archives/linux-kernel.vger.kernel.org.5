Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729B7D2CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjJWIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJWIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43CD7D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c8a1541232so25448305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049801; x=1698654601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDj8p8VlOUWmt6ePZtJj52Ju7p2Y1636xaXynBRmH4M=;
        b=ESLob1UbjBeQXWmATGlGDVFX/ccJq/psY6rKeSPpA5LQihEo8YeLQ2FFAjwkd+VUaw
         IwAVoLM51QGFiGje6BpmxP4gHZBXyYZ2HFrQmWyiTYJZx9PvHYex7AMKKesIGwi4JDrK
         HLwT2vhrf1ognNZ/vRWda4g56Ide3aPgJMiaStUTt/Q3Id5T7hWGmqDfFg+QOGxtDj3B
         IynOaUV03m2vtY943kZctQ/GfLjxWUAU4aUe51V/NxQNhsHTlr2aSk50s+bZjTAIUPDk
         2J1izRBehLaBLMV4cfZLxWX6682m6qDZ/gtd3LmkUHEFXeP3MYy66gTS5bFWL8cvBxYl
         M3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049801; x=1698654601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDj8p8VlOUWmt6ePZtJj52Ju7p2Y1636xaXynBRmH4M=;
        b=umF16mmFxUbnA0UdABWz3UOgj2BQ9nANr0CaEpRxMeMGWoaKUbqvl+OLz8uDXKHwHM
         /wJ20truLDvLbREgfKIdTIC+SKj6bhbzZkubMS6hayGkw1I5SBIE90+U4h69/Ue7zwaR
         RgYYMpcrdpP9TVWiCNRr/k2orsyjv0ajjTMRY5mZizzqiY3aop4/OkocVThoW3hMhKOH
         pvQA4Ivj5ddPYmrsdVsFKdFvUYVA/eHevJLymjZocGTBeFMDlxRuSBN/lYnejt0NARLl
         Lh4/oVA2llQvKG3/gk/olSzG+Vc/kxl2qfGT5xPt1uhcC4T91/ZO7zBBbomaNfytuiYT
         OQuA==
X-Gm-Message-State: AOJu0YxWkKGr27je7VEH/XpUbcBiMWfKl/AcVaXR1d6rJHV6c4RxV15t
        +XXc2g4xvvXdtiw7dXOf+posUQ==
X-Google-Smtp-Source: AGHT+IHcCdTfYDcXkZ0Qt5csB3IUm6TeiHVMhTQKrBuA3FQKpUEaJPQvyodQ8j5twuKfm3ICNLk/lg==
X-Received: by 2002:a17:902:c602:b0:1c8:7822:e5c3 with SMTP id r2-20020a170902c60200b001c87822e5c3mr7531739plr.47.1698049800869;
        Mon, 23 Oct 2023 01:30:00 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:30:00 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 07/12] riscv: Handle pseudo NMI in arch irq handler
Date:   Mon, 23 Oct 2023 16:29:06 +0800
Message-Id: <20231023082911.23242-8-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit handles pseudo NMI in arch irq handler. We enter NMI context
before handling NMI and keeps all interrupts disabled during NMI handling
to avoid interrupt nesting.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Hangjing Li <lihangjing@bytedance.com>
---
 drivers/irqchip/irq-riscv-intc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 83a0a744fce6..c672c0c64d5d 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -20,6 +20,26 @@
 
 static struct irq_domain *intc_domain;
 
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+
+static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
+{
+	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
+
+	if (unlikely(cause >= BITS_PER_LONG))
+		panic("unexpected interrupt cause");
+
+	if (is_nmi(cause)) {
+		nmi_enter();
+		generic_handle_domain_nmi(intc_domain, cause);
+		nmi_exit();
+	} else {
+		generic_handle_domain_irq(intc_domain, cause);
+	}
+}
+
+#else /* CONFIG_RISCV_PSEUDO_NMI */
+
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
@@ -30,6 +50,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 	generic_handle_domain_irq(intc_domain, cause);
 }
 
+#endif /* CONFIG_RISCV_PSEUDO_NMI */
+
 /*
  * On RISC-V systems local interrupts are masked or unmasked by writing
  * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be written
-- 
2.20.1

