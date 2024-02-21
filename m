Return-Path: <linux-kernel+bounces-75460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07F85E902
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F871F24124
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7686AF1;
	Wed, 21 Feb 2024 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWvv+Ne6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83985C6A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547230; cv=none; b=pmCFlwMjo2Myx77FqQytXx0JT0kva6Dp0H0MyiLy+PyDsNXsSf6YmhZPBzfWaq7S1J/+Q0QhVk4D8plBxmkcEQi19yx8N4Jf/UEIMX62OnVFWyuDSL7myZiUiRG5Mkw9raapU91Jn8XtBjvDVgO+Hk5utYBu8w7cc8D2beFnxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547230; c=relaxed/simple;
	bh=ezld0i8kpFcENtir9eJVLeUvod6ZBR837TtflfyVCGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN43Do+tgNqAn59pQ8aGjykLw095/dFlEEus5PogR2XkDJZr6bSjZxMe8JCT2s0YkGe0Sdf15x5srcjonNEdY0U2RXm6yM8galZM1HBKG1VmlWP/Uh7oCY6bQLY7qQMkbLz9X72t/L1YijhuSIH+kIyBzxNn9eeqYVsgL2Q6tjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWvv+Ne6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso60a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547226; x=1709152026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je+wI6CEMdLT1s3zWGtUtN9P5ncA8Ay23Vgh9ImMsn0=;
        b=MWvv+Ne6tBDyAnCCQF4lDlyyYx8ehW4aJFUudCQypFc6VVNTBbKSpOmvp3gZk+BNoa
         7axWFqrX9HqbMTeg3E2SOOYdSniI44aYKTcnzZ0sAoVTcJw10aov4UFuKPD4clg30JOw
         vr7A98feTKQf/IjnyjPfx/NtQqea9DdLWD6TqCGg/5XWjwWsCRbtpIC9g9ZrNSLNZIJ0
         joLK373h1Wwo2OdetUIcSiL4vkCgyJ4vZqJTEtHdsorwrQMLZFPN8xmvEylCFQwr/KTx
         LjC7l1iXCNbEiO4kAnByTB2hvgMc4DOo4GWqHgABHMUHXyFGyGtcPFYG2aVrt20Dl3Ux
         RDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547226; x=1709152026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je+wI6CEMdLT1s3zWGtUtN9P5ncA8Ay23Vgh9ImMsn0=;
        b=P9yu+1WnLeqflg0BSBI4MJwNU3yfIHJrGd6i4WRxMwQgppGqFFvX76p2S2Qa4lap/W
         YTVa6V8oRuOkoiNGIlpY5C6Z0BlaizWkHoZLsfrw54AieRDb9eshoW0NDk3+k5SFRafT
         0Rzpu9ffGYLN1/1K9IAWzgTm0gfAWbRUMAxg4jfkoM2Xnml6wk9/y75/mi8uhcKpk4xm
         VpZ2w2rA4Nwvbvi4MFURKfAEjTsB4A0SUAp7VkNilXMOd7wZ64vNdf+eJTwlXRa7AdXl
         4AFv3TWYsA7wjbTgRCIrxj66kgfj3GEbbtTdh7p/+5GfBh5FWyRXExTYer0N0biGuxQQ
         pW+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8Rx4me/l8nVCs2AzTUPCJg1tHIFSYUwFfAMNkJ6xH9uNkqGCrBrerzwCBLywjVop6IIMTk82I3eG8NWeue5tdVUYGyAK7Smw9Fi3l
X-Gm-Message-State: AOJu0YyCyQlk3S9vAq1RhmXb41dReNf4JTxgZFxon0fnUnoCIm/sl9Iq
	H9D/1IbEHu+ceIImkwRDBoi5NILN9+gIelu4UBtCfKj6auvwghvnnLfhbKOUFOg5nXMMlSVBons
	jtQ==
X-Google-Smtp-Source: AGHT+IHPo+UjbZ6iRRYGUzoRkaVryRPKM6qpRZiFYVszmiOWnQ91YZlbOwR3BiUjPsw/CFhk3seTDA==
X-Received: by 2002:a50:9b11:0:b0:563:ff57:b7e8 with SMTP id o17-20020a509b11000000b00563ff57b7e8mr221240edi.1.1708547226115;
        Wed, 21 Feb 2024 12:27:06 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:2c31:2431:3037:f162])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056000078700b0033d5aee2ff1sm9575712wrb.97.2024.02.21.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:27:05 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH 2/2] kallsyms: build faster by using .incbin
