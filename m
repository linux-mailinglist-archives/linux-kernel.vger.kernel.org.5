Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216CD80FB82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjLLXn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjLLXnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:43:24 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71EA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:43:30 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1fb33059466so4383954fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702424609; x=1703029409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNd4cydKF+lz1Ya2rZoPQuxGthKYpbAQUeO2mpbG8PM=;
        b=SpEqdIb84jB9+saQpsohEJ7f1TMlWgg9D9mw10Z3CQEm/kCGnQfmkeYywItOhZ+ji/
         EL5Oulo2kv/DVV6C2NUWxThh2yvoULz9u+sDXVpVhO36myPYvgL0/Mb7M8FdHBWli0H0
         3/GgvzsB+AaALWpk37kdGn4RPOjDQYo3bTvbMeUbniUD5kTAKnXt/6DckcWnzAbt/p9A
         sh1kvdhyzpM1EecN+pnBEgczf7dBAspfG9j6b5uCzh58pSTDLcHuOKyHKKobxKbfcR8s
         dlGCXSQC0CAcwlePDtc7N1b7bnbHMyfwbxqXnYWY6Ie7fldhwNuQPPFfc9IUK22zllca
         azZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424609; x=1703029409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNd4cydKF+lz1Ya2rZoPQuxGthKYpbAQUeO2mpbG8PM=;
        b=khYvOvdPgL5pQ/b6p+mfUX5wbPV5/koPxv9BFq6GK4tW1eQPGWaI9lmI7n/gV689WU
         YElo9n/8FG8448Z/QuEyyiNpFw4UhvLexHYNav4/luoK0s1aOilLh1WJv7bkK0jw/A8Q
         K4/BnUp1DXQKCNTYa6bro6ZAKIOXS9PPZGrzbHwVDCsR5KE7gWa5Y7xqSvUl+iduiW/K
         YFKrUbHZnZGg/DGA3738p352PPlgrYd+H7p/rXA/EN0gNxlZt78yf5Pyc5Rx7fTUFgZE
         B5QvOgL08nOEScn9UoA25WmxBo95c7Dx6ckhFEO1scISDTkA8BpNFn7REUQw2vmJ2/qC
         2ngQ==
X-Gm-Message-State: AOJu0Yy1hFLc5x/MCtj2+kTKHH+6tVro+xCMNhGMK6/S5IKsaS54wRj1
        9RMhoHpGLieKThfRfEHKxugaGQ==
X-Google-Smtp-Source: AGHT+IEHzx4vj2UvrndZESerQKod5hFuqcwBJIVl9cik0yq8CJG/pTBNuU4yL62/5smMAPqIB574eg==
X-Received: by 2002:a05:6870:c98a:b0:1fa:f63a:13db with SMTP id hi10-20020a056870c98a00b001faf63a13dbmr9114496oab.51.1702424609343;
        Tue, 12 Dec 2023 15:43:29 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b26-20020aca221a000000b003b9ce74a69esm2648470oic.38.2023.12.12.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:43:29 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
Cc:     Deepak Gupta <debug@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] riscv: abstract envcfg CSR
Date:   Tue, 12 Dec 2023 15:42:44 -0800
Message-ID: <20231212234310.2034900-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch abstracts envcfg CSR in kernel (as is done for other homonyn
CSRs). CSR_ENVCFG is used as alias for CSR_SENVCFG or CSR_MENVCFG depending
on how kernel is compiled.

Additionally it changes CBZE enabling to start using CSR_ENVCFG instead of
CSR_SENVCFG.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h   | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..b3400517b0a9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -415,6 +415,7 @@
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
 # define CSR_TVEC	CSR_MTVEC
+# define CSR_ENVCFG CSR_MENVCFG
 # define CSR_SCRATCH	CSR_MSCRATCH
 # define CSR_EPC	CSR_MEPC
 # define CSR_CAUSE	CSR_MCAUSE
@@ -439,6 +440,7 @@
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
 # define CSR_TVEC	CSR_STVEC
+# define CSR_ENVCFG CSR_SENVCFG
 # define CSR_SCRATCH	CSR_SSCRATCH
 # define CSR_EPC	CSR_SEPC
 # define CSR_CAUSE	CSR_SCAUSE
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..98623393fd1f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -725,7 +725,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.43.0


From 2ad5b91bda97f6dbc9f48a2e0e8c6eae5b8452ca Mon Sep 17 00:00:00 2001
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 12 Dec 2023 14:28:59 -0800
Subject: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit

envcfg CSR defines enabling bits for cache management instructions and soon
will control enabling for control flow integrity and pointer masking features.

Control flow integrity and pointer masking features need to be enabled on per
thread basis. Additionally, I believe cache management instructions need to be
enabled on per thread basis. As an example a seccomped task on riscv may be
restricted to not use cache management instructions

This patch creates a place holder for envcfg CSR in `thread_info` and adds
logic to save and restore on trap entry and exits. This allows such isa feature
to be enabled on per thread basis.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/thread_info.h | 1 +
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/riscv/kernel/entry.S            | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 574779900bfb..320bc899a63b 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -57,6 +57,7 @@ struct thread_info {
 	long			user_sp;	/* User stack pointer */
 	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	unsigned long envcfg;
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a03129f40c46..cdd8f095c30c 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -39,6 +39,7 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+	OFFSET(TASK_TI_ENVCFG, task_struct, thread_info.envcfg);
 #ifdef CONFIG_SHADOW_CALL_STACK
 	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
 #endif
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..a1d87013f15a 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -64,12 +64,14 @@ SYM_CODE_START(handle_exception)
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
 	csrr s5, CSR_SCRATCH
+	csrr s6, CSR_ENVCFG
 	REG_S s0, PT_SP(sp)
 	REG_S s1, PT_STATUS(sp)
 	REG_S s2, PT_EPC(sp)
 	REG_S s3, PT_BADADDR(sp)
 	REG_S s4, PT_CAUSE(sp)
 	REG_S s5, PT_TP(sp)
+	REG_S s6, TASK_TI_ENVCFG(tp)
 
 	/*
 	 * Set the scratch register to 0, so that if a recursive exception
@@ -129,6 +131,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	addi s0, sp, PT_SIZE_ON_STACK
 	REG_S s0, TASK_TI_KERNEL_SP(tp)
 
+	/* restore envcfg bits for current thread */
+	REG_L s0, TASK_TI_ENVCFG(tp)
+	csrw CSR_ENVCFG, s0
+
 	/* Save the kernel shadow call stack pointer */
 	scs_save_current
 
-- 
2.43.0

