Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D635D794607
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbjIFWNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIFWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:13:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AEB19B5;
        Wed,  6 Sep 2023 15:13:40 -0700 (PDT)
Date:   Wed, 06 Sep 2023 22:13:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694038419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMhoqF5R02gP1aEj7OMzAoNpaCLUGjyaEAfsQAdUsok=;
        b=GZKFWhNcQT/SAJMwdwN0gJC42m8DyM3hYD/pYLUhZ265Hg2zoKEWvYB6fmBVag4Q+4jWb6
        tAlH1Uqd4/9XKUOJkH0s+Rnx8wQdyfh+kcdV+wyIMc56gFdYUGLDGgQ5HG/sN/T+RQR5xe
        vY3JevnhooVPcCvV3nou9o2lNTLsqdlL3tDNFeJGjUPKLrZ2dPAAXTOfSCRb1H6UodWh2o
        YlNVynVoniEoWhgXBILCd6paS48+FxyygxBeIZZyXNDbC1lfTWsdDDO8D6X5mOAY0u/ZS9
        TlQjUeIZ8LtSfhhxo57gV84sw/Io2vhbn5b62xTzrB/TJb9cXbzNikLJLAMPtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694038419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMhoqF5R02gP1aEj7OMzAoNpaCLUGjyaEAfsQAdUsok=;
        b=EmK/S1O0AthPV+Pw+7xx6kvSdT1OsPdpiiUPue9maaaEnexP9/tW4QaZl+oVE9NW1bR9nK
        FbfhPtkJi6T6h3AQ==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/bitops: Use __builtin_clz{l|ll} to evaluate
 constant expressions
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230828-x86_fls-v1-1-e6a31b9f79c3@google.com>
References: <20230828-x86_fls-v1-1-e6a31b9f79c3@google.com>
MIME-Version: 1.0
Message-ID: <169403841804.27769.15355528156114088162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3dae5c43badf285e22f6d88388e8a232a83bdfec
Gitweb:        https://git.kernel.org/tip/3dae5c43badf285e22f6d88388e8a232a83bdfec
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Mon, 28 Aug 2023 11:53:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 07 Sep 2023 00:05:50 +02:00

x86/asm/bitops: Use __builtin_clz{l|ll} to evaluate constant expressions

Micro-optimize the bitops code some more, similar to commits:

  fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions")
  2fcff790dcb4 ("powerpc: Use builtin functions for fls()/__fls()/fls64()")

>From a recent discussion, I noticed that x86 is lacking an optimization
that appears in arch/powerpc/include/asm/bitops.h related to constant
folding.  If you add a BUILD_BUG_ON(__builtin_constant_p(param)) to
these functions, you'll find that there were cases where the use of
inline asm pessimized the compiler's ability to perform constant folding
resulting in runtime calculation of a value that could have been
computed at compile time.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230828-x86_fls-v1-1-e6a31b9f79c3@google.com
---
 arch/x86/include/asm/bitops.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 2edf684..50e5ebf 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -293,6 +293,9 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
  */
 static __always_inline unsigned long __fls(unsigned long word)
 {
+	if (__builtin_constant_p(word))
+		return BITS_PER_LONG - 1 - __builtin_clzl(word);
+
 	asm("bsr %1,%0"
 	    : "=r" (word)
 	    : "rm" (word));
@@ -360,6 +363,9 @@ static __always_inline int fls(unsigned int x)
 {
 	int r;
 
+	if (__builtin_constant_p(x))
+		return x ? 32 - __builtin_clz(x) : 0;
+
 #ifdef CONFIG_X86_64
 	/*
 	 * AMD64 says BSRL won't clobber the dest reg if x==0; Intel64 says the
@@ -401,6 +407,9 @@ static __always_inline int fls(unsigned int x)
 static __always_inline int fls64(__u64 x)
 {
 	int bitpos = -1;
+
+	if (__builtin_constant_p(x))
+		return x ? 64 - __builtin_clzll(x) : 0;
 	/*
 	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64 says the
 	 * dest reg is undefined if x==0, but their CPU architect says its
