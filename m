Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748927AAECB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjIVJwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:52:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17556192;
        Fri, 22 Sep 2023 02:51:54 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695376312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpjFuO3kpiiRuhS3uCerH9ELrQfzhc9H6B9pLwV5SGs=;
        b=2Hqy11VPsKyGPCH5XHyDoo7oM2X0pwaFlmSU4vCYL7GMZ8E52TxkhhkaRTWXTrqJlhUDoB
        4iHLOhwvirobikr+j9hcf7Py/4SkHM9Pv8q7PbewqQbQX2xY80fRXcJFfkKLsqnKy4ghzv
        Qxn7X7UTF79p75tfBqtsy5SksasgmxmPeI/bwJx+7rQbYL/v4L4wupU/QMiPdlfyy7EXCe
        ZYfm8SmAYhoBhdY30ycFeBA1CB4IjlYkXQ01kC0Zvr8wfaMlfEpyJsBduWIsqg06zcOZh7
        WHRjzoJ8kRdz/E00dZDNyIFNCOz49F9duYYo3Kbt3QfIkMg8jQFEeohjpG21uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695376312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpjFuO3kpiiRuhS3uCerH9ELrQfzhc9H6B9pLwV5SGs=;
        b=DrJyloPynzJbN7llHszpoQESUQkxcT5a5g6Qs9J4JRjGoHUpt7Ic6CWGSKRxtPxFBqf4qC
        AsEXkxZaHW1p1LCg==
From:   "tip-bot2 for Fangrui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/speculation, objtool: Use absolute
 relocations for annotations
Cc:     Fangrui Song <maskray@google.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230920001728.1439947-1-maskray@google.com>
References: <20230920001728.1439947-1-maskray@google.com>
MIME-Version: 1.0
Message-ID: <169537631186.27769.11892799557376863263.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b8ec60e1186cdcfce41e7db4c827cb107e459002
Gitweb:        https://git.kernel.org/tip/b8ec60e1186cdcfce41e7db4c827cb107e459002
Author:        Fangrui Song <maskray@google.com>
AuthorDate:    Tue, 19 Sep 2023 17:17:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 11:41:24 +02:00

x86/speculation, objtool: Use absolute relocations for annotations

.discard.retpoline_safe sections do not have the SHF_ALLOC flag.  These
sections referencing text sections' STT_SECTION symbols with PC-relative
relocations like R_386_PC32 [0] is conceptually not suitable.  Newer
LLD will report warnings for REL relocations even for relocatable links [1]:

    ld.lld: warning: vmlinux.a(drivers/i2c/busses/i2c-i801.o):(.discard.retpoline_safe+0x120): has non-ABS relocation R_386_PC32 against symbol ''

Switch to absolute relocations instead, which indicate link-time
addresses.  In a relocatable link, these addresses are also output
section offsets, used by checks in tools/objtool/check.c.  When linking
vmlinux, these .discard.* sections will be discarded, therefore it is
not a problem that R_X86_64_32 cannot represent a kernel address.

Alternatively, we could set the SHF_ALLOC flag for .discard.* sections,
but I think non-SHF_ALLOC for sections to be discarded makes more sense.

Note: if we decide to never support REL architectures (e.g. arm, i386),
we can utilize R_*_NONE relocations (.reloc ., BFD_RELOC_NONE, sym),
making .discard.* sections zero-sized.  That said, the section content
waste is 4 bytes per entry, much smaller than sizeof(Elf{32,64}_Rel).

  [0] commit 1c0c1faf5692 ("objtool: Use relative pointers for annotations")
  [1] https://github.com/ClangBuiltLinux/linux/issues/1937

Signed-off-by: Fangrui Song <maskray@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20230920001728.1439947-1-maskray@google.com
---
 arch/x86/include/asm/alternative.h   |  4 ++--
 arch/x86/include/asm/nospec-branch.h |  4 ++--
 include/linux/objtool.h              | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 9c4da69..65f7909 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -58,7 +58,7 @@
 #define ANNOTATE_IGNORE_ALTERNATIVE				\
 	"999:\n\t"						\
 	".pushsection .discard.ignore_alts\n\t"			\
-	".long 999b - .\n\t"					\
+	".long 999b\n\t"					\
 	".popsection\n\t"
 
 /*
@@ -352,7 +352,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 .macro ANNOTATE_IGNORE_ALTERNATIVE
 	.Lannotate_\@:
 	.pushsection .discard.ignore_alts
-	.long .Lannotate_\@ - .
+	.long .Lannotate_\@
 	.popsection
 .endm
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c55cc24..4952b73 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -196,7 +196,7 @@
 .macro ANNOTATE_RETPOLINE_SAFE
 .Lhere_\@:
 	.pushsection .discard.retpoline_safe
-	.long .Lhere_\@ - .
+	.long .Lhere_\@
 	.popsection
 .endm
 
@@ -334,7 +334,7 @@
 #define ANNOTATE_RETPOLINE_SAFE					\
 	"999:\n\t"						\
 	".pushsection .discard.retpoline_safe\n\t"		\
-	".long 999b - .\n\t"					\
+	".long 999b\n\t"					\
 	".popsection\n\t"
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 03f82c2..6f6da95 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -48,13 +48,13 @@
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
-	".long 986b - .\n\t"					\
+	".long 986b\n\t"					\
 	".popsection\n\t"
 
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
-	".long 998b - .\n\t"						\
+	".long 998b\n\t"						\
 	".popsection\n\t"
 
 #else /* __ASSEMBLY__ */
@@ -66,7 +66,7 @@
 #define ANNOTATE_INTRA_FUNCTION_CALL				\
 	999:							\
 	.pushsection .discard.intra_function_calls;		\
-	.long 999b - .;						\
+	.long 999b;						\
 	.popsection;
 
 /*
@@ -118,7 +118,7 @@
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr
-	.long	.Lhere_\@ - .
+	.long	.Lhere_\@
 	.popsection
 .endm
 
@@ -141,7 +141,7 @@
 .macro REACHABLE
 .Lhere_\@:
 	.pushsection .discard.reachable
-	.long	.Lhere_\@ - .
+	.long	.Lhere_\@
 	.popsection
 .endm
 
