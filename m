Return-Path: <linux-kernel+bounces-157259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A58B0F28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E6C2964B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5D16D315;
	Wed, 24 Apr 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rv/pDXj7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A316C874
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974029; cv=none; b=V21pfgn+lQX18vlzo2W31bhXpUGNVti1c1VFBAIwCpTcAhM8ERthUVrw1VwkuK4toSMbeB8WJRs+skG8/gfx87JNKwUZKcmHis4ITgzbIxrLeuukYi/jDSK1WTWXjljJ++iIDN1efECPbIXUI2cXsrikfNSNfEy1ZbHB/rrPbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974029; c=relaxed/simple;
	bh=1+VCxIzQcdwbTGlX9e1o9EFbgAwdNaFUnQJi6aPn/k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UC0nhDMva21jIOR9+7NpWXQn3U3PVaaZoEEQ80evPOUB6PmBvJANdj+FFel1iutZo0B+0PkvFlP+egKnv5jANWC/gT1Hl5DRpEiAe3huTTS6tpqILxQejEYzrYn8GS8Pg6fj4w7BYnLEYatQB8SNjgqxQthlSm28Hlo14fsotzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rv/pDXj7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5823bd7eeso137744276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974027; x=1714578827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEfb48Zw4FzaI31A4Yvo9b2JQcLeZ9Sid/iFgPsmsBc=;
        b=Rv/pDXj7oa9+h99JFEYoIkhTwaWpzk+3tbBLCUgiN73/tt+MPr3bbo8GIRt6QnuME7
         /pS6UR8NBQ/wFkdIYR/4jHw4o87O/BjRHJEbMpHkCfJoAXhnP6UVgmEmlSomJSYJRoaM
         JwqSZtyzUEF1/TDDoHAGMsYLWiZgkknvOhHDbVOulG9eemaAiNIoCPikkQdx2CHOsqja
         mD6Ubaop7QynWzSNqAxw5+FD5CTOnQRWVNl5EK9eU6bwl0ry9yDPHKIb/0Iy00i5NF9k
         +3CbAPpSmF4L2KTv6tBaeD/tMD/wqtv6WQ9oPToh5MKvlC/afQvAxItwAI4RICY9v4iB
         +8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974027; x=1714578827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEfb48Zw4FzaI31A4Yvo9b2JQcLeZ9Sid/iFgPsmsBc=;
        b=RTluq9BwvcGGtqsr5n8lkdRsFCgBoRryj6byo2SyXnOBKLvvCZCBe5f243hfIqh9Ca
         ZTFp6LdK19uIDNkKnmI7c8j0QROaPMGzdexpclxfh/FBuSc+rVkFgsd3/a9rsTnqMKrt
         E24Y8D3yw0fjg2JGkgFN4a6mpHXCul1gQS9bYXUfrOp7YjA+Hk+8c4tdVeelynYvNWL9
         d9oDzhnnM7mZwrUXEmVtufkXgewQQBbfvbvF0bE7PJiL950A0UzKWkAwS8hqZ7ssYddh
         MCc/CraovIU7MZoFYZKWI7lXcu6bfQWie4vYiMKX7NRHFNP6+I/u3fnKfBgkXyVuaGMn
         +jnw==
X-Gm-Message-State: AOJu0Yw5VIOFhxsc+LIbpegJH71hdDo03XOLcazAO4FBBmcKAy8p3Jn3
	uB5iYfZ6b+s5cfjSM/dNactABRBl+un2vF2GvcJYlAOPxwk3iwRCasByhta7DbiYt18uv++iPdt
	yqgyAPhj84gpeIM2YTw4QRt8wcYC0FR5MO9UjbT69R7sMWpNRuG57hxJNhYQZ13aE3hx07JOTZD
	+fb8kjIMIZ9ESR9zAqXG1om3pwl+Bgkw==
X-Google-Smtp-Source: AGHT+IHbg4wJywEqzUt2+8hQS3ObQVSgRyNrAL3sr6Ik+6p7Atan3Jg90qVh+XsYqwBQa0qziPF/Vb/1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:c789:0:b0:dc6:b7c2:176e with SMTP id
 w131-20020a25c789000000b00dc6b7c2176emr4995ybe.4.1713974026968; Wed, 24 Apr
 2024 08:53:46 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:16 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5039; i=ardb@kernel.org;
 h=from:subject; bh=KbB2fMI6RaaNb9qTs1/na+POkGeoOZURr4jcCaqB+Qw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T682aCbcVWayP97etXvKAe1Jmc/WfuFq7S1nTRTJ6I
 l8KH37YUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYS3sbIMD2FX52rem5U7pXq
 ytRHu2telH5M9vvg/i9Rb8nzrNCCIIb//kdzNfTuXL6vFdr7TXl/9bSzqhs+GpQ9eRf68MvGBJ4 +fgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-17-ardb+git@google.com>
Subject: [RFC PATCH 6/9] kexec: Add support for fully linked purgatory executables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The purgatory ELF object is typically a partially linked object, which
puts the burden on the kexec loader to lay out the executable in memory,
and this involves (among other things) deciding the placement of the
sections in memory, and fixing up all relocations (relative and absolute
ones)

