Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B727CD953
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJRKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjJRKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:34:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD84B0;
        Wed, 18 Oct 2023 03:34:19 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:34:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697625258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/VEj17dC043XA4hYMiDpbKalqipjKN+BqFccruqrqEM=;
        b=d7e5qUfFNLiBwFpx86cnZsYd1NlSfw/LJ0voMxIfVNecavDSNd++Re8m9DGNaAFGO8Z6Yr
        PmmFxjP1CKgTxj/GK+MR/k09VuuRpG4U5Uqgx/gadlizZzy7kks7kls7xNbzk1Se87J8iz
        k5pNAP4BPFHn6IDwCBAFap2KmUvOvpnoEuQ/U83pvXFNehT4ggk9TVVYy5qMoGoXFQPRke
        0ue3ncn+hZb2s7jXCDSSYPAKhDHy8OH7mAVdWnrur7Am+M5MnLa5SsVZMVJaffMj85S3gN
        +SEGcuUcyjow6BQJqCJZl5FtTw5XK+NyJdG4g5+wuijxWXJ67eyzEJF+ZQo79A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697625258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/VEj17dC043XA4hYMiDpbKalqipjKN+BqFccruqrqEM=;
        b=Bd6StY75qgtv5Ur6PJ6dOruYfDEjY1n8S1W9GvKNzzDXcZxTql48q1vJxyJmW/UoAwUN5u
        LDCWOhASXvVFcTBg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Rename conflicting 'boot_params' pointer to
 'boot_params_ptr'
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169762525760.3135.14704281872948052299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d55d5bc5d937743aa8ebb7ca3af25111053b5d8c
Gitweb:        https://git.kernel.org/tip/d55d5bc5d937743aa8ebb7ca3af25111053b5d8c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 17 Oct 2023 15:25:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Oct 2023 12:03:03 +02:00

x86/boot: Rename conflicting 'boot_params' pointer to 'boot_params_ptr'

The x86 decompressor is built and linked as a separate executable, but
it shares components with the kernel proper, which are either #include'd
as C files, or linked into the decompresor as a static library (e.g, the
EFI stub)

Both the kernel itself and the decompressor define a global symbol
'boot_params' to refer to the boot_params struct, but in the former
case, it refers to the struct directly, whereas in the decompressor, it
refers to a global pointer variable referring to the struct boot_params
passed by the bootloader or constructed from scratch.

This ambiguity is unfortunate, and makes it impossible to assign this
decompressor variable from the x86 EFI stub, given that declaring it as
extern results in a clash. So rename the decompressor version (whose
scope is limited) to boot_params_ptr.

[ mingo: Renamed 'boot_params_p' to 'boot_params_ptr' for clarity ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/acpi.c         | 14 ++++++-------
 arch/x86/boot/compressed/cmdline.c      |  4 ++--
 arch/x86/boot/compressed/ident_map_64.c |  7 +++---
 arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++++------------
 arch/x86/boot/compressed/mem.c          |  6 +++---
 arch/x86/boot/compressed/misc.c         | 24 +++++++++++-----------
 arch/x86/boot/compressed/misc.h         |  1 +-
 arch/x86/boot/compressed/pgtable_64.c   |  9 +++-----
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/boot.h             |  2 ++-
 10 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf890..55c98fd 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -30,13 +30,13 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
 	 * ACPI_TABLE_GUID because it has more features.
 	 */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_ptr, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_20_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
 
 	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_ptr, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
@@ -56,15 +56,15 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_ptr);
 	if (et == EFI_TYPE_NONE)
 		return 0;
 
-	systab_pa = efi_get_system_table(boot_params);
+	systab_pa = efi_get_system_table(boot_params_ptr);
 	if (!systab_pa)
 		error("EFI support advertised, but unable to locate system table.");
 
