Return-Path: <linux-kernel+bounces-32599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C8835DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AACA0B22FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91239875;
	Mon, 22 Jan 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SG6i9JSp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FA39860
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914768; cv=none; b=XUTbtJW2FJJDSm0fDHr5j3kfhhzYxFrnKz8uiPBRPhahPvvAyVtSFP6d8rhbU3TaBGuQ8HqwwT+Y8sPvsoVxe0jd49iJX+JiPR7pfPRuYoqhC5ussDspfMj8CUDYJvexgTa1C7CJlfuxti/C+FGymFoUhnFUZ+Mj6VlL7Q2qcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914768; c=relaxed/simple;
	bh=NvZ9QYXHyD9CvB6BGA5UKBh+CJlv7ohKGlZB0ViTzZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDyl7lakLiVkDiHSTIY9U4v8kbBb5CR9LgIwlyFDRt9be0zfWVp+Is9ISUBdTg0s3OBwwbbkyWuMKNDQSP+Cn8Vt3JRG37/qJi76UglLIuMpV46+Pbib6dOstUL3ysztRDw5AJHuuX8a4edmvE9fgJ/SFU30Jb02Qh9/KsqyZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SG6i9JSp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc237543b74so3348656276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914765; x=1706519565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ue2vmRkHm0fVc6V6NYaJ8ToLI0DQfe3Y1iY9J4coyg=;
        b=SG6i9JSpVNdDkPcVZQkC/nQclGrDc5CAbladqHJL+t4v3HiQDAHtFiGRuoHF6fo2ss
         rW6XcRNyFJ6wB4S4HkYqFLmbJEAHQ07qAcEFsYBVDUNceVFoT36ilXncUOBGmt+9IJvz
         B3GNOmzvUkYPx3P7k8M55NqlcrU8Q7aZWZyB63YnNUkJZYy4ucrb+cEbOiQAO6rXfYvc
         4N4aKLL5BFr9gt0MPMHmhuC2wbT7WuXOcm6gSvXY/dYyQTT3qybvimFbEbl/7D6v/QTs
         JBtCp2lxahkwcSA0qn055qk+OcaW8DX+BKVZPtv5jzPAKP/+j5H0pxuwIxxEG5Fy48um
         trig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914765; x=1706519565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ue2vmRkHm0fVc6V6NYaJ8ToLI0DQfe3Y1iY9J4coyg=;
        b=ISc9EyMf2M+KmuDggwWfmMxOXtnx/EFGn9HuLfn7AmTTLYISANqCMWp4bP3XL6b2cV
         URZyzAgw4KRI+jOQIJJRrzhr5r50+YK6py4HlC4RQCjBOtTG5U4RNV9xI0pYqbbVDUAU
         Ncm6qVHavMSCcwzg0v8j95vwRtDlefe0fERX4GY2UNdmQS1ihE86Anrvf/bbTrFZ0dk+
         V91AlsbNd9/B9TkEFt9C+GUMY/pO4Hzd02BrrVriEcsBoFkgqEdnyQZkUElSd43SIuxV
         jiJEthdIVqERebxyYeJ1CPDW+HboCEwowIGSR5l/2hcZeO48yIT9Iw5r2ILpfTTgqu+v
         /PyQ==
X-Gm-Message-State: AOJu0YxNTfM2kPSDVpOlEG/RT6yx/R2Qr6PQFu7pABDl9CQNp/ritbyu
	HlA8JRWHQWreOJtX3KHzn4Sos9plgbvDn7trsE3CnburOBOXp6premgMHtYDzghnJOKuTSL434h
	wXUzqbEJNgUxImCH1YZrwemLgM+k6XoW7kNCQUmqXxkaMjJA2FEjn3qQbgPyKTxK3bf+klSjjJ6
	2LLSHPEHrxsOr0MpI5end8QOmqBfhObA==
X-Google-Smtp-Source: AGHT+IGJDRSjcYcg8n9oDXDtdZCAWw9nAc///2zyg4L6KF8baH0Ss4ES3FuPcGALSZ7TmZSFYMHQD9pi
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:11c1:0:b0:dc2:46cd:eee9 with SMTP id
 184-20020a2511c1000000b00dc246cdeee9mr238812ybr.4.1705914765393; Mon, 22 Jan
 2024 01:12:45 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:53 +0100