Date: Wed, 21 Feb 2024 21:26:54 +0100
Message-ID: <20240221202655.2423854-2-jannh@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240221202655.2423854-1-jannh@google.com>
References: <20240221202655.2423854-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kallsyms builds a big assembly file (~19M with a normal
kernel config), and then the assembler has to turn that big assembly
file back into binary data, which takes around a second per kallsyms
invocation. (Normally there are two kallsyms invocations per build.)

It is much faster to instead directly output binary data, which can
be imported in an assembly file using ".incbin". This is also the
approach taken by arch/x86/boot/compressed/mkpiggy.c.
So this patch switches kallsyms to that approach.

A complication with this is that the endianness of numbers between
host and target might not match (for example, when cross-compiling);
and there seems to be no kconfig symbol that tells us what endianness
the target has.
So pass the path to the intermediate vmlinux ELF file to the kallsyms
tool, and let it parse the ELF header to figure out the target's
endianness.

I have verified that running kallsyms without these changes and
kallsyms with these changes on the same input System.map results
in identical object files.

This change reduces the time for an incremental kernel rebuild
(touch fs/ioctl.c, then re-run make) from 27.7s to 24.1s (medians
over 16 runs each) on my machine - saving around 3.6 seconds.

Signed-off-by: Jann Horn <jannh@google.com>
---
 scripts/kallsyms.c      | 196 ++++++++++++++++++++++++++++++++--------
 scripts/link-vmlinux.sh |   5 +-
 2 files changed, 159 insertions(+), 42 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f35be95adfbe..ef03d723aded 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,6 +27,10 @@
 #include <string.h>
 #include <ctype.h>
 #include <limits.h>
+#include <endian.h>
+#include <elf.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
@@ -75,7 +79,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
-			"[--lto-clang] in.map > out.S\n");
+			"[--lto-clang] in in.map out.S out.bin\n");
 	exit(1);
 }
 
@@ -290,20 +294,57 @@ static void read_map(const char *in)
 	fclose(fp);
 }
 
+static bool is_64bit, is_little_endian;
+static char *asm_path, *bin_path;
+static FILE *asm_file, *bin_file;
+static size_t bin_offset, bin_included;
+
 static void output_label(const char *label)
 {
-	printf(".globl %s\n", label);
-	printf("\tALGN\n");
-	printf("%s:\n", label);
+	fprintf(asm_file, ".globl %s\n", label);
+	fprintf(asm_file, "\tALGN\n");
+	fprintf(asm_file, "%s:\n", label);
 }
 
 /* Provide proper symbols relocatability by their '_text' relativeness. */
 static void output_address(unsigned long long addr)
 {
 	if (_text <= addr)
-		printf("\tPTR\t_text + %#llx\n", addr - _text);
+		fprintf(asm_file, "\tPTR\t_text + %#llx\n", addr - _text);
 	else
-		printf("\tPTR\t_text - %#llx\n", _text - addr);
+		fprintf(asm_file, "\tPTR\t_text - %#llx\n", _text - addr);
+}
+
+/*
+ * Include all data that has been written into bin_file since the last call to
+ * this function.
+ */
+static void include_bin_data(void)
+{
+	fprintf(asm_file, ".incbin \"%s\", %zu, %zu\n", bin_path,
+		bin_included, bin_offset - bin_included);
+	bin_included = bin_offset;
+}
+
+static void output_bin_data(const void *data, size_t len)
+{
+	if (fwrite(data, 1, len, bin_file) != len) {
+		fprintf(stderr, "kallsyms: unable to write output\n");
+		exit(EXIT_FAILURE);
+	}
+	bin_offset += len;
+}
+static void output_bin_u32(uint32_t value)
+{
+	uint32_t encoded = is_little_endian ? htole32(value) : htobe32(value);
+
+	output_bin_data(&encoded, sizeof(encoded));
+}
+static void output_bin_u16(uint16_t value)
+{
+	uint16_t encoded = is_little_endian ? htole16(value) : htobe16(value);
+
+	output_bin_data(&encoded, sizeof(encoded));
 }
 
 /* uncompress a compressed symbol. When this function is called, the best table
@@ -384,25 +425,36 @@ static void sort_symbols_by_name(void)
 
 static void write_src(void)
 {
-	unsigned int i, k, off;
+	unsigned int i, off;
 	unsigned int best_idx[256];
 	unsigned int *markers;
 	char buf[KSYM_NAME_LEN];
 
-	printf("#include <asm/bitsperlong.h>\n");
-	printf("#if BITS_PER_LONG == 64\n");
-	printf("#define PTR .quad\n");
-	printf("#define ALGN .balign 8\n");
-	printf("#else\n");
-	printf("#define PTR .long\n");
-	printf("#define ALGN .balign 4\n");
-	printf("#endif\n");
+	asm_file = fopen(asm_path, "w");
+	if (!asm_file) {
+		perror("unable to open asm output");
+		exit(EXIT_FAILURE);
+	}
+	bin_file = fopen(bin_path, "w");
+	if (!bin_file) {
+		perror("unable to open bin output");
+		exit(EXIT_FAILURE);
+	}
+
+	fprintf(asm_file, "#include <asm/bitsperlong.h>\n");
+	fprintf(asm_file, "#if BITS_PER_LONG == 64\n");
+	fprintf(asm_file, "#define PTR .quad\n");
+	fprintf(asm_file, "#define ALGN .balign 8\n");
+	fprintf(asm_file, "#else\n");
+	fprintf(asm_file, "#define PTR .long\n");
+	fprintf(asm_file, "#define ALGN .balign 4\n");
+	fprintf(asm_file, "#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	fprintf(asm_file, "\t.section .rodata, \"a\"\n");
 
 	output_label("kallsyms_num_syms");
-	printf("\t.long\t%u\n", table_cnt);
-	printf("\n");
+	fprintf(asm_file, "\t.long\t%u\n", table_cnt);
+	fprintf(asm_file, "\n");
 
 	/* table of offset markers, that give the offset in the compressed stream
 	 * every 256 symbols */
