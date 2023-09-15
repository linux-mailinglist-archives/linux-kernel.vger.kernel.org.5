Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE327A18FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjIOIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjIOIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:36:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0807E7E;
        Fri, 15 Sep 2023 01:36:28 -0700 (PDT)
Date:   Fri, 15 Sep 2023 08:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694766987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gblbQos8VTNNdUR5WR/h70J7iw2C+0i404bkbVCQRoI=;
        b=KQVFclS0QKWzqEXxbT+1qkip+4o6d3/VMsLrND60Zo3g32lWCHscjOl8YkWhKxKZKSpjKU
        MSiPedACt1Uc3xP2/oq0mxGeueNYlBORmP6VcL9S6xrn2e42shi39ieDT2w5ngI0bfPkC8
        OGCS+pLNH4PrIo+g6cGLNzgFElEjNq3Df21VuTQ0Wg/F1y7WM4+5UThiFchGK9Bxt/SRZl
        cCBoWfqJtWHBGjdndvCwAWTOqh2OdNYQxBTengPCy9HNs2J3Qe5cV+RVXcjoMyNPt3zoaF
        YgayGYGCdlQgfnp8UG+ZIBsSwZOzgr6fEUVDDFkOf+3I74id7wnLbv7M2ymCSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694766987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gblbQos8VTNNdUR5WR/h70J7iw2C+0i404bkbVCQRoI=;
        b=oc2zV1Oj+U9a3vg/XiC8NJIdfJ7jt5ZTPK0ixXHC6Y1xndJZLrl7ji/ts2JPV5sgmK6/Xy
        vMe452etrsSp7mBw==
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
Message-ID: <169476698697.27769.6321588484141795759.tip-bot2@tip-bot2>
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

Commit-ID:     f7d2101197488fdd2106ca21346733562f398765
Gitweb:        https://git.kernel.org/tip/f7d2101197488fdd2106ca21346733562f398765
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 14 Sep 2023 10:01:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 10:31:26 +02:00

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
