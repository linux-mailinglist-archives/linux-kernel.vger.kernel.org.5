Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED897B8354
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbjJDPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbjJDPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E24CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4064e3c7c07so3944735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432471; x=1697037271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgvk3biMyb3dWXWlkLQojD9wXEb7N0NOjcs65taIzUI=;
        b=nUeW6T6pTJRYIOYabrcMy7S4fkvdDOWVf5fOP5TrBvUZzdn6BedDcai/Gs1PVuwkRw
         LuDmxohXQq2cN1XGUDGCbRCMUcn5jFqCkkIa83rYiOCxswXKf1FNQB7ssZPfgla+j4Ib
         xNjaEN280Y7mCrh6aRjz6lUMh5lMXxBuS90a59/LkKVZt7Llk4uhzWj5g/a4Kj5Tjeu1
         IrzS6hQMmKGqqDifEsTRYb8ctZtd0smJYTTeEoiU87bbVyIWTxElkPHULNWfIh2qZnd/
         taEIeUd1Wn3Plgo/R4lOmrZ/Z74qenyIR6/lnsIArf3+KVzSWARMC138dVV1WnJJaKGu
         EMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432471; x=1697037271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgvk3biMyb3dWXWlkLQojD9wXEb7N0NOjcs65taIzUI=;
        b=Tm/EJKs8pKDpvzxd2rqyBvOHoNDZJARpdoUitP8mw2/V+GsIWUnN1Mf2LzC6oQYiIV
         JuWHIN9uuOzF8RjeF/Ep24H386ENCSL/tCH65XRngey7KxVVZJSd2oy6vGE7s9pb+dJ1
         S0twostrSluVp4Fa7cnUGtLnCgB0elc2vIiWNk/l6WwsvKsZ8ZBffX6FEWZj0acyD/UV
         2jeVlwf9lKNMpq9w5q5UzULQvRTkdqiRe684YFTEtxfXiHEtxUmjPaHe3gUavq7Zx8On
         LEj25TTXDKVl5hFtr4faE3tKXPipI2+CKasyuUR/qoCSLy51Ju0P5su+uxFNcL0SLD1q
         4foQ==
X-Gm-Message-State: AOJu0Yy5/5k7iRBAAfMGPpEB+FlLE37RgZWP8qjVQyCelRBIhTNoX+bp
        YYgmftPJDLH/r4g4wqhMYGP4Dg==
X-Google-Smtp-Source: AGHT+IFWFyxvkpKoO/6/23fHvmhwPdqiEfb/7rp6Yc0TRcJio42GVyA9Nn9VHADu7IcrpwduTsF9nw==
X-Received: by 2002:a05:600c:5192:b0:405:1ba2:4fcf with SMTP id fa18-20020a05600c519200b004051ba24fcfmr2488360wmb.4.1696432471665;
        Wed, 04 Oct 2023 08:14:31 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:31 -0700 (PDT)
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
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 8/8] riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
Date:   Wed,  4 Oct 2023 17:14:05 +0200
Message-ID: <20231004151405.521596-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/riscv/include/asm/processor.h   |  9 +++++++++
 arch/riscv/kernel/process.c          | 18 ++++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c |  6 ++++++
 3 files changed, 33 insertions(+)

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
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index d99b95084b6c..bba301b5194d 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -418,6 +418,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 	if (!unaligned_enabled)
 		return -1;
 
+	if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -517,6 +520,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 	if (!unaligned_enabled)
 		return -1;
 
+	if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-- 
2.42.0

