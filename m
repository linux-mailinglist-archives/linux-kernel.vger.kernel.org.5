Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBFC7DF126
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376258AbjKBL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376270AbjKBL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:29:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10578111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:29:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507973f3b65so984015e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698924545; x=1699529345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgAqePGVhUCu3U56kTFLSJugpfg6qt/lSZ7uytS2Gf4=;
        b=BQb08mpbYh4FwfaddGcZDs6LMGQnnXbzI0le3TBrHcv1i3VvxZ6K4o2jAR9Z81J//U
         OzR5vtBq+WdIuym23V3smYHtt+mrRKJ012WMHImhqZ9pqo3fUp8gOoiPeqbfS8tEdZOe
         YiJqlTlegHZkL2SYFi/jpdcvnU/cC26Tts7euW0wYEmE50bQ0KG1SXDdmnfttrjopwlu
         ZGpzCRQ6/e7a62wj19wkm6oHOxE0GhipaQwJ5w/OU9L8oCKxS/wanYGP8m/5XlTHFSb7
         hxPzYr++/0wRXmTuHQ1hnV40jgLrq4qqZ0v7S578+ZiY8rRpe2qddCF4EkWybRak/Dyo
         WZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924545; x=1699529345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgAqePGVhUCu3U56kTFLSJugpfg6qt/lSZ7uytS2Gf4=;
        b=kVcUYyi3QCMHygkg8XU72NlXW8AmSc2iHX1cN1+LguvIifXgFNdUtBvZauT1QqLu6H
         Vv3kyfibAe0EH8IrKrEeyxWp3/CUvdiX79iTSRCKa6c9P+lyvNM5mXeSyKwYUpanwDaw
         c5a1lq0Te8cTXihda64h9h3lTcIxU9iRPYkkHyqUG4iyJksM4cso3BRRjIDrJLqMv7+z
         /wAMp1ULU4tH8C4W+cN3TAW70Kyq9He2/vAAB1fdSESq6nIJn2GV8ZVD08uEe7H5vnwN
         jhDOwfvTh6rblQJKKsK5cKzI63C2lEdc9sHhRyI24YBvuNljS09ka4tK9GTxiqj+VNDt
         PMxw==
X-Gm-Message-State: AOJu0YxaiEzqDHN4BMupSiBiZamZwZWeIYqEN/rgod60DpBInJzdfztR
        efXaTBdXlr4UkQ6YMtPwapk=
X-Google-Smtp-Source: AGHT+IG1aAKgdGzC3k/REBwV6JyV6IBliK6pMT84b9AjnExv2LuJIAXVc6W6Py1AsuS5MaK/OhKUzw==
X-Received: by 2002:a05:6512:2248:b0:4fe:7e7f:1328 with SMTP id i8-20020a056512224800b004fe7e7f1328mr17608450lfu.16.1698924544906;
        Thu, 02 Nov 2023 04:29:04 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d4f8a000000b003232f167df5sm2168227wru.108.2023.11.02.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:29:04 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] x86/callthunks: Fix and unify call thunks assembly snippets
Date:   Thu,  2 Nov 2023 12:25:48 +0100
Message-ID: <20231102112850.3448745-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102112850.3448745-1-ubizjak@gmail.com>
References: <20231102112850.3448745-1-ubizjak@gmail.com>
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

