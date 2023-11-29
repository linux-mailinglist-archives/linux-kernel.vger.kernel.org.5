Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE37F7FE2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjK2WSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2WRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:17:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164DBD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:17:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B968C433CD;
        Wed, 29 Nov 2023 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701296279;
        bh=hd6/cveEUNsa+JSOFRwRWxLeImJJ4mFqSehJRZNpmqg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=F3vkcUrbC9fWRuaqydSqSzMnS4KrvklUnCQDUM+XP/oKoItOMpu98Bi3SY13DSz/P
         cDtJLUrBfefCqkbsxto5aYavpQY+yoG3B64NcIJPuY9Qcp9SRrU1jfppB+dzVHYG0V
         gXE6e136klP5+q8LmaS30w0wuJ9Q5FrtZ61mpDPuw8QXhs3e3XFUDzlBrJ+KLuRs5i
         pk9DCDJioatUD9aaAqkcoPOyslb4mVXL+Fk1SWo4fDxBbJnsi80ksLTl2vhU1v4E2B
         LTYHh2nmmNX/M5UKLRfGPqIiSd3ZO9a+RUdisQ0mtqWtekbQEN2wuwdf3bcBK3p3bM
         X4o8SxoIHTjMg==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 29 Nov 2023 15:17:42 -0700
Subject: [PATCH v3 2/3] x86/tools: objdump_reformat.awk: Allow for spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-objdump-reformat-llvm-v3-2-0d855e79314d@kernel.org>
References: <20231129-objdump-reformat-llvm-v3-0-0d855e79314d@kernel.org>
In-Reply-To: <20231129-objdump-reformat-llvm-v3-0-0d855e79314d@kernel.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, ndesaulniers@google.com, keescook@chromium.org,
        samuelzeter@gmail.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=nathan@kernel.org;
 h=from:subject:message-id; bh=JQyd5OlWKOWs6EDp0gJ7kaEqsFs19g/OI4Sr1wB1jyI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKnpO6Y45azZaWJU3r5C8pj7naR1l/T5G3oUhSb0pcokM
 kzZf2NlRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhIrzAjQ8unR2FudaeevFBf
 LigS/VHRq/Qp78ytJ2/+bpzi0bjH1JLhn3FLaZTx264pmbKF1l2febQeOu3n4Cp/bhIrN8fS7FE
 rMwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Zeter <samuelzeter@gmail.com>

GNU objdump and LLVM objdump have differing output formats.
Specifically, GNU objump will format its output as: address:<tab>hex,
whereas LLVM objdump displays its output as address:<space>hex.

objdump_reformat.awk incorrectly handles this discrepancy due to
the unexpected space and as a result insn_decoder_test fails, as
its input is garbled.

The instruction line being tokenized now handles a space and colon,
or tab delimiter.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1364
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index 276e572a6f60..a4120d907277 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -22,7 +22,7 @@ BEGIN {
 }
 
 /^ *[0-9a-f]+:/ {
-	if (split($0, field, "\t") < 3) {
+	if (split($0, field, /: |\t/) < 3) {
 		# This is a continuation of the same insn.
 		prev_hex = prev_hex field[2]
 	} else {

-- 
2.43.0

