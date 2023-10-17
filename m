Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FE7CC8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjJQQ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJQQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:28:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78438FE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:28:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9190787a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697560114; x=1698164914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qD1TIlJEBCWEp5FpDJPkSVLZhr5746v+N1MHVT+wqUc=;
        b=Vw7T5U8ZJWJInx84EWbACpNalJCaDBZbw+tDSAl5JWmIBBYbpZCd/T1HRfMzqbQCJ+
         m7+f1s4RANwmdTSE4kSmC5IE2DZCQMFG1llx9jzX7GecUfHAlCqM803ZOnpD9QSnGjVk
         fNNlrFXZ26ZTW8432tPdPlt4ZojP18ukJYow7/uYLaRbCp9dpCd8eBSezzf5uGkVvKbO
         F7S/zTd6BVmKVtW53eRKrA+BdqOsTXwgsMOg2fSvt0xyXg3JaQSAszlPFSYKX/vVPxHM
         eYvvX/eQZATdc7qEJH/XVgYyhXVJm5XWusf8R27o3uH5AlXWdYrmBXdxoOBdKtBY5uL/
         oWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560114; x=1698164914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD1TIlJEBCWEp5FpDJPkSVLZhr5746v+N1MHVT+wqUc=;
        b=TB1jsJyOXER0id7JezMvjZRfxqMFitn7WrlneOvZ0x8IOmLRzfKY1YJEgvgwWcmaZX
         9+FomyZCAHtX18LOBw6r7Px4y8Wi9y8ce0jYkj4IAIQhCzmv/m9ax+vLWJkT6Sa/AzxY
         GLe8TqxA3yvuhr9t/U/BXholo9QaMN0ZoaHl+duDApzs157/kr4e+ZI1CQnyd6JNOrry
         xONZmJFwN/hMU+j/7SvajU9cduJcJEwq51bEUSIM1uP3byKFiQxdxXTfgE1jjWRUY4/I
         WHoICQE8d/R15gcvUqWjbeVYXHhHw0KJ0QGXaodr4C7hLiRyha7FwvARHunhUgsHPUP3
         RM7A==
X-Gm-Message-State: AOJu0YwV6iniSThpInAOIkmzp6jZLKF8scbNkV4ASTgbcucwiqnITx9t
        BpNMteVrfm40s7L18GOgSz8=
X-Google-Smtp-Source: AGHT+IE3Cfh9b/JzqGg6j8gIi+dTtztg88/AEC+rLc5ZXs12bE5RhG34cZdOWcisCjIuoDPYLKhuIg==
X-Received: by 2002:a05:6402:40ce:b0:53d:d8ad:4d46 with SMTP id z14-20020a05640240ce00b0053dd8ad4d46mr2756595edb.36.1697560113606;
        Tue, 17 Oct 2023 09:28:33 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b42-20020a509f2d000000b0053e43492ef1sm1515759edf.65.2023.10.17.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:28:33 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip v3 1/3] x86/percpu: Correct PER_CPU_VAR usage to include symbol and its addend
Date:   Tue, 17 Oct 2023 18:27:32 +0200
Message-ID: <20231017162811.200569-1-ubizjak@gmail.com>
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
Cc: Ingo Molnar <mingo@kernel.org>
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
index c73047bf9f4b..4e295798638b 100644
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
index de6469dffe3a..1a88ad8a7b48 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -190,7 +190,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + FIXED_stack_canary
+	movq	%rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
 #endif
 
 	/*
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3aaaa0..3dcabbc49149 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -448,7 +448,7 @@ SYM_CODE_START(soft_restart_cpu)
 	UNWIND_HINT_END_OF_STACK
 
 	/* Find the idle task stack */
-	movq	PER_CPU_VAR(pcpu_hot) + X86_current_task, %rcx
+	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
-- 
2.41.0

