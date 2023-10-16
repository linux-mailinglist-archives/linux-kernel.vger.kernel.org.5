Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C757CA649
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJPLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjJPLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:09:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF5B4;
        Mon, 16 Oct 2023 04:09:14 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:09:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697454553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KivpYjCswqmyMYmTza1UAeGN464mC4l6senqCmFquu8=;
        b=fI6PaVP9NU+p2uNPtQBRh4gnuEP7BcedBxqSj3DGCisTSA+QDRcPJ2GUgkbQzaTXPhp13y
        ZGn1n1yP5nZ/OKiAZ0L8qsbCukrFUqvGOfY5BuoF3SYJL08ArkOyj9aIZbfxZTjVkyRuuK
        +6so6zHi4RNcI2Hr3C1pO5372i74mdFxMsIHSYeVt3eTFciInP4xggdzhFPVz6hHAuMkNZ
        S9pOVedE0aSB6iJtL1X0Xkx/US79Z75cOD/jrwpA0DhAKyNHzA7Fll5B7f1lskVrIsxc0W
        tWONISxx+8SUkd6rP7bKx0kRm+z1ALh6NGU+Xlgs68jffoU+gDFDp66/vQ+r/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697454553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KivpYjCswqmyMYmTza1UAeGN464mC4l6senqCmFquu8=;
        b=n6Vq4wjfv+CRpFo1rEh/6R/ocpVQJwTbnbpA86R6rt8VAgmU8AqZrIRO3r32xst0OZCcV7
        NCmr+FT5KgW2JwAA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Rewrite arch_raw_cpu_ptr() to be easier
 for compilers to optimize
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231015202523.189168-1-ubizjak@gmail.com>
References: <20231015202523.189168-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169745455266.3135.6448612613186875465.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     a048d3abae7c33f0a3f4575fab15ac5504d443f7
Gitweb:        https://git.kernel.org/tip/a048d3abae7c33f0a3f4575fab15ac5504d443f7
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 15 Oct 2023 22:24:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 12:51:58 +02:00

x86/percpu: Rewrite arch_raw_cpu_ptr() to be easier for compilers to optimize

Implement arch_raw_cpu_ptr() as a load from this_cpu_off and then
add the ptr value to the base. This way, the compiler can propagate
addend to the following instruction and simplify address calculation.

E.g.: address calcuation in amd_pmu_enable_virt() improves from:

    48 c7 c0 00 00 00 00	mov    $0x0,%rax
	87b7: R_X86_64_32S	cpu_hw_events

    65 48 03 05 00 00 00	add    %gs:0x0(%rip),%rax
    00
	87bf: R_X86_64_PC32	this_cpu_off-0x4

    48 c7 80 28 13 00 00	movq   $0x0,0x1328(%rax)
    00 00 00 00

to:

    65 48 8b 05 00 00 00	mov    %gs:0x0(%rip),%rax
    00
	8798: R_X86_64_PC32	this_cpu_off-0x4
    48 c7 80 00 00 00 00	movq   $0x0,0x0(%rax)
    00 00 00 00
	87a6: R_X86_64_32S	cpu_hw_events+0x1328

The compiler also eliminates additional redundant loads from
this_cpu_off, reducing the number of percpu offset reads
from 1668 to 1646 on a test build, a -1.3% reduction.

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
Link: https://lore.kernel.org/r/20231015202523.189168-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 60ea775..915675f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -56,9 +56,11 @@
 #define arch_raw_cpu_ptr(ptr)					\
 ({								\
 	unsigned long tcp_ptr__;				\
-	asm ("add " __percpu_arg(1) ", %0"			\
+	asm ("mov " __percpu_arg(1) ", %0"			\
 	     : "=r" (tcp_ptr__)					\
-	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
+	     : "m" (__my_cpu_var(this_cpu_off)));		\
+								\
+	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else /* CONFIG_SMP */
