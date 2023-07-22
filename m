Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE675DCA3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGVMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGVMmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:42:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE710F4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:42:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so1704384f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690029720; x=1690634520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mzz7+cmo7mG0EjTGePf51Ll6Zdd1gZGMKR3whiCyXs=;
        b=V96TMuxzudRhcGO/ZzQURbancsr5lKEHHBYSmn0kZqALCnTYGBt7N4G1iEsoR+Yekd
         smhceP2BChWnvJEr+/BjRf0ivPk/DG2KEKHi1qne5UgfIa6encaUClnG5uFPUgJMMpOy
         9/PK/doiMTFKxoAp+ChEFoQChQtEyAcPwruDqxliXTg3/1Xx7iFIUpzMaicoRmWe2yLq
         BkxM1RPuaM6PhOBx/1nBLZNffEklYgeyOlvCeowGZ8tFZKTTo41f8B9l5wh+1JfNaMkY
         GYyH7cwskMy6Hzl8UyTMwDzQAPH620WMZjclV58qyllqLw19MGecyPtEzCsYA+rE6X9s
         trBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029720; x=1690634520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mzz7+cmo7mG0EjTGePf51Ll6Zdd1gZGMKR3whiCyXs=;
        b=O3ai2S8wep24B4KF2IN0yB0XliHm9r1qk2n6mcdnhLVvryOoihIkgGSkCIuv0/C6ns
         Dl3sr+IqhDQ5/9s8Dw8kMazyCMK6gdxx9Ix9qM43MlnoGQc0lfAes17SlVpgA/hcjVDa
         Z9AgYf6NglcnRmBbffJJy3nrM0+sPp6e1udKE5EgAvX2oYgm42KV8Kyxo1GDn+jeewEl
         mLhbVd3JCIZXAbss+6lkW25xOZnqSLQXxrrzIs21+wFXlO7fDjELm4SPID5Gc50ROT6g
         GXEUkQoFuTR8NGsO23CAdOT4rl+LeVL921UYWm5+FEOfvhm8cajSnDFYbxh9E06enTPZ
         2CXQ==
X-Gm-Message-State: ABy/qLbfsPAHILP+PqSR1Lw1+u2M721vLDZ5K9pPJ/M+lztxjUbG0AWj
        14h5XDg2f4RXCnbYKAmUL13c7A==
X-Google-Smtp-Source: APBJJlFPWsJ9UUvyXPKGTP406O50bV7Q/6usxZuBSXPnk3Ri0enBPV1j0pOYb37plBHyyigt+Sgy8g==
X-Received: by 2002:a5d:4489:0:b0:313:f38d:555f with SMTP id j9-20020a5d4489000000b00313f38d555fmr3856610wrq.24.1690029719827;
        Sat, 22 Jul 2023 05:41:59 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id r6-20020adff106000000b0031424950a99sm6863986wro.81.2023.07.22.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 05:41:59 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 3/5] arm64: libstub: Move KASLR handling functions to kaslr.c
Date:   Sat, 22 Jul 2023 14:38:48 +0200
Message-Id: <20230722123850.634544-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722123850.634544-1-alexghiti@rivosinc.com>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for riscv to use the same functions to handle the pĥysical
kernel move when KASLR is enabled.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/efi.h              |   2 +
 drivers/firmware/efi/libstub/Makefile     |   2 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
 drivers/firmware/efi/libstub/efistub.h    |   8 ++
 drivers/firmware/efi/libstub/kaslr.c      | 159 ++++++++++++++++++++++
 5 files changed, 183 insertions(+), 105 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/kaslr.c

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 4cf2cb053bc8..46273ee89445 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -168,4 +168,6 @@ static inline void efi_capsule_flush_cache_range(void *addr, int size)
 
 efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f);
 
+void efi_icache_sync(unsigned long start, unsigned long end);
+
 #endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 16d64a34d1e1..11aba8a041ec 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,7 +86,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 				   screen_info.o efi-stub-entry.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
-lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o smbios.o
+lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 770b8ecb7398..452b7ccd330e 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -14,42 +14,6 @@
 
 #include "efistub.h"
 