@@ -437,20 +489,23 @@ static void write_src(void)
 		/* Encode length with ULEB128. */
 		if (table[i]->len <= 0x7F) {
 			/* Most symbols use a single byte for the length. */
-			printf("\t.byte 0x%02x", table[i]->len);
+			unsigned char len_encoded[1] = { table[i]->len };
+
+			output_bin_data(len_encoded, sizeof(len_encoded));
 			off += table[i]->len + 1;
 		} else {
 			/* "Big" symbols use two bytes. */
-			printf("\t.byte 0x%02x, 0x%02x",
+			unsigned char len_encoded[2] = {
 				(table[i]->len & 0x7F) | 0x80,
-				(table[i]->len >> 7) & 0x7F);
+				(table[i]->len >> 7) & 0x7F
+			};
+
+			output_bin_data(len_encoded, sizeof(len_encoded));
 			off += table[i]->len + 2;
 		}
-		for (k = 0; k < table[i]->len; k++)
-			printf(", 0x%02x", table[i]->sym[k]);
-		printf("\n");
+		output_bin_data(table[i]->sym, table[i]->len);
 	}
-	printf("\n");
+	include_bin_data();
 
 	/*
 	 * Now that we wrote out the compressed symbol names, restore the
@@ -463,8 +518,8 @@ static void write_src(void)
 
 	output_label("kallsyms_markers");
 	for (i = 0; i < ((table_cnt + 255) >> 8); i++)
-		printf("\t.long\t%u\n", markers[i]);
-	printf("\n");
+		output_bin_u32(markers[i]);
+	include_bin_data();
 
 	free(markers);
 
@@ -473,15 +528,15 @@ static void write_src(void)
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
 		expand_symbol(best_table[i], best_table_len[i], buf);
-		printf("\t.asciz\t\"%s\"\n", buf);
+		output_bin_data(buf, strlen(buf)+1);
 		off += strlen(buf) + 1;
 	}
-	printf("\n");
+	include_bin_data();
 
 	output_label("kallsyms_token_index");
 	for (i = 0; i < 256; i++)
-		printf("\t.short\t%d\n", best_idx[i]);
-	printf("\n");
+		output_bin_u16(best_idx[i]);
+	include_bin_data();
 
 	output_label("kallsyms_offsets");
 
@@ -513,13 +568,12 @@ static void write_src(void)
 				table[i]->addr);
 			exit(EXIT_FAILURE);
 		}
-		printf("\t.long\t%#x	/* %s */\n", (int)offset, table[i]->sym);
+		output_bin_u32((uint32_t)offset);
 	}
