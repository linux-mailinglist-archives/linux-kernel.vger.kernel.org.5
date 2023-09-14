Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7777A03DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbjINMaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjINMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:30:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA941FC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694694614; x=1726230614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sR+zT73wsMXErBcopbNqQMDJkeQDLlNb2UdQEZ/50wo=;
  b=lMk3VF2KstfTpOOmA7aKxNZIgVC8sObX2ZsrKHAU83Q0jFF9KwgZP134
   +2hbuzEkiXvkG2XScWY5ZVnxiGmbjxRZDBGb5rVNlmJnupI4W8R4g2UfX
   6I6YLMIbOKyhmKRSDcEsiXbBOplK2Qy7DQMrdDW6spGbb9NFBaMT59g0Q
   fJqd4+gbQ/gw/9Sxbw10zQq3I2CfkIPXcJaTmu2WFvpihcj5cGN50wRTh
   TwY9JsXi8V5SJj6YTJcjGASheeuLRgDFgt7ILjFzWWNqsLA27AfpDETRE
   523dvp1wZB27coYZ3pB8qq1iqkvMH545BeLp/Pg9JnkdL4SIkKpr+C87a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363972229"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="363972229"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 05:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747708268"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="747708268"
Received: from njayagop-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 05:30:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E3769109D89; Thu, 14 Sep 2023 15:30:07 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.de,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/compressed: Reserve more memory for page tables
Date:   Thu, 14 Sep 2023 15:30:01 +0300
Message-ID: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

To address this issue, let's allocate some extra space for page tables.
128K should be sufficient for any use-case. The logic can be simplified
by using a single value for all kernel configurations.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Aaron Lu <aaron.lu@intel.com>
Fixes: 34bbb0009f3b ("x86/boot/compressed: Enable 5-level paging during decompression stage")
---
 arch/x86/include/asm/boot.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..aaf1b2fc6ede 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,20 @@
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
+ * mapping of the 4G of RAM in 4-level paging mode.
+ *
+ * The additional page table needed for 5-level paging is allocated from
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
+ * Total number of page table kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
+ */
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
-- 
2.41.0