In-Reply-To: <20240122090851.851120-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=ardb@kernel.org;
 h=from:subject; bh=8Z7gd3kTb2u9hK0wTWYrEf9GDcgvcakQPNv0R7gN2o8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwdIsmzezFAp52a+9FVjSY79C54j1MiVvl2f/V+7/G
 aRm/e9hRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIeAfDf48/O7a+4GRIKPuy
 hm/X71tsG+701bE6Fof27rFf/Lzz7E+Gv+Jm0Z3bW9gd+bzVvy3/bZN5q07v2ZbXOzgzH2kK7Fj 9jBEA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-8-ardb+git@google.com>
Subject: [RFC PATCH 1/5] kallsyms: Avoid weak references for kallsyms symbols
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

kallsyms is a directory of all the symbols in the vmlinux binary, and so
creating it is somewhat of a chicken-and-egg problem, as its non-zero
size affects the layout of the binary, and therefore the values of the
symbols.

For this reason, the kernel is linked more than once, and the first pass
does not include any kallsyms data at all. For the linker to accept
this, the symbol declarations describing the kallsyms metadata are
emitted as having weak linkage, so they can remain unsatisfied. During
the subsequent passes, the weak references are satisfied by the kallsyms
metadata that was constructed based on information gathered from the
preceding passes.

Weak references lead to somewhat worse codegen, because taking their
address may need to produce NULL (if the reference was unsatisfied), and
this is not usually supported by RIP or PC relative symbol references.

Given that these references are ultimately always satisfied in the final
link, let's drop the weak annotation, and instead, provide fallback
definitions in the linker script that are only emitted if an unsatisfied
reference exists.

While at it, drop the FRV specific annotation that these symbols reside
in .rodata - FRV is long gone.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5dd3a61d673d..a39e050416c7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -448,11 +448,30 @@
 #endif
 #endif
 
+/*
+ * Some symbol definitions will not exist yet during the first pass of the
+ * link, but are guaranteed to exist in the final link. Provide preliminary
+ * definitions that will be superseded in the final link to avoid having to
+ * rely on weak external linkage, which requires a GOT when used in position
+ * independent code.
+ */
+#define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(kallsyms_addresses = .);				\
+	PROVIDE(kallsyms_offsets = .);					\
+	PROVIDE(kallsyms_names = .);					\
+	PROVIDE(kallsyms_num_syms = .);					\
+	PROVIDE(kallsyms_relative_base = .);				\
+	PROVIDE(kallsyms_token_table = .);				\
+	PROVIDE(kallsyms_token_index = .);				\
+	PROVIDE(kallsyms_markers = .);					\
+	PROVIDE(kallsyms_seqs_of_names = .);
+
 /*
  * Read only Data
  */
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
+	PRELIMINARY_SYMBOL_DEFINITIONS					\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..22ea19a36e6e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -325,12 +325,6 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long symbol_start = 0, symbol_end = 0;
 	unsigned long i, low, high, mid;
 
-	/* This kernel should never had been booted. */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
-		BUG_ON(!kallsyms_addresses);
-	else
-		BUG_ON(!kallsyms_offsets);
-
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
 	high = kallsyms_num_syms;
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 27fabdcc40f5..85480274fc8f 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -5,27 +5,21 @@
 #include <linux/types.h>
 
 /*
- * These will be re-linked against their real values
- * during the second link stage.
+ * These will be re-linked against their real values during the second link
+ * stage. Preliminary values must be provided in the linker script using the
+ * PROVIDE() directive so that the first link stage can complete successfully.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[];
+extern const int kallsyms_offsets[];
+extern const u8 kallsyms_names[];
 
-/*
- * Tell the compiler that the count isn't in the small data section if the arch
- * has one (eg: FRV).
- */
-extern const unsigned int kallsyms_num_syms
-__section(".rodata") __attribute__((weak));
-
-extern const unsigned long kallsyms_relative_base
-__section(".rodata") __attribute__((weak));
+extern const unsigned int kallsyms_num_syms;
+extern const unsigned long kallsyms_relative_base;
 
-extern const char kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const char kallsyms_token_table[];
+extern const u16 kallsyms_token_index[];
 
-extern const unsigned int kallsyms_markers[] __weak;
-extern const u8 kallsyms_seqs_of_names[] __weak;
+extern const unsigned int kallsyms_markers[];
+extern const u8 kallsyms_seqs_of_names[];
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
-- 
2.43.0.429.g432eaa2c6b-goog


