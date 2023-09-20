Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777437A6FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjITARj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITARi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:17:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25CEAB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:17:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b6a51f360so70967917b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695169052; x=1695773852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tT8RTtiIvMH0jr3h5GfFxiVuJzDdiA1NvVC8sxpn06Q=;
        b=NnS8rvEjStTsox1SybNVAn5om+cHQtX9dZb8cenUc5AFD5/QjRWATh/3NWcDv3nMY6
         9I/sGmwyTHp0VKD9+td4FJvO9W/ua6gOYfrAGx0EHfRuPSk5AB1yBcRuWDJJA86h3iUB
         DbbXGZivz0gb4mddw2TPNRzwOccLZdgPcRFlOoe5ZOWezoyjcDykoFkhnH3VhoDQ7usY
         S6wr48nwPcp854QNbMo++nAjONinYDSw/KigvEn52nU9fotX0vGB1NVH0tW0mlOY43rD
         FZyacfOw3VhzwRqfh0Hju3HLDJms54bnvJUKTFNpiKQ9R+kkzCRS4qpGZ77Vsemqmr5u
         SA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695169052; x=1695773852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT8RTtiIvMH0jr3h5GfFxiVuJzDdiA1NvVC8sxpn06Q=;
        b=TBf48LvSvU7L1X5xnKhEb2JwlsHCTr1hDO6GeB4gtC1QLDNOiGCnOEdCnpL/amLZxM
         rbhg8qOmOF1khyxKQQTn3zsPHh8J0iPy5fXVHgbzcyfXbC6eCNIw/IlASkAivhroBBqI
         k6pwTXyXLduQieaKeHhEBnYJGnw6qANDJb12PMB/PAr2654WO54tUFAlpIOrNc0lXE1G
         bVhpDfEBmbzFsPQJblrGoSNgNqfIOhfXqffxK4mfja/31EQrvq9JiRU86Hat3knYQlnn
         f36n93m3fs8Gw2hrwCCJ/OnTEBwhW05YcFyU5534rD9C9dj8gvYXbQNpjpOmsPkWtUp8
         9GNQ==
X-Gm-Message-State: AOJu0YzHRR1biMMBLDMPMaf6REMwDAiT89QY70rejMXSGw2wCrARpMTR
        ti3ojoN4TPJCdTyHBXq/ja/RQqtwGLsk
X-Google-Smtp-Source: AGHT+IHXYkvHxsnm+XtyucMHmTP6WHJAmizuj0WQQpgTjADkwA/bJi/QLtEi5t/MKjFM1E/F7Det8is3uPc/
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:57db:b73a:fd87:4f18])
 (user=maskray job=sendgmr) by 2002:a81:b1c8:0:b0:58c:7cb1:10f with SMTP id
 p191-20020a81b1c8000000b0058c7cb1010fmr15525ywh.9.1695169051817; Tue, 19 Sep
 2023 17:17:31 -0700 (PDT)
Date:   Tue, 19 Sep 2023 17:17:28 -0700
Mime-Version: 1.0
Message-ID: <20230920001728.1439947-1-maskray@google.com>
Subject: [PATCH] x86/speculation, objtool: Use absolute relocations for annotations
From:   Fangrui Song <maskray@google.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.discard.retpoline_safe sections do not have the SHF_ALLOC flag.  These
sections referencing text sections' STT_SECTION symbols with PC-relative
relocations like R_386_PC32 [0] is conceptually not suitable.  Newer
LLD will report warnings for REL relocations even for relocatable links
[1].

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

Link: https://github.com/ClangBuiltLinux/linux/issues/1937 [1]
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/x86/include/asm/alternative.h   |  4 ++--
 arch/x86/include/asm/nospec-branch.h |  4 ++--
 include/linux/objtool.h              | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 9c4da699e11a..65f79092c9d9 100644
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
index c55cc243592e..4952b73d944e 100644
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
index 03f82c2c2ebf..6f6da95fe7f9 100644
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
 
-- 
2.42.0.459.ge4e396fd5e-goog

