Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5182576D8B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHBUdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjHBUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:33:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4010E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mTJSeFJRdx9xWm5zyNpApVtCKfugrSvpOLZjvUoRvZI=; b=KVaPUoXFRqTVkPae4mTYr1d7bM
        3X9ensVfyB5PSM0yn+CvPI13wN7eZAinWsJrGheOQn+VvciO0Z1SJjnHIfLm1A4cAv+xOHfip2kRP
        P3greT9AiADxww+yJW8MDbm0FhFdQQAFASS+Bd85ECbQ03ObYrbKYisnpQvNstej8jHincB8S45W2
        LjHlnA80W3vJUEWRjF1/qe3C8gUexHOiJHwiB9gYHIgJhRzx0o/i8ixJoumrxpKN+JV+t7Dj9yx3N
        9HVKRrd2vSBlPaB7h07T990+tFoJXlTq7II+8h4FkHy3yzj4jdcy+GMY3T9SIff56gyXud+FfhpZ0
        l5jot2qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRIX5-00H3Mu-6K; Wed, 02 Aug 2023 20:33:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B483630007E;
        Wed,  2 Aug 2023 22:33:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A908211237D2; Wed,  2 Aug 2023 22:33:22 +0200 (CEST)
Date:   Wed, 2 Aug 2023 22:33:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@kernel.org,
        andrew.cooper3@citrix.com, David.Kaplan@amd.com
Subject: Re: [PATCH 2/2] x86/ibt: Avoid duplicate ENDBR in
 __put_user_nocheck*()
Message-ID: <20230802203322.GG231007@hirez.programming.kicks-ass.net>
References: <20230802105545.594381530@infradead.org>
 <20230802110323.086971726@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802110323.086971726@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:55:47PM +0200, Peter Zijlstra wrote:
> Commit cb855971d717 ("x86/putuser: Provide room for padding") changed
> __put_user_nocheck_*() into proper functions but failed to note that
> SYM_FUNC_START() already provides ENDBR, rendering the explicit ENDBR
> superfluous.

The below objtool thing reliably detects this pattern:

vmlinux.o: warning: objtool: __put_user_nocheck_1+0x4: duplicate ENDBR
vmlinux.o: warning: objtool: __put_user_nocheck_2+0x4: duplicate ENDBR
vmlinux.o: warning: objtool: __put_user_nocheck_4+0x4: duplicate ENDBR
vmlinux.o: warning: objtool: __put_user_nocheck_8+0x4: duplicate ENDBR

---
 tools/objtool/check.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05f0e5a..c6ba6e768b03 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4254,13 +4254,30 @@ static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
 	return insn->offset == sym->offset + sym->len;
 }
 
-static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+static int validate_ibt_insn(struct objtool_file *file,
+			     struct instruction *insn,
+			     struct instruction *prev)
 {
 	struct instruction *dest;
 	struct reloc *reloc;
 	unsigned long off;
 	int warnings = 0;
 
+	if (prev && prev->sym && prev->sym == insn->sym &&
+	    prev->type == INSN_ENDBR && insn->type == INSN_ENDBR) {
+		/*
+		 * ___bpf_prog_run() is a maze of 'label as value' and
+		 * 'computed goto' and GCC gets confused and emits back-to-back
+		 * ENDBR due to failing to merge two labels.
+		 *
+		 * Don't warn about this until GCC is fixed or verbose.
+		 */
+		if (strcmp(insn->sym->name, "___bpf_prog_run") != 0 || opts.verbose) {
+			WARN_INSN(insn, "duplicate ENDBR");
+			warnings++;
+		}
+	}
+
 	/*
 	 * Looking for function pointer load relocations.  Ignore
 	 * direct/indirect branches:
@@ -4382,11 +4399,13 @@ static int validate_ibt(struct objtool_file *file)
 {
 	struct section *sec;
 	struct reloc *reloc;
-	struct instruction *insn;
+	struct instruction *insn, *prev = NULL;
 	int warnings = 0;
 
-	for_each_insn(file, insn)
-		warnings += validate_ibt_insn(file, insn);
+	for_each_insn(file, insn) {
+		warnings += validate_ibt_insn(file, insn, prev);
+		prev = insn;
+	}
 
 	for_each_sec(file, sec) {
 
