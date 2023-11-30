Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA57FEB30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjK3Ivc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjK3Iva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:51:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07D10D1;
        Thu, 30 Nov 2023 00:51:35 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:51:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701334293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUdTvOEPs2S9No28jSLuPsp1FLVFo0Rm9xlD7Lb41/I=;
        b=esjq3x6sM7QObKd550sJzKaPxi6LRDLwrhJJidkv2L074ZnVZfheoh4Evwaoeb2bAiqpqn
        1wuHGcQ1H+VJe+JUKYgsRhAHevDk6KVN+HOmvAxCbxiGSPBPX1xdfGDxE8hkYp+ei30l48
        4Qq6jqDfztaiDMPkdQYCFiTs8Q+ZjSz1mX0GLdhRRKRjeQh8ySgMHnEr+8canrdt82IuA9
        FrK27nKRhUfrvpCmCsWBHX52Up+VtTAi64OtVxvo06NFOxmkh2IPh97eBP+Jx+ThGJJULl
        HsT0QosUrhXH7/Eich/QI3fWZnsinni7PvCiUX7Buazc3QszbmkkRpAvuseXpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701334293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUdTvOEPs2S9No28jSLuPsp1FLVFo0Rm9xlD7Lb41/I=;
        b=IGPufNnRLJwxPh2/n/JJCgynSnooIg8/3K/8LRZ+mQwFVsPyso0dW+ReGv2b9KNdI/kRsN
        Di9apj3QzBurRwCQ==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/tools: Remove chkobjdump.awk
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129-objdump-reformat-llvm-v3-3-0d855e79314d@kernel.org>
References: <20231129-objdump-reformat-llvm-v3-3-0d855e79314d@kernel.org>
MIME-Version: 1.0
Message-ID: <170133429300.398.16123263998836409962.tip-bot2@tip-bot2>
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

Commit-ID:     5225952d74d43e4c054731c74b8afd700b23a94a
Gitweb:        https://git.kernel.org/tip/5225952d74d43e4c054731c74b8afd700b23a94a
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 29 Nov 2023 15:17:43 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 09:38:12 +01:00

x86/tools: Remove chkobjdump.awk

This check is superfluous now that the minimum version of binutils to
build the kernel is 2.25. This also fixes an error seen with
llvm-objdump because it does not support '-v' prior to LLVM 13:

  llvm-objdump: error: unknown argument '-v'

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://github.com/llvm/llvm-project/commit/dde24a87c55f82d8c7b3bf3eafb10f2b9b2b9a01
Link: https://lore.kernel.org/r/20231129-objdump-reformat-llvm-v3-3-0d855e79314d@kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1362
---
 arch/x86/tools/Makefile       |  2 +-
 arch/x86/tools/chkobjdump.awk | 34 +----------------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)
 delete mode 100644 arch/x86/tools/chkobjdump.awk

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 90e820a..7278e25 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -17,7 +17,7 @@ reformatter = $(srctree)/arch/x86/tools/objdump_reformat.awk
 chkobjdump = $(srctree)/arch/x86/tools/chkobjdump.awk
 
 quiet_cmd_posttest = TEST    $@
-      cmd_posttest = ($(OBJDUMP) -v | $(AWK) -f $(chkobjdump)) || $(OBJDUMP) -d -j .text $(objtree)/vmlinux | $(AWK) -f $(reformatter) | $(obj)/insn_decoder_test $(posttest_64bit) $(posttest_verbose)
+      cmd_posttest = $(OBJDUMP) -d -j .text $(objtree)/vmlinux | $(AWK) -f $(reformatter) | $(obj)/insn_decoder_test $(posttest_64bit) $(posttest_verbose)
 
 quiet_cmd_sanitytest = TEST    $@
       cmd_sanitytest = $(obj)/insn_sanity $(posttest_64bit) -m 1000000
diff --git a/arch/x86/tools/chkobjdump.awk b/arch/x86/tools/chkobjdump.awk
deleted file mode 100644
index a4cf678..0000000
--- a/arch/x86/tools/chkobjdump.awk
+++ /dev/null
@@ -1,34 +0,0 @@
-# GNU objdump version checker
-#
-# Usage:
-# objdump -v | awk -f chkobjdump.awk
-BEGIN {
-	# objdump version 2.19 or later is OK for the test.
-	od_ver = 2;
-	od_sver = 19;
-}
-
-/^GNU objdump/ {
-	verstr = ""
-	gsub(/\(.*\)/, "");
-	for (i = 3; i <= NF; i++)
-		if (match($(i), "^[0-9]")) {
-			verstr = $(i);
-			break;
-		}
-	if (verstr == "") {
-		printf("Warning: Failed to find objdump version number.\n");
-		exit 0;
-	}
-	split(verstr, ver, ".");
-	if (ver[1] > od_ver ||
-	    (ver[1] == od_ver && ver[2] >= od_sver)) {
-		exit 1;
-	} else {
-		printf("Warning: objdump version %s is older than %d.%d\n",
-		       verstr, od_ver, od_sver);
-		print("Warning: Skipping posttest.");
-		# Logic is inverted, because we just skip test without error.
-		exit 0;
-	}
-}
