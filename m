Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9344C7C7228
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379486AbjJLQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379171AbjJLQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:12:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C252C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d82bea507so2077547a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127168; x=1697731968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDMSEbE6Ie84T5BkOrHBUuyCR3ToRtFXIBnMpzsN9Bo=;
        b=Wx3RuQBDyTTHA94MKgfUO+Rhw6T/eEaGM0BfllQJG6Umr7z0Kd9/66l2mQWk5fiUxe
         rUYIuVZnWguFvOuMs7OJRNVJ12EDs7Fye9PFIIHMRN6t9b7Xw9KJM8KpnXFZMiDGfnBJ
         W0QqZk8tPWIiYt0/nZBrqOOA2Lj4dhHZJ278MpE35s/p+Y7bay4JgEFFJ0BFoOAy0jz3
         MCINtKspUhTlJ/qfAqRDS4Sr4lg6AXjDhbXGdL8w5Okd1h9n6yvWX50CSzHDMfAOdh0q
         7MLTC67zYJf4tFJsc7JPcN/+hZfk18iONm1hEyF+fJ/wjgnXU1bB/kCL/ahklQE15n6S
         SCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127168; x=1697731968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDMSEbE6Ie84T5BkOrHBUuyCR3ToRtFXIBnMpzsN9Bo=;
        b=uOLXVHRtGLiHRbJkSsVTduQX5bnsDGkCBLdUV1qSq7TBWNEWdIlASwqNOa31bObgy0
         9PGkq6maD8Cd+UAZSUMDNf2EaWgYRze6Q7lnnGUp1tkpabyhAqE4WKgJ1JGOQN4TaB9w
         HCnHrt1TuyMDDsd6xlVCgBNM+mHSXk1w5iVrZ6WKuJWsyQY/ous8QHNTsEEGPMVVNcy9
         ULoQLt868iBoy9u4iydVBdhsIleadoT+DcclXe9GiyL0ZTbeCO4+6+S7sBlt7sY3hp46
         akdAakpSfJ0JiJlr9qqFH0PCfnzbioYIIj521m08eEo6g5zSUUQkqxOQ6qBX2L8Y9x4v
         KJsA==
X-Gm-Message-State: AOJu0YzmJNVisrovCKsEDscwGAdbbBXDkyn3EYMABieK2hesx6aZr4pL
        nVo/UtyuXALHDBaJgFTHy3M=
X-Google-Smtp-Source: AGHT+IEJe39mReMmuqoI7tLyKV8yCFM2VE+XW0dysIJl/d8IcLEFQpg5Cv5p2IFg4LrOKeuqQ65l1Q==
X-Received: by 2002:a17:906:2d1:b0:9b2:b765:8802 with SMTP id 17-20020a17090602d100b009b2b7658802mr24346581ejk.40.1697127168624;
        Thu, 12 Oct 2023 09:12:48 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm11414461ejb.141.2023.10.12.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:12:48 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/4] x86/percpu: Correct PER_CPU_VAR usage to include symbol and its addend
Date:   Thu, 12 Oct 2023 18:10:37 +0200
Message-ID: <20231012161237.114733-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012161237.114733-1-ubizjak@gmail.com>
References: <20231012161237.114733-1-ubizjak@gmail.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
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

