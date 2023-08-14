Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0829A77B5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHNKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjHNKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:00:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC58E65;
        Mon, 14 Aug 2023 03:00:26 -0700 (PDT)
Date:   Mon, 14 Aug 2023 10:00:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692007225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sNSLYyhA4qV7EEKt3GZvB5O3YA2jlDM3bozLIDUGkU=;
        b=qMVDkV6QNPtPMVlTFtOldtNHq4ZMMy66F5G4oqyMQvZqClRi1DCOvxkgLyWwv4tT51cgQ1
        ntX1Wh6kH5T9DTM5Et0A5+tCUTykOe5GNORcXvNGErMng7Bk8V2XcxB9LyzEehwDcTNJhf
        Kod7sxqEod4CvM0JNMOJIynPmdR0tXxfr/lUgg7/duhRTmCwUOLPt5uaiWukwGlNNtn54J
        QmGaTJG+SU3dl88lnqj807Yum/Uxlqfs4pQf95Xik5syIXCuACtUXxFxSTDk+5kabSo09r
        ud9wTRu3lqUqqu96lK42gs4JhDLx8De97SXDJcWKD0tDiiCGtBEY+AhpnkOVew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692007225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sNSLYyhA4qV7EEKt3GZvB5O3YA2jlDM3bozLIDUGkU=;
        b=AlAeZz5zpYlXbgXzULu3S4I4bJrdwvL+UY1IH3/pJtYQWkNc70zhAiTtyYNpSq2ARQygCZ
        Q3wdA7CZQe4Ud8Dw==
From:   "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/retpoline,kprobes: Fix position of thunk
 sections with CONFIG_LTO_CLANG
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230711091952.27944-2-petr.pavlu@suse.com>
References: <20230711091952.27944-2-petr.pavlu@suse.com>
MIME-Version: 1.0
Message-ID: <169200722469.27769.3677814215325694646.tip-bot2@tip-bot2>
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

Commit-ID:     79cd2a11224eab86d6673fe8a11d2046ae9d2757
Gitweb:        https://git.kernel.org/tip/79cd2a11224eab86d6673fe8a11d2046ae9d2757
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Tue, 11 Jul 2023 11:19:51 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Aug 2023 11:44:19 +02:00

x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG

The linker script arch/x86/kernel/vmlinux.lds.S matches the thunk
sections ".text.__x86.*" from arch/x86/lib/retpoline.S as follows:

  .text {
    [...]
    TEXT_TEXT
    [...]
    __indirect_thunk_start = .;
    *(.text.__x86.*)
    __indirect_thunk_end = .;
    [...]
  }

Macro TEXT_TEXT references TEXT_MAIN which normally expands to only
".text". However, with CONFIG_LTO_CLANG, TEXT_MAIN becomes
".text .text.[0-9a-zA-Z_]*" which wrongly matches also the thunk
sections. The output layout is then different than expected. For
instance, the currently defined range [__indirect_thunk_start,
__indirect_thunk_end] becomes empty.

Prevent the problem by using ".." as the first separator, for example,
".text..__x86.indirect_thunk". This pattern is utilized by other
explicit section names which start with one of the standard prefixes,
such as ".text" or ".data", and that need to be individually selected in
the linker script.

  [ nathan: Fix conflicts with SRSO and fold in fix issue brought up by
    Andrew Cooper in post-review:
    https://lore.kernel.org/20230803230323.1478869-1-andrew.cooper3@citrix.com ]

Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230711091952.27944-2-petr.pavlu@suse.com
---
 arch/x86/kernel/vmlinux.lds.S | 8 ++++----
 arch/x86/lib/retpoline.S      | 8 ++++----
 tools/objtool/check.c         | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ef06211..dfb8783 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,15 +134,15 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.indirect_thunk)
-		*(.text.__x86.return_thunk)
+		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
 		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
 #ifdef CONFIG_CPU_SRSO
-		*(.text.__x86.rethunk_untrain)
+		*(.text..__x86.rethunk_untrain)
 #endif
 
 		ENTRY_TEXT
@@ -153,7 +153,7 @@ SECTIONS
 		 * definition.
 		 */
 		. = srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
-		*(.text.__x86.rethunk_safe)
+		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
 		*(.gnu.warning)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 132cedb..8db74d8 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -13,7 +13,7 @@
 #include <asm/frame.h>
 #include <asm/nops.h>
 
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
 
 
 .macro POLINE reg
@@ -148,7 +148,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  * As a result, srso_safe_ret_alias() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
-	.section .text.__x86.rethunk_untrain
+	.section .text..__x86.rethunk_untrain
 
 SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
@@ -158,7 +158,7 @@ SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 SYM_FUNC_END(srso_untrain_ret_alias)
 __EXPORT_THUNK(srso_untrain_ret_alias)
 
-	.section .text.__x86.rethunk_safe
+	.section .text..__x86.rethunk_safe
 #endif
 
 /* Needs a definition for the __x86_return_thunk alternative below. */
@@ -172,7 +172,7 @@ SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 	int3
 SYM_FUNC_END(srso_safe_ret_alias)
 
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05..e2ee10c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -389,7 +389,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
-		    !strncmp(sec->name, ".text.__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
 		/*
