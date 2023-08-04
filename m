Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2676FC3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHDIoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHDIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:43:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150B930EB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0LFXPFcS4UF38aCYeIOwXi07gRitSmQZGen5y0ki7Vc=; b=qbQcxnEsZr2IOc6d/NkOa/F0Yr
        jhuadu+csIl1xc9AR0JbPvBsLZ1K8dw8lrEP2te4kKDQ26o2NlcYIfHVzC7POJAN8MOrvyuzR1VkH
        HHssqvfTyXYrfu6EuSUhRU7XOeUM64+qnLyTRFqVxD9LRqiMO2BydFWeF1cQXGBHIbJydORoaEWzc
        RTyykaBx0Xr51kIXf2mcRF6rpPXF1qS7qG41pumNSnxKjV1jBtWqjrNP2ka9LJ4A2/JjYfXSpQ4aj
        CVdd4+x1Bi286X1k/glaua/l6pSnIc6slbjWXJhtQbey57Jc+ahxNc4MMkaXoxChsCLOFlF/Lmlm2
        piJLCJeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRqPB-000EW5-0A;
        Fri, 04 Aug 2023 08:43:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5ED930020C;
        Fri,  4 Aug 2023 10:43:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B0BD20D38538; Fri,  4 Aug 2023 10:43:28 +0200 (CEST)
Date:   Fri, 4 Aug 2023 10:43:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86/retpoline,kprobes: Fix "Fix position of thunk
 sections with CONFIG_LTO_CLANG"
Message-ID: <20230804084328.GA220434@hirez.programming.kicks-ass.net>
References: <20230803215555.zl5oabntc44ry3uc@treble>
 <20230803230323.1478869-1-andrew.cooper3@citrix.com>
 <20230804082853.GM212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804082853.GM212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:28:53AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 04, 2023 at 12:03:23AM +0100, Andrew Cooper wrote:
> > Lets hope there are no .text..__x86womble sections around.
> > 
> > Fixes: 973ab2d61f33 ("x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG")
> > Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> > ---
> > CC: Petr Pavlu <petr.pavlu@suse.com>
> > CC: Peter Zijlstra (Intel) <peterz@infradead.org>
> > CC: Josh Poimboeuf <jpoimboe@kernel.org>
> > CC: linux-kernel@vger.kernel.org
> > 
> > Alternatively,
> > 
> > int strstarts(const char *s1, const char *s2)
> > {
> >         return strncmp(s1, s2, strlen(s2));
> > }
> 
> Durr, I hate C ;-/ And yes, we have a ton of it, lemme try that
> strstarts thing.

So there, that builds and compiles a kernel, must be good :-)

Now, let me go make some wake-up juice ...

---
 tools/objtool/check.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e096eb325acd..a2b624b580ff 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -20,6 +20,7 @@
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
+#include <linux/string.h>
 
 struct alternative {
 	struct alternative *next;
@@ -383,13 +384,13 @@ static int decode_instructions(struct objtool_file *file)
 
 		if (strcmp(sec->name, ".altinstr_replacement") &&
 		    strcmp(sec->name, ".altinstr_aux") &&
-		    strncmp(sec->name, ".discard.", 9))
+		    !strstarts(sec->name, ".discard."))
 			sec->text = true;
 
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
-		    !strncmp(sec->name, ".text..__x86.", 12))
+		    strstarts(sec->name, ".text..__x86."))
 			sec->noinstr = true;
 
 		/*
@@ -709,8 +710,7 @@ static int create_static_call_sections(struct objtool_file *file)
 			perror("strdup");
 			return -1;
 		}
-		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
-			    STATIC_CALL_TRAMP_PREFIX_LEN)) {
+		if (!strstarts(key_name, STATIC_CALL_TRAMP_PREFIX_STR)) {
 			WARN("static_call: trampoline name malformed: %s", key_name);
 			free(key_name);
 			return -1;
@@ -900,7 +900,7 @@ static int create_cfi_sections(struct objtool_file *file)
 		if (sym->type != STT_FUNC)
 			continue;
 
-		if (strncmp(sym->name, "__cfi_", 6))
+		if (!strstarts(sym->name, "__cfi_"))
 			continue;
 
 		idx++;
@@ -916,7 +916,7 @@ static int create_cfi_sections(struct objtool_file *file)
 		if (sym->type != STT_FUNC)
 			continue;
 
-		if (strncmp(sym->name, "__cfi_", 6))
+		if (!strstarts(sym->name, "__cfi_"))
 			continue;
 
 		if (!elf_init_reloc_text_sym(file->elf, sec,
@@ -2468,7 +2468,7 @@ static bool is_profiling_func(const char *name)
 	/*
 	 * Many compilers cannot disable KCOV with a function attribute.
 	 */
-	if (!strncmp(name, "__sanitizer_cov_", 16))
+	if (strstarts(name, "__sanitizer_cov_"))
 		return true;
 
 	/*
@@ -2477,7 +2477,7 @@ static bool is_profiling_func(const char *name)
 	 * the __no_sanitize_thread attribute, remove them. Once the kernel's
 	 * minimum Clang version is 14.0, this can be removed.
 	 */
-	if (!strncmp(name, "__tsan_func_", 12) ||
+	if (strstarts(name, "__tsan_func_") ||
 	    !strcmp(name, "__tsan_atomic_signal_fence"))
 		return true;
 
@@ -2492,8 +2492,7 @@ static int classify_symbols(struct objtool_file *file)
 		if (func->bind != STB_GLOBAL)
 			continue;
 
-		if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
-			     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
+		if (strstarts(func->name, STATIC_CALL_TRAMP_PREFIX_STR))
 			func->static_call_tramp = true;
 
 		if (arch_is_retpoline(func))
@@ -2528,7 +2527,7 @@ static void mark_rodata(struct objtool_file *file)
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
+		if (strstarts(sec->name, ".rodata") &&
 		    !strstr(sec->name, ".str1.")) {
 			sec->rodata = true;
 			found = true;
@@ -3400,7 +3399,7 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 	 * something 'BAD' happened. At the risk of taking the machine down,
 	 * let them proceed to get the message out.
 	 */
-	if (!strncmp(func->name, "__ubsan_handle_", 15))
+	if (strstarts(func->name, "__ubsan_handle_"))
 		return true;
 
 	return false;
@@ -3531,8 +3530,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
-			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6))
+			if (strstarts(func->name, "__cfi_") ||
+			    strstarts(func->name, "__pfx_"))
 				return 0;
 
 			WARN("%s() falls through to next function %s()",
@@ -4401,9 +4400,9 @@ static int validate_ibt(struct objtool_file *file)
 		 * These sections can reference text addresses, but not with
 		 * the intent to indirect branch to them.
 		 */
-		if ((!strncmp(sec->name, ".discard", 8) &&
+		if ((strstarts(sec->name, ".discard") &&
 		     strcmp(sec->name, ".discard.ibt_endbr_noseal"))	||
-		    !strncmp(sec->name, ".debug", 6)			||
+		    strstarts(sec->name, ".debug")			||
 		    !strcmp(sec->name, ".altinstructions")		||
 		    !strcmp(sec->name, ".ibt_endbr_seal")		||
 		    !strcmp(sec->name, ".orc_unwind_ip")		||
