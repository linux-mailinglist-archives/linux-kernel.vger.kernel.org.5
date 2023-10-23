Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3327D4197
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjJWVSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjJWVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:55 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09A10EA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so2383979a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095866; x=1698700666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEKMOhNXhzYoW+58HZlorWdy0xM6bOeFhfp+J2ei5Pk=;
        b=f5v1bg2wTB/Kn6LwJpHzy/NrUL+Zta4De4mKhdOcbbckcb+8lm8bU2dzR8P6+D0mnO
         xfv9hqzglgRqyMOb0aOyUvdJtAJNXDLeib8zwC7uz3090sYsikxgFjXBWHeeigKVlglU
         q7Cp1oSC7Y7zx/1/mt5yr9r2IK7f+CbNR2g2a/dRdj8FkfxFeeVY021KbGrVO8usZEJP
         EqYklfSQs+Rt0VuXSUVUmMKUQiZwnFf21N+X7d57KazYF9w5WRx+AT7VEG4uq5VpJoJK
         3aNXpt+L2VBzzFK9VkHqVLQupIV9MBgpLjj26o19vHFZqjFOdg6aqX63P5CRs8NM4Ukz
         y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095866; x=1698700666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEKMOhNXhzYoW+58HZlorWdy0xM6bOeFhfp+J2ei5Pk=;
        b=kZx+YPOgQMqkk9qYKCcnqz/cSbfxAE9qacDr/jPXKCv4zI9Cgd8zK/1Ye9wKHOoANF
         yaJWYNGWPH3G16pa8GrXCiSx6stecJhdcjGmmJYULDswSZsq5qC/zb4LwyOmlPOVqwyf
         r54z5ZMJf771qaKUnw0mfJxsQ9cCqS/z9H2DaiYQql0jqGHihcENNJjO/kWqIaKZNLcc
         sBgXcpI+76RTtseSK5NnlAlPEEel2qwMr9KEA29afsdZJj+DjT42mRIn1KLRAfuAxtx4
         hYZY0Yfg2G4DTAMc/BOqPqmVTBd7PaEDqXBtjVWeOSYrDU9vS7Bx9Usrtpxrz4lpsaFI
         i5kA==
X-Gm-Message-State: AOJu0YxnbCZBco6XN6vhtQQGM6uW0NUaasa5+NF/tOdAiha1hdYTIAqP
        GVheL22JTf29JSycvF9kAT8box9vQQ==
X-Google-Smtp-Source: AGHT+IGbZgFn3oiMlJ+4djD0f2J76lDoep5A66IXsy9vVb7Txw+ed20YED5ds2J0AtCucndhMVvhKg==
X-Received: by 2002:a05:6830:2055:b0:6b9:8357:61e6 with SMTP id f21-20020a056830205500b006b9835761e6mr10532584otp.35.1698095866666;
        Mon, 23 Oct 2023 14:17:46 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:46 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 9/9] kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
Date:   Mon, 23 Oct 2023 17:17:30 -0400
Message-ID: <20231023211730.40566-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023211730.40566-1-brgerst@gmail.com>
References: <20231023211730.40566-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 init/Kconfig            | 11 +-----
 kernel/kallsyms.c       | 12 ++-----
 scripts/kallsyms.c      | 80 ++++++++---------------------------------
 scripts/link-vmlinux.sh |  4 ---
 4 files changed, 18 insertions(+), 89 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1af31b23e376..4d91c5632aaf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1715,11 +1715,6 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols, or kernel live patching.
 
-config KALLSYMS_ABSOLUTE_PERCPU
-	bool
-	depends on KALLSYMS
-	default n
-
 config KALLSYMS_BASE_RELATIVE
 	bool
 	depends on KALLSYMS
@@ -1727,11 +1722,7 @@ config KALLSYMS_BASE_RELATIVE
 	help
 	  Instead of emitting them as absolute values in the native word size,
 	  emit the symbol references in the kallsyms table as 32-bit entries,
-	  each containing a relative value in the range [base, base + U32_MAX]
-	  or, when KALLSYMS_ABSOLUTE_PERCPU is in effect, each containing either
-	  an absolute value in the range [0, S32_MAX] or a relative value in the
-	  range [base, base + S32_MAX], where base is the lowest relative symbol
-	  address encountered in the image.
+	  each containing a relative value in the range [base, base + U32_MAX].
 
 	  On 64-bit builds, this reduces the size of the address table by 50%,
 	  but more importantly, it results in entries whose values are build
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..f4e8e531052a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -151,16 +151,8 @@ unsigned long kallsyms_sym_address(int idx)
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
 		return kallsyms_addresses[idx];
 
-	/* values are unsigned offsets if --absolute-percpu is not in effect */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
-		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
-
-	/* ...otherwise, positive offsets are absolute values */
-	if (kallsyms_offsets[idx] >= 0)
-		return kallsyms_offsets[idx];
-
-	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
-	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+	/* values are unsigned offsets */
+	return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
 }
 
 static void cleanup_symbol_name(char *s)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..501f978abf4b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,8 +5,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: kallsyms [--all-symbols] [--absolute-percpu]
