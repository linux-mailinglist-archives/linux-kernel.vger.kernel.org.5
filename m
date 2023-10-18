Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05287CDDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjJRNpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJRNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:45:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9571595;
        Wed, 18 Oct 2023 06:45:01 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697636700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mn1R1D8LCZyXRyc+VdxbsLSJ9bsUZqepc3iAJQINwx0=;
        b=mCxibk6xYxt62iYT5CvrcV5a7mbDgwEAK5eJIFczKY/JTy8hgdWGDNVYFBR6KWDcNqbzZS
        nMacdn6vrBh4aCZdo1bNgSNcsdcCdaHrE+AZk0jJFoIafgzJxq/ppa7NsWUhlH/ejXP3vM
        3ijHemP0528A4eyaHk+fuK6wFZsmtaXT7RcgdEvua5b5rB3oN+LLiw9LQGj02BDfaxHwsA
        y/xKnr8DjRyU/Qn5GEysfaEKKAK5avbhPxo1++CgyaYWJ/MiPsZ/u8em6+BPQ+JbvxAUhH
        EfBbACl85PrrDZ0RCYv8SkTpunU3YrWSyjcZ24Uo82v/12A6yXD7tqV6Tk7hxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697636700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mn1R1D8LCZyXRyc+VdxbsLSJ9bsUZqepc3iAJQINwx0=;
        b=aZH7NdcWIn71zvYYPCvDu1x/dNBna/ir9tGipZUunernAdQu26L03P8423FxD/2T1Tn+Nw
        ZetpclpinhBsTjCQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Use the correct asm operand modifier in
 percpu_stable_op()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231016200755.287403-1-ubizjak@gmail.com>
References: <20231016200755.287403-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169763669910.3135.5711813859163110694.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     e39828d2c1c0781ccfcf742791daf88fdfa481ea
Gitweb:        https://git.kernel.org/tip/e39828d2c1c0781ccfcf742791daf88fdfa481ea
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Oct 2023 22:07:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Oct 2023 14:09:16 +02:00

x86/percpu: Use the correct asm operand modifier in percpu_stable_op()

The "P" asm operand modifier is a x86 target-specific modifier.

When used for a constant, it drops all syntax-specific prefixes and
issues the bare constant. This modifier is not correct for address
handling, in this case a generic "a" operand modifier should be used.

The "a" asm operand modifier substitutes a memory reference, with the
actual operand treated as address.  For x86_64, when a symbol is
provided, the "a" modifier emits "sym(%rip)" instead of "sym",
enabling shorter %rip-relative addressing.

Clang allows only "i" and "r" operand constraints with an "a" modifier,
so the patch normalizes the modifier/constraint pair to "a"/"i"
which is consistent between both compilers.

The patch reduces code size of a test build by 4072 bytes:

   text            data     bss    dec             hex     filename
   25523268        4388300  808452 30720020        1d4c014 vmlinux-old.o
   25519196        4388300  808452 30715948        1d4b02c vmlinux-new.o

[ mingo: Changelog clarity. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20231016200755.287403-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 5474690..ac3220a 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -194,9 +194,9 @@ do {									\
 #define percpu_stable_op(size, op, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __force_percpu_arg(P[var]), "%[val]")	\
+	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "p" (&(_var)));					\
+	    : [var] "i" (&(_var)));					\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
