Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0667FEB32
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjK3Ivj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjK3Iva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:51:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BFF12C;
        Thu, 30 Nov 2023 00:51:36 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:51:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701334295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9AjYlYAYx+oR2KXDgTbog5n4T+oR4QcI16HbOuThJQ=;
        b=zzoZr18aSPmR5kfCWlGeDY4B2FYFk0VQU9u9msMYgexOJWsBmNt+sAQbunwtTlLNQfc7HE
        lHy57dfNENJ4zcX8s5gHGeGdD95iVpahnBAgmbagKf5aIDXlFFoxwaPYc3TWXmmb/lUtxk
        jloVKzF5Lkw3GfwlQdJGA0eBB7qf/NGdSDHjFSzgTLvaMg0PsOd0+lZaHM0/gXCrzBCcYU
        TVPd978b6VklnE5Hp6WRXkFlLxN2s3omhlVFww/iyS8Nr1yrNLPy8XbYZ/criu2i+DyvIv
        Dnh2kn0JO+56whoT2IG4UccOrGCc1PGIjNwfUHn1MJf4jlrrKam+QzqV3fDa9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701334295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9AjYlYAYx+oR2KXDgTbog5n4T+oR4QcI16HbOuThJQ=;
        b=R2vUcqhyg5AVYswADf+2gdRAhtzHftfFoFzsbOdXAX+dJgGQLzLHGyFVtj0HH9pjVckFff
        VdhQ//N6+G+GQYDA==
From:   "tip-bot2 for Samuel Zeter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/tools: objdump_reformat.awk: Ensure regex matches fwait
Cc:     Samuel Zeter <samuelzeter@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129-objdump-reformat-llvm-v3-1-0d855e79314d@kernel.org>
References: <20231129-objdump-reformat-llvm-v3-1-0d855e79314d@kernel.org>
MIME-Version: 1.0
Message-ID: <170133429425.398.12209221658096369317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     60c2ea7c89e375804171552d8ea53d9084ec3269
Gitweb:        https://git.kernel.org/tip/60c2ea7c89e375804171552d8ea53d9084ec3269
Author:        Samuel Zeter <samuelzeter@gmail.com>
AuthorDate:    Wed, 29 Nov 2023 15:17:41 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 09:38:09 +01:00

x86/tools: objdump_reformat.awk: Ensure regex matches fwait

If there is "wait" mnemonic in the line being parsed, it is incorrectly
handled by the script, and an extra line of "fwait" in
objdump_reformat's output is inserted. As insn_decoder_test relies upon
the formatted output, the test fails.

This is reproducible when disassembling with llvm-objdump:

Pre-processed lines:

  ffffffff81033e72: 9b                    wait
  ffffffff81033e73: 48 c7 c7 89 50 42 82  movq

After objdump_reformat.awk:

  ffffffff81033e72:       9b      fwait
  ffffffff81033e72:                               wait
  ffffffff81033e73:       48 c7 c7 89 50 42 82    movq

The regex match now accepts spaces or tabs, along with the "fwait"
instruction.

Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20231129-objdump-reformat-llvm-v3-1-0d855e79314d@kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1364
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index f418c91..276e572 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -12,7 +12,7 @@ BEGIN {
 	prev_hex = ""
 	prev_mnemonic = ""
 	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
-	fwait_expr = "^9b "
+	fwait_expr = "^9b[ \t]*fwait"
 	fwait_str="9b\tfwait"
 }
 
