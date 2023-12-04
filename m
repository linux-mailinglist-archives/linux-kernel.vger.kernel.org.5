Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10B802C09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjLDH3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjLDH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:28:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60186D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:29:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22559C433C8;
        Mon,  4 Dec 2023 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701674944;
        bh=ag47fZQN67ZIIBjPxPbl0fUu/BkVyp7AgqE71oADyVA=;
        h=From:To:Cc:Subject:Date:From;
        b=Cw53yCj0nyzlnWnbte5Lwrqcep7sQ1vNA/H/kA1jFpbkHZOKhfjn8Qj8RC6vXV0hj
         dhqJl1orOc2HwTgI7jTsQakj6rb7vDmEu4+ro5uD5rMIejGmoTDV6sF/uel4qK/lVn
         Cg4WhA2u9chkMf7njxL5GsVYB3w1ItBWrgL5tDs+Mh/kX7M2GKPcUTwWvPYnS0PcNm
         BNYaaMPEjV9iIOaUB67vzKsLwaYORmmG85864Qlh8mRFefPnLJ/G8GanlBWFg7B4Rb
         pilAA3MJ1N1eyVclZay+OkSO5b2rlXwVLOJjA2mpyDQ6l+PrzzYtkHiBx7Ba3NqgLH
         +FYvPa5pAjgIQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Uros Bizjak <ubizjak@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/alternative: move apply_relocation() out of init section
Date:   Mon,  4 Dec 2023 08:28:41 +0100
Message-Id: <20231204072856.1033621-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is now called from a few places that are no __init_or_module,
resulting a link time warning:

WARNING: modpost: vmlinux: section mismatch in reference: patch_dest+0x8a (section: .text) -> apply_relocation (section: .init.text)

Remove the annotation here.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not entire sure about this one, it does address the warning, but it
might be possible to find and change all the callers instead if they
fit the __init_or_module pattern.
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d973bcf7db78..4a25642ab714 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(alternatives_patched);
 #define DA_ENDBR	0x08
 #define DA_SMP		0x10
 
-static unsigned int __initdata_or_module debug_alternative;
+static unsigned int debug_alternative;
 
 static int __init debug_alt(char *str)
 {
@@ -206,7 +206,7 @@ static int skip_nops(u8 *instr, int offset, int len)
  * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
  * to the end of the NOP sequence into a single NOP.
  */
-static bool __init_or_module
+static bool
 __optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, int *target)
 {
 	int i = *next - insn->length;
@@ -325,7 +325,7 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 	return (target < src || target > src + src_len);
 }
 
-void __init_or_module apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 {
 	int prev, target = 0;
 
-- 
2.39.2

