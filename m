Return-Path: <linux-kernel+bounces-112931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E5887FD8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84D28143C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F747A52;
	Sun, 24 Mar 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POCNoGvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F687441F;
	Sun, 24 Mar 2024 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319743; cv=none; b=KUE1JpDS7BW9mqaKcrejKs9XVNwjXxWjmk56bNYII752iLTrIY+62PbI0VLpiHOtZqihTCNBbHuonlqAG56UF/krF/q3jmBgCEO0QIoUNcotD5F1WTpU/lmrgY/MDafN5vpakagm4r+zqyfU4oJ9bSfA6QTcyeAdy3wQjJO+Lz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319743; c=relaxed/simple;
	bh=vYYFwKto6yg6woV1Hr3fxCR11bex2S34Ri9YamTHIhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH0MD59/vcagRtx+3h0tHHycW7qOX7qFFe+g3Z0u84SzCS+8RDgS/yX++tBOTTWnW1f4wj/MxBLvq9SP0yeVq/KMXn6G1ZdugTV2r2yMtDUdK6eO+3DA64bBQKJPYQFv63B2HsRVwUEy2L6lfaD1Ptdi3mxnoSbRK8gxs1zULZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POCNoGvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E35C433A6;
	Sun, 24 Mar 2024 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319743;
	bh=vYYFwKto6yg6woV1Hr3fxCR11bex2S34Ri9YamTHIhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POCNoGvUqs7kP3hwUNumSwgNscJdCSKxGQaMQDv6AiNmkCvWkoVV63did86WUoT/V
	 cwb2fh+5PPM0ZMTbC0sJ3IsNN2l8zEcr0Oa7az0wo7OVAxu5Y5d2I1qvfpKU0plHz+
	 ZZarxHz70KoR+d9n9vHk5f0/EV0cjt0Nm994cgv1QHpwu+sFfPwtstVVVnlG0wZ5i8
	 N/ctf5z8VhwBJ1AUjw330FQGGqsgBgPttRcSgL85ob22F9nEE9HfCVR7av7tQLQKOw
	 YUpUe9iQgay8l7cjlopERSp4qfK7FdtTJ6Jg6z4FNw5Eq+lXh081oAQNWsD7o2lXCi
	 Va+CLtqW1Rt1g==
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
Subject: [PATCH 6.8 044/715] x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type
Date: Sun, 24 Mar 2024 18:23:43 -0400
Message-ID: <20240324223455.1342824-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


