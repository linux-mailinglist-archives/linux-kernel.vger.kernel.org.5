Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA77AA235
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIUVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjIUVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6C72BD;
        Thu, 21 Sep 2023 10:10:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695282201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcSH7dNMTsPoxRqHg8T2+Oqlqdr6DZoNM17pqKOJ7vY=;
        b=JPVR3y7Rq1Wo4PtnSNVIDuf+Y5kDJapsQWQZpmCRR7gO31to7nSAI2WLd4JCD8gphpBbdX
        07dMI+npwIQbZVZYhtqEsmWy1XlP79N/whTqGX91mViu5A7qblabL9/nX1UZVtyvqYxoBp
        QT2S6kiQGdvDJS7nmaUw7bPbQZxqBlnwcNPG/5lRAGKMnZ91JJI8IISwMw8ela8Ng361vv
        bJbfOSCkjAdpDGn0YvyO95U/vq+EYOBRjXnlNbhZo17qFygAFfNFu3A3FpzIMwdWyDp/5f
        ihk2rZU75feTOmhhs2lrCdgnu/ZBI2UTtTbs/QkCezUd/FYBPNT3/Sr3iJGrGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695282201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcSH7dNMTsPoxRqHg8T2+Oqlqdr6DZoNM17pqKOJ7vY=;
        b=btQl7vz4LqnyqMbuA9uHFaYhmZD57myb0sC1KuipEXd/exO36itWDn5HC+uYbGlAVsn+2T
        GsrtvbYe0aamtZAg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Do not clobber %rsi in
 percpu_{try_,}cmpxchg{64,128}_op
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230918151452.62344-1-ubizjak@gmail.com>
References: <20230918151452.62344-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169528220128.27769.15672114308825684343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     7c097ca50d2ba7f7989f01175f366151256bfa10
Gitweb:        https://git.kernel.org/tip/7c097ca50d2ba7f7989f01175f366151256bfa10
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 18 Sep 2023 17:14:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 09:35:50 +02:00

x86/percpu: Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op

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
assembly is removed. Also, both the CALL and replacement CMPXCHG16B
are 5 bytes long, removing the need for NOPs in the asm code.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230918151452.62344-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a87db61..20624b8 100644
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