-/*
- * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
- * to provide space, and fail to zero it). Check for this condition by double
- * checking that the first and the last byte of the image are covered by the
- * same EFI memory map entry.
- */
-static bool check_image_region(u64 base, u64 size)
-{
-	struct efi_boot_memmap *map;
-	efi_status_t status;
-	bool ret = false;
-	int map_offset;
-
-	status = efi_get_memory_map(&map, false);
-	if (status != EFI_SUCCESS)
-		return false;
-
-	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
-		efi_memory_desc_t *md = (void *)map->map + map_offset;
-		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
-
-		/*
-		 * Find the region that covers base, and return whether
-		 * it covers base+size bytes.
-		 */
-		if (base >= md->phys_addr && base < end) {
-			ret = (base + size) <= end;
-			break;
-		}
-	}
-
-	efi_bs_call(free_pool, map);
-
-	return ret;
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
@@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 {
 	efi_status_t status;
 	unsigned long kernel_size, kernel_codesize, kernel_memsize;
-	u32 phys_seed = 0;
-	u64 min_kimg_align = efi_get_kimg_min_align();
-
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
-		void *p;
-
-		if (efi_nokaslr) {
-			efi_info("KASLR disabled on kernel command line\n");
-		} else if (efi_bs_call(handle_protocol, image_handle,
-				       &li_fixed_proto, &p) == EFI_SUCCESS) {
-			efi_info("Image placement fixed by loader\n");
-		} else {
-			status = efi_get_random_bytes(sizeof(phys_seed),
-						      (u8 *)&phys_seed);
-			if (status == EFI_NOT_FOUND) {
-				efi_info("EFI_RNG_PROTOCOL unavailable\n");
-				efi_nokaslr = true;
-			} else if (status != EFI_SUCCESS) {
-				efi_err("efi_get_random_bytes() failed (0x%lx)\n",
-					status);
-				efi_nokaslr = true;
-			}
-		}
-	}
 
 	if (image->image_base != _text) {
 		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
@@ -98,50 +37,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	kernel_codesize = __inittext_end - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
 	*reserve_size = kernel_memsize;
+	*image_addr = (unsigned long)_text;
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
-		/*
-		 * If KASLR is enabled, and we have some randomness available,
-		 * locate the kernel at a randomized offset in physical memory.
-		 */
-		status = efi_random_alloc(*reserve_size, min_kimg_align,
-					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE);
-		if (status != EFI_SUCCESS)
-			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
-	} else {
-		status = EFI_OUT_OF_RESOURCES;
-	}
-
-	if (status != EFI_SUCCESS) {
-		if (!check_image_region((u64)_text, kernel_memsize)) {
-			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
-		} else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
-			   (u64)_end < EFI_ALLOC_LIMIT) {
-			/*
-			 * Just execute from wherever we were loaded by the
-			 * UEFI PE/COFF loader if the placement is suitable.
-			 */
-			*image_addr = (u64)_text;
-			*reserve_size = 0;
-			return EFI_SUCCESS;
-		}
-
-		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align,
-						    EFI_LOADER_CODE);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to relocate kernel\n");
-			*reserve_size = 0;
-			return status;
-		}
-	}
-
-	*image_addr = *reserve_addr;
-	memcpy((void *)*image_addr, _text, kernel_size);
-	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
-	efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
+	status = efi_kaslr_relocate_kernel(image_addr,
+					   reserve_addr, reserve_size,
+					   kernel_size, kernel_codesize,
+					   kernel_memsize,
+					   efi_kaslr_get_phys_seed(image_handle));
+	if (status != EFI_SUCCESS)
+		return status;
 
 	return EFI_SUCCESS;
 }
@@ -159,3 +63,8 @@ unsigned long primary_entry_offset(void)
 	 */
 	return (char *)primary_entry - _text;
 }
