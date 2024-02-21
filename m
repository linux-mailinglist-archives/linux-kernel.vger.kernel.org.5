Return-Path: <linux-kernel+bounces-75459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85C85E900
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AF1F23BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5486654;
	Wed, 21 Feb 2024 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqN+db4E"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70C42A8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547228; cv=none; b=JP2l0uq2pVWqz21uVgAETfX1TQlhsc4YgkrASMoOgPR9lJbNFIPHZfJXGMw1jKUL21H+w60d6VEi4pp0KLNVgjNFI5hpjYJ9as5auiL44ndRaAvPYWoTInagjffuDbhegAvIPwMcAQmgI2FKf586HBETLyCGq1P/4W06El2FhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547228; c=relaxed/simple;
	bh=3j03Qb0xtShAH05XRNVvgv/2gAOfWYxJvB9YxzR5lhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnUN78loVYHjc0O+TDqO+DJdRRqHRs0pJvAd4aKkCzwvJMw+4pY391suUWloOUK3oY/yYIYItVY/QrZnNdosxTzzPYj7XsZEIx0gX4D+532RgQUJhc3MvLk5Vm1hIrDAtcOl9ArnPkMHMsNAXi5Zqo2DWNvCwWQn5IcBvt+vb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BqN+db4E; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so38a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547224; x=1709152024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVMC4eb66pNSxPeBaeLVvkGzXsMPDRJGzt+F/nlnaOI=;
        b=BqN+db4EtI0L3LKiFaoRPsTVeR5F0Sw1fOpll0x9Hxv40VIrAlF4bmRWsnMIxQMN5r
         1hrqQUyor8OO2z92zNcHEsXofA9+h+CriToLGQSyj5+Py7nJsmVtS6ECPfO74dqss21N
         sZEz5hEymHc7TtdmmrGRc4TnEEfGyxGxuDsN6uI0BAf7IuyW6f7qOpMlE2ahk4pDXcI5
         w6xDfa8rGrFy5gDmPg+pW2+pnlTR4OcuAvzJf5Bgkpp8c7QMsqXR2DcZ3cM78BABwyl0
         9wx+UN9+t36GblJSlOwgrPnEO3ubgEUe9alCrVz0clV5V0/f6SonQXU+aAxXdQ22jYCB
         MH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547224; x=1709152024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVMC4eb66pNSxPeBaeLVvkGzXsMPDRJGzt+F/nlnaOI=;
        b=nlznNtcRiQeGK1oB3LVHi3A9MuKilGgPO3oYgFhYEnGUKS4lVs95BxXLME/SjI6Ccb
         ZllhqW0Cuqe247x8zGOwjME9HUuLqdX8p83m5KHDE8U/fDgKBac9wefxP127lDL8cRXq
         carXvNa9ZsmjFFJyfJSTaNT7pAA1O7IRUwNtwRmqRG44IbB2tEDNawz60myR/AnrRic6
         5WapRw+IWxGYFfktGfWKyHdGiFaF9QMg5sYyfoEst6ZSdJRw60krdsUCJFgejcGOQ4Vl
         woh6f6YVU3DkyOvt39XacpxoGmJawm/6TT663Dnqe64BzIQIhIUu+ciDyglxIbmqujqG
         fLag==
X-Forwarded-Encrypted: i=1; AJvYcCW3UVR7FA1vo1HQUaWM7fhjd3DDvTDGnxfGVNvX/caSSrxqx6yUE+LOzNef+DsgNhdT7mxw/pa+1sI2bmTfS0p5mCie5USWbTXhZ0dt
X-Gm-Message-State: AOJu0YwaDSQLiwSRy++YgNvMNC5X+t0KwA1GDMmusLzow2e3R5HRCAIw
	zby75QLMVJ1Zic+0XGwqv0J4FqqfBu2yV1mTf8GwkT79AFz3+TFHQOFuS4/a4w==
