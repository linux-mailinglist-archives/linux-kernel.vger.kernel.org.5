Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769477D2CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJWIbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjJWIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF77D6B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d1373f631so2375943a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049818; x=1698654618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zaYgIQbfD9rezIYpqI9laPzzTdWx+ZAuyZYYGD6lvk=;
        b=Kjd3jevJivPEcsw5F67N8jy0YvnVBqHR5+uIDJ+9La/cvROPJqBXHLpWV36WidC2Dt
         RqgxAytav/Ur5ma2mfgDfcqN6jrfiMzQxwbb8dN3lsRIktkn6tuMHhGHKADFrFeJfrOu
         vd6vVbV8RzC9b3Nb5A7o5+iw7fF/QxQ4sd6vym6sd+EsWiiO81QOgRu3Mfol527titTO
         U/mt7XTu5CiNZYWEkpb4fElOcSDDuM+n5n8UAyRv/DbiqwpaSUaSULuhBTkIqBC/Ciro
         gsgWWvvEGSv0OIUlxFW8VCegUd4FS9f158yDWngOMSyfvFVSgpOEiUqcizwGCh6+Tgvr
         U16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049818; x=1698654618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zaYgIQbfD9rezIYpqI9laPzzTdWx+ZAuyZYYGD6lvk=;
        b=Bc8xPho61ChO1r5kDpCTLZSReGnYFms6YVjqwM8jucDTmXdnDTDc2LkKM5uZ2rn9GU
         3s+sAVDO0PfyyUypJrTdRxvAWPg3VmjVhQZYTIBeYwb1BmPUgl6/Oyk4WfLkbIECf6bg
         j6LCfYZckZWErH+K9VmJvPa+oSBv/ggTvAFi1cPU2X655B5D6ZQwZhdwetDmTaQIRF0I
         GtoJfVG30Ght9RcC8bG15Zn2d5uL43s/kieDDSQ0UyAhaiM/tNzqQ0W8b/xX8nwas135
         vtxFjms9EDdpr8gWZc2EEkthRk1pvldndgIs+R5OKyT98uR9dphQx7V6O/oP93F+0xcd
         +HLg==
X-Gm-Message-State: AOJu0YzYWyEA9iJeBwps4Y+MdrtzGXLaxDcEZvhlfwjTiXNalNYakGx4
        HaPAiA1GJaufDj+AIFZW2YDZmA==
X-Google-Smtp-Source: AGHT+IFpt0TBJ9j577UmWU9zDZbpQtF3JzZZq4hl33QCJ42B75FqE8SvRamj8B8r3i2TgYxF2UyAzw==
X-Received: by 2002:a17:90b:3e85:b0:27d:1567:f51d with SMTP id rj5-20020a17090b3e8500b0027d1567f51dmr9084887pjb.47.1698049817843;
        Mon, 23 Oct 2023 01:30:17 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.30.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:30:17 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 10/12] riscv: Enable NMIs during interrupt handling
Date:   Mon, 23 Oct 2023 16:29:09 +0800
Message-Id: <20231023082911.23242-11-luxu.kernel@bytedance.com>
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

Hardware automatically clearing SIE field of CSR_STATUS whenever
thread traps into kernel by interrupt, disabling all irqs including NMIs
during interrupt handling.

This commit re-enable NMIs during interrupt handling by setting the SIE
field in CSR_STATUS and restoring NMIs bits in CSR_IE. Normal interrupts
are still disabled during interrupt handling and NMIs are also disabled
during NMIs handling to avoid nesting.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Hangjing Li <lihangjing@bytedance.com>
Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
Reviewed-by: Yu Li <liyu.yukiteru@bytedance.com>
---
 arch/riscv/kernel/traps.c        | 44 +++++++++++++++++++++++---------
 drivers/irqchip/irq-riscv-intc.c |  2 ++
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 63d3c1417563..185743edfa09 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -356,20 +356,11 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 }
 #endif
 
-static void noinstr handle_riscv_irq(struct pt_regs *regs)
+static void noinstr do_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 
-	irq_enter_rcu();
 	old_regs = set_irq_regs(regs);
-	handle_arch_irq(regs);
-	set_irq_regs(old_regs);
-	irq_exit_rcu();
-}
-
-asmlinkage void noinstr do_irq(struct pt_regs *regs)
-{
-	irqentry_state_t state = irqentry_enter(regs);
 #ifdef CONFIG_IRQ_STACKS
 	if (on_thread_stack()) {
 		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
@@ -382,7 +373,9 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
 		"move	sp, %[sp]		\n"
 		"move	a0, %[regs]		\n"
-		"call	handle_riscv_irq	\n"
+		"la	t0, handle_arch_irq	\n"
+		REG_L"	t1, (t0)		\n"
+		"jalr	t1			\n"
 		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
 		REG_L"  s0, (sp)		\n"
 		"addi	sp, sp, "RISCV_SZPTR   "\n"
@@ -398,11 +391,38 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 		  "memory");
 	} else
 #endif
-		handle_riscv_irq(regs);
+		handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+}
+
+static __always_inline void __do_nmi(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_nmi_enter(regs);
+
+	do_interrupt(regs);
+
+	irqentry_nmi_exit(regs, state);
+}
+
+static __always_inline void __do_irq(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	irq_enter_rcu();
+	do_interrupt(regs);
+	irq_exit_rcu();
 
 	irqentry_exit(regs, state);
 }
 
+asmlinkage void noinstr do_irq(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_RISCV_PSEUDO_NMI) && regs_irqs_disabled(regs))
+		__do_nmi(regs);
+	else
+		__do_irq(regs);
+}
+
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long pc)
 {
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index c672c0c64d5d..80ed8606e04d 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -34,7 +34,9 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 		generic_handle_domain_nmi(intc_domain, cause);
 		nmi_exit();
 	} else {
+		enable_nmis();
 		generic_handle_domain_irq(intc_domain, cause);
+		disable_nmis();
 	}
 }
 
-- 
2.20.1

