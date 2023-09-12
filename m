Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796AF79D972
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjILTSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjILTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:18:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45841C1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:18:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4046C433C7;
        Tue, 12 Sep 2023 19:18:40 +0000 (UTC)
Date:   Tue, 12 Sep 2023 21:18:37 +0200
From:   Helge Deller <deller@gmx.de>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix lockdep static memory detection
Message-ID: <ZQC5jS/Kc/JiBEOa@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata()
and init_section_contains() to verify if a lock is located inside a
kernel static data section.

This change triggers a failure on LoongArch, for which the vmlinux.lds.S
script misses to put the locks (as part of in the .data.rel symbols)
into the Linux data section.
This patch fixes the lockdep problem by moving *(.data.rel*) symbols
into the kernel data section (from _sdata to _edata).

Additionally, move other wrongly assigned symbols too:
- altinstructions into the _initdata section,
- PLT symbols behind the read-only section, and
- *(.la_abs) into the data section.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more")
Cc: stable <stable@kernel.org> # v6.4+

diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index b1686afcf876..bb2ec86f37a8 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -53,33 +53,6 @@ SECTIONS
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	_etext = .;
 
-	/*
-	 * struct alt_inst entries. From the header (alternative.h):
-	 * "Alternative instructions for different CPU types or capabilities"
-	 * Think locking instructions on spinlocks.
-	 */
-	. = ALIGN(4);
-	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
-		__alt_instructions = .;
-		*(.altinstructions)
-		__alt_instructions_end = .;
-	}
-
-#ifdef CONFIG_RELOCATABLE
-	. = ALIGN(8);
-	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
-		__la_abs_begin = .;
-		*(.la_abs)
-		__la_abs_end = .;
-	}
-#endif
-
-	.got : ALIGN(16) { *(.got) }
-	.plt : ALIGN(16) { *(.plt) }
-	.got.plt : ALIGN(16) { *(.got.plt) }
-
-	.data.rel : { *(.data.rel*) }
-
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -94,6 +67,18 @@ SECTIONS
 
 	__initdata_begin = .;
 
+	/*
+	 * struct alt_inst entries. From the header (alternative.h):
+	 * "Alternative instructions for different CPU types or capabilities"
+	 * Think locking instructions on spinlocks.
+	 */
+	. = ALIGN(4);
+	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+		__alt_instructions = .;
+		*(.altinstructions)
+		__alt_instructions_end = .;
+	}
+
 	INIT_DATA_SECTION(16)
 	.exit.data : {
 		EXIT_DATA
@@ -113,6 +98,11 @@ SECTIONS
 
 	_sdata = .;
 	RO_DATA(4096)
+
+	.got : ALIGN(16) { *(.got) }
+	.plt : ALIGN(16) { *(.plt) }
+	.got.plt : ALIGN(16) { *(.got.plt) }
+
 	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
 
 	.rela.dyn : ALIGN(8) {
@@ -121,6 +111,17 @@ SECTIONS
 		__rela_dyn_end = .;
 	}
 
+	.data.rel : { *(.data.rel*) }
+
+#ifdef CONFIG_RELOCATABLE
+	. = ALIGN(8);
+	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
+		__la_abs_begin = .;
+		*(.la_abs)
+		__la_abs_end = .;
+	}
+#endif
+
 	.sdata : {
 		*(.sdata)
 	}
