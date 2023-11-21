Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74087F3618
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjKUSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjKUSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:36:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E012E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:36:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8E8C433C9;
        Tue, 21 Nov 2023 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591813;
        bh=u1Z+uhkAAWZ5rmqaUW2oCllaPTDshYz0d6+Ko3LZvdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FstPSUpxC6bCoYdEGw+0ftTkOH9n+o9k4xcso+Xrb8l8tQGVcojhaAEIIzGs17XMn
         BzP+EQYOWy7UrrOew+ypwZWCIAD6j0j39mMxxOaVNfDokmMESfydlF6/s0KysXtkLr
         Umf2mfbJzUgHIAEuE1SCrpvyPRCfV7fGVhZgj8qW/Y2cEN4xN5u2ncQvLj4Byao35o
         Nyyzms7y11zd9VkV6PgxhMl0zT6RB5F8LBfHpO9R466L+XW2VmEk5JdlX+t3O7n1kJ
         KsHHShrU2fTrpwAxBpSf9QUCdg8jkgZBIrfqM/27zXbLxXvnkDX2e4TyZylZ8ZoY0c
         dADffB1y8tpJA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Tomasz Pala <gotar@polanet.pl>,
        Sebastian Manciulea <manciuleas@protonmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/9] x86/pci: Reword ECAM EfiMemoryMappedIO logging to avoid 'reserved'
Date:   Tue, 21 Nov 2023 12:36:36 -0600
Message-Id: <20231121183643.249006-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

fd3a8cff4d4a ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM
space") added the concept of using the EFI memory map to help decide
whether ECAM space mentioned in the MCFG table is valid.

Unfortunately it described that EfiMemoryMappedIO space as "reserved", but
it is actually not *reserved* by the EFI memory map.  EfiMemoryMappedIO
only means the firmware requested that the OS map this space for use by
firmware runtime services.

Change the dmesg logging to describe it as simply "EfiMemoryMappedIO", not
as "reserved as EfiMemoryMappedIO".  A previous commit actually *does*
reserve the space if ACPI PNP0C01/02 devices haven't done so:

  - PCI: ECAM at [mem 0xe0000000-0xefffffff] reserved as EfiMemoryMappedIO
  + PCI: ECAM at [mem 0xe0000000-0xefffffff] is EfiMemoryMappedIO; assuming valid
    PCI: ECAM [mem 0xe0000000-0xefffffff] reserved to work around lack of ACPI motherboard _CRS

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index e9497ee0f854..64c39a23d37a 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -443,9 +443,11 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 	return mcfg_res.flags;
 }
 
-static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
+static bool is_efi_mmio(struct resource *res)
 {
 #ifdef CONFIG_EFI
+	u64 start = res->start;
+	u64 end = res->start + resource_size(res);
 	efi_memory_desc_t *md;
 	u64 size, mmio_start, mmio_end;
 
@@ -455,11 +457,6 @@ static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
 			mmio_start = md->phys_addr;
 			mmio_end = mmio_start + size;
 
-			/*
-			 * N.B. Caller supplies (start, start + size),
-			 * so to match, mmio_end is the first address
-			 * *past* the EFI_MEMORY_MAPPED_IO area.
-			 */
 			if (mmio_start <= start && end <= mmio_end)
 				return true;
 		}
@@ -543,8 +540,9 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
 
-		if (is_mmconf_reserved(is_efi_mmio, cfg, dev,
-				       "EfiMemoryMappedIO")) {
+		if (is_efi_mmio(&cfg->res)) {
+			pr_info("ECAM %pR is EfiMemoryMappedIO; assuming valid\n",
+				&cfg->res);
 			conflict = insert_resource_conflict(&iomem_resource,
 							    &cfg->res);
 			if (conflict)
-- 
2.34.1

