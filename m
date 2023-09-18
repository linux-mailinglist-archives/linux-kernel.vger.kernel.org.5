Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B587A4C18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjIRP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjIRP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:26:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E3173A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:24:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b974031aeaso76156641fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050543; x=1695655343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj6CfCifiInxilezCfVnNyqKnuEuH+TT9wHQcIQ/jE4=;
        b=V5SCNGudBO8loecDInJiIeKhhY+weQT4P2RvhBrnIKjKU5OTcZo49RGLdMuunOUter
         rx+5Rv4Bprl4Hy2bWdX+oby/14v4WnXimIgKAUNJlP/YeIwA3NdfctUD8Ns5q2CPxHHE
         uHVcvL6Dpi4dKqHOgjR/+44T+SNsg+ePgGbmPqK2KfY5vPnu+7o3k2GumJB1l0+bjkmp
         2fJSl7c7sKR31V1cFovh7R9DC7QuKjg+op/FPUT8F37dHoTaohcFGs/igRQdwi+c8hq5
         XGZpPhzUfSUlG8nrJsJtH4InNIb3PN7Mtc+1nkW6yuBcrOYesGZCwAKZAwBb3V0H2kbs
         tBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050543; x=1695655343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zj6CfCifiInxilezCfVnNyqKnuEuH+TT9wHQcIQ/jE4=;
        b=Gs722kVoRBf2SM0XMZu5G7+RDoo+FyXeMj0HcXjiTs6qdSrnHq0ARsXppzWsP/9Psf
         fxr+PwKq/njZV9vNFxHXeR5joz1ei8doOFC8h3V4QPGVZQQC72mLJUJS7hDrVmt3+or9
         Js6ow/SNUs5Q6DjmflgZbpg3Lkbyu915i0tWP9UOYHza1cAW189KTNTxk/oQd3O7BvSj
         ikhIgXm3SPh/55B/L6pzmula4/P6EWwbiJjFIaBTIzT1bflyrbDkVZWz610B9IAiSzEh
         UYVojRL3XkAKFNv52uPoCAur9SiJcHJbeiv6GJW7FkSHRDWFT0TVceOuTP6aa/0RgoQt
         Q8yw==
X-Gm-Message-State: AOJu0YzJ9R9CPWQXsqgCAq5orosmQ5x8aex1peNI6MeutYk6PEE1SFM/
        4/N9nFZ/11sjZ+rOapR465ZG+sZ51+E=
X-Google-Smtp-Source: AGHT+IE+YPMscbUl9r+toArG0T4qysAv++sWJmVZWSjvhdwE8ZS8vrwdfDF0sU43HajmQN9BRn5nIw==
X-Received: by 2002:a05:6512:3050:b0:503:7c0:ae96 with SMTP id b16-20020a056512305000b0050307c0ae96mr5698167lfb.20.1695050102941;
        Mon, 18 Sep 2023 08:15:02 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i8-20020a0564020f0800b005309eb7544fsm4472314eda.45.2023.09.18.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:15:02 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH tip v2] x86/percpu: Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op
Date:   Mon, 18 Sep 2023 17:14:10 +0200
Message-ID: <20230918151452.62344-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fallback alternative uses %rsi register to manually load pointer
to the percpu variable before the call to the emulation function.
This is unoptimal, because the load is hidden from the compiler.

Move the load of %rsi outside inline asm, so the compiler can
reuse the value. The code in slub.o improves from:

    55ac:	49 8b 3c 24          	mov    (%r12),%rdi
    55b0:	48 8d 4a 40          	lea    0x40(%rdx),%rcx
    55b4:	49 8b 1c 07          	mov    (%r15,%rax,1),%rbx
    55b8:	4c 89 f8             	mov    %r15,%rax
    55bb:	48 8d 37             	lea    (%rdi),%rsi
    55be:	e8 00 00 00 00       	callq  55c3 <...>
			55bf: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
    55c3:	75 a3                	jne    5568 <...>
    55c5:	...

0000000000000000 <.altinstr_replacement>:
   5:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)

to:

    55ac:	49 8b 34 24          	mov    (%r12),%rsi
    55b0:	48 8d 4a 40          	lea    0x40(%rdx),%rcx
    55b4:	49 8b 1c 07          	mov    (%r15,%rax,1),%rbx
    55b8:	4c 89 f8             	mov    %r15,%rax
    55bb:	e8 00 00 00 00       	callq  55c0 <...>
			55bc: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
    55c0:	75 a6                	jne    5568 <...>
    55c2:	...

Where the alternative replacement instruction now uses %rsi:

0000000000000000 <.altinstr_replacement>:
   5:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)

The instruction (effectively a reg-reg move) at 55bb: in the original
assembly is removed. Also, both the call and replacement cmpxchg16b
are 5 bytes long, removing the need for nops in the asm code.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2:
 - Put parenthesis around _var argument when taking its address
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a87db6140fe2..20624b80f890 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -242,14 +242,15 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  : [var] "+m" (_var),					\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
-		    "c" (new__.high)					\
-		  : "memory", "esi");					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
 									\
 	old__.var;							\
 })
@@ -271,7 +272,7 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
@@ -279,8 +280,9 @@ do {									\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
-		    "c" (new__.high)					\
-		  : "memory", "esi");					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
 	likely(success);						\
@@ -309,14 +311,15 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  : [var] "+m" (_var),					\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
-		    "c" (new__.high)					\
-		  : "memory", "rsi");					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
 									\
 	old__.var;							\
 })
@@ -338,7 +341,7 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
@@ -346,8 +349,9 @@ do {									\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
-		    "c" (new__.high)					\
-		  : "memory", "rsi");					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
 	likely(success);						\
-- 
2.41.0

