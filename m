Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA677B0AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjI0RAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0RAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:32 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB8DE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:30 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a803afa8c5so4210515241.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834029; x=1696438829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DmNFRxVXj8V3ocvjWMiRzGtl0URBCJyLqRyOWHwpdo=;
        b=niJ9TK3uHDTUJRdvlpKeb3J6E/u8VUuejYA4zVl6fdbZ14/GtVkfjfZrbqXKXPgKWB
         r0Zfh6MhJBIUv+FTFtqwUPjV2XK6J0vvFz0fPLtAHJTKRxSro5Bua7Yv4mRNq5x3pM84
         8TQwCtPbaHHpQhyyCaUyjKWILwzvj2sKcH6dPBYpZhwgJQuvfKwmwXtduUviKNckhqfy
         jC9ic3wQF15av0ptoptrTRPaldBKvIN6sJp7BzCebmXqAy4wElQcWTNZh1c0ZFtpteoA
         vpNy1p86b/LOZX9b4ZTGc0ffr78SDR0LFuaW+v5fpl59sT/f4WU7kHHp4oPAiGB9I0xy
         wamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834029; x=1696438829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DmNFRxVXj8V3ocvjWMiRzGtl0URBCJyLqRyOWHwpdo=;
        b=CzENp1vCtrtvXmqzcXVvCIpOc4kZDS/j8BXzFAs0pw5uMAP7nhRtxMK+q4vmvzRhI6
         gTa/UyF8pCgCWrBnhPjJV3xdu3b7JqAXqI/uXoix40Qhjmpnf35QQ0mRAoyYbDaJoeap
         IQYfdjXuiFiPzVicJsKx6Hdx6DPdJlHXsRNMxDbzzuB3pjhC4Trb38JS7WGN8iX+IFMS
         a3DsNUUfVUCtqK6h8kff2bJNuoiCfm1+6G/UN3vRHuAddANVL6HoagdJFDcyWFntrhkb
         F44GBuDcGiC74ZsZSjXZD58ij1YcYyNaND2C/75GEJa9zjhl57XK0pSNF1DN5P8A+CEC
         /3Rg==
X-Gm-Message-State: AOJu0Yywn0ty7muO4AEF08npjbyXmQOn6r2u9z9rvcZs5uQ1Y65r3TKR
        OauU8eTww8Ng9Sk+znlU6ODngQ==
X-Google-Smtp-Source: AGHT+IGBgFPJjICylrMDS7JPEnRZuaEEh3Sec+u6/LbCPif/YPGepNKpytUBblydLbUQWx1xQGW8Jw==
X-Received: by 2002:a67:f98f:0:b0:452:81c4:3b56 with SMTP id b15-20020a67f98f000000b0045281c43b56mr2534411vsq.18.1695834028193;
        Wed, 27 Sep 2023 10:00:28 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:27 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 1/4] RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
Date:   Wed, 27 Sep 2023 22:30:12 +0530
Message-Id: <20230927170015.295232-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927170015.295232-1-sunilvl@ventanamicro.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance the acpi_os_ioremap() to support opregions in MMIO space. Also,
have strict checks using EFI memory map to allow remapping the RAM similar
to arm64.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/Kconfig       |  1 +
 arch/riscv/kernel/acpi.c | 87 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..ac039cf8af7a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
+	select ARCH_KEEP_MEMBLOCK
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 56cb2c986c48..e619edc8b0cc 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -14,9 +14,10 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 #include <linux/pci.h>
-#include <linux/efi.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -217,7 +218,89 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 
 void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 {
-	return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
+	efi_memory_desc_t *md, *region = NULL;
+	pgprot_t prot;
+
+	if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
+		return NULL;
+
+	for_each_efi_memory_desc(md) {
+		u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
+
+		if (phys < md->phys_addr || phys >= end)
+			continue;
+
+		if (phys + size > end) {
+			pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
+			return NULL;
+		}
+		region = md;
+		break;
+	}
+
+	/*
+	 * It is fine for AML to remap regions that are not represented in the
+	 * EFI memory map at all, as it only describes normal memory, and MMIO
+	 * regions that require a virtual mapping to make them accessible to
+	 * the EFI runtime services.
+	 */
+	prot = PAGE_KERNEL_IO;
+	if (region) {
+		switch (region->type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+		case EFI_PERSISTENT_MEMORY:
+			if (memblock_is_map_memory(phys) ||
+			    !memblock_is_region_memory(phys, size)) {
+				pr_warn(FW_BUG "requested region covers kernel memory\n");
+				return NULL;
+			}
+
+			/*
+			 * Mapping kernel memory is permitted if the region in
+			 * question is covered by a single memblock with the
+			 * NOMAP attribute set: this enables the use of ACPI
+			 * table overrides passed via initramfs.
+			 * This particular use case only requires read access.
+			 */
+			fallthrough;
+
+		case EFI_RUNTIME_SERVICES_CODE:
+			/*
+			 * This would be unusual, but not problematic per se,
+			 * as long as we take care not to create a writable
+			 * mapping for executable code.
+			 */
+			prot = PAGE_KERNEL_RO;
+			break;
+
+		case EFI_ACPI_RECLAIM_MEMORY:
+			/*
+			 * ACPI reclaim memory is used to pass firmware tables
+			 * and other data that is intended for consumption by
+			 * the OS only, which may decide it wants to reclaim
+			 * that memory and use it for something else. We never
+			 * do that, but we usually add it to the linear map
+			 * anyway, in which case we should use the existing
+			 * mapping.
+			 */
+			if (memblock_is_map_memory(phys))
+				return (void __iomem *)__va(phys);
+			fallthrough;
+
+		default:
+			if (region->attribute & EFI_MEMORY_WB)
+				prot = PAGE_KERNEL;
+			else if ((region->attribute & EFI_MEMORY_WC) ||
+				 (region->attribute & EFI_MEMORY_WT))
+				prot = pgprot_writecombine(PAGE_KERNEL);
+		}
+	}
+
+	return ioremap_prot(phys, size, pgprot_val(prot));
 }
 
 #ifdef CONFIG_PCI
-- 
2.39.2