-	printf("\n");
+	include_bin_data();
 
 	output_label("kallsyms_relative_base");
 	output_address(relative_base);
-	printf("\n");
 
 	if (lto_clang)
 		for (i = 0; i < table_cnt; i++)
@@ -527,12 +581,24 @@ static void write_src(void)
 
 	sort_symbols_by_name();
 	output_label("kallsyms_seqs_of_names");
-	for (i = 0; i < table_cnt; i++)
-		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\n",
+	for (i = 0; i < table_cnt; i++) {
+		unsigned char seq_encoded[3] = {
 			(unsigned char)(table[i]->seq >> 16),
 			(unsigned char)(table[i]->seq >> 8),
-			(unsigned char)(table[i]->seq >> 0));
-	printf("\n");
+			(unsigned char)(table[i]->seq >> 0)
+		};
+		output_bin_data(seq_encoded, sizeof(seq_encoded));
+	}
+	include_bin_data();
+
+	if (fclose(asm_file)) {
+		perror("unable to write to asm output");
+		exit(EXIT_FAILURE);
+	}
+	if (fclose(bin_file)) {
+		perror("unable to write to bin output");
+		exit(EXIT_FAILURE);
+	}
 }
 
 
@@ -795,6 +861,52 @@ static void record_relative_base(void)
 		}
 }
 
+static void get_target_data_types(const char *elf_path)
+{
+	int elf_fd = open(elf_path, O_RDONLY);
+	unsigned char elf_ident[EI_NIDENT];
+
+	if (elf_fd == -1) {
+		perror("open ELF");
+		exit(EXIT_FAILURE);
+	}
+	if (read(elf_fd, elf_ident, sizeof(elf_ident)) != sizeof(elf_ident)) {
+		perror("read ELF header");
+		exit(EXIT_FAILURE);
+	}
+	close(elf_fd);
+
+	if (elf_ident[EI_MAG0] != ELFMAG0 || elf_ident[EI_MAG1] != ELFMAG1 ||
+	    elf_ident[EI_MAG2] != ELFMAG2 || elf_ident[EI_MAG3] != ELFMAG3) {
+		fprintf(stderr, "kallsyms: input ELF has invalid header\n");
+		exit(EXIT_FAILURE);
+	}
+
+	switch (elf_ident[EI_CLASS]) {
+	case ELFCLASS32:
+		is_64bit = false;
+		break;
+	case ELFCLASS64:
+		is_64bit = true;
+		break;
+	default:
+		fprintf(stderr, "kallsyms: input ELF has invalid bitness\n");
+		exit(EXIT_FAILURE);
+	}
+
+	switch (elf_ident[EI_DATA]) {
+	case ELFDATA2LSB:
+		is_little_endian = true;
+		break;
+	case ELFDATA2MSB:
+		is_little_endian = false;
+		break;
+	default:
+		fprintf(stderr, "kallsyms: input ELF has invalid endianness\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	while (1) {
@@ -813,10 +925,14 @@ int main(int argc, char **argv)
 			usage();
 	}
 
-	if (optind >= argc)
+	if (optind+4 != argc)
 		usage();
+	asm_path = argv[optind+2];
+	bin_path = argv[optind+3];
+
+	get_target_data_types(argv[optind]);
 
-	read_map(argv[optind]);
+	read_map(argv[optind+1]);
 	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5127371d3393..1b5ff33a2d4a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -162,7 +162,7 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	scripts/kallsyms ${kallsymopt} ${1} > ${2}
+	scripts/kallsyms ${kallsymopt} ${1} ${2} ${3} ${4}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
@@ -173,10 +173,11 @@ kallsyms_step()
 	kallsyms_vmlinux=.tmp_vmlinux.kallsyms${1}
 	kallsymso=${kallsyms_vmlinux}.o
 	kallsyms_S=${kallsyms_vmlinux}.S
+	kallsyms_bin=${kallsyms_vmlinux}.bin
 
 	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
 	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms ${kallsymso_prev}
-	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
+	kallsyms ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms ${kallsyms_S} ${kallsyms_bin}
 
 	info AS ${kallsyms_S}
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
-- 
2.44.0.rc0.258.g7320e95886-goog


