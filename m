Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1E7F15D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjKTOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjKTOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:37:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC2A110
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Uh5WSMt/ka3TMy8zfdv/20yKPi+OXOk7N9AxmMFqyLk=; b=Fb2800RwQnF0EXjquKGxGkXtLR
        buQDZLc3i7Quns6BiCSAbKLaIzRh/62W+0H+UD2s9lUyo9zsVc9FGWQgs7sczVSoR5/4EbDxfSxub
        zBgjVIHN1j+6e0o+1V6d5otGsRZkP93CATfK1t5IHWSrN2zevwhDjBiKuKxF462aWnnXsVZ8lwhSL
        zfeCb1E6/aPx6/2F3Z82zjiJQH/z8xOehDfIH3VoYII8ArEVHg0kBMpSm/nor+6Hi9Yfg1Jbu391T
        b4L4cUB/yOuLxuG3D5RM0H3s61BJMotnPWgR1hcVGCKqo2qjO5//RNgoPthOeRpTu1sBpRES2i9I+
        lAyCpCkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r55PM-00B0A0-1p;
        Mon, 20 Nov 2023 14:37:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id D60333007C8; Mon, 20 Nov 2023 15:37:51 +0100 (CET)
Message-Id: <20231120143626.753200755@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 20 Nov 2023 15:33:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/2] x86/entry: Harden return-to-user
References: <20231120143344.584345121@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the DEBUG_ENTRY check that validates CS is a user segment
unconditional and move it nearer to IRET.

PRE:
       140,026,608      cycles:k                                                      ( +-  0.01% )
       236,696,176      instructions:k            #    1.69  insn per cycle           ( +-  0.00% )

POST:
       139,957,681      cycles:k                                                      ( +-  0.01% )
       236,681,819      instructions:k            #    1.69  insn per cycle           ( +-  0.00% )

(this is with --repeat 100 and the run-to-run variance is bigger than
the difference shown)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -559,13 +559,6 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START_LOCAL(common_interrupt_return)
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	IBRS_EXIT
-#ifdef CONFIG_DEBUG_ENTRY
-	/* Assert that pt_regs indicates user mode. */
-	testb	$3, CS(%rsp)
-	jnz	1f
-	ud2
-1:
-#endif
 #ifdef CONFIG_XEN_PV
 	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 #endif
@@ -576,8 +569,14 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 	STACKLEAK_ERASE
 	POP_REGS
 	add	$8, %rsp	/* orig_ax */
+	UNWIND_HINT_IRET_REGS
+
+.Lswapgs_and_iret:
 	swapgs
-	jmp	.Lnative_iret
+	/* Assert that the IRET frame indicates user mode. */
+	testb	$3, 8(%rsp)
+	jnz	.Lnative_iret
+	ud2
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 .Lpti_restore_regs_and_return_to_usermode:
@@ -613,8 +612,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 
 	/* Restore RDI. */
 	popq	%rdi
-	swapgs
-	jmp	.Lnative_iret
+	jmp	.Lswapgs_and_iret
 #endif
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)


