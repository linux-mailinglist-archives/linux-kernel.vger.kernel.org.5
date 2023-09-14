Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290057A072C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjINOWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbjINOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:22:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62541D7;
        Thu, 14 Sep 2023 07:22:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694701347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o44G06hAJziml8pp0cuaTUEtEYfmyNkmKHXY38oO1WM=;
        b=RMsZxdwU0Mj2Rk539pjdzWvKAWrCLvdESw/Ncy+zz5ApNm2i8NPsi+zszMmwSlECgrJVH8
        8Rxw+bTSsZn6+ovHmIiVsY63EW4CYfv41MIdeMgHn8sCTHm4bz7hxI0E8o7LNeRvF9ajYn
        v9xmKMsz98ujOa21UPVWO4n4RFVRzjvOEFgST6CC1MxFmQGUdbDXJYjW0qGGtxtEABHDbc
        P6fAs6DZ5+Pb7XUhnD8lBpdfTs/C58c7DceCviY9GaXQDUVQgofovCXKmuS4ND2PvX8QKZ
        TTrymiRZok1/8kdGMXeyBK70icWTshGIPuITKxI2CJD5l+A/IoVnVdp4UVquEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694701347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o44G06hAJziml8pp0cuaTUEtEYfmyNkmKHXY38oO1WM=;
        b=Ho8CWlgGmZiQAYPycuqAmvGz+WOk7HTNgg87JaqsLjE9UPyG8/YVucIgUO+uC11fu+b3/K
        NruSPm/CozCYutCw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/compressed: Reserve more memory for page tables
Cc:     Aaron Lu <aaron.lu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
References: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169470134628.27769.10667514395726055409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7362132a6408d23244b95025ea85dd3dc41e5332
Gitweb:        https://git.kernel.org/tip/7362132a6408d23244b95025ea85dd3dc41e5332
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Thu, 14 Sep 2023 15:30:01 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 14 Sep 2023 16:12:28 +02:00

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

To address this issue, let's allocate some extra space for page tables.
128K should be sufficient for any use-case. The logic can be simplified
by using a single value for all kernel configurations.

Fixes: 34bbb0009f3b ("x86/boot/compressed: Enable 5-level paging during decompression stage")
Reported-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230914123001.27659-1-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/boot.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 4ae1433..d2caae2 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,20 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
+/*
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode.
+ *
+ * The additional page table needed for 5-level paging is allocated from
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
+ * Total number of page table kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
