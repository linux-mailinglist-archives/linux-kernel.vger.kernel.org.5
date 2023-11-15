Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C857EC9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjKORiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjKORiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:38:08 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6951715
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:42 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5842a7fdc61so3583604eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069860; x=1700674660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM3WKUS19C6H61LiRqPZba/3FsTYnCRGf0Iggb95Tzk=;
        b=fQTn0A876g5qiGlEZDA797uktb1Gb5FR85rdkwvEQQWTBlllKrJ/e7kVKqBWPExrOP
         gUoYji5u5ZWQJ/EKtwo4YJbM+PpGBsLz6MlhMuEm86VGPYbzNavtGkF9vzwIVdOqRcko
         l1088g8no2/Ik/xohGrVK4Ma6seOvzsdeGnbK8PeuWUSRq6Eiq+2/mPJqWbqnsgBoQwf
         fqQUVIUUbrf9uNfBYWhOxAbnwGhaMvkrNzBbVuMfpvDgO9ZL5FAub+SumBz5Oa7zKGtp
         51NQs4JswdvmOeGWRzhnN4n2hkGdP68z+UuNj7DIC/QEMFO5w7nYbMUSnZt39cmc6yIx
         xtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069860; x=1700674660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM3WKUS19C6H61LiRqPZba/3FsTYnCRGf0Iggb95Tzk=;
        b=cc7xDpFX1F+8b6WandOaUT+CDxv3gW7Be9izLuXwa9LfhYiTS4AfxzcrYF55otbuAv
         Xlun4TCRgIHvFIbhKqKlr3Qyys4fbXhYlo60ksWVXVKYKQV5SRNAEs+z8ge6nkV/sHTJ
         jix0/lc3eRs3l4yI7yXrvcH6Uu3w6fwtCNa22e7jj1hfheoBUgZ9Hs1QP2eTBaRA1fmk
         5EX7r6XZo/qJawtejxGdZGmotz8I8TnPnnfN4aA1fR3RYvYaofekCiZlEBfrIO4kUGzf
         yj2qKqviWsS6dl9fXGDLpEhUzsSo12EkPdJevnD/kY1hrZ2avjeohHM2AKDfYrrqwmYY
         0VNQ==
X-Gm-Message-State: AOJu0YxfnR5AhlWXDjiP0/ErA04tjQ0oeu+CwqfUawjc8VglVofTdK49
        2MVo1Jzu9YG7XKVBlK45EncSY2KoEA==
X-Google-Smtp-Source: AGHT+IGDNerEzTHNzojJnC39t/wRd3hyjOhnAWFGMiSSfdd2wqsdNGdI+oILO+Kbi48J4gu2+A8rzw==
X-Received: by 2002:a05:6359:1581:b0:16b:fd1c:fdba with SMTP id jv1-20020a056359158100b0016bfd1cfdbamr5343991rwb.27.1700069860075;
        Wed, 15 Nov 2023 09:37:40 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:39 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 11/14] x86/boot/64: Remove inverse relocations
