Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D287802ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjLDJkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjLDJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907BD2;
        Mon,  4 Dec 2023 01:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=H9F+SG0jcXjCMA+hoF+Z9AplgtYJpt1PN/dsuLjAMTg=; b=GI9fusMqIKIMDgOataLeOA6L29
        ELtX3JSwhcqgFDC9EOI33qDJMM4Vur0H0pMdS2WT6/Tfc45bLVdueDVlvK6C8SJHh36tmHIi/t6yh
        g+epxU5qqvQjgQxvaq6Xk0btkrvgB39T5iTjmJCxEAkpAqqlxulpsi5ljenzWUFJyhTrE3w0V+OjN
        DrBCDFuJwRn2fObHlA9ZURdFgSDsd1W37iofnA3cNAv6p7NDx36zBwswl158x7ykTzemSzQeqAUUb
        BheiyAwlrxiGH5U0/ck/BvjhNG2PRfnSPKx9vWKDxQGDue8bcUeOibb2CX/68Hhg1mqdl8CvqWCOx
        cmDljhyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rA5QZ-000X0c-6w; Mon, 04 Dec 2023 09:39:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id AFA29301C36; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093732.436930429@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 10/11] x86/nospec: JMP_NOSPEC
References: <20231204093702.989848513@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -403,6 +403,17 @@ static inline void call_depth_return_thu
 	"call *%[thunk_target]\n",				\
 	X86_FEATURE_RETPOLINE_LFENCE)
 
+# define JMP_NOSPEC						\
+	ALTERNATIVE_2(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	"jmp __x86_indirect_thunk_%V[thunk_target]\n",		\
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_LFENCE)
+
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #else /* CONFIG_X86_32 */
@@ -433,10 +444,31 @@ static inline void call_depth_return_thu
 	"call *%[thunk_target]\n",				\
 	X86_FEATURE_RETPOLINE_LFENCE)
 
+# define JMP_NOSPEC						\
+	ALTERNATIVE_2(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	"       jmp    901f;\n"					\
+	"       .align 16\n"					\
+	"901:	call   903f;\n"					\
+	"902:	pause;\n"					\
+	"    	lfence;\n"					\
+	"       jmp    902b;\n"					\
+	"       .align 16\n"					\
+	"903:	lea    4(%%esp), %%esp;\n"			\
+	"       pushl  %[thunk_target];\n"			\
+	"       ret;\n"						\
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_LFENCE)
+
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
 #else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
+# define JMP_NOSPEC "jmp *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
 


