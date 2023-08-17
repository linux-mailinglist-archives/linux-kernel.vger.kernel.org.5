Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14E77F24C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348958AbjHQIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbjHQIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:39:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C221BD4;
        Thu, 17 Aug 2023 01:39:23 -0700 (PDT)
Date:   Thu, 17 Aug 2023 08:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692261561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVVlkAPAQ+SvYlw9veHUUzPOf+AqkmCVdaT+cCbl4jM=;
        b=zjhAzHit5kQPWXC4WkMP0eLO1UW7A/6A0Wzw0eucWrJe/P6UZ7C2aikR4nn9//R45EBguG
        DBGxPRi1iRGYgTS9V3dEqzvBSgYJvwHFInrawz/G2cCBNfqvvbbpoWOlhks5qFH/pGJRC8
        P05mx9cnnD4l3yq8WCR+Q02UyhI2UmiF468gXxaoJuhfLD+VxoOWgKy+LtSclGBVJ3uOa7
        6NTm/L7B+6f3vgPJWMyeVGM+dmgaGc/AnJCfGT8Bm2/SfC6Go0zh4dmvAvBSvMQM8kbmnP
        bUycyp6dOaukGHr/VQM8dnCogF7uDv+LfpEphFkFdYeCggLI5fDS9w4j3/iw4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692261561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVVlkAPAQ+SvYlw9veHUUzPOf+AqkmCVdaT+cCbl4jM=;
        b=ue+Y78D/SvmHmNKirmC+Ytp+4l6ddkrtovPoLeRSxL9n25sucoaxi81BBPrljlDFp1uCwt
        uNwOal7bepq1UZAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool/x86: Fixup frame-pointer vs rethunk
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816115921.GH980931@hirez.programming.kicks-ass.net>
References: <20230816115921.GH980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169226156036.27769.8460741923496477919.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dbf46008775516f7f25c95b7760041c286299783
Gitweb:        https://git.kernel.org/tip/dbf46008775516f7f25c95b7760041c286299783
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Aug 2023 13:59:21 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 17 Aug 2023 00:44:35 +02:00

objtool/x86: Fixup frame-pointer vs rethunk

For stack-validation of a frame-pointer build, objtool validates that
every CALL instruction is preceded by a frame-setup. The new SRSO
return thunks violate this with their RSB stuffing trickery.

Extend the __fentry__ exception to also cover the embedded_insn case
used for this. This cures:

  vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup

Fixes: 4ae68b26c3ab ("objtool/x86: Fix SRSO mess")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20230816115921.GH980931@hirez.programming.kicks-ass.net
---
 tools/objtool/check.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7a9aaf4..1384090 100644
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
