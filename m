Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8697CCDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbjJQUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjJQUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:25:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A61BA;
        Tue, 17 Oct 2023 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574330; x=1729110330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcF+O4qhVSDzWKyOPqIfGB0MPXeZPkkPdOYMfsrWVF0=;
  b=OYVqzXze13qHqoLPgXrwAY1F5UxX6jgrbXAmmnmxbiLJ497jgzMcTWai
   qdfXq9pVmhPDreyTj+WhdVcVJbiNHTjkWvtY4A42/tsaxBTH3dWVjAyLJ
   QOjIy5W2LYnxzuRil79sygRtMcYlD35iD5q3QnbirkaXZOIY8Fbg7KRpR
   Jyjo8LefcxdAvOK6Vf2/e61NIEgGUaiwgNoDxdgRpbyfigYnKkWYlCdeS
   LQnAKXfH5Cv6BGjiMZU1iKfnAJ9EtAEyB2n3c1mLV5NyKFOn867eZ8bSo
   ka3u0mYopThZlRF0EUZoWqoNxDMIJISGlbLVgdu6N0ZlMYgFR0HxlaXZx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429498"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040438"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040438"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:27 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 02/10] x86/mm/cpa: Reject incorrect encryption change requests
Date:   Tue, 17 Oct 2023 13:24:57 -0700
Message-Id: <20231017202505.340906-3-rick.p.edgecombe@intel.com>
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

Kernel memory is "encrypted" by default.  Some callers may "decrypt" it
in order to share it with things outside the kernel like a device or an
untrusted VMM.

There is nothing to stop set_memory_encrypted() from being passed memory
that is already "encrypted" (aka. "private" on TDX).  In fact, some
callers do this because ... $REASONS.  Unfortunately, part of the TDX
decrypted=>encrypted transition is truly one way*.  It can't handle
being asked to encrypt an already encrypted page

Allow __set_memory_enc_pgtable() to detect already-encrypted memory
before it hits the TDX code.

* The one way part is "page acceptance"

[commit log written by Dave Hansen]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/mm/pat/set_memory.c | 41 +++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..1238b0db3e33 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2122,6 +2122,21 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
+static bool kernel_vaddr_encryped(unsigned long addr, bool enc)
+{
+	unsigned int level;
+	pte_t *pte;
+
+	pte = lookup_address(addr, &level);
+	if (!pte)
+		return false;
+
+	if (enc)
+		return pte_val(*pte) == cc_mkenc(pte_val(*pte));
+
+	return pte_val(*pte) == cc_mkdec(pte_val(*pte));
+}
+
 /*
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
@@ -2130,7 +2145,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 {
 	pgprot_t empty = __pgprot(0);
 	struct cpa_data cpa;
-	int ret;
+	int ret, numpages_in_state = 0;
 
 	/* Should not be working on unaligned addresses */
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
@@ -2143,6 +2158,30 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
 	cpa.pgd = init_mm.pgd;
 
+	/*
+	 * If any page is already in the right state, bail with an error
+	 * because the code doesn't handled it. This is likely because
+	 * something has gone wrong and isn't worth optimizing for.
+	 *
+	 * If all the memory pages are already in the desired state return
+	 * success.
+	 *
+	 * kernel_vaddr_encryped() does not synchronize against huge page
+	 * splits so take pgd_lock. A caller doing strange things could
+	 * get a new PMD mid level PTE confused with a huge PMD entry. Just
+	 * lock to tie up loose ends.
+	 */
+	spin_lock(&pgd_lock);
+	for (int i = 0; i < numpages; i++) {
+		if (kernel_vaddr_encryped(addr + (PAGE_SIZE * i), enc))
+			numpages_in_state++;
+	}
+	spin_unlock(&pgd_lock);
+	if (numpages_in_state == numpages)
+		return 0;
+	else if (numpages_in_state)
+		return 1;
+
 	/* Must avoid aliasing mappings in the highmem code */
 	kmap_flush_unused();
 	vm_unmap_aliases();
-- 
2.34.1

