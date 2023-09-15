Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4B7A1D68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjIOLZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjIOLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:25:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDDCC8;
        Fri, 15 Sep 2023 04:25:04 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694777103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9J21HuhWXljN+jXTdAk29WG1MDKeiqVwqZ9TxVbomng=;
        b=LMlX6Toxx7Q1vxs3t5ydLNVNMin45taaBUfxXOvsKMtAZO9uh6nFhWqmJHfNF1oVfY22O8
        dXr3iUCAaFSertTJbfxwMjRRGEnh0nh6w9BVzYzDg9yKY/nAsbSS9S6EsnrZUIe0hzwmHG
        en8+d51zW12pNormq5jvFI6vRDhrj51jkREY5ZuZ2PNtGjcx14sBusxNFWbyK8rWzuzsOU
        SRosXR5UWp/wtr9FO5MvElFxyX7mmS6wfIT+9yAkqQQbjJ8jzTMy2fqWiKIbLwVraAgZzm
        9rF7+WTdXM807R0Wgch53PFsZbqYGzfVm6JJj2TsMEpr5JP+10Dr24c5rGXn3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694777103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9J21HuhWXljN+jXTdAk29WG1MDKeiqVwqZ9TxVbomng=;
        b=EeooppuNQPAxP/cVjKRXBsjgytBF6dvzFT0DezyrOfGumL/LBTTNwAn5pqqZ7ccHpu5NoH
        +F/j9dtnQkQ/oaBQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230906185941.53527-1-ubizjak@gmail.com>
References: <20230906185941.53527-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     54cd971c6f4461fb6b178579751788bf4f64dfca
Gitweb:        https://git.kernel.org/tip/54cd971c6f4461fb6b178579751788bf4f64dfca
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 06 Sep 2023 20:58:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:16:35 +02:00

x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}

Define target-specific {raw,this}_cpu_try_cmpxchg64() and
{raw,this}_cpu_try_cmpxchg128() macros. These definitions override
the generic fallback definitions and enable target-specific
optimized implementations.

Several places in mm/slub.o improve from e.g.:

    53bc:	48 8d 4f 40          	lea    0x40(%rdi),%rcx
    53c0:	48 89 fa             	mov    %rdi,%rdx
    53c3:	49 8b 5c 05 00       	mov    0x0(%r13,%rax,1),%rbx
    53c8:	4c 89 e8             	mov    %r13,%rax
    53cb:	49 8d 30             	lea    (%r8),%rsi
    53ce:	e8 00 00 00 00       	call   53d3 <...>
			53cf: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
    53d3:	48 31 d7             	xor    %rdx,%rdi
    53d6:	4c 31 e8             	xor    %r13,%rax
    53d9:	48 09 c7             	or     %rax,%rdi
    53dc:	75 ae                	jne    538c <...>

to:

    53bc:	48 8d 4a 40          	lea    0x40(%rdx),%rcx
    53c0:	49 8b 1c 07          	mov    (%r15,%rax,1),%rbx
    53c4:	4c 89 f8             	mov    %r15,%rax
    53c7:	48 8d 37             	lea    (%rdi),%rsi
    53ca:	e8 00 00 00 00       	call   53cf <...>
			53cb: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
    53cf:	75 bb                	jne    538c <...>

reducing the size of mm/slub.o by 80 bytes:

   text    data     bss     dec     hex filename
  39758    5337    4208   49303    c097 slub-new.o
  39838    5337    4208   49383    c0e7 slub-old.o

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230906185941.53527-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 67 ++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 34734d7..4c36419 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -237,12 +237,47 @@ do {									\
 
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
 #define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+
+#define percpu_try_cmpxchg64_op(size, qual, _var, _ovalp, _nval)	\
+({									\
+	bool success;							\
+	u64 *_oval = (u64 *)(_ovalp);					\
+	union {								\
+		u64 var;						\
+		struct {						\
+			u32 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = *_oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "esi");					\
+	if (unlikely(!success))						\
+		*_oval = old__.var;					\
+	likely(success);						\
+})
+
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg64_op(8,         , pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg64_op(8, volatile, pcp, ovalp, nval)
 #endif
 
 #ifdef CONFIG_X86_64
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
 #define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
 
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg_op(8,         , pcp, ovalp, nval);
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval);
+
 #define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
@@ -269,6 +304,38 @@ do {									\
 
 #define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
 #define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+
+#define percpu_try_cmpxchg128_op(size, qual, _var, _ovalp, _nval)	\
+({									\
+	bool success;							\
+	u128 *_oval = (u128 *)(_ovalp);					\
+	union {								\
+		u128 var;						\
+		struct {						\
+			u64 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = *_oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "rsi");					\
+	if (unlikely(!success))						\
+		*_oval = old__.var;					\
+	likely(success);						\
+})
+
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16,         , pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16, volatile, pcp, ovalp, nval)
 #endif
 
 /*
