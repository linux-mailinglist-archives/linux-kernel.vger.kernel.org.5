Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31827805ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjLETxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:53:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE23A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:53:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7299FC433C7;
        Tue,  5 Dec 2023 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701805996;
        bh=5bILRm/voPLjGTGQ/2zk5RoYBOPSzOEdtIPbiV7rR0M=;
        h=From:Date:Subject:To:Cc:From;
        b=rZl2VeTYSyv0nFgj+9bbl3iP7V9JuPOrOv3FngmiP8rmM/cmIPfZO4ZVt5HMqze2a
         wpPLxbChLvQZeb8H/r8AKrB/henHwRHiuygWU90/qwrPmQ/3SEOzwQlcaUblDCcdhA
         DroFvHKIO20pJloDs+TkUx5xi/I6Rs83ja3ECGJBSKzWmnkiPTAhaDGcuJpVNE4QFH
         NkxGjxBe/ganelNIOLJST+/RadhGxN2eQbFPd2qzbZ8/igHqdJZThmV3O1JysdfHbH
         5Q+Ut/CzvDRcy3NJfe32z7PGITCI22ZjzD7qCAZ14duhfswBUDdx/AyzAG+NFojt0P
         NOpDjKnvax1/w==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 05 Dec 2023 12:53:08 -0700
Subject: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKN/b2UC/zWN2wrCMBAFf6XsswtptHj5FZGyaVaNJk3YaC2U/
 ruL4OPAnDkLVJbAFU7NAsJTqCGPCu2mgeFO440xeGWwxm5bazrM7uHfqfTC1yyJXkifJ6rpI2O
 MU/oL6Mj3PBfBI+93g7dkDq4D7Radhvn3eb6s6xengL9GgwAAAA==
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5bILRm/voPLjGTGQ/2zk5RoYBOPSzOEdtIPbiV7rR0M=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKn59avvh/y0Yp8yseFB/C75KbV3D9tXvBTYeTTDb7/fp
 zXbeDniO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEck8z/M9zP1Yfdo//ucHt
 O2ej3JYve8fS/WF/v3/gralT9/3hjjvCyPDadKqcXrDFjZd85To3Dwjf2RUm8XyT7/wDKrPmnDm
 zaD0/AA==
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

When running the instruction decoder selftest with LLVM=1 +
CONFIG_PVH=y, there is a series of warnings:

  arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
  arch/x86/tools/insn_decoder_test: warning: ffffffff81000050     ea                      <unknown>
  arch/x86/tools/insn_decoder_test: warning: objdump says 1 bytes, but insn_get_length() says 7
  arch/x86/tools/insn_decoder_test: warning: Decoded and checked 7214721 instructions with 1 failures

GNU objdump outputs "(bad)" instead of "<unknown>", which is already
handled in the bad_expr regex, so there is no warning.

  $ objdump -d arch/x86/platform/pvh/head.o | grep -E '50:\s+ea'
  50:   ea                      (bad)

  $ llvm-objdump -d arch/x86/platform/pvh/head.o | grep -E '50:\s+ea'
        50: ea                            <unknown>

Add "<unknown>" to the bad_expr regex to clear up the warning, allowing
the instruction decoder selftest to fully pass with llvm-objdump.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index a4120d907277..20b08a6c4d33 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -11,7 +11,7 @@ BEGIN {
 	prev_addr = ""
 	prev_hex = ""
 	prev_mnemonic = ""
-	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
+	bad_expr = "(\\(bad\\)|<unknown>|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
 	fwait_expr = "^9b[ \t]*fwait"
 	fwait_str="9b\tfwait"
 }

---
base-commit: 5225952d74d43e4c054731c74b8afd700b23a94a
change-id: 20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-9e74cd2a08b5

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

