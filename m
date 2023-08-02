Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7976D019
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjHBOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjHBOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677221723;
        Wed,  2 Aug 2023 07:33:18 -0700 (PDT)
Date:   Wed, 02 Aug 2023 14:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690986796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBsgB1YLGfdl/SuhRbFuHsRmPl5vqrv9c+Xp2VGeIns=;
        b=YO9grGOi6dMO5re7MmmMEkWvlIcKpXTNPZRXY9A1EJKHFhqPGRtwgveF6hX7elLOtSLdL2
        8qMih6NwA8uJg0FlHlaAZwswAQfS5j+BkPc7JBHWZEATmA0ZYrg/+jTRRvTcNHTI46sUy0
        JJsMH8Hb3kg0hexYTt4yL0+lwl68xhXqAScVmE568OAdhlRpvKRTSI+c3mknty4JoypMk8
        vCWsAEXZLDFFgukEXfdue8rIw6aEMd4cG1SuZoskB9L+JSGLeYCbjDhjF2LeqkeIr1VST/
        cRM62+zDMTugwM61R88rKorxau6OLHGb/m2VH4k3t/8MstDhHEN7quL+cX+4yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690986796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBsgB1YLGfdl/SuhRbFuHsRmPl5vqrv9c+Xp2VGeIns=;
        b=uRe1hDAh9TJSm1ycOqyQBOKXTb8CnsvlijTKGrq30Qox39Rwa7gCXALXKPLe65B7PJ6/iL
        +and02IxgK0+6jDw==
From:   "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retpoline,kprobes: Fix position of thunk sections
 with CONFIG_LTO_CLANG
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230711091952.27944-2-petr.pavlu@suse.com>
References: <20230711091952.27944-2-petr.pavlu@suse.com>
MIME-Version: 1.0
Message-ID: <169098679602.28540.7005603884356771970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     973ab2d61f33dc85212c486e624af348c4eeb5c9
Gitweb:        https://git.kernel.org/tip/973ab2d61f33dc85212c486e624af348c4eeb5c9
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Tue, 11 Jul 2023 11:19:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:27:07 +02:00

x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG

Linker script arch/x86/kernel/vmlinux.lds.S matches the thunk sections
".text.__x86.*" from arch/x86/lib/retpoline.S as follows:

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

Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230711091952.27944-2-petr.pavlu@suse.com
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 arch/x86/lib/retpoline.S      | 4 ++--
 tools/objtool/check.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 03c885d..a4cd04c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,7 +134,7 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.*)
+		*(.text..__x86.*)
 		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3fd066d..3bea963 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -12,7 +12,7 @@
 #include <asm/percpu.h>
 #include <asm/frame.h>
 
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
 
 
 .macro POLINE reg
@@ -131,7 +131,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  */
 #ifdef CONFIG_RETHUNK
 
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05..e096eb3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -389,7 +389,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
-		    !strncmp(sec->name, ".text.__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 12))
 			sec->noinstr = true;
 
 		/*