All of this can be greatly simplified by using a fully linked PIE ELF
executable instead, constructed in a way that removes the need for any
relocation processing or layout and allocation of individual sections.

By gathering all allocatable sections into a single PT_LOAD segment, and
relying on RIP-relative references, all relocations will be applied by
the linker, and the segment simply needs to be copied into memory.

So add a linker script and some minimal handling in generic code, which
can be used by architectures to opt into this approach. This will be
wired up for x86 in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/purgatory.lds | 34 ++++++++++
 kernel/kexec_file.c               | 68 +++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/purgatory.lds b/include/asm-generic/purgatory.lds
new file mode 100644
index 000000000000..260c457f7608
--- /dev/null
+++ b/include/asm-generic/purgatory.lds
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+PHDRS
+{
+	text PT_LOAD FLAGS(7) FILEHDR PHDRS;
+}
+
+SECTIONS
+{
+	. = SIZEOF_HEADERS;
+
+	.text : {
+		*(.text .rodata* .kexec-purgatory .data*)
+	} :text
+
+	.bss : {
+		*(.bss .dynbss)
+	} :text
+
+	.rela.dyn : {
+		*(.rela.*)
+	}
+
+	.symtab 0 : { *(.symtab) }
+	.strtab 0 : { *(.strtab) }
+	.shstrtab 0 : { *(.shstrtab) }
+
+	/DISCARD/ : {
+		*(.interp .modinfo .dynsym .dynstr .hash .gnu.* .dynamic .comment)
+		*(.got .plt .got.plt .plt.got .note.* .eh_frame .sframe)
+	}
+}
+
+ASSERT(SIZEOF(.rela.dyn) == 0, "Absolute relocations detected");
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bef2f6f2571b..6379f8dfc29f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1010,6 +1010,62 @@ static int kexec_apply_relocations(struct kimage *image)
 	return 0;
 }
 
+/*
+ * kexec_load_purgatory_pie - Load the position independent purgatory object.
+ * @pi:		Purgatory info struct.
+ * @kbuf:	Memory parameters to use.
+ *
+ * Load a purgatory PIE executable. This is a fully linked executable
+ * consisting of a single PT_LOAD segment that does not require any relocation
+ * processing.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int kexec_load_purgatory_pie(struct purgatory_info *pi,
+				    struct kexec_buf *kbuf)
+{
+	const Elf_Phdr *phdr = (void *)pi->ehdr + pi->ehdr->e_phoff;
+	int ret;
+
+	if (pi->ehdr->e_phnum != 1)
+		return -EINVAL;
+
+	kbuf->bufsz = phdr->p_filesz;
+	kbuf->memsz = phdr->p_memsz;
+	kbuf->buf_align = phdr->p_align;
+
+	kbuf->buffer = vzalloc(kbuf->bufsz);
+	if (!kbuf->buffer)
+		return -ENOMEM;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		goto out_free_kbuf;
+
+	kbuf->image->start = kbuf->mem + pi->ehdr->e_entry;
+
+	pi->sechdrs = vcalloc(pi->ehdr->e_shnum, pi->ehdr->e_shentsize);
+	if (!pi->sechdrs)
+		goto out_free_kbuf;
+
+	pi->purgatory_buf = memcpy(kbuf->buffer,
+				   (void *)pi->ehdr + phdr->p_offset,
+				   kbuf->bufsz);
+
+	memcpy(pi->sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
+	       pi->ehdr->e_shnum * pi->ehdr->e_shentsize);
+
+	for (int i = 0; i < pi->ehdr->e_shnum; i++)
+		if (pi->sechdrs[i].sh_flags & SHF_ALLOC)
+			pi->sechdrs[i].sh_addr += kbuf->mem;
+
+	return 0;
+
+out_free_kbuf:
+	vfree(kbuf->buffer);
+	return ret;
+}
+
 /*
  * kexec_load_purgatory - Load and relocate the purgatory object.
  * @image:	Image to add the purgatory to.
@@ -1031,6 +1087,9 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 
 	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 
+	if (pi->ehdr->e_type != ET_REL)
+		return kexec_load_purgatory_pie(pi, kbuf);
+
 	ret = kexec_purgatory_setup_kbuf(pi, kbuf);
 	if (ret)
 		return ret;
@@ -1087,7 +1146,8 @@ static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 
 		/* Go through symbols for a match */
 		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+			if (pi->ehdr->e_type == ET_REL &&
+			    ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
 				continue;
 
 			if (strcmp(strtab + syms[k].st_name, name) != 0)
@@ -1159,6 +1219,12 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	sym_buf = (char *)pi->purgatory_buf + sec->sh_offset + sym->st_value;
 
+	if (pi->ehdr->e_type != ET_REL) {
+		const Elf_Shdr *shdr = (void *)pi->ehdr + pi->ehdr->e_shoff;
+
+		sym_buf -= shdr[sym->st_shndx].sh_addr;
+	}
+
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
 	else
-- 
2.44.0.769.g3c40516874-goog


