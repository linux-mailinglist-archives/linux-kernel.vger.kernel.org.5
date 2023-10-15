Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044D7C99ED
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjJOQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:10:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920BAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:10:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so6346920a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697386246; x=1697991046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6M2BQ1j3esHLsNrh33huqDf3/RvkLGOffuZFGUfaNiI=;
        b=a5jFmB1ArHDMI0o97VhnBcaVGCdV0SqnSsHXPjc4/p/q8oHsSHSKR/2cOKxZ9ivfJT
         LTcLwwm/tie1unNIjkA66W1ZuI8CQek7+m5ObohxPMgvlIXw6ORGQ9/MJw/QDUt+sbl1
         aJu6JsdBl5o00du7fbRZ9gibnRuQ27dEhNdNxaTDbaXmlBOsMvGx9MNo2seSkfysmaW2
         X5TCLksqRnEF95rwW4CKUe6POG+c49M5u9H7tmOVw+RFR8YDq9qZh8IJHfS7NdjJCJ2n
         l/NstXFt/aSwfcgeKZo4tBRz8LFm/TEhEPw7LVWQmKn4PEZG3RuSqZVu/YKr1QOJUInr
         GNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697386246; x=1697991046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M2BQ1j3esHLsNrh33huqDf3/RvkLGOffuZFGUfaNiI=;
        b=G7hC7rEown9zbUTlvEgRavlSolto/DOIC6b7iSydxX+ZPRQ04jk+ZTqZOqMzgWKE3R
         AvrwLB4vwGBFSCs+s0SWIBjifQs+TLVK2gnoD+LwjPWlAnjPYMBSSe9hDy32WjEflw81
         +VFSvfJYsTskDx6ls2rz+DymVHjnzYt9mrjJQY1yQGpZvgORpwiwUUaDaw5DRAJbJ18M
         7BGLDd+/9YVyY/tQdbKJ5XJwhTbptyExbgb5yV7RpXABPWtMKqTS7lvy596vy6oxrnI3
         igx6XgtxlK24b/tY/Y2KYhKCI59UmnZdxhNzwp7Kpd+tpdky9O9KUI/zd0rKd8Xyvp0k
         Jj0Q==
X-Gm-Message-State: AOJu0YysPWA+n3DhAPx6add5ti8+cmbU1VTd4JKT26RyIRSxe9FLKxNb
        zZF3gc73SOsPYdgqGPslPogteagIUOyaeA==
X-Google-Smtp-Source: AGHT+IEvlhJjwyQxB/GihB1vaJMXVxCuUzFpGcYEAGzxv4qn4tTRurqXJe51uzZpYjAHwtycAh8vUw==
X-Received: by 2002:a17:906:c5:b0:9ad:c763:bc7a with SMTP id 5-20020a17090600c500b009adc763bc7amr26258797eji.23.1697386246235;
        Sun, 15 Oct 2023 09:10:46 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id rh14-20020a17090720ee00b009b947f81c4asm2421863ejb.155.2023.10.15.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 09:10:45 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 1/2] x86/percpu: Correct PER_CPU_VAR usage to include symbol and its addend
Date:   Sun, 15 Oct 2023 18:08:55 +0200
Message-ID: <20231015161036.39689-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PER_CPU_VAR macro should be applied to a symbol and its addend.
Inconsistent usage is currently harmless, but needs to be corrected
before %rip-relative addressing is introduced to PER_CPU_VAR macro.

No functional changes intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/entry/calling.h  | 2 +-
 arch/x86/entry/entry_32.S | 2 +-
 arch/x86/entry/entry_64.S | 2 +-
 arch/x86/kernel/head_64.S | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..47368ab0bda0 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -173,7 +173,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 #define THIS_CPU_user_pcid_flush_mask   \
-	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_pcid_flush_mask
+	PER_CPU_VAR(cpu_tlbstate + TLB_STATE_user_pcid_flush_mask)
 
 .macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6e6af42e044a..d4e094b2c877 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -305,7 +305,7 @@
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
 #define GDT_ESPFIX_OFFSET (GDT_ENTRY_ESPFIX_SS * 8)
-#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + GDT_ESPFIX_OFFSET
+#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page + GDT_ESPFIX_OFFSET)
 
 	ALTERNATIVE	"jmp .Lend_\@", "", X86_BUG_ESPFIX
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de22511..3d6770b87b87 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -252,7 +252,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + FIXED_stack_canary
+	movq	%rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
 #endif
 
 	/*
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ea6995920b7a..bfe5ec2f4f83 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -449,7 +449,7 @@ SYM_CODE_START(soft_restart_cpu)
 	UNWIND_HINT_END_OF_STACK
 
 	/* Find the idle task stack */
-	movq	PER_CPU_VAR(pcpu_hot) + X86_current_task, %rcx
+	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
-- 
2.41.0

