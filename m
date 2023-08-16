Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545C77E0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbjHPL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244963AbjHPL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:59:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEF2121;
        Wed, 16 Aug 2023 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w4pNixXG/yujqwuAAE04Kdf6OftnyKzc8cljjGmu4i0=; b=JdVKR7WK8g11MZo+4lm3fupwxw
        GoLvxoGZxjzWh+wP9bd0wrNAt8ewSXQl5qjB3tp0OvS+R3xJB9Jkf7+sKU16nrgNaVC9MckkWdC1I
        PE1NPfdpesLNRMb+w0SupQ3T2PXmV4n09rMp41IfsqhGnqE92gMMpwaPan299rizYgBmYUVJBtwq1
        eyoUIhYWVc5a3pxl86GdNmil5LhcaS2vi25ISLrhq6H4zvoRlFEA1rgDRCVxwvBMKEwx/P45ztu7f
        ZseukUVqOzPx9L+X2TxW+ZeByx4fUNP9K4SdRRZkdbF23SPK2uctEoorUYKNj3yxWy2SLGKAdaCwq
        JIu5mnFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWFBK-00CytP-1g;
        Wed, 16 Aug 2023 11:59:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 289123001FD;
        Wed, 16 Aug 2023 13:59:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 057EE2C904588; Wed, 16 Aug 2023 13:59:22 +0200 (CEST)
Date:   Wed, 16 Aug 2023 13:59:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] objtool/x86: Fix SRSO mess
Message-ID: <20230816115921.GH980931@hirez.programming.kicks-ass.net>
References: <20230814121148.704502245@infradead.org>
 <169217251760.27769.15304146275480287222.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169217251760.27769.15304146275480287222.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 07:55:17AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40
> Gitweb:        https://git.kernel.org/tip/4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Mon, 14 Aug 2023 13:44:29 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00
> 
> objtool/x86: Fix SRSO mess
> 
> Objtool --rethunk does two things:
> 
>  - it collects all (tail) call's of __x86_return_thunk and places them
>    into .return_sites. These are typically compiler generated, but
>    RET also emits this same.
> 
>  - it fudges the validation of the __x86_return_thunk symbol; because
>    this symbol is inside another instruction, it can't actually find
>    the instruction pointed to by the symbol offset and gets upset.
> 
> Because these two things pertained to the same symbol, there was no
> pressing need to separate these two separate things.
> 
> However, alas, along comes SRSO and more crazy things to deal with
> appeared.
> 
> The SRSO patch itself added the following symbol names to identify as
> rethunk:
> 
>   'srso_untrain_ret', 'srso_safe_ret' and '__ret'
> 
> Where '__ret' is the old retbleed return thunk, 'srso_safe_ret' is a
> new similarly embedded return thunk, and 'srso_untrain_ret' is
> completely unrelated to anything the above does (and was only included
> because of that INT3 vs UD2 issue fixed previous).
> 
> Clear things up by adding a second category for the embedded instruction
> thing.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20230814121148.704502245@infradead.org

Turns out I forgot to build with FRAME_POINTER=y, that still gives:

vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup

the below seems to cure this.

---
 tools/objtool/check.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7a9aaf400873..1384090530db 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2650,12 +2650,17 @@ static int decode_sections(struct objtool_file *file)
 	return 0;
 }
 
-static bool is_fentry_call(struct instruction *insn)
+static bool is_special_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
-	    insn_call_dest(insn) &&
-	    insn_call_dest(insn)->fentry)
-		return true;
+	if (insn->type == INSN_CALL) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (!dest)
+			return false;
+
+		if (dest->fentry || dest->embedded_insn)
+			return true;
+	}
 
 	return false;
 }
@@ -3656,7 +3661,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (opts.stackval && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_special_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_INSN(insn, "call without frame pointer save/setup");
 				return 1;
