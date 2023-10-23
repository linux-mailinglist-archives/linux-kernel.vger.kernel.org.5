Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191197D2CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjJWI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjJWI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:29:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD21DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so3015197b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049778; x=1698654578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at7wi3me+Z61wYFd7J2d3j74V70AFyRlLZ+mJARIjAE=;
        b=jolbgEvqeuI6JHbIiGOBuLMlL1/o93PhR8i2WR023e0Xd9zQOpaJUdD/NZXBHxb9wF
         /lqv7hExIXx+nQJjLQX/6Uv3TXE4JhRObxZFHRqKHWx2UWLNJVLUUuIvqbXN5Dz71wvw
         6t2VJGMSF8MCZtbzYoIj64xjTpGcMemFcjBJS+LZHOxNQt6ouDqGi3VQC+/HVQjejvb7
         SMsUKV/+6gJDOktDVtxSyQA2ST+HwW6PgHjZs5ZWMdextMgdTpl7FiEy7lL+8vup6ttx
         v6Oy/RZjWl8bwGkdkkDssV9tXIbKQlV62XZIw6Cfg8qkrtAF/42bi38eTxGCXDV+/Cpa
         Fzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049778; x=1698654578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at7wi3me+Z61wYFd7J2d3j74V70AFyRlLZ+mJARIjAE=;
        b=Esja8U4FG07Tk9rFMR8AdAyCcroPybmzXvCv1Sq7CLO3Dga19Rhxyovg+oBg+UezKv
         3zaLC88p0UZBQAscBwiAKflxqZXyrrwVge4h6tjP6G+RFjINPL9efoEEe8KhSy6NiUz5
         aTi3SkSTDevkRMwRv9TSlFOA2tOKnQb5K3xbZgSgnpfSZECpcSBs1uDrcE0tP9xnXszC
         xshT7AjbEu5HALxDyAOuyGN+gJFAPrvuapYCLrpLOBLlqWUYqWkxnMFE+K8LHuUNl5AW
         Kfw/ACeJNlq4SqYFIRAgVje/qFsg4H07GZyPsXXRCm82cNCBz16mDvpsd6+m/Q08+bqS
         p1Cg==
X-Gm-Message-State: AOJu0YwFxQD6JF9IuEFN9QAFIh0HfJ1b/KyEEUCebsnF10OSDg4v17mA
        L7Tal9tlRH3/OIlZVzxxwAubCg==
X-Google-Smtp-Source: AGHT+IHAxAXPREhEH68MgYTJlOqTtsbSB0gFuNM7voWNCv0htKF7/ukJX/oxNlGp1Ca/X+qqi24MCg==
X-Received: by 2002:a05:6a20:7489:b0:16b:afc2:3b68 with SMTP id p9-20020a056a20748900b0016bafc23b68mr10853205pzd.25.1698049778199;
        Mon, 23 Oct 2023 01:29:38 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:29:37 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 03/12] riscv: Switch to CSR_IE masking when disabling irqs
Date:   Mon, 23 Oct 2023 16:29:02 +0800
Message-Id: <20231023082911.23242-4-luxu.kernel@bytedance.com>
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

This commit switch the way of disabling irqs to CSR_IE masking.

After CSR_IE has been made a part of context, now we can safely
switch to CSR_IE masking when disabling irqs.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Hangjing Li <lihangjing@bytedance.com>
Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
Reviewed-by: Yu Li <liyu.yukiteru@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h | 58 +++++++++++++++++++++++++++++++
 arch/riscv/include/asm/ptrace.h   |  4 +++
 arch/riscv/kernel/entry.S         |  7 +++-
 arch/riscv/kernel/head.S          | 10 ++++++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 08d4d6a5b7e9..e0ff37315178 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -10,6 +10,62 @@
 #include <asm/processor.h>
 #include <asm/csr.h>
 
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+
+static inline void local_irq_switch_on(void)
+{
+	csr_set(CSR_STATUS, SR_IE);
+}
+
+static inline void local_irq_switch_off(void)
+{
+	csr_clear(CSR_STATUS, SR_IE);
+}
+
+/* read interrupt enabled status */
+static inline unsigned long arch_local_save_flags(void)
+{
+	return csr_read(CSR_IE);
+}
+
+/* unconditionally enable interrupts */
+static inline void arch_local_irq_enable(void)
+{
+	csr_set(CSR_IE, irqs_enabled_ie);
+}
+
+/* unconditionally disable interrupts */
+static inline void arch_local_irq_disable(void)
+{
+	csr_clear(CSR_IE, irqs_enabled_ie);
+}
+
+/* get status and disable interrupts */
+static inline unsigned long arch_local_irq_save(void)
+{
+	return csr_read_clear(CSR_IE, irqs_enabled_ie);
+}
+
+/* test flags */
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags != irqs_enabled_ie);
+}
+
+/* test hardware interrupt enable bit */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+/* set interrupt enabled status */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	csr_write(CSR_IE, flags);
+}
+
+#else /* CONFIG_RISCV_PSEUDO_NMI */
+
 /* read interrupt enabled status */
 static inline unsigned long arch_local_save_flags(void)
 {
@@ -52,4 +108,6 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	csr_set(CSR_STATUS, flags & SR_IE);
 }
 
+#endif /* !CONFIG_RISCV_PSEUDO_NMI */
+
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b57d3a6b232f..e552e7fb46f3 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -178,7 +178,11 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 
 static inline int regs_irqs_disabled(struct pt_regs *regs)
 {
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+	return (regs->ie != irqs_enabled_ie);
+#else
 	return !(regs->status & SR_PIE);
+#endif
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 19ba7c4520b9..d1f28dab02f7 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -66,8 +66,13 @@ _save_context:
 	REG_S s4, PT_CAUSE(sp)
 	REG_S s5, PT_TP(sp)
 #ifdef CONFIG_RISCV_PSEUDO_NMI
-	csrr s0, CSR_IE
+	csrrw s0, CSR_IE, x0
 	REG_S s0, PT_IE(sp)
+	andi s1, s1, SR_PIE
+	beqz s1, 1f
+	li s1, SR_IE
+	csrs CSR_STATUS, s1
+1:
 #endif /* CONFIG_RISCV_PSEUDO_NMI */
 
 	/*
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3710ea5d160f..4f9446defacd 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -169,6 +169,10 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call setup_trap_vector
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+	li t0, SR_IE
+	csrs CSR_STATUS, t0
+#endif
 	tail smp_callin
 #endif /* CONFIG_SMP */
 
@@ -320,6 +324,12 @@ clear_bss_done:
 #ifdef CONFIG_KASAN
 	call kasan_early_init
 #endif
+
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+	li t0, SR_IE
+	csrs CSR_STATUS, t0
+#endif
+
 	/* Start the kernel */
 	call soc_early_init
 	tail start_kernel
-- 
2.20.1

