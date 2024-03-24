Return-Path: <linux-kernel+bounces-115349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA1C889C35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A720FB3CAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F31E9F94;
	Mon, 25 Mar 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxxV5vmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3251D4C65;
	Sun, 24 Mar 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320560; cv=none; b=ZMbQl6Am//HAqjgBI/HgLvBf5kA26FAwEcrz9KYgzanEayiN5lOqfH91xrnwm6INZRfeBKYoYvId+n9b1DmPNh0/zb8lqX7SjoscuR+PMZ8MIBssZL55deIb5ZiM/B8ZLGodRAFnaDMZ3oRkTr6EMaPfpl+6uyAmMqAsqP/JD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320560; c=relaxed/simple;
	bh=vYYFwKto6yg6woV1Hr3fxCR11bex2S34Ri9YamTHIhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hujw/wOfurpkS7Vy0ZgC7AcOfudnnPka6pDT2h+CLBv4Zq2TJo8Z6Vk9GANZtkRfEU8bb0QhXkZGC/sqRhCnILWg/cXkUS/555c1NFMm0XsfiiCqrqbgd0256+dULODrkLlWVKFqJpuJpgyVql+Ln2VNNl2UXhk8bEEbfwYjsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxxV5vmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33937C433C7;
	Sun, 24 Mar 2024 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320560;
	bh=vYYFwKto6yg6woV1Hr3fxCR11bex2S34Ri9YamTHIhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxxV5vmq+V3sQ+vubbe08K9s/fSge8IgY+om1uM7rxwtOGBj06775ZTU0NVwCC4Z/
	 PQ3fevCjVEvXkHbysvfMoeCUKmx+T71SnrTB7WQGr9TXlxrX+cC6ti7WbBir//Emgr
	 snlfcq3o6Yj6EcJC+AuMqFUdeBN942bCe+TxX5CRYcLxujRthkiY1OLhHAikOhWnM2
	 VBltzxT17fNe4iwec0WF3eKXJzC/aBGB1iEwxlClgl9qWFMgiAkTrtj0ga3915CCS3
	 RLXiZ/H9oYPcT8rxXbdK7Ky6lsmyx7CUjujRXMlcY/GKMZNGMkqLgYCEqIfaZVovHw
	 BYXaeXAzpj2BA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Roth <michael.roth@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 121/713] x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type
Date: Sun, 24 Mar 2024 18:37:27 -0400
Message-ID: <20240324224720.1345309-122-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michael Roth <michael.roth@amd.com>

[ Upstream commit 8e5647a723c49d73b9f108a8bb38e8c29d3948ea ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/page.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9f..1b93ff80b43bc 100644
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
-- 
2.43.0


