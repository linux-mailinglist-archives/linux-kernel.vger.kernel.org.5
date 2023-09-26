Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8A7AEF54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjIZPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjIZPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16C11D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:04:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3232bb059d3so776037f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740638; x=1696345438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFmLYHjhKHshwcnMAhKMVILwqWg7P2jKMKJHqTBO9sw=;
        b=OCOs+Toc6Zcr89I8P6fgdkouO225He7DaJ2RFuV8kM+kd1GIFL14/6GQmf3+q8Dqdk
         /fLHP9FxG1M9MkErU2RthU1buWKjdjghpM77TOqSAznrQ3APkKT/wqFygw5jnv9j5Kyn
         83yg8scHJzBUfoFdh8OmSbRoLBmJw9nVM58CHlTrYD/NXTJVvzSoH20iojrWvqM/DnDR
         ZW+g8AtxjFTsXrEq2Ljn1aU9JMLQCpFE/SsszwEk8BqGTClbi+pQoy/HK2r59OXP1dl0
         npTVpDEDh8y/Ek2tj2I7JBjPqfP4A/qvWD1MhUXWo2IBnUHCj04Ux+qfyuyuv1JL4gmg
         1wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740638; x=1696345438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFmLYHjhKHshwcnMAhKMVILwqWg7P2jKMKJHqTBO9sw=;
        b=jJfkZdnaIRP1omniPvurm3AO8zKXGG6FGOVyV9xk1n/QQ6vWctbazdMAalbK5jn060
         LW7mrugPbQ7Hz64Km+NwEYaaIB0NwWXYQxAJH/I+WCePD58ckrWHftN6w3nss96SC3sU
         Vmtl5+PYtFbO0Lf6GOABUkbGK4ZC/Mooxky3+AwvJbLsQ3fZkmBvfdyrp8urEGuIg5bF
         2WOXr0wmt4U2zgh5tmhyz9HgcnJkCCp2a2iunk7jQYTQ4NUAPu/nSID7YttG0qQPJxhm
         aaaD+IbH1S8Bf+xkD4l4JMvOTC4HH1RJiI0JKU5LrpHWD45+2mplr0tqLntfm2qwowLr
         UzIg==
X-Gm-Message-State: AOJu0YzHVLpuVIYGMYz7wksLlJzZSjoKEpVGIhO602qfy0iHVXOL3y2Z
        WBvWWvJF8N2JK/X/a85tfI3MpQ==
X-Google-Smtp-Source: AGHT+IF7/3y4X24APaMGQ6kFYsLNk/acfAFaY0nL+weTO0hHgxXwLwx3zMRxiAiTuT7k9FHJ9VrrZQ==
X-Received: by 2002:a5d:6a8a:0:b0:31a:ea18:c516 with SMTP id s10-20020a5d6a8a000000b0031aea18c516mr7713743wru.3.1695740638606;
        Tue, 26 Sep 2023 08:03:58 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:58 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 7/7] riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
Date:   Tue, 26 Sep 2023 17:03:16 +0200
Message-Id: <20230926150316.1129648-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that trap support is ready to handle misalignment errors in S-mode,
allow the user to control the behavior of misaligned accesses using
prctl(PR_SET_UNALIGN). Add an align_ctl flag in thread_struct which
will be used to determine if we should SIGBUS the process or not on
such fault.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/processor.h |  9 +++++++++
 arch/riscv/kernel/process.c        | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3e23e1786d05..adbe520d07c5 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -8,6 +8,7 @@
 
 #include <linux/const.h>
 #include <linux/cache.h>
+#include <linux/prctl.h>
 
 #include <vdso/processor.h>
 
@@ -82,6 +83,7 @@ struct thread_struct {
 	unsigned long bad_cause;
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
+	unsigned long align_ctl;
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -94,6 +96,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 
 #define INIT_THREAD {					\
 	.sp = sizeof(init_stack) + (long)&init_stack,	\
+	.align_ctl = PR_UNALIGN_NOPRINT,		\
 }
 
 #define task_pt_regs(tsk)						\
@@ -134,6 +137,12 @@ extern long riscv_v_vstate_ctrl_set_current(unsigned long arg);
 extern long riscv_v_vstate_ctrl_get_current(void);
 #endif /* CONFIG_RISCV_ISA_V */
 
+extern int get_unalign_ctl(struct task_struct *tsk, unsigned long addr);
+extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
+
+#define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
+#define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e32d737e039f..4f21d970a129 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -25,6 +25,7 @@
 #include <asm/thread_info.h>
 #include <asm/cpuidle.h>
 #include <asm/vector.h>
+#include <asm/cpufeature.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -41,6 +42,23 @@ void arch_cpu_idle(void)
 	cpu_do_idle();
 }
 
+int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
+{
+	if (!unaligned_ctl_available())
+		return -EINVAL;
+
+	tsk->thread.align_ctl = val;
+	return 0;
+}
+
+int get_unalign_ctl(struct task_struct *tsk, unsigned long adr)
+{
+	if (!unaligned_ctl_available())
+		return -EINVAL;
+
+	return put_user(tsk->thread.align_ctl, (unsigned long __user *)adr);
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	show_regs_print_info(KERN_DEFAULT);
-- 
2.40.1

