Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D72789252
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjHYX1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjHYX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B42109;
        Fri, 25 Aug 2023 16:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780F260FD3;
        Fri, 25 Aug 2023 23:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F31DC433C7;
        Fri, 25 Aug 2023 23:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693006019;
        bh=NRfWPuaD6h1lm/WpIu+J+BVfiSwTpIn3GiMhCp3Y/ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8JvjCUu0qyJwTqpSM+isHKAk291AzsSN2EBizo11a0ZsG5p9M+yAyS7ZyfPsm1LQ
         Gw7GMlHdtyrrYJdKu/zvfJO0rArih4p6HOPJ9nYe58LCs55sj4dB1TcmzHVb0ZaXIX
         ANJOjDYbbfIUu5JLi5cnzBiq4cLzcL5k+d202am3NNg16gep31/CIBDFkRiG9TojWO
         paYtV9GiG+30sMpQ/IldFSnEGGXkdYLUthc4dYpIfTZiWNalIxVEGceIKgqnxC7urt
         BaD0rztnT2VCavOSusfpljUd0LCK+djXV6SWdsMw4ROwzln3NZqp2hVk5fP9qc9Qsq
         oE7C1K78bXQ1w==
Date:   Fri, 25 Aug 2023 16:26:57 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <20230825232657.psb7c7x2tdgzciqw@treble>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
 <2023082458-vividness-habitable-cbc8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023082458-vividness-habitable-cbc8@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:52:56PM +0200, Greg KH wrote:
> On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> > Hey Paul,
> > 
> > On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > > I hit the splat at the end of this message in recent mainline, and has
> > > appeared some time since v6.5-rc1.  Should I be worried?
> > 
> > does it go away if you try the latest tip:x86/urgent branch?
> 
> Note, this problem is showing up in the 6.1.y branch right now, due to
> one objtool patch not being able to be backported there easily (i.e. I
> tried and gave up.)
> 
> 4ae68b26c3ab ("objtool/x86: Fix SRSO mess") being the commit that I
> can't seem to get to work properly, my attempt can be seen here:
> 	https://lore.kernel.org/r/2023082212-pregnant-lizard-80e0@gregkh

> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -796,8 +796,11 @@ bool arch_is_retpoline(struct symbol *sy
>  
>  bool arch_is_rethunk(struct symbol *sym)
>  {
> -	return !strcmp(sym->name, "__x86_return_thunk") ||
> -	       !strcmp(sym->name, "srso_untrain_ret") ||
> -	       !strcmp(sym->name, "srso_safe_ret") ||
> -	       !strcmp(sym->name, "retbleed_return_thunk");
> +	return !strcmp(sym->name, "__x86_return_thunk");
> +}
> +
> +bool arch_is_embedded_insn(struct symbol *sym)
> +{
> +	return !strcmp(sym->name, "retbleed_return_thunk") ||
> +	       !strcmp(sym->name, "srso_safe_ret");

This wouldn't work with the current 6.1.y branch, I assume you had some
other patches applied before this.  e.g., the patch renaming __ret to
retbleed_return_thunk.

>  }
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -418,7 +418,7 @@ static int decode_instructions(struct ob
>  		}
>  
>  		list_for_each_entry(func, &sec->symbol_list, list) {
> -			if (func->type != STT_FUNC || func->alias != func)
> +			if (func->embedded_insn || func->alias != func)
>  				continue;

This hunk looks like a bug.  This might be the source of your problems.
 
The below patch seems to work on stock 6.1.47.  Or if you have other
SRSO patches pending, point me to them and I can look at porting this
one to fit.

---8<---

From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] objtool/x86: Fix SRSO mess

Objtool --rethunk does two things:

 - it collects all (tail) call's of __x86_return_thunk and places them
   into .return_sites. These are typically compiler generated, but
   RET also emits this same.

 - it fudges the validation of the __x86_return_thunk symbol; because
   this symbol is inside another instruction, it can't actually find
   the instruction pointed to by the symbol offset and gets upset.

Because these two things pertained to the same symbol, there was no
pressing need to separate these two separate things.

However, alas, along comes SRSO and more crazy things to deal with
appeared.

The SRSO patch itself added the following symbol names to identify as
rethunk:

  'srso_untrain_ret', 'srso_safe_ret' and '__ret'

Where '__ret' is the old retbleed return thunk, 'srso_safe_ret' is a
new similarly embedded return thunk, and 'srso_untrain_ret' is
completely unrelated to anything the above does (and was only included
because of that INT3 vs UD2 issue fixed previous).

Clear things up by adding a second category for the embedded instruction
thing.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.704502245@infradead.org

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c      | 11 +++++++----
 tools/objtool/check.c                | 22 +++++++++++++++++++++-
 tools/objtool/include/objtool/arch.h |  1 +
 tools/objtool/include/objtool/elf.h  |  1 +
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a60c5efe34b3..4cf730e3ac1d 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -796,8 +796,11 @@ bool arch_is_retpoline(struct symbol *sym)
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	return !strcmp(sym->name, "__x86_return_thunk");
+}
+
+bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "__ret") ||
+	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2c350933a23..a88ad299fc31 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1164,16 +1164,33 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
+__weak bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return false;
+}
+
 #define NEGATIVE_RELOC	((void *)-1L)
 
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
@@ -1437,7 +1454,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2327,6 +2344,9 @@ static int classify_symbols(struct objtool_file *file)
 			if (arch_is_rethunk(func))
 				func->return_thunk = true;
 
+			if (arch_is_embedded_insn(func))
+				func->embedded_insn = true;
+
 			if (!strcmp(func->name, "__fentry__"))
 				func->fentry = true;
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index beb2f3aa94ff..861c0c60ac81 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int *base);
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 16f4067b82ae..5d4a841fbd31 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -60,6 +60,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 embedded_insn     : 1;
 	struct list_head pv_target;
 };
 
-- 
2.41.0

