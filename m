Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD027A342D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjIQHzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIQHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:54:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DAD18C;
        Sun, 17 Sep 2023 00:54:49 -0700 (PDT)
Date:   Sun, 17 Sep 2023 07:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694937287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOw6yz0Ovl1v3C5JTgkjuh1d4DAtgpH008fK72BO4q4=;
        b=1kEuy4L7Yus+5J62uCVClGr5DKjZXr+fmfWHndOEwX37/5XewQkmmSpVqMtZ+8M7YaucBZ
        cvflnOmoWgRg4LxVI9Sv1e26jdi0mywtEj3b/QwBr7qoGPHgDvCrCR/D3jwTlJGXyzWzdK
        FstD6toNM7+5Z/nOuQjyo5kcLBEecht/ZlULFpbgYCOXUFsS3Z6eAZ85oou1LL5Xwj1ddX
        Lacvm8h/Ur0827/crwjrYOS2CBi6+sekf/buLJ7C47keVK3k7Q3a2CaOc7RmXg9QfxgWpY
        7xd86XSpHU3xFOQaZ/pFAQGBXUBRmmMYh6yUqDDpbQ5JG9hjaOACDRY/VpceFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694937287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOw6yz0Ovl1v3C5JTgkjuh1d4DAtgpH008fK72BO4q4=;
        b=JtdlJBfkoYiWJv+e0wEHyNMv+LE5YaYAqgIZujanvLw1kxJJJKFQqZl8KdDCwWLNoIQNmP
        g8Cw2/kH4NTHVwDA==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/purgatory: Remove LTO flags
Cc:     Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230914170138.995606-1-song@kernel.org>
References: <20230914170138.995606-1-song@kernel.org>
MIME-Version: 1.0
Message-ID: <169493728660.27769.18183881403388976059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     75b2f7e4c9e0fd750a5a27ca9736d1daa7a3762a
Gitweb:        https://git.kernel.org/tip/75b2f7e4c9e0fd750a5a27ca9736d1daa7a3762a
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 14 Sep 2023 10:01:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 09:49:03 +02:00

x86/purgatory: Remove LTO flags

-flto* implies -ffunction-sections. With LTO enabled, ld.lld generates
multiple .text sections for purgatory.ro:

  $ readelf -S purgatory.ro  | grep " .text"
    [ 1] .text             PROGBITS         0000000000000000  00000040
    [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
    [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
    [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
    [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
    [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
    [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0

This causes WARNING from kexec_purgatory_setup_sechdrs():

  WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
  kexec_load_purgatory+0x37f/0x390

Fix this by disabling LTO for purgatory.

[ AFAICT, x86 is the only arch that supports LTO and purgatory. ]

We could also fix this with an explicit linker script to rejoin .text.*
sections back into .text. However, given the benefit of LTOing purgatory
is small, simply disable the production of more .text.* sections for now.

Fixes: b33fff07e3e3 ("x86, build: allow LTO to be selected")
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20230914170138.995606-1-song@kernel.org
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index c2a29be..08aa0f2 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