+
+void efi_icache_sync(unsigned long start, unsigned long end)
+{
+	caches_clean_inval_pou(start, end);
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6aa38a1bf126..b1a1037567ba 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1132,6 +1132,14 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
 
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
+efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
+				       unsigned long *reserve_addr,
+				       unsigned long *reserve_size,
+				       unsigned long kernel_size,
+				       unsigned long kernel_codesize,
+				       unsigned long kernel_memsize,
+				       u32 phys_seed);
+u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
 
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
new file mode 100644
index 000000000000..be0c8ab0982a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper functions used by the EFI stub on multiple
+ * architectures to deal with physical address space randomization.
+ */
+#include <linux/efi.h>
+
+#include "efistub.h"
+
+/**
+ * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KASLR
+ * @image_handle:	Handle to the image
+ *
+ * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOCOL
+ * that will be used to move the kernel physical mapping.
+ *
+ * Return:	the random seed
+ */
+u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
+{
+	efi_status_t status;
+	u32 phys_seed;
+	efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
+	void *p;
+
+	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return 0;
+
+	if (efi_nokaslr) {
+		efi_info("KASLR disabled on kernel command line\n");
+	} else if (efi_bs_call(handle_protocol, image_handle,
+			       &li_fixed_proto, &p) == EFI_SUCCESS) {
+		efi_info("Image placement fixed by loader\n");
+	} else {
+		status = efi_get_random_bytes(sizeof(phys_seed),
+					      (u8 *)&phys_seed);
+		if (status == EFI_SUCCESS) {
+			return phys_seed;
+		} else if (status == EFI_NOT_FOUND) {
+			efi_info("EFI_RNG_PROTOCOL unavailable\n");
+			efi_nokaslr = true;
+		} else if (status != EFI_SUCCESS) {
+			efi_err("efi_get_random_bytes() failed (0x%lx)\n",
+				status);
+			efi_nokaslr = true;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
+ * to provide space, and fail to zero it). Check for this condition by double
+ * checking that the first and the last byte of the image are covered by the
+ * same EFI memory map entry.
+ */
+static bool check_image_region(u64 base, u64 size)
+{
+	struct efi_boot_memmap *map;
+	efi_status_t status;
+	bool ret = false;
+	int map_offset;
+
+	status = efi_get_memory_map(&map, false);
+	if (status != EFI_SUCCESS)
+		return false;
+
+	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
+		efi_memory_desc_t *md = (void *)map->map + map_offset;
+		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
+
+		/*
+		 * Find the region that covers base, and return whether
+		 * it covers base+size bytes.
+		 */
+		if (base >= md->phys_addr && base < end) {
+			ret = (base + size) <= end;
+			break;
+		}
+	}
+
+	efi_bs_call(free_pool, map);
+
+	return ret;
+}
+
+/**
+ * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR enabled)
+ * @image_addr: Pointer to the current kernel location
+ * @reserve_addr:	Pointer to the relocated kernel location
+ * @reserve_size:	Size of the relocated kernel
+ * @kernel_size:	Size of the text + data
+ * @kernel_codesize:	Size of the text
+ * @kernel_memsize:	Size of the text + data + bss
+ * @phys_seed:		Random seed used for the relocation
+ *
+ * If KASLR is not enabled, this function relocates the kernel to a fixed
+ * address (or leave it as its current location). If KASLR is enabled, the
+ * kernel physical location is randomized using the seed in parameter.
+ *
+ * Return:	status code, EFI_SUCCESS if relocation is successful
+ */
+efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
+				       unsigned long *reserve_addr,
+				       unsigned long *reserve_size,
+				       unsigned long kernel_size,
+				       unsigned long kernel_codesize,
+				       unsigned long kernel_memsize,
+				       u32 phys_seed)
+{
+	efi_status_t status;
+	u64 min_kimg_align = efi_get_kimg_min_align();
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
+		/*
+		 * If KASLR is enabled, and we have some randomness available,
+		 * locate the kernel at a randomized offset in physical memory.
+		 */
+		status = efi_random_alloc(*reserve_size, min_kimg_align,
+					  reserve_addr, phys_seed,
+					  EFI_LOADER_CODE);
+		if (status != EFI_SUCCESS)
+			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
+	} else {
+		status = EFI_OUT_OF_RESOURCES;
+	}
+
+	if (status != EFI_SUCCESS) {
+		if (!check_image_region(*image_addr, kernel_memsize)) {
+			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
+		} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
+			   (u64)_end < EFI_ALLOC_LIMIT) {
+			/*
+			 * Just execute from wherever we were loaded by the
+			 * UEFI PE/COFF loader if the placement is suitable.
+			 */
+			*reserve_size = 0;
+			return EFI_SUCCESS;
+		}
+
+		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
+						    ULONG_MAX, min_kimg_align,
+						    EFI_LOADER_CODE);
+
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to relocate kernel\n");
+			*reserve_size = 0;
+			return status;
+		}
+	}
+
+	memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
+	*image_addr = *reserve_addr;
+	efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
+	efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
+
+	return status;
+}
-- 
2.39.2

