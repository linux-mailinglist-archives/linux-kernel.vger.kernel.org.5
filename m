Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE97F5C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjKWKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:31:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D719D;
        Thu, 23 Nov 2023 02:31:18 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700735476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGiLDGmbqrWlSjfhkQgPnYZ8qvWq9oDF9VGMNYqyrrM=;
        b=zDSlhhUkPXrzP8nf2RHbRQ7QC3w8aKKmUQ2PtJaeIJ3iA3F4zIDPGhGha6b7EovSNZPGNK
        y5p+K63x+0jqu6e+kbw08RcFqVtCwwHS49EhicvTAZOutuY8FO5iifRbz4YGDt8GOaCZjB
        z36gGiSaTR3QLylKsth6RDo5V9YS1RUJv1Z8gQ5W0VD5s9qR6ZuhjdXO6ySebxUYJKumCY
        ao6b//fYnB2dRSFH2hkAIPnd3V3AnQctBbuY6Y/PaleKLABZb9hSEaoR/8XhuHAcsO+jcv
        WHSovPEmtUHeREE2qwlU7KIjabCvmjDSJk/BAFMh0l2bMJFV0Xosgs+khhjLgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700735476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGiLDGmbqrWlSjfhkQgPnYZ8qvWq9oDF9VGMNYqyrrM=;
        b=oiJLfsg/JzQBjq5/beKwYJ+STInXf6rZ9sGhMDJesGJDliSdLwI7T0izhWq7N6ndofhSYj
        e8Hrnt0HgoxwbVDw==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Ensure input to pfn_to_kaddr() is treated as a
 64-bit type
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122163700.400507-1-michael.roth@amd.com>
References: <20231122163700.400507-1-michael.roth@amd.com>
MIME-Version: 1.0
Message-ID: <170073547546.398.2637807593174571076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8e5647a723c49d73b9f108a8bb38e8c29d3948ea
Gitweb:        https://git.kernel.org/tip/8e5647a723c49d73b9f108a8bb38e8c29d3948ea
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Wed, 22 Nov 2023 10:37:00 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Nov 2023 11:13:21 +01:00

x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type

On 64-bit platforms, the pfn_to_kaddr() macro requires that the input
value is 64 bits in order to ensure that valid address bits don't get
lost when shifting that input by PAGE_SHIFT to calculate the physical
address to provide a virtual address for.

One such example is in pvalidate_pages() (used by SEV-SNP guests), where
the GFN in the struct used for page-state change requests is a 40-bit
bit-field, so attempts to pass this GFN field directly into
pfn_to_kaddr() ends up causing guest crashes when dealing with addresses
above the 1TB range due to the above.

Fix this issue with SEV-SNP guests, as well as any similar cases that
might cause issues in current/future code, by using an inline function,
instead of a macro, so that the input is implicitly cast to the
expected 64-bit input type prior to performing the shift operation.

While it might be argued that the issue is on the caller side, other
archs/macros have taken similar approaches to deal with instances like
this, such as ARM explicitly casting the input to phys_addr_t:

  e48866647b48 ("ARM: 8396/1: use phys_addr_t in pfn_to_kaddr()")

A C inline function is even better though.

[ mingo: Refined the changelog some more & added __always_inline. ]

Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231122163700.400507-1-michael.roth@amd.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/page.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c3..1b93ff8 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -66,10 +66,14 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
  * virt_addr_valid(kaddr) returns true.
  */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+static __always_inline void *pfn_to_kaddr(unsigned long pfn)
+{
+	return __va(pfn << PAGE_SHIFT);
+}
+
 static __always_inline u64 __canonical_address(u64 vaddr, u8 vaddr_bits)
 {
 	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