X-Google-Smtp-Source: AGHT+IGjx+evP+twUluQUI6O+JiuvrpCAU/fVnlCmHOMImFnPwTJ7Sz9pQMXDaki4rJG2oSqaNnNDw==
X-Received: by 2002:a50:c30f:0:b0:564:55e5:6ee1 with SMTP id a15-20020a50c30f000000b0056455e56ee1mr261447edb.2.1708547224123;
        Wed, 21 Feb 2024 12:27:04 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:2c31:2431:3037:f162])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm17912611wrx.47.2024.02.21.12.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:27:03 -0800 (PST)
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
Subject: [PATCH 1/2] kallsyms: get rid of code for absolute kallsyms
Date: Wed, 21 Feb 2024 21:26:53 +0100
Message-ID: <20240221202655.2423854-1-jannh@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To compile code for absolute kallsyms, you had to turn off
KALLSYMS_BASE_RELATIVE. I think based on the way it was declared in
Kconfig (without a string after "bool"), it wasn't even possible to
select it.

Get rid of this config option, as preparation for some kallsyms
optimizations that would otherwise be infeasible.

Signed-off-by: Jann Horn <jannh@google.com>
---
 init/Kconfig                        | 18 -------
 kernel/crash_core.c                 |  4 --
 kernel/kallsyms.c                   | 10 +---
 kernel/kallsyms_internal.h          |  1 -
 scripts/kallsyms.c                  | 78 ++++++++++++-----------------
 scripts/link-vmlinux.sh             |  4 --
 tools/perf/tests/vmlinux-kallsyms.c |  1 -
 7 files changed, 34 insertions(+), 82 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8426d59cc634..ef525aacfc4c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1791,24 +1791,6 @@ config KALLSYMS_ABSOLUTE_PERCPU
 	depends on KALLSYMS
 	default X86_64 && SMP
 
-config KALLSYMS_BASE_RELATIVE
-	bool
-	depends on KALLSYMS
-	default y
-	help
-	  Instead of emitting them as absolute values in the native word size,
-	  emit the symbol references in the kallsyms table as 32-bit entries,
-	  each containing a relative value in the range [base, base + U32_MAX]
-	  or, when KALLSYMS_ABSOLUTE_PERCPU is in effect, each containing either
-	  an absolute value in the range [0, S32_MAX] or a relative value in the
-	  range [base, base + S32_MAX], where base is the lowest relative symbol
-	  address encountered in the image.
-
-	  On 64-bit builds, this reduces the size of the address table by 50%,
-	  but more importantly, it results in entries whose values are build
-	  time constants, and no relocation pass is required at runtime to fix
-	  up the entries based on the runtime load address of the kernel.
-
 # end of the "standard kernel features (expert users)" menu
 
 config ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 75cd6a736d03..1e72e65ca344 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -817,12 +817,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(kallsyms_num_syms);
 	VMCOREINFO_SYMBOL(kallsyms_token_table);
 	VMCOREINFO_SYMBOL(kallsyms_token_index);
-#ifdef CONFIG_KALLSYMS_BASE_RELATIVE
 	VMCOREINFO_SYMBOL(kallsyms_offsets);
 	VMCOREINFO_SYMBOL(kallsyms_relative_base);
-#else
-	VMCOREINFO_SYMBOL(kallsyms_addresses);
-#endif /* CONFIG_KALLSYMS_BASE_RELATIVE */
 #endif /* CONFIG_KALLSYMS */
 
 	arch_crash_save_vmcoreinfo();
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..db9bd5ff6383 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -148,9 +148,6 @@ static unsigned int get_symbol_offset(unsigned long pos)
 
 unsigned long kallsyms_sym_address(int idx)
 {
-	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
-		return kallsyms_addresses[idx];
-
 	/* values are unsigned offsets if --absolute-percpu is not in effect */
 	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
 		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
@@ -326,12 +323,9 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long i, low, high, mid;
 
 	/* This kernel should never had been booted. */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
-		BUG_ON(!kallsyms_addresses);
-	else
-		BUG_ON(!kallsyms_offsets);
+	BUG_ON(!kallsyms_offsets);
 
-	/* Do a binary search on the sorted kallsyms_addresses array. */
+	/* Do a binary search on the sorted kallsyms_offsets array. */
 	low = 0;
 	high = kallsyms_num_syms;
 
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 27fabdcc40f5..451a38b88db9 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -8,7 +8,6 @@
  * These will be re-linked against their real values
  * during the second link stage.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
 extern const int kallsyms_offsets[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..f35be95adfbe 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -6,7 +6,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * Usage: kallsyms [--all-symbols] [--absolute-percpu]
- *                         [--base-relative] [--lto-clang] in.map > out.S
+ *                         [--lto-clang] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -63,7 +63,6 @@ static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
 static int absolute_percpu;
-static int base_relative;
 static int lto_clang;
 
 static int token_profit[0x10000];
@@ -76,7 +75,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
-			"[--base-relative] [--lto-clang] in.map > out.S\n");
+			"[--lto-clang] in.map > out.S\n");
 	exit(1);
 }
 
