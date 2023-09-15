Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588D67A16CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjIOHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjIOHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:02:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C4EB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694761360; x=1726297360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0kZ/AIc+rsmCS2PWVznIgM2tf3amxnRp/LSICst2bU=;
  b=ihBCXYk2bDyBJ5XrP2MqKmI1T8uJyplywH+dDbmNPP3STyea/VzsflT2
   UuKrcXghwG1OkWIf0VNgDqJDG6EIQKRf+ruFwhq9JBnKK065g+OoKbvgk
   IJLtE7T1i44C31Q01BoZMkYFfMUYR2XbJrv2RvJxJ8PCCFHLPNz2qrN1j
   xm3bi7/Zi0aAbL4ZZelskp4cuRjd948o66KUcfN54JAU0RJVxiL2reoWZ
   Nur4gqXXesIuKKsI3nawYfzUCtoZNt4wUumKhwdKtyYIc0IxvYYSus8a5
   SW/hiPdOdPjls4MkfWdoGMAePvrFG4OD3N25krUvjnrnQepwD+kYUJLhh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443244754"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="443244754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 00:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="835091524"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="835091524"
Received: from gcecchi-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 00:02:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C7E1F1099B8; Fri, 15 Sep 2023 10:02:27 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com
Cc:     kirill.shutemov@linux.intel.com, aaron.lu@intel.com,
        ardb@google.com, bagasdotme@gmail.com, bp@alien8.de,
        keescook@chromium.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.de,
        tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: [PATCHv2] x86/boot/compressed: Reserve more memory for page tables
Date:   Fri, 15 Sep 2023 10:02:21 +0300
Message-ID: <20230915070221.10266-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914170726.4am7xi36m4hdgiyk@box>
References: <20230914170726.4am7xi36m4hdgiyk@box>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decompressor has a hard limit on the number of page tables it can
allocate. This limit is defined at compile-time and will cause boot
failure if it is reached.

The kernel is very strict and calculates the limit precisely for the
worst-case scenario based on the current configuration. However, it is
easy to forget to adjust the limit when a new use-case arises. The
worst-case scenario is rarely encountered during sanity checks.

In the case of enabling 5-level paging, a use-case was overlooked. The
limit needs to be increased by one to accommodate the additional level.
This oversight went unnoticed until Aaron attempted to run the kernel
via kexec with 5-level paging and unaccepted memory enabled.

Update wost-case calculations to include 5-level paging.

To address this issue, let's allocate some extra space for page tables.
128K should be sufficient for any use-case. The logic can be simplified
by using a single value for all kernel configurations.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Aaron Lu <aaron.lu@intel.com>
Fixes: 34bbb0009f3b ("x86/boot/compressed: Enable 5-level paging during decompression stage")
---
 arch/x86/boot/compressed/ident_map_64.c |  8 +++++
 arch/x86/include/asm/boot.h             | 47 +++++++++++++++++--------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bcc956c17872..08f93b0401bb 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -59,6 +59,14 @@ static void *alloc_pgt_page(void *context)
 		return NULL;
 	}
 
+	/* Consumed more tables than expected? */
+	if (pages->pgt_buf_offset == BOOT_PGT_SIZE_WARN) {
+		debug_putstr("pgt_buf running low in " __FILE__ "\n");
+		debug_putstr("Need to raise BOOT_PGT_SIZE?\n");
+		debug_putaddr(pages->pgt_buf_offset);
+		debug_putaddr(pages->pgt_buf_size);
+	}
+
 	entry = pages->pgt_buf + pages->pgt_buf_offset;
 	pages->pgt_buf_offset += PAGE_SIZE;
 
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..215d37f7dde8 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,40 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
-# define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
 /*
- * Assuming all cross the 512GB boundary:
- * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode:
+ * - 1 level4 table;
+ * - 1 level3 table;
+ * - 4 level2 table that maps everything with 2M pages;
+ *
+ * The additional level5 table needed for 5-level paging is allocated from
+ * trampoline_32bit memory.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_INIT_PGT_SIZE	(6*4096)
+
+/*
+ * Total number of page tables kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
+ *
+ * Worst-case scenario:
+ *  - 5-level paging needs 1 level5 table;
+ *  - KASLR needs to map kernel, boot_params, cmdline and randomized kernel,
+ *    assuming all of them cross 256T boundary:
+ *    + 4*2 level4 table;
+ *    + 4*2 level3 table;
+ *    + 4*2 level2 table;
+ *  - X86_VERBOSE_BOOTUP needs to map the first 2M (video RAM):
+ *    + 1 level4 table;
+ *    + 1 level3 table;
+ *    + 1 level2 table;
+ * Total: 28 tables
+ *
+ * Add 4 spare table in case decompressor touches anything beyond what is
+ * accounted above. Warn if it happens.
+ */
+# define BOOT_PGT_SIZE_WARN	(28*4096)
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
-- 
2.41.0

