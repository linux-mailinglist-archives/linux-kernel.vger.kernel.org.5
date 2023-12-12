Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DA80FB96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbjLLXvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377494AbjLLXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:51:02 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D19C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:50:47 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6da2db096bcso370195a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702425046; x=1703029846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDRVUnCHqVBNMGZhqCPohfXcgegTHPBlvp76ltshrAo=;
        b=K4RE5qalWc+CitC1XvAzzuV4uZQ22vzhZUqu3mFlzbctLLCkP2xiB5pu+Vz9r2qOa8
         9uReUXVkZoj7qy0gIEGRZN2wyMWcO4fxv59V02fVAQRNjDSUxXtzinGkLZAUOVDUKAFN
         LtHy2WxBsIcfPVGarQqCO9NmBk2aEaF7yooRjdapgdCc3KGK/XIHNx/4aoeQxP8G4b5F
         WocJx5qWvJvPz7KsATWhWVW66IBGgutyOMVvsg9mAF8+SbKn8oKmZe7tjLf5DrYCAMb1
         ZIotDg6sjxAppbW+/fodaRh4o3HTNUz+kfSE8733nfKSXQOEGSaasfpSSUT/E7Or0yxG
         uQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425046; x=1703029846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDRVUnCHqVBNMGZhqCPohfXcgegTHPBlvp76ltshrAo=;
        b=g4tXUe0Acyu3XJoH9qVeBeY3YsPhPuFZn0s3eEsxvI6tZHFfAJITfsWAsSPApIPvxK
         nj7iRkODH5rPuLM1ljsKFT1FK8frjLXkw4K0r1R6717Cc+Dn3cwF87nMdCCl12k6PCfI
         PFP6Wvmfp1PgN7Hb8YkC8tNDz91wf5DcSNR0OlqVHzvA4TG10hS/ziXK1Cf5yXjwBMWx
         l72V8PuKY0/bCdseIe2z/J2Z0xKRUd1KHEFYo2gq9mfAhjOB4vXsqrQxR49bN3b5uAdn
         /brxJHLPXbTgdKiEwAC/9o465a75avhMYnsAuLQEAb7h/AHDdM+QbOYFWnxTCkB9s9K6
         Kr3g==
X-Gm-Message-State: AOJu0YzI0dBhpTlv4PmJnqnBsix8h7UP0fLd+6AbgmMke8BGdon9/cGz
        2myuG1b/aWPHafMzsLXG+Ty4UQ==
X-Google-Smtp-Source: AGHT+IEOA9OOk1W/KojXDfb3Ais4G9s15fdKp+IHUP8pXH3qypddUDcMFyI9c1zXKiioXpSIJUHSJg==
X-Received: by 2002:a05:6830:1b65:b0:6ce:271a:5fd0 with SMTP id d5-20020a0568301b6500b006ce271a5fd0mr3948835ote.4.1702425046465;
        Tue, 12 Dec 2023 15:50:46 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m19-20020a0568301e7300b006b9cc67386fsm2487295otr.66.2023.12.12.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:50:46 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
Cc:     Deepak Gupta <debug@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit
Date:   Tue, 12 Dec 2023 15:49:25 -0800
Message-ID: <20231212235003.2036221-1-debug@rivosinc.com>
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

