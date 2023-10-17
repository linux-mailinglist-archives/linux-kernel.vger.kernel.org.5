Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7757CCDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbjJQUZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjJQUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:25:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59989F;
        Tue, 17 Oct 2023 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574330; x=1729110330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+c/mkJRcRl/HTZD+PEVBiG6EmvprrHB2jpk4jFyydb0=;
  b=YOaXpWmqlBQ/fBIZtCORTY+HA8/+90LrE3kyDLgvDrwexUZho+rd1h2P
   wiDFd/Idu9HUrcVy8Wg2/YZJj9vDqzJ9eRxpzonDM7emQKFbWhadXIMjJ
   ct8tPeDXtb6AiSlLpxK6aWwKxLeavr6Sc2fpLfKmCFoENW1SpBMg4fHJI
   eYNWooVl9cXbWr6XlxCEXNL/ihUF0DToa0+qHUjaklJ+cuHv2drrouFL6
   P9G1HH7gHvoKTv9fjBtMVc4OAJ6snuj2m//1pmhqjaWtNh+o8BsNXKjik
   7aV8L3B0Ncx0PT62eW8Wrb3IMwx5kOWgU9e7pL4e1MdF0o87IjIWs6LTS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429487"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429487"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040434"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040434"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:25 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 01/10] mm: Add helper for freeing decrypted memory
Date:   Tue, 17 Oct 2023 13:24:56 -0700
Message-Id: <20231017202505.340906-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeing decrypted memory to the page allocator the memory needs to be
manually re-encrypted beforehand. If this step is skipped, then the next
user of those pages will have the contents inadvertently exposed to
the guest, or cause the guest to crash if the page is used in way
disallowed by HW (i.e. for executable code or as a page table).

Unfortunately, there are many instance of patterns like:
set_memory_encrypted(pages);
free_pages(pages);

...or...

if (set_memory_decrypted(addr, 1))
	free_pages(pages);

This is a problem because set_memory_encrypted() and
set_memory_decrypted() can be failed by the untrusted host in such a way
that an error is returned and the resulting memory is shared.

To aid in a tree-wide cleanup of these callers, add a
free_decrypted_pages() function that will first try to encrypt the pages
before returning them. If it is not successful, have it leak the pages and
warn about this. This is preferable to returning shared pages to allocator
or panicking.

In some cases the code path's for freeing decrypted memory handle both
encrypted and decrypted pages. In this case, rely on set_memory() to
handle being asked to convert memory to the state it is already in.

Going forward, rely on cross-arch callers to find and use
free_decrypted_pages() instead of resorting to more heavy handed solutions
like terminating the guest when nasty VMM behavior is observed.

To make s390's arch set_memory_XXcrypted() definitions available in
linux/set_memory.h, add include for s390's asm version of set_memory.h.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/s390/include/asm/set_memory.h |  1 +
 include/linux/set_memory.h         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 06fbabe2f66c..09d36ebd64b5 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -3,6 +3,7 @@
 #define _ASMS390_SET_MEMORY_H
 
 #include <linux/mutex.h>
+#include <linux/mem_encrypt.h>
 
 extern struct mutex cpa_mutex;
 
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 95ac8398ee72..a898b14b6b1f 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -5,6 +5,8 @@
 #ifndef _LINUX_SET_MEMORY_H_
 #define _LINUX_SET_MEMORY_H_
 
+#include <linux/gfp.h>
+
 #ifdef CONFIG_ARCH_HAS_SET_MEMORY
 #include <asm/set_memory.h>
 #else
@@ -78,4 +80,15 @@ static inline int set_memory_decrypted(unsigned long addr, int numpages)
 }
 #endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
+static inline void free_decrypted_pages(unsigned long addr, int order)
+{
+	int ret = set_memory_encrypted(addr, 1 << order);
+
+	if (ret) {
+		WARN_ONCE(1, "Failed to re-encrypt memory before freeing, leaking pages!\n");
+		return;
+	}
+	free_pages(addr, order);
+}
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.34.1

