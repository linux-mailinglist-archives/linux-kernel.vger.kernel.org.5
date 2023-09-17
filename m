Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1357A342C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjIQHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjIQHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:54:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56473191;
        Sun, 17 Sep 2023 00:54:49 -0700 (PDT)
Date:   Sun, 17 Sep 2023 07:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694937287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+Xt67ikLSJQkDZ5RHaKRKUGeO9dxXKuGY9TkbnvghE=;
        b=GDIA0CxQcYVzG86kFCa4cUx3CAjIaYc+wSrEJhg6NefAvm8SB6hHxrkNGph+mv+pqOFsmr
        c9xQ+OeD1W+GHw87pUZi4RczNmxMOWnB822TfK3jECGTlckpIQ2YCbxkxPqcRNxLPTHcay
        8JFnu+15uTnR0CZ6eY/7fHQmMjjdrH8SRL1ZAdjVumaUK6F2QqEMuBPFQiO8r5eCeKvmlj
        caH0oa4HnDn7LGP8rakch1ZEmgYKJNMyWrkzUi6PExrWOby+aWD4A934DzXk2ewmg6uQO7
        s7KHQmehuXR27sXgAQRGqHCvKl79SF41pDPICs/0meGWbpqPbqe6q9RAtnrGcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694937287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+Xt67ikLSJQkDZ5RHaKRKUGeO9dxXKuGY9TkbnvghE=;
        b=Ii7cn8pfqoeq3Gm4afMMmAhf4zhaP41kEDCE7cNlWHFCBqUj/O9gSMhqusEvlrhX3bO8EE
        URsWJvUwZ+Wk8qBA==
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
Message-ID: <169493728726.27769.6657332180593925239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f530ee95b72e77b09c141c4b1a4b94d1199ffbd9
Gitweb:        https://git.kernel.org/tip/f530ee95b72e77b09c141c4b1a4b94d1199ffbd9
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 15 Sep 2023 10:02:21 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 09:48:57 +02:00

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
