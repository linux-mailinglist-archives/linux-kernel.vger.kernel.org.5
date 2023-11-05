Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8327E16DF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjKEVh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjKEVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:37:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51066CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:37:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso586104166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699220265; x=1699825065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgAqePGVhUCu3U56kTFLSJugpfg6qt/lSZ7uytS2Gf4=;
        b=beN4WwOD5FVwnUp8UIdN4MM/fbIPFd7Z5y1dDuuF0fgIrBdq3bhAMHdF+l77ltYJ79
         x+18nDszzq9cFePvqiBWqncGzsDff8Bkr/JkODmWZPu0qXo24n1luWcSSUdcHK7G4gWz
         60guZ8EIP0tyCm184ZwbH/2RPcEL4AMOvux0RdpVMA3di1iznqUOfYBI1Ew82ylHlxAT
         sA5y+7TU2UpTNLsbo1ETR7KqvDuw5lv/6ET20VDmIQ9M4p6F0M6cuXdyeEopYuI+nZ6F
         5AlbWtqIlLdP9Q/JGbouIMRtXu7Bj68kT2Xo5iw/GHG0uU5arY5SUk36coK98WSnEp4H
         ZnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699220265; x=1699825065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgAqePGVhUCu3U56kTFLSJugpfg6qt/lSZ7uytS2Gf4=;
        b=MQB8K0xi0UqBO8/s4FORXUbpeXLwXzw9w+BIB0CJKJuDUceyxmukLxyz5Ih1yIxY76
         oT+9w5w93ESp7v7ZbI/zAPNcDBoxp8aADVDyH1gXibJFbwOgH9jzy7ZzY58t4hKihR00
         FucmyLBnrtJshwIIzWvAq/MPn6Pqngm6qTCjEZtWl8kLxM+HvYiKsUphT3KTpt0r1uUM
         2KJjl3msn0bL/tY1emwHxe3ydD2q/55DgHbQlLnYPrYcEEzRdzxbxC6Kn9LPBY0+keWr
         l/Aq0kCL3KcKLm7RpzW1TOO2lSlNVZLYrO5n8thmbhZF5P72mDBFyJGXuG11QXp5Un/K
         6qZA==
X-Gm-Message-State: AOJu0Yz5jicpIgAD27qIxQ2t3QCoQG94a250AZCQgVpfgpUIEH79GSTk
        U0OJ37vW+Iuo325+X3ZHBd8=
X-Google-Smtp-Source: AGHT+IEF2ldJdGcZVoPUorSjwHeNACRqRBtR/1vAQ2Y2jzwokkjTG5dZddGUTHREoRFo8Un1Uqn5WA==
X-Received: by 2002:a17:907:c313:b0:9bd:e3ae:ef57 with SMTP id tl19-20020a170907c31300b009bde3aeef57mr12829693ejc.60.1699220264570;
        Sun, 05 Nov 2023 13:37:44 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709064e5700b009c5c5c2c5a4sm3386559ejw.219.2023.11.05.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 13:37:44 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -tip v2 3/3] x86/callthunks: Fix and unify call thunks assembly snippets
Date:   Sun,  5 Nov 2023 22:34:37 +0100
Message-ID: <20231105213731.1878100-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231105213731.1878100-1-ubizjak@gmail.com>
References: <20231105213731.1878100-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently thunk debug macros explicitly define %gs: segment register
prefix for their percpu variables. This is not compatible with
!CONFIG_SMP, which requires non-prefixed percpu variables.

Fix call thunks debug macros to use PER_CPU_VAR macro from percpu.h
to conditionally use %gs: segment register prefix, depending on
CONFIG_SMP.

Finally, unify ASM_ prefixed assembly macros with their non-prefixed
variants. With support of %rip-relative relocations in place, call
thunk templates allow %rip-relative addressing, so unified assembly
snippet can be used everywhere.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/nospec-branch.h | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f93e9b96927a..6f677be6bdb9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -59,13 +59,13 @@
 
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 # define CALL_THUNKS_DEBUG_INC_CALLS				\
-	incq	%gs:__x86_call_count;
+	incq	PER_CPU_VAR(__x86_call_count);
 # define CALL_THUNKS_DEBUG_INC_RETS				\
-	incq	%gs:__x86_ret_count;
+	incq	PER_CPU_VAR(__x86_ret_count);
 # define CALL_THUNKS_DEBUG_INC_STUFFS				\
-	incq	%gs:__x86_stuffs_count;
+	incq	PER_CPU_VAR(__x86_stuffs_count);
 # define CALL_THUNKS_DEBUG_INC_CTXSW				\
-	incq	%gs:__x86_ctxsw_count;
+	incq	PER_CPU_VAR(__x86_ctxsw_count);
 #else
 # define CALL_THUNKS_DEBUG_INC_CALLS
 # define CALL_THUNKS_DEBUG_INC_RETS
@@ -80,9 +80,6 @@
 #define CREDIT_CALL_DEPTH					\
 	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
 
-#define ASM_CREDIT_CALL_DEPTH					\
-	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
-
 #define RESET_CALL_DEPTH					\
 	xor	%eax, %eax;					\
 	bts	$63, %rax;					\
@@ -95,20 +92,14 @@
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define INCREMENT_CALL_DEPTH					\
-	sarq	$5, %gs:pcpu_hot + X86_call_depth;		\
-	CALL_THUNKS_DEBUG_INC_CALLS
-
-#define ASM_INCREMENT_CALL_DEPTH				\
 	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #else
 #define CREDIT_CALL_DEPTH
-#define ASM_CREDIT_CALL_DEPTH
 #define RESET_CALL_DEPTH
-#define INCREMENT_CALL_DEPTH
-#define ASM_INCREMENT_CALL_DEPTH
 #define RESET_CALL_DEPTH_FROM_CALL
+#define INCREMENT_CALL_DEPTH
 #endif
 
 /*
@@ -158,7 +149,7 @@
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
 	lfence;						\
-	ASM_CREDIT_CALL_DEPTH				\
+	CREDIT_CALL_DEPTH				\
 	CALL_THUNKS_DEBUG_INC_CTXSW
 #else
 /*
@@ -311,7 +302,7 @@
 .macro CALL_DEPTH_ACCOUNT
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 	ALTERNATIVE "",							\
-		    __stringify(ASM_INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+		    __stringify(INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
-- 
2.41.0

