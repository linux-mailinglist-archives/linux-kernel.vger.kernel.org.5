Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9ED77ECBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbjHPWJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbjHPWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:08:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F126AD;
        Wed, 16 Aug 2023 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6+3FzdqyU8erirMrs06cOCf70G4V/DWb87UhgWGmP/4=; b=vGCV+mCUXp6TIF5906g7OwNexv
        TCqTCwqMnR3qmtbbh7Il1heTPs06TnlK5TH8Q5s0D2bM3xbtW9+4Rtar9GxFxqQ1RJzrKWMIubrwP
        NwO6Ms3AzLYQbWfkzwUvFQGZR3RKiwveEdaoWtJ55iS3wLtyEpg+bX62+MtycwAR93oNRIZ1US1II
        CB2Fea76XqjuGODu/UdVeJ42Wjrks/soNNEn79IBCEK6lBo75nBiXflONu9uIs8GpNYXdzkKsqFFk
        LVScCILSQXy8xKkoML0xd+mBxR3Wd8WsnHp/vzMQSIl5JcfBNilea7YWy8aBRW75iyUt8zRMH3BQP
        QAjwProA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWOgz-00H9tB-7w; Wed, 16 Aug 2023 22:08:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DACC730020C;
        Thu, 17 Aug 2023 00:08:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C677820307330; Thu, 17 Aug 2023 00:08:40 +0200 (CEST)
Date:   Thu, 17 Aug 2023 00:08:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: [PATCH] objtool/x86: Fixup frame-pointer vs rethunk
Message-ID: <20230816220840.GB998718@hirez.programming.kicks-ass.net>
References: <20230814121148.704502245@infradead.org>
 <169217251760.27769.15304146275480287222.tip-bot2@tip-bot2>
 <20230816115921.GH980931@hirez.programming.kicks-ass.net>
 <20230816203152.co5hgmo2epd6wvef@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816203152.co5hgmo2epd6wvef@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:31:52PM -0700, Josh Poimboeuf wrote:
> On Wed, Aug 16, 2023 at 01:59:21PM +0200, Peter Zijlstra wrote:
> > Turns out I forgot to build with FRAME_POINTER=y, that still gives:
> > 
> > vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup
> > 
> > the below seems to cure this.
> 
> LGTM

OK, with Changelog below.

---
Subject: objtool/x86: Fixup frame-pointer vs rethunk
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 16 Aug 2023 13:59:21 +0200

For stack-validation of a frame-pointer build, objtool validates that
every CALL instructions is preceded by a frame-setup. The new SRSO
return thunks violate this with their RSB stuffing trickery.

Extend the __fentry__ exception to also cover the embedded_insn case
used for this. This cures:

vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup

Fixes: 4ae68b26c3ab ("objtool/x86: Fix SRSO mess")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2630,12 +2630,17 @@ static int decode_sections(struct objtoo
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
@@ -3636,7 +3641,7 @@ static int validate_branch(struct objtoo
 			if (ret)
 				return ret;
 
-			if (opts.stackval && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_special_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_INSN(insn, "call without frame pointer save/setup");
 				return 1;
