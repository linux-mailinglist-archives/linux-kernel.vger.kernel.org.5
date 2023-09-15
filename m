Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782577A18D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjIOI3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjIOI3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:29:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EBD2D70;
        Fri, 15 Sep 2023 01:28:30 -0700 (PDT)
Date:   Fri, 15 Sep 2023 08:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694766508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5D+PB2+Xq1bmF0uQFk1Rfk1E0SNjFQGsUKNQTbL8vjI=;
        b=JDhRrZvPCASGh+mPXX31Uw59n5BNE8m1JOk8sf/RCOAwwDfWEH8bRm64VGi2gjCFofzA1W
        4x7tUZtHDp/5Nm2dYCPxEqOy5dlGHLAoqAawzs8MeFczytbdg1dHY6Veo42ftgH/vv7idS
        M/ghNUJr2Ycwfsq5W4FnVJVIVAXjiQdYa80EvMiEsHXk7DbBIi3PpMAIiT6bF/QlvP8XI0
        ltGSwV1RTbGh8KyOtrkO+DEqDYY4ck/XOPTI4/C/wYX9EEOWBxKYdHPq0g1inFBHTJZPs5
        s8mHoK+ZiuHdEecPcYppnuWYqNeMOOfSkDCGOH6ufhUD3NMvdQljg95dSxEQwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694766508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5D+PB2+Xq1bmF0uQFk1Rfk1E0SNjFQGsUKNQTbL8vjI=;
        b=ZBfDrVqjNn6i6tUBnjfmxoWZ0eiBrTM5dWMnPXt9w+Nb6ZACLJP8z1C3Iisim9gaInmaKp
        HIcCObaIkD2FtMBw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/compressed: Reserve more memory for page tables
Cc:     Aaron Lu <aaron.lu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230915070221.10266-1-kirill.shutemov@linux.intel.com>
References: <20230915070221.10266-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169476650726.27769.5534132274690328507.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2768c8ca5cc768568e4dfca291b26caa652127cb
Gitweb:        https://git.kernel.org/tip/2768c8ca5cc768568e4dfca291b26caa652127cb
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 15 Sep 2023 10:02:21 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 10:22:24 +02:00

x86/boot/compressed: Reserve more memory for page tables

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

[ Also add a warning, should this memory run low - by Dave Hansen. ]

Fixes: 34bbb0009f3b ("x86/boot/compressed: Enable 5-level paging during decompression stage")
Reported-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915070221.10266-1-kirill.shutemov@linux.intel.com
---
 arch/x86/boot/compressed/ident_map_64.c |  8 ++++-
 arch/x86/include/asm/boot.h             | 45 ++++++++++++++++--------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bcc956c..08f93b0 100644
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
index 4ae1433..b3a7cfb 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,40 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
+/*
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode:
+ * - 1 level4 table;
+ * - 1 level3 table;
+ * - 4 level2 table that maps everything with 2M pages;
+ *
+ * The additional level5 table needed for 5-level paging is allocated from
+ * trampoline_32bit memory.
+ */
 # define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
+
 /*
- * Assuming all cross the 512GB boundary:
- * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
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
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_PGT_SIZE_WARN	(28*4096)
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
