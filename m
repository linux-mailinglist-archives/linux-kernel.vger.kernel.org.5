Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678407BFFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjJJOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjJJOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:52:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641C9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696949557; x=1728485557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N8GHrbB+g3J2bwdOgOKJfQNmUYYlh1BLqqQjCEAYP58=;
  b=HhG5EgdaI+bR075NBLi08GvlDR8hMroi5qjJbsaZxB7Lt6T3yZseRxnh
   gyYhTnVI2jmSWzpcddofBdZh9H/LLbdtUyWEeIqLPLTuimnMiUTMOwE8g
   dVgdHjB4jLBT7F1aDl7UhtSxGt9yWDYYMxF4TVFiJrRtXYRQFe85q0i3r
   RCJGl12TfakGJfMciQnPw1pctX5Jy6wYY8GeIRoLpTsYdX1nZveXrAn4B
   d6JZ4KltsMs203PMfZ7kUGuCsMPfhN5HLgAbmhYU3tj9e6pNHkE9hf2uZ
   TWPdNSNHGpo4y3N33BYaeGJDsHhFaSOYWaxuwkxPcC2uGNa5aBwQQkQMW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374763965"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374763965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788609435"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="788609435"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 07:52:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 1/2] x86/sev: Move sev_setup_arch() to mem_encrypt.c
Date:   Tue, 10 Oct 2023 17:52:19 +0300
Message-Id: <20231010145220.3960055-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
References: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4d96f9109109b ("x86/sev: Replace occurrences of
sev_active() with cc_platform_has()"), the SWIOTLB bounce buffer size
adjustment and restricted virtio memory setting also inadvertently apply
to TDX: the code is using cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) as
a gatekeeping condition, which is also true for TDX, and this is also what
we want.

To reflect this, move the corresponding code to generic mem_encrypt.c.
No functional changes intended.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/include/asm/mem_encrypt.h |  4 ++--
 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/mm/mem_encrypt.c          | 34 +++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c      | 35 ------------------------------
 4 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 473b16d73b47..359ada486fa9 100644
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
index 3e05ecf8cf8d..ccd3ad29a1dc 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1120,7 +1120,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Needs to run after memblock setup because it needs the physical
 	 * memory size.
 	 */
-	sev_setup_arch();
+	mem_encrypt_setup_arch();
 
 	efi_fake_memmap();
 	efi_find_mirror();
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f27e14e185f..c290c55b632b 100644
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
index 6faea41e99b6..62dde75d41fa 100644
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
-- 
2.40.1

