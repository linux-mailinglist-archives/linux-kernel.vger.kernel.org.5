Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6459D7A4C29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjIRP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIRP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:26:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A140E7D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:24:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so10196987a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050580; x=1695655380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9w51n7QMOQJeK8votiojWKcMu4fMg8/31xrSA59I3w=;
        b=eRjvxvVGAN79HNPIriHwIUDQKz9aC7RKVaKiSN2v9/owAJIUG1Jn9rL0c7cOTJ6T8c
         ns0KPbmp0SkIYJrgIuEUm5+0I66uBCtqxi8UnhDwQOW5WNTa/54tHp5V5AdaWZkQqlcZ
         +NyZ8vPyy874GqWN9dD8gcxM5yOj3+FEPridKmLMB/JQp3W99nG8fq7+yQCkwMgWPICQ
         5CUt8HBYBatTLOtzA4LCE/7CLpeW1aKViR+owYgeL+d5QAuVyfzhlBOYvQn3BRyBSxMO
         NJiStF7z/4/qQVCPyzK7DRI2CmmEBoQCAurOJfAM+X4UrptCFOinV1jYmH39tID/5+Qq
         LHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050580; x=1695655380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9w51n7QMOQJeK8votiojWKcMu4fMg8/31xrSA59I3w=;
        b=D2E0zsqoHkXEOM7JjvQOgxL2Jz/0o70TOYa3sSGLQD+fDre4lX2KB74ZwQYG9JUqYq
         tExAwsInW92yrEhH7eszq69V9v3joo9Kp2QaEXYmR0JGfkCmw/O/6pXOiBKy9YhtoviM
         NRvxozB1wJo4skmhYU845IS2PcAHJtS4aXYgSOXRokdqiO1u91peBjAjCh/yaOG9bMjW
         docuY6AdaYVaHYV4uY+hNOjU9gL4KuK5iBbY8kjclceWsghu2UFs7uMZOo6ePUzjpHl6
         oGbsaRKvV1KR+LfMKzNizR8NtBPZDbTnT7+QXNmptG+NxFNiNAUBxeCHe+RC536TlOHy
         FDUw==
X-Gm-Message-State: AOJu0YwyHbr14RRQ5OcCN1K1JzMzZRe5gcYSSNZ9J9uWoRHRy1RVTV2u
        1bkOZre65Pm6OxjF5MXTTdGNxX6wu2k=
X-Google-Smtp-Source: AGHT+IFGCSLWzcSFnMl5XhQEPdt5TDed4iZUPtZ/3lvvMrE/lYDaF8doABT5qZX0mNuPy9sJh+4Q5A==
X-Received: by 2002:a17:906:dc8b:b0:96f:9cea:a34d with SMTP id cs11-20020a170906dc8b00b0096f9ceaa34dmr16509246ejc.21.1695046196049;
        Mon, 18 Sep 2023 07:09:56 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7d599000000b0052a1c0c859asm6140300edq.59.2023.09.18.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:09:55 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH tip] x86/percpu: Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op
Date:   Mon, 18 Sep 2023 16:08:27 +0200
Message-ID: <20230918140929.3477-1-ubizjak@gmail.com>
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
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a87db6140fe2..331a9d4dce82 100644
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
+		    "S" (&_var)						\
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
+		    "S" (&_var)						\
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
+		    "S" (&_var)						\
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
+		    "S" (&_var)						\
+		  : "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
 	likely(success);						\
-- 
2.41.0

