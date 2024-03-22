Return-Path: <linux-kernel+bounces-111826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ECE887158
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588E1289050
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953F60EE4;
	Fri, 22 Mar 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMaE6ww5"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5A60DD7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126390; cv=none; b=kIlTjKYaVORzZuI35fhwxYPTX0S2e5iTGQmNrS3eR7B8GXisUgPQfiI9q2tcwJ55h5NkIet55Pu9lxl4/eLT42sHTXg4sc9ePdacGggYKpe3D0JVwYMF3j59uMuGC/z4BrQWIQJSjMIND5l9Q38gnwEYyX5/www+TmG4VCyHcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126390; c=relaxed/simple;
	bh=w5lRor2gDUTAnKWbRfo5S7pLGPoO+/siZMlAQOcuzkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgUdURZcRdWAxWiJqAwYYXDDwJu9Bvi7yx9nG51pDlhChMVEosFATwGfxKa6+M3VUKHkc5GncwbSGwqT3RsrrOQ8Qpo1ZZAIrXsstT9bdFsaGI6rVeZYFh7LpcnbIrezx3CCFoI46vfdqdAegjovlvulfsUVvEo4AUPCQ07WVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMaE6ww5; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789e83637e0so148243185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126387; x=1711731187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9enSTXYKk4Zrvj4rfHNHKtmAkQZHAnQu5tvlI07i35w=;
        b=VMaE6ww5qId5pi8MhC+CK5vYO+NtcWjIRoQyF2uWaKcJDLgkEDFg8BqjVkJ3avo527
         ewE87W+PAz+3F+nykIEqfQNnikh2h7pyh4SZ814EvUz8dHtCkkIG16r9ppxKBcW43dlh
         YGmtBh6iDy/RLQWXzxy9tYaS/QWXfDS0QU3k3xEoe/zqTn0JQhkT9pHxAA4ahhOBU93e
         z/inmex5SbdAe8971+TGh6+TV7AlyvzTac57Qeomwic5md2ChW+KONrPD8hvSzQt+Zjp
         OVRp5Xx7eZsnvJYH9ESpDyo6/7uUUW7cxk46wHM9IBYeLhr6/WM9X2K8B6ymacxHy6Ui
         bVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126387; x=1711731187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9enSTXYKk4Zrvj4rfHNHKtmAkQZHAnQu5tvlI07i35w=;
        b=uome9eq6DPn6JcAx+HNS+izYptUUr6tA9G7Pzk/sXebAHIuPnWw2Lfi5ioiMVGAPyJ
         +2NmIaZWJw37Xw1vN1wNlSu8+xHtACn8tqnI55LbcdpNERwDSYaBlFsphTOYxwRkWGpo
         ivmGVLRHhHKtIK0FaOptwdIEOYumIoA+ZutBXPgygfeHZvQTGp8NYl7BAMWuCbE8CwM4
         nWS8V5fX/XjE1J/R1dbu+/2puxE3YMMk3UXdgsDyn+3gUiqpAoGJZ9xzIzSzB/+cETNH
         0dOdpeZ0UO9qNKbk/bYNyOOvVzwe/8J9rebPZmvMpEUPAuFTc8HqZfSKgQ43t5uThLQb
         118A==
X-Gm-Message-State: AOJu0YySin5AGH/87wiHedFLChh57h74sOLaTJqpRJSZr+3yxG7B7/Gr
	vYc5QG6uA3oixl8knKWYyvySYxozKJ7iZ4o8AkIeC+28x5fEX0NzTHEfJdM=
X-Google-Smtp-Source: AGHT+IE77AtBJ2T3L4/FCqCn71Qd678y5r9QRm/DcKAWicsPNMT6z27t7nqp07NFmrz/FP2C2Q4UzQ==
X-Received: by 2002:a05:620a:8016:b0:78a:40fb:b199 with SMTP id ee22-20020a05620a801600b0078a40fbb199mr1562979qkb.38.1711126387496;
        Fri, 22 Mar 2024 09:53:07 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:53:07 -0700 (PDT)
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
Subject: [PATCH v4 16/16] kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
Date: Fri, 22 Mar 2024 12:52:33 -0400
Message-ID: <20240322165233.71698-17-brgerst@gmail.com>
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

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 init/Kconfig            | 11 +-----
 kernel/kallsyms.c       | 12 ++-----
 scripts/kallsyms.c      | 80 ++++++++---------------------------------
 scripts/link-vmlinux.sh |  4 ---
 4 files changed, 18 insertions(+), 89 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0f928f82dc7a..0622599ce503 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1781,11 +1781,6 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols, or kernel live patching.
 
-config KALLSYMS_ABSOLUTE_PERCPU
-	bool
-	depends on KALLSYMS
-	default n
-
 config KALLSYMS_BASE_RELATIVE
 	bool
 	depends on KALLSYMS
@@ -1793,11 +1788,7 @@ config KALLSYMS_BASE_RELATIVE
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
index 7862a8101747..7b0596cd5a80 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -153,10 +153,6 @@ kallsyms()
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
2.44.0