- *                         [--base-relative] [--lto-clang] in.map > out.S
+ * Usage: kallsyms [--all-symbols] [--base-relative] [--lto-clang]
+ *		   in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -37,7 +37,6 @@ struct sym_entry {
 	unsigned int len;
 	unsigned int seq;
 	unsigned int start_pos;
-	unsigned int percpu_absolute;
 	unsigned char sym[];
 };
 
@@ -55,14 +54,9 @@ static struct addr_range text_ranges[] = {
 #define text_range_text     (&text_ranges[0])
 #define text_range_inittext (&text_ranges[1])
 
-static struct addr_range percpu_range = {
-	"__per_cpu_start", "__per_cpu_end", -1ULL, 0
-};
-
 static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
-static int absolute_percpu;
 static int base_relative;
 static int lto_clang;
 
@@ -75,7 +69,7 @@ static unsigned char best_table_len[256];
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
 			"[--base-relative] [--lto-clang] in.map > out.S\n");
 	exit(1);
 }
@@ -167,7 +161,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 		return NULL;
 
 	check_symbol_range(name, addr, text_ranges, ARRAY_SIZE(text_ranges));
-	check_symbol_range(name, addr, &percpu_range, 1);
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
@@ -183,7 +176,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 	sym->len = len;
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
-	sym->percpu_absolute = 0;
 
 	return sym;
 }
@@ -334,11 +326,6 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 	return total;
 }
 
-static int symbol_absolute(const struct sym_entry *s)
-{
-	return s->percpu_absolute;
-}
-
 static void cleanup_symbol_name(char *s)
 {
 	char *p;
@@ -499,30 +486,17 @@ static void write_src(void)
 			 */
 
 			long long offset;
-			int overflow;
-
-			if (!absolute_percpu) {
-				offset = table[i]->addr - relative_base;
-				overflow = (offset < 0 || offset > UINT_MAX);
-			} else if (symbol_absolute(table[i])) {
-				offset = table[i]->addr;
-				overflow = (offset < 0 || offset > INT_MAX);
-			} else {
-				offset = relative_base - table[i]->addr - 1;
-				overflow = (offset < INT_MIN || offset >= 0);
-			}
-			if (overflow) {
+
+			offset = table[i]->addr - relative_base;
+			if (offset < 0 || offset > UINT_MAX) {
 				fprintf(stderr, "kallsyms failure: "
-					"%s symbol value %#llx out of range in relative mode\n",
-					symbol_absolute(table[i]) ? "absolute" : "relative",
+					"symbol value %#llx out of range in relative mode\n",
 					table[i]->addr);
 				exit(EXIT_FAILURE);
 			}
 			printf("\t.long\t%#x	/* %s */\n", (int)offset, table[i]->sym);
-		} else if (!symbol_absolute(table[i])) {
-			output_address(table[i]->addr);
 		} else {
-			printf("\tPTR\t%#llx\n", table[i]->addr);
+			output_address(table[i]->addr);
 		}
 	}
 	printf("\n");
@@ -775,36 +749,15 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
-static void make_percpus_absolute(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
-			/*
-			 * Keep the 'A' override for percpu symbols to
-			 * ensure consistent behavior compared to older
-			 * versions of this tool.
-			 */
-			table[i]->sym[0] = 'A';
-			table[i]->percpu_absolute = 1;
-		}
-}
-
-/* find the minimum non-absolute symbol address */
+/* find the minimum symbol address */
 static void record_relative_base(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (!symbol_absolute(table[i])) {
-			/*
-			 * The table is sorted by address.
-			 * Take the first non-absolute symbol value.
-			 */
-			relative_base = table[i]->addr;
-			return;
-		}
+	/*
+	 * The table is sorted by address.
+	 * Take the first symbol value.
+	 */
+	if (table_cnt)
+		relative_base = table[0]->addr;
 }
 
 int main(int argc, char **argv)
@@ -812,7 +765,6 @@ int main(int argc, char **argv)
 	while (1) {
 		static const struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
-			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{"base-relative",   no_argument, &base_relative,   1},
 			{"lto-clang",       no_argument, &lto_clang,       1},
 			{},
@@ -831,8 +783,6 @@ int main(int argc, char **argv)
 
 	read_map(argv[optind]);
 	shrink_table();
-	if (absolute_percpu)
-		make_percpus_absolute();
 	sort_symbols();
 	if (base_relative)
 		record_relative_base();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a432b171be82..d25b6d5de45e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -148,10 +148,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if is_enabled CONFIG_KALLSYMS_ABSOLUTE_PERCPU; then
-		kallsymopt="${kallsymopt} --absolute-percpu"
-	fi
-
 	if is_enabled CONFIG_KALLSYMS_BASE_RELATIVE; then
 		kallsymopt="${kallsymopt} --base-relative"
 	fi
-- 
2.41.0

