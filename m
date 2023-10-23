Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436A7D2CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjJWIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjJWIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1091510EF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2910294b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049812; x=1698654612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ95gw/OAzQTy7Pqa/IxTLGW5cdMj2QHsOf1G6j+k+o=;
        b=S30YYUPeF3K4Wg7u5gv9HP8YR1365PNv7lH+yH8yqCc8lgXpWtld+GOUV6U7GTyVS+
         z2i6EMgOwPqz2g8s079d1IGwRG5mdFGLL3yrri0vfqCM82IaDJBhdWfQbCiDszl8lqST
         nunaU991Zqd9Qv2rNXHHeyN9d1luOOD1BBb59nG9LQfmipfpOxjHyBeFD9h53TnHfvPO
         VLFwmsehR+/ER7sRRODTWF7nO1Q+1KoTh54UE/ZaIU6yJf62qYWBlDeVMe18atuoKP4W
         I2tppbSMuDVaigItRRWfAPpa2GVrMq8AQs1ViWm0O7V32Z7kbGWfO2iqWqcU7WSXqpCL
         OwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049812; x=1698654612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ95gw/OAzQTy7Pqa/IxTLGW5cdMj2QHsOf1G6j+k+o=;
        b=Ak2HaZ06WNAFnN0NNl6spF8BOxZHeBrgNwEhlfph8vyjcO1osWBFe0hIUSBuIWpsjg
         Ysd3sC6hkhm6SLeWtZ3cp/sfb7gcKmjT4xkHEyWYqdXvl/4f7V8laj7B24yNewX5hitQ
         sg9S5//TrfeBT9z1rfEtRsl3JBdlRpM4INwJxPRwyKfZde6tYOizMFE7bwBAaimxwV2n
         IU0HvtG0H+RwIYRuGesOWLukMH5j2ch7Cp5LumNA2Cmqpv8oTaa/ZAYJliflInauYp9M
         wGw4+SzQqsO8iFAJIw0/43iB1ZBroEXvMj80vJphwzn6o8HZd/pA05xnlqciu/D1neRf
         MTUw==
X-Gm-Message-State: AOJu0YxuMO1DjDMAL8wE7Mo+I8cGITcLCCHMsCovbRFyN6gcoGE/uXr2
        MsKGOAC4iI08QoCmcaRumvt90Q==
X-Google-Smtp-Source: AGHT+IGiT6MKYuJi2ZVpq5CAD0Z+TUVQ/Ug4skMI+tZ5HzA4krihsDz81Ez71goYp3lfV7OVtvYOHA==
X-Received: by 2002:a05:6a20:1611:b0:17b:8016:6f79 with SMTP id l17-20020a056a20161100b0017b80166f79mr10196547pzj.3.1698049812218;
        Mon, 23 Oct 2023 01:30:12 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.30.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:30:11 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 09/12] riscv: Enable NMIs during exceptions
Date:   Mon, 23 Oct 2023 16:29:08 +0800
Message-Id: <20231023082911.23242-10-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have switched the way of disabling irqs to CSR_IE masking. But
hardware still automatically clearing SIE field of CSR_STATUS whenever
thread traps into kernel, which disabling all irqs including NMIs.

This commit re-enables NMIs and normal irqs during exceptions by setting
the SIE field in CSR_STATUS and restoring NMI and irq bits in CSR_IE.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h  | 13 +++++++++++++
 arch/riscv/include/asm/switch_to.h |  7 +++++++
 arch/riscv/kernel/traps.c          | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 42f7803582df..6a709e9c69ca 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -29,6 +29,16 @@ static inline void set_nmi(int irq) {}
 
 static inline void unset_nmi(int irq) {}
 
+static inline void enable_nmis(void)
+{
+	csr_set(CSR_IE, ALLOWED_NMI_MASK);
+}
+
+static inline void disable_nmis(void)
+{
+	csr_clear(CSR_IE, ALLOWED_NMI_MASK);
+}
+
 static inline void local_irq_switch_on(void)
 {
 	csr_set(CSR_STATUS, SR_IE);
@@ -128,6 +138,9 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	csr_set(CSR_STATUS, flags & SR_IE);
 }
 
+static inline void enable_nmis(void) {}
+static inline void disable_nmis(void) {}
+
 #endif /* !CONFIG_RISCV_PSEUDO_NMI */
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index a727be723c56..116cffeaa6bf 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -84,4 +84,11 @@ do {							\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+
+#define prepare_arch_switch(next)			disable_nmis()
+#define finish_arch_post_lock_switch()			enable_nmis()
+
+#endif /* CONFIG_RISCV_PSEUDO_NMI */
+
 #endif /* _ASM_RISCV_SWITCH_TO_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index fae8f610d867..63d3c1417563 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -135,7 +135,9 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
+		enable_nmis();							\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		disable_nmis();							\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
@@ -292,8 +294,12 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
+		enable_nmis();
+
 		handle_break(regs);
 
+		disable_nmis();
+
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -338,10 +344,14 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	enable_nmis();
+
 	handle_page_fault(regs);
 
 	local_irq_disable();
 
+	disable_nmis();
+
 	irqentry_exit(regs, state);
 }
 #endif
-- 
2.20.1

