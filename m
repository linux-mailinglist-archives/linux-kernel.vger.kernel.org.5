Return-Path: <linux-kernel+bounces-111821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F1887153
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29569B2283E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC5660912;
	Fri, 22 Mar 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiM1cQGD"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCF5FB86
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126383; cv=none; b=icTBFSZzpZ1NVAIuzLk1oXRQxsE9TJSSxygTMC2PdP0CXUWVnXcdyCBG/XGTkwvpQ87akuDfgJkoJEqtSmtHwppUwwdi6r9gKba6lWCtpEliWilsudAA7P44hfU/9CikRIxEHYL3WcdI4qO8Y0TJMC9z23Uwn2VZttHHg4tMOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126383; c=relaxed/simple;
	bh=OYUzYLr+7DFc0Yg8XJUmqtJvSULKfoOk7CEJH8QvPOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IighiEP//NAnYOhg1mXv4GyJfaV/iUCdkBtefNo1cuPUtUge8X9Y5WimcApYfBhm8wnhyRh8/qcEVQT1RrRBLa7jjVhv2sCkLAE7kb0dKa+UCo9hz4tQnFXayGnKLP5xSFLYS7B01J9Rb+S6DBQMwQjip7WqC3qtq5IcSXGqzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiM1cQGD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-789db18e24eso154501685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126380; x=1711731180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVeh0+wAyXSYjyC1NzNd5L1fFSfCLsOJXPOqL3R9BXM=;
        b=RiM1cQGDDFvd8fy7WvcCc2E5/c3kPShmWa+NEFP7jEq9mqE4ow/jAFg+RRG8pYrVsb
         zKrOUoPUZP8e2lFK9S4sG9rVJKZKVQwBTrvpXK1Tpd3TPRKlOmwz+IryI97r4as6G/Jw
         FSehRcOtZhp+YNdaheHbK+Y4R3jV1FeCXP3oNAjuq+vCYCBS6hdEOdFfVbS8PCY4hHGC
         DV0WKJt9JRM4StJB3e5832Qb5tjE8Z1yPwrtUc3cMKsP70fxv5JEPkcflyQ3rpDXI5iM
         stkcpqJ2nWx25csTS6KHF1OOyyYV/dwpVTs/9ky4KOOuwplvjkwrb2LdW/4bwXFnKHt1
         Uh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126380; x=1711731180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVeh0+wAyXSYjyC1NzNd5L1fFSfCLsOJXPOqL3R9BXM=;
        b=VR4sQLiZFveVPIjMNGePcoZGrsKLp8oPRcyI4TjBdRSqMvN4ASsv6ewb324N/ncJTp
         0gy2gv8g2QVvhRHWIE2rOQXVN6n5rwm9W+kpH7LHObKjtYRnAk2m5ObscgXwMLwCcA5c
         yD8JTipsmRfwtaLgLf62uFmj4dqazByPKCnmEJuI4ia8CR8ZONU6apx6gA6922MXNzaF
         FlX9/8oZ3E7AE0xkakVVvGSraIXfYQPiedHgpIa6q/2FFvJEmfcTylRLMwAM3YiTNn21
         s0eBXNDTGeGYT5rfjsuPJkWgGnTYsT3HPcmGx5mLQenRIwrAOy/YSFKLyLhektuMroIP
         KjXA==
X-Gm-Message-State: AOJu0YxUwKfU9Hmh5EIccJiNzjTzbSkTkeukMyMHEpdMu+QV75ON1361
	il9ztBlRFOzWnbKKqhB+tY7uXCi4VzZLuFm6Q5G3BnO2Ij99M89aU4CMYeY=
X-Google-Smtp-Source: AGHT+IHTSl3k0/ZKKffxZcJ/Pvsut4x1mP3K7EcGRwm++0TiWkLAR4DWO11FqlpIfkF1jSsbEAIFRQ==
X-Received: by 2002:a37:ef01:0:b0:788:41d6:14cb with SMTP id j1-20020a37ef01000000b0078841d614cbmr3908qkk.24.1711126380355;
        Fri, 22 Mar 2024 09:53:00 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:59 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 11/16] x86/boot/64: Remove inverse relocations
Date: Fri, 22 Mar 2024 12:52:28 -0400
Message-ID: <20240322165233.71698-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inverse relocations were needed to offset the effects of relocation for
RIP-relative accesses to zero-based percpu data.  Now that the percpu
section is linked normally as part of the kernel image, they are no
longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/boot/compressed/misc.c |  14 +---
 arch/x86/tools/relocs.c         | 126 +-------------------------------
 2 files changed, 2 insertions(+), 138 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..371288202268 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -235,7 +235,7 @@ static void handle_relocations(void *output, unsigned long output_len,
 
 	/*
 	 * Process relocations: 32 bit relocations first then 64 bit after.
-	 * Three sets of binary relocations are added to the end of the kernel
+	 * Two sets of binary relocations are added to the end of the kernel
 	 * before compression. Each relocation table entry is the kernel
 	 * address of the location which needs to be updated stored as a
 	 * 32-bit value which is sign extended to 64 bits.
@@ -245,8 +245,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 * kernel bits...
 	 * 0 - zero terminator for 64 bit relocations
 	 * 64 bit relocation repeated
-	 * 0 - zero terminator for inverse 32 bit relocations
-	 * 32 bit inverse relocation repeated
 	 * 0 - zero terminator for 32 bit relocations
 	 * 32 bit relocation repeated
 	 *
@@ -263,16 +261,6 @@ static void handle_relocations(void *output, unsigned long output_len,
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
index 65e6f3d6d890..e490297a486b 100644
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
@@ -773,75 +744,8 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
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
@@ -852,12 +756,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
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
@@ -867,33 +765,21 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
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
@@ -1107,7 +993,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 	/* Order the relocations for more efficient processing */
 	sort_relocs(&relocs32);
 #if ELF_BITS == 64
-	sort_relocs(&relocs32neg);
 	sort_relocs(&relocs64);
 #else
 	sort_relocs(&relocs16);
@@ -1139,13 +1024,6 @@ static void emit_relocs(int as_text, int use_real_mode)
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
@@ -1196,8 +1074,6 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
-	if (ELF_BITS == 64)
-		percpu_init();
 	if (show_absolute_syms) {
 		print_absolute_symbols();
 		return;
-- 
2.44.0