-	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len);
+	ret = efi_get_conf_table(boot_params_ptr, &cfg_tbl_pa, &cfg_tbl_len);
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
@@ -156,7 +156,7 @@ acpi_physical_address get_rsdp_addr(void)
 {
 	acpi_physical_address pa;
 
-	pa = boot_params->acpi_rsdp_addr;
+	pa = boot_params_ptr->acpi_rsdp_addr;
 
 	if (!pa)
 		pa = efi_get_rsdp_addr();
@@ -210,7 +210,7 @@ static unsigned long get_acpi_srat_table(void)
 	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
 	if (!rsdp)
 		rsdp = (struct acpi_table_rsdp *)(long)
-			boot_params->acpi_rsdp_addr;
+			boot_params_ptr->acpi_rsdp_addr;
 
 	if (!rsdp)
 		return 0;
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d..c1bb180 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -14,9 +14,9 @@ static inline char rdfs8(addr_t addr)
 #include "../cmdline.c"
 unsigned long get_cmd_line_ptr(void)
 {
-	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+	unsigned long cmd_line_ptr = boot_params_ptr->hdr.cmd_line_ptr;
 
-	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+	cmd_line_ptr |= (u64)boot_params_ptr->ext_cmd_line_ptr << 32;
 
 	return cmd_line_ptr;
 }
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bcc956c..3c8593d 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -151,8 +151,9 @@ void initialize_identity_maps(void *rmode)
 	 * or does not touch all the pages covering them.
 	 */
 	kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
-	boot_params = rmode;
-	kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	boot_params_ptr = rmode;
+	kernel_add_identity_map((unsigned long)boot_params_ptr,
+				(unsigned long)(boot_params_ptr + 1));
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
@@ -160,7 +161,7 @@ void initialize_identity_maps(void *rmode)
 	 * Also map the setup_data entries passed via boot_params in case they
 	 * need to be accessed by uncompressed kernel via the identity mapping.
 	 */
-	sd = (struct setup_data *)boot_params->hdr.setup_data;
+	sd = (struct setup_data *)boot_params_ptr->hdr.setup_data;
 	while (sd) {
 		unsigned long sd_addr = (unsigned long)sd;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9193acf..dec961c 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -63,7 +63,7 @@ static unsigned long get_boot_seed(void)
 	unsigned long hash = 0;
 
 	hash = rotate_xor(hash, build_str, sizeof(build_str));
-	hash = rotate_xor(hash, boot_params, sizeof(*boot_params));
+	hash = rotate_xor(hash, boot_params_ptr, sizeof(*boot_params_ptr));
 
 	return hash;
 }
@@ -383,7 +383,7 @@ static void handle_mem_options(void)
 static void mem_avoid_init(unsigned long input, unsigned long input_size,
 			   unsigned long output)
 {
-	unsigned long init_size = boot_params->hdr.init_size;
+	unsigned long init_size = boot_params_ptr->hdr.init_size;
 	u64 initrd_start, initrd_size;
 	unsigned long cmd_line, cmd_line_size;
 
@@ -395,10 +395,10 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	mem_avoid[MEM_AVOID_ZO_RANGE].size = (output + init_size) - input;
 
 	/* Avoid initrd. */
-	initrd_start  = (u64)boot_params->ext_ramdisk_image << 32;
-	initrd_start |= boot_params->hdr.ramdisk_image;
-	initrd_size  = (u64)boot_params->ext_ramdisk_size << 32;
-	initrd_size |= boot_params->hdr.ramdisk_size;
+	initrd_start  = (u64)boot_params_ptr->ext_ramdisk_image << 32;
+	initrd_start |= boot_params_ptr->hdr.ramdisk_image;
+	initrd_size  = (u64)boot_params_ptr->ext_ramdisk_size << 32;
+	initrd_size |= boot_params_ptr->hdr.ramdisk_size;
 	mem_avoid[MEM_AVOID_INITRD].start = initrd_start;
 	mem_avoid[MEM_AVOID_INITRD].size = initrd_size;
 	/* No need to set mapping for initrd, it will be handled in VO. */
@@ -413,8 +413,8 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	}
 
 	/* Avoid boot parameters. */
-	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
-	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params);
+	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params_ptr;
+	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params_ptr);
 
 	/* We don't need to set a mapping for setup_data. */
 
@@ -447,7 +447,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	}
 
 	/* Avoid all entries in the setup_data linked list. */
