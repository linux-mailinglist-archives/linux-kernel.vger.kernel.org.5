Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAA67AAC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjIVINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjIVINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:13:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0452122;
        Fri, 22 Sep 2023 01:12:31 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695370350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ARBaVfzfcA6faFmUzH9kFAgDWK5n4gM0GoxjOTpPz6U=;
        b=HvMCXmQzLXKfmNWsJq5fVTrb4KFgTVRumB+bzpnHgDUP6z9edoFcwMEURMjxQL3B0beJil
        ptpeJ4tyu8hL+9ZPnsMcJQzEV/PLEz8Wk16sZWlMoSl7p3tGRROhdvSKnVh9n9muvHB7H7
        M1fct/QaVbg6gdfe2sNYRdh6FfFe0zHs5S+2rwYw/eju9mvQu5bMyZzhcLAbHTpp7ET0cZ
        6vFwLS5QVswAu8bWgMkbJDzL5Nx25YYgal5guFEJrsF0g59HjBi6tpUCoMu4YqgXgIGGMe
        5aTo2YrEQQ1KtM+VJCPxyOmi6FOfttJqcsUpH0zi72dSvm+bPjQpr+RsnE6jgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695370350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ARBaVfzfcA6faFmUzH9kFAgDWK5n4gM0GoxjOTpPz6U=;
        b=fYWeBnxOWlXRTOYT5Qlux+8pPIU5HQwJB0Eo6VIdSeYTT+S2Lyfj/0niWSXwdgmfoSY61U
        R0BNto10t0+kkxAA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/bitops: Remove unused __sw_hweight64() assembly
 implementation on x86-32
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169537034995.27769.6683093223501252262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ad424743256b0119bd60a9248db4df5d998000a4
Gitweb:        https://git.kernel.org/tip/ad424743256b0119bd60a9248db4df5d998000a4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 22 Jan 2022 13:39:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 09:34:50 +02:00

x86/bitops: Remove unused __sw_hweight64() assembly implementation on x86-32

Header cleanups in the fast-headers tree highlighted that we have an
unused assembly implementation for __sw_hweight64():

    WARNING: modpost: EXPORT symbol "__sw_hweight64" [vmlinux] version ...

__arch_hweight64() on x86-32 is defined in the
arch/x86/include/asm/arch_hweight.h header as an inline, using
__arch_hweight32():

  #ifdef CONFIG_X86_32
  static inline unsigned long __arch_hweight64(__u64 w)
  {
          return  __arch_hweight32((u32)w) +
                  __arch_hweight32((u32)(w >> 32));
  }

*But* there's also a __sw_hweight64() assembly implementation:

  arch/x86/lib/hweight.S

  SYM_FUNC_START(__sw_hweight64)
  #ifdef CONFIG_X86_64
  ...
  #else /* CONFIG_X86_32 */
        /* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
        pushl   %ecx

        call    __sw_hweight32
        movl    %eax, %ecx                      # stash away result
        movl    %edx, %eax                      # second part of input
        call    __sw_hweight32
        addl    %ecx, %eax                      # result

        popl    %ecx
        ret
  #endif

But this __sw_hweight64 assembly implementation is unused - and it's
essentially doing the same thing that the inline wrapper does.

Remove the assembly version and add a comment about it.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/lib/hweight.S | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index 12c16c6..0a152e5 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -36,8 +36,12 @@ SYM_FUNC_START(__sw_hweight32)
 SYM_FUNC_END(__sw_hweight32)
 EXPORT_SYMBOL(__sw_hweight32)
 
-SYM_FUNC_START(__sw_hweight64)
+/*
+ * No 32-bit variant, because it's implemented as an inline wrapper
+ * on top of __arch_hweight32():
+ */
 #ifdef CONFIG_X86_64
+SYM_FUNC_START(__sw_hweight64)
 	pushq   %rdi
 	pushq   %rdx
 
@@ -66,18 +70,6 @@ SYM_FUNC_START(__sw_hweight64)
 	popq    %rdx
 	popq    %rdi
 	RET
-#else /* CONFIG_X86_32 */
-	/* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
-	pushl   %ecx
-
-	call    __sw_hweight32
-	movl    %eax, %ecx                      # stash away result
-	movl    %edx, %eax                      # second part of input
-	call    __sw_hweight32
-	addl    %ecx, %eax                      # result
-
-	popl    %ecx
-	RET
-#endif
 SYM_FUNC_END(__sw_hweight64)
 EXPORT_SYMBOL(__sw_hweight64)
+#endif