Date:   Wed, 15 Nov 2023 12:37:05 -0500
Message-ID: <20231115173708.108316-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the percpu section is not at a fixed virtual address, inverse
relocations, which were needed to offset the effects of relocation on
RIP-relative percpu references, are no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/boot/compressed/misc.c |  14 +---
 arch/x86/tools/relocs.c         | 126 +-------------------------------
 2 files changed, 2 insertions(+), 138 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..2de345a236c0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -221,7 +221,7 @@ static void handle_relocations(void *output, unsigned long output_len,
 
 	/*
 	 * Process relocations: 32 bit relocations first then 64 bit after.
-	 * Three sets of binary relocations are added to the end of the kernel
+	 * Two sets of binary relocations are added to the end of the kernel
 	 * before compression. Each relocation table entry is the kernel
 	 * address of the location which needs to be updated stored as a
 	 * 32-bit value which is sign extended to 64 bits.
@@ -231,8 +231,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 * kernel bits...
 	 * 0 - zero terminator for 64 bit relocations
 	 * 64 bit relocation repeated
-	 * 0 - zero terminator for inverse 32 bit relocations
-	 * 32 bit inverse relocation repeated
 	 * 0 - zero terminator for 32 bit relocations
 	 * 32 bit relocation repeated
 	 *
@@ -249,16 +247,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 		*(uint32_t *)ptr += delta;
 	}
 #ifdef CONFIG_X86_64
-	while (*--reloc) {
-		long extended = *reloc;
-		extended += map;
-
-		ptr = (unsigned long)extended;
-		if (ptr < min_addr || ptr > max_addr)
-			error("inverse 32-bit relocation outside of kernel!\n");
-
-		*(int32_t *)ptr -= delta;
-	}
 	for (reloc--; *reloc; reloc--) {
 		long extended = *reloc;
 		extended += map;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3b0cfddd8b27..ae9bbf634826 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -28,7 +28,6 @@ struct relocs {
 static struct relocs relocs16;
 static struct relocs relocs32;
 #if ELF_BITS == 64
-static struct relocs relocs32neg;
 static struct relocs relocs64;
 #define FMT PRIu64
 
@@ -89,7 +88,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"__per_cpu_load|"
 	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
@@ -287,33 +285,6 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 	return name;
 }
 
-static Elf_Sym *sym_lookup(const char *symname)
-{
-	int i;
-	for (i = 0; i < shnum; i++) {
-		struct section *sec = &secs[i];
-		long nsyms;
-		char *strtab;
-		Elf_Sym *symtab;
-		Elf_Sym *sym;
-
-		if (sec->shdr.sh_type != SHT_SYMTAB)
-			continue;
-
-		nsyms = sec->shdr.sh_size/sizeof(Elf_Sym);
-		symtab = sec->symtab;
-		strtab = sec->link->strtab;
-
-		for (sym = symtab; --nsyms >= 0; sym++) {
-			if (!sym->st_name)
-				continue;
-			if (strcmp(symname, strtab + sym->st_name) == 0)
-				return sym;
-		}
-	}
-	return 0;
-}
-
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
@@ -756,75 +727,8 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 	}
 }
 
-/*
- * The .data..percpu section is a special case for x86_64 SMP kernels.
- * It is used to initialize the actual per_cpu areas and to provide
- * definitions for the per_cpu variables that correspond to their offsets
- * within the percpu area. Since the values of all of the symbols need
- * to be offsets from the start of the per_cpu area the virtual address
- * (sh_addr) of .data..percpu is 0 in SMP kernels.
- *
- * This means that:
- *
- *	Relocations that reference symbols in the per_cpu area do not
- *	need further relocation (since the value is an offset relative
- *	to the start of the per_cpu area that does not change).
- *
- *	Relocations that apply to the per_cpu area need to have their
- *	offset adjusted by by the value of __per_cpu_load to make them
- *	point to the correct place in the loaded image (because the
- *	virtual address of .data..percpu is 0).
- *
- * For non SMP kernels .data..percpu is linked as part of the normal
- * kernel data and does not require special treatment.
- *
- */
-static int per_cpu_shndx	= -1;
-static Elf_Addr per_cpu_load_addr;
-
-static void percpu_init(void)
-{
-	int i;
-	for (i = 0; i < shnum; i++) {
-		ElfW(Sym) *sym;
-		if (strcmp(sec_name(i), ".data..percpu"))
-			continue;
-
-		if (secs[i].shdr.sh_addr != 0)	/* non SMP kernel */
-			return;
-
-		sym = sym_lookup("__per_cpu_load");
-		if (!sym)
-			die("can't find __per_cpu_load\n");
-
-		per_cpu_shndx = i;
-		per_cpu_load_addr = sym->st_value;
-		return;
-	}
-}
-
 #if ELF_BITS == 64
 
-/*
- * Check to see if a symbol lies in the .data..percpu section.
- *
- * The linker incorrectly associates some symbols with the
- * .data..percpu section so we also need to check the symbol
- * name to make sure that we classify the symbol correctly.
- *
- * The GNU linker incorrectly associates:
- *	__init_begin
- *	__per_cpu_load
- *
- * The "gold" linker incorrectly associates:
- *	init_per_cpu__gdt_page
- */
-static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-{
-	return 0;
-}
-
-
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
@@ -835,12 +739,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
-	/*
-	 * Adjust the offset if this reloc applies to the percpu section.
-	 */
-	if (sec->shdr.sh_info == per_cpu_shndx)
-		offset += per_cpu_load_addr;
-
 	switch (r_type) {
 	case R_X86_64_NONE:
 		/* NONE can be ignored. */
@@ -850,33 +748,21 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_PLT32:
 	case R_X86_64_REX_GOTPCRELX:
 		/*
-		 * PC relative relocations don't need to be adjusted unless
-		 * referencing a percpu symbol.
+		 * PC relative relocations don't need to be adjusted.
 		 *
 		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
 		 */
-		if (is_percpu_sym(sym, symname))
-			add_reloc(&relocs32neg, offset);
 		break;
 
 	case R_X86_64_PC64:
 		/*
 		 * Only used by jump labels
 		 */
-		if (is_percpu_sym(sym, symname))
-			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
-			    symname);
 		break;
 
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-		/*
-		 * References to the percpu area don't need to be adjusted.
-		 */
-		if (is_percpu_sym(sym, symname))
-			break;
-
 		if (shn_abs) {
 			/*
 			 * Whitelisted absolute symbols do not require
@@ -1090,7 +976,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 	/* Order the relocations for more efficient processing */
 	sort_relocs(&relocs32);
 #if ELF_BITS == 64
-	sort_relocs(&relocs32neg);
 	sort_relocs(&relocs64);
 #else
 	sort_relocs(&relocs16);
@@ -1122,13 +1007,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 		/* Now print each relocation */
 		for (i = 0; i < relocs64.count; i++)
 			write_reloc(relocs64.offset[i], stdout);
-
-		/* Print a stop */
-		write_reloc(0, stdout);
-
-		/* Now print each inverse 32-bit relocation */
-		for (i = 0; i < relocs32neg.count; i++)
-			write_reloc(relocs32neg.offset[i], stdout);
 #endif
 
 		/* Print a stop */
@@ -1179,8 +1057,6 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
-	if (ELF_BITS == 64)
-		percpu_init();
 	if (show_absolute_syms) {
 		print_absolute_symbols();
 		return;
-- 
2.41.0