-	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
+	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
 	while (ptr) {
 		struct mem_vector avoid;
 
@@ -706,7 +706,7 @@ static inline bool memory_type_is_free(efi_memory_desc_t *md)
 static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
 {
-	struct efi_info *e = &boot_params->efi_info;
+	struct efi_info *e = &boot_params_ptr->efi_info;
 	bool efi_mirror_found = false;
 	struct mem_vector region;
 	efi_memory_desc_t *md;
@@ -777,8 +777,8 @@ static void process_e820_entries(unsigned long minimum,
 	struct boot_e820_entry *entry;
 
 	/* Verify potential e820 positions, appending to slots list. */
-	for (i = 0; i < boot_params->e820_entries; i++) {
-		entry = &boot_params->e820_table[i];
+	for (i = 0; i < boot_params_ptr->e820_entries; i++) {
+		entry = &boot_params_ptr->e820_table[i];
 		/* Skip non-RAM entries. */
 		if (entry->type != E820_TYPE_RAM)
 			continue;
@@ -852,7 +852,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-	boot_params->hdr.loadflags |= KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		mem_limit = KERNEL_IMAGE_SIZE;
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 3c16092..b3c3a4b 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -54,17 +54,17 @@ bool init_unaccepted_memory(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_ptr);
 	if (et == EFI_TYPE_NONE)
 		return false;
 
-	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	ret = efi_get_conf_table(boot_params_ptr, &cfg_table_pa, &cfg_table_len);
 	if (ret) {
 		warn("EFI config table not found.");
 		return false;
 	}
 
-	table = (void *)efi_find_vendor_table(boot_params, cfg_table_pa,
+	table = (void *)efi_find_vendor_table(boot_params_ptr, cfg_table_pa,
 					      cfg_table_len, guid);
 	if (!table)
 		return false;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index f711f2a..b99e08e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_ptr;
 
 struct port_io_ops pio_ops;
 
@@ -132,8 +132,8 @@ void __putstr(const char *s)
 	if (lines == 0 || cols == 0)
 		return;
 
-	x = boot_params->screen_info.orig_x;
-	y = boot_params->screen_info.orig_y;
+	x = boot_params_ptr->screen_info.orig_x;
+	y = boot_params_ptr->screen_info.orig_y;
 
 	while ((c = *s++) != '\0') {
 		if (c == '\n') {
@@ -154,8 +154,8 @@ void __putstr(const char *s)
 		}
 	}
 
-	boot_params->screen_info.orig_x = x;
-	boot_params->screen_info.orig_y = y;
+	boot_params_ptr->screen_info.orig_x = x;
+	boot_params_ptr->screen_info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb(14, vidport);
@@ -382,14 +382,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	size_t entry_offset;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
-	boot_params = rmode;
+	boot_params_ptr = rmode;
 
 	/* Clear flags intended for solely in-kernel use. */
-	boot_params->hdr.loadflags &= ~KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
-	sanitize_boot_params(boot_params);
+	sanitize_boot_params(boot_params_ptr);
 
-	if (boot_params->screen_info.orig_video_mode == 7) {
+	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -397,8 +397,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params->screen_info.orig_video_lines;
-	cols = boot_params->screen_info.orig_video_cols;
+	lines = boot_params_ptr->screen_info.orig_video_lines;
+	cols = boot_params_ptr->screen_info.orig_video_cols;
 
 	init_default_io_ops();
 
@@ -417,7 +417,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 * so that early debugging output from the RSDP parsing code can be
 	 * collected.
 	 */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	boot_params_ptr->acpi_rsdp_addr = get_rsdp_addr();
 
 	debug_putstr("early console in extract_kernel\n");
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index cc70d3f..c0d502b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 7939eb6..51f957b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -28,7 +28,6 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  */
 unsigned long *trampoline_32bit __section(".data");
 
-extern struct boot_params *boot_params;
 int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
@@ -49,7 +48,7 @@ static unsigned long find_trampoline_placement(void)
 	 *
 	 * Only look for values in the legacy ROM for non-EFI system.
 	 */
-	signature = (char *)&boot_params->efi_info.efi_loader_signature;
+	signature = (char *)&boot_params_ptr->efi_info.efi_loader_signature;
 	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
 	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
 		ebda_start = *(unsigned short *)0x40e << 4;
@@ -65,10 +64,10 @@ static unsigned long find_trampoline_placement(void)
 	bios_start = round_down(bios_start, PAGE_SIZE);
 
 	/* Find the first usable memory region under bios_start. */
-	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+	for (i = boot_params_ptr->e820_entries - 1; i >= 0; i--) {
 		unsigned long new = bios_start;
 
-		entry = &boot_params->e820_table[i];
+		entry = &boot_params_ptr->e820_table[i];
 
 		/* Skip all entries above bios_start. */
 		if (bios_start <= entry->addr)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_ptr = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index dc8c876..9c075b5 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -605,7 +605,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 4ae1433..74d5a17 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -68,6 +68,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