@@ -484,54 +483,43 @@ static void write_src(void)
 		printf("\t.short\t%d\n", best_idx[i]);
 	printf("\n");
 
-	if (!base_relative)
-		output_label("kallsyms_addresses");
-	else
-		output_label("kallsyms_offsets");
+	output_label("kallsyms_offsets");
 
 	for (i = 0; i < table_cnt; i++) {
-		if (base_relative) {
-			/*
-			 * Use the offset relative to the lowest value
-			 * encountered of all relative symbols, and emit
-			 * non-relocatable fixed offsets that will be fixed
-			 * up at runtime.
-			 */
+		/*
+		 * Use the offset relative to the lowest value
+		 * encountered of all relative symbols, and emit
+		 * non-relocatable fixed offsets that will be fixed
+		 * up at runtime.
+		 */
 
-			long long offset;
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
-				fprintf(stderr, "kallsyms failure: "
-					"%s symbol value %#llx out of range in relative mode\n",
-					symbol_absolute(table[i]) ? "absolute" : "relative",
-					table[i]->addr);
-				exit(EXIT_FAILURE);
-			}
-			printf("\t.long\t%#x	/* %s */\n", (int)offset, table[i]->sym);
-		} else if (!symbol_absolute(table[i])) {
-			output_address(table[i]->addr);
+		long long offset;
+		int overflow;
+
+		if (!absolute_percpu) {
+			offset = table[i]->addr - relative_base;
+			overflow = (offset < 0 || offset > UINT_MAX);
+		} else if (symbol_absolute(table[i])) {
+			offset = table[i]->addr;
+			overflow = (offset < 0 || offset > INT_MAX);
 		} else {
-			printf("\tPTR\t%#llx\n", table[i]->addr);
+			offset = relative_base - table[i]->addr - 1;
+			overflow = (offset < INT_MIN || offset >= 0);
 		}
+		if (overflow) {
+			fprintf(stderr, "kallsyms failure: "
+				"%s symbol value %#llx out of range in relative mode\n",
+				symbol_absolute(table[i]) ? "absolute" : "relative",
+				table[i]->addr);
+			exit(EXIT_FAILURE);
+		}
+		printf("\t.long\t%#x	/* %s */\n", (int)offset, table[i]->sym);
 	}
 	printf("\n");
 
-	if (base_relative) {
-		output_label("kallsyms_relative_base");
-		output_address(relative_base);
-		printf("\n");
-	}
+	output_label("kallsyms_relative_base");
+	output_address(relative_base);
+	printf("\n");
 
 	if (lto_clang)
 		for (i = 0; i < table_cnt; i++)
@@ -813,7 +801,6 @@ int main(int argc, char **argv)
 		static const struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
 			{"absolute-percpu", no_argument, &absolute_percpu, 1},
-			{"base-relative",   no_argument, &base_relative,   1},
 			{"lto-clang",       no_argument, &lto_clang,       1},
 			{},
 		};
@@ -834,8 +821,7 @@ int main(int argc, char **argv)
 	if (absolute_percpu)
 		make_percpus_absolute();
 	sort_symbols();
-	if (base_relative)
-		record_relative_base();
+	record_relative_base();
 	optimize_token_table();
 	write_src();
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 7862a8101747..5127371d3393 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -157,10 +157,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --absolute-percpu"
 	fi
 
-	if is_enabled CONFIG_KALLSYMS_BASE_RELATIVE; then
-		kallsymopt="${kallsymopt} --base-relative"
-	fi
-
 	if is_enabled CONFIG_LTO_CLANG; then
 		kallsymopt="${kallsymopt} --lto-clang"
 	fi
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 822f893e67d5..1bb91f2ec5ba 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -26,7 +26,6 @@ static bool is_ignored_symbol(const char *name, char type)
 		 * when --all-symbols is specified so exclude them to get a
 		 * stable symbol list.
 		 */
-		"kallsyms_addresses",
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
 		"kallsyms_num_syms",
-- 
2.44.0.rc0.258.g7320e95886-goog


