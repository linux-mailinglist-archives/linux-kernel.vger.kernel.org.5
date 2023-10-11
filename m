Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA17C4D27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbjJKIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345300AbjJKIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:30:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CEA4;
        Wed, 11 Oct 2023 01:30:13 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:30:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697013012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSPBuAm80ZxoUwzuH9kINz5WfE0OV6AFLUrvEvTJ2c8=;
        b=P11B6y3tYJhmTerCnLZmv2BP8WSnNFbrBTWxENza2fXI13zscUH174BqYVJKxaN71OQ5Ir
        vdFkRSTqXgbjObq7M0HBpodbtCeEF/4DjADp17C4vEp+bHU1TyPinW8zp7tE2UWDN7NtY3
        9mgGTmsiljwqTHpvaLy5UDmAxaWwqvmJN6nzV6zm+HRHmFKIYjAjEiBv0B0XzNZHn72dqw
        a8QCSOqYZfIVD8UrrHiPmVmZdv8WD5mPkpMnpptXrEqVhRyp4TCL6EZbsf0JrihEUhRLlb
        F7CrbaJWUoZR/n8FvdO5cS1ETBAULmfQc8vB2OAjDZpSLcKE5q1YOsoopnp20w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697013012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSPBuAm80ZxoUwzuH9kINz5WfE0OV6AFLUrvEvTJ2c8=;
        b=F6TdGmDl9cgQ9O0gROg55QFDyPdHeLeMcxPz/jKXIgpSPuDLbthVuqTeczU9PGkogOYYXn
        syayGUjHe6u5uNCg==
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev: Move sev_setup_arch() to mem_encrypt.c
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010145220.3960055-2-alexander.shishkin@linux.intel.com>
References: <20231010145220.3960055-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169701301155.3135.15738501380783422700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6e74b125155dc8c747d76fb45d8e6d20e9e4fb4d
Gitweb:        https://git.kernel.org/tip/6e74b125155dc8c747d76fb45d8e6d20e9e4fb4d
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 10 Oct 2023 17:52:19 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Oct 2023 10:15:47 +02:00

x86/sev: Move sev_setup_arch() to mem_encrypt.c

Since commit:

  4d96f9109109b ("x86/sev: Replace occurrences of sev_active() with cc_platform_has()")

... the SWIOTLB bounce buffer size adjustment and restricted virtio memory
setting also inadvertently apply to TDX: the code is using
cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) as a gatekeeping condition,
which is also true for TDX, and this is also what we want.

To reflect this, move the corresponding code to generic mem_encrypt.c.

No functional changes intended.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20231010145220.3960055-2-alexander.shishkin@linux.intel.com
---
 arch/x86/include/asm/mem_encrypt.h |  4 +--
 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/mm/mem_encrypt.c          | 34 ++++++++++++++++++++++++++++-
 arch/x86/mm/mem_encrypt_amd.c      | 35 +-----------------------------
 4 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 473b16d..359ada4 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -19,8 +19,10 @@
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
+void __init mem_encrypt_setup_arch(void);
 #else
 static inline void mem_encrypt_init(void) { }
+static inline void __init mem_encrypt_setup_arch(void) { }
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -43,7 +45,6 @@ void __init sme_map_bootdata(char *real_mode_data);
 void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
-void __init sev_setup_arch(void);
 
 void __init sme_encrypt_kernel(struct boot_params *bp);
 void __init sme_enable(struct boot_params *bp);
@@ -73,7 +74,6 @@ static inline void __init sme_map_bootdata(char *real_mode_data) { }
 static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
-static inline void __init sev_setup_arch(void) { }
 
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b9145a6..ec44dc5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1124,7 +1124,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Needs to run after memblock setup because it needs the physical
 	 * memory size.
 	 */
-	sev_setup_arch();
+	mem_encrypt_setup_arch();
 
 	efi_fake_memmap();
 	efi_find_mirror();
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f27e14..c290c55 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -12,6 +12,7 @@
 #include <linux/swiotlb.h>
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
+#include <linux/virtio_anchor.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
@@ -86,3 +87,36 @@ void __init mem_encrypt_init(void)
 
 	print_mem_encrypt_feature_info();
 }
+
+void __init mem_encrypt_setup_arch(void)
+{
+	phys_addr_t total_mem = memblock_phys_mem_size();
+	unsigned long size;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
+	 * Kernel uses SWIOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB using a percentage of guest
+	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
+	 * memory is allocated from low memory, ensure that the adjusted size
+	 * is within the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers
+	 * is more of an approximation of the static adjustment which
+	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = total_mem * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	swiotlb_adjust_size(size);
+
+	/* Set restricted memory access for virtio. */
+	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
+}
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 6faea41..62dde75 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -20,7 +20,6 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
-#include <linux/virtio_anchor.h>
 #include <linux/cc_platform.h>
 
 #include <asm/tlbflush.h>
@@ -215,40 +214,6 @@ void __init sme_map_bootdata(char *real_mode_data)
 	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
 }
 
-void __init sev_setup_arch(void)
-{
-	phys_addr_t total_mem = memblock_phys_mem_size();
-	unsigned long size;
-
-	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return;
-
-	/*
-	 * For SEV, all DMA has to occur via shared/unencrypted pages.
-	 * SEV uses SWIOTLB to make this happen without changing device
-	 * drivers. However, depending on the workload being run, the
-	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
-	 * run out of buffers for DMA, resulting in I/O errors and/or
-	 * performance degradation especially with high I/O workloads.
-	 *
-	 * Adjust the default size of SWIOTLB for SEV guests using
-	 * a percentage of guest memory for SWIOTLB buffers.
-	 * Also, as the SWIOTLB bounce buffer memory is allocated
-	 * from low memory, ensure that the adjusted size is within
-	 * the limits of low available memory.
-	 *
-	 * The percentage of guest memory used here for SWIOTLB buffers
-	 * is more of an approximation of the static adjustment which
-	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
-	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
-	swiotlb_adjust_size(size);
-
-	/* Set restricted memory access for virtio. */
-	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
-}
-
 static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 {
 	unsigned long pfn = 0;
