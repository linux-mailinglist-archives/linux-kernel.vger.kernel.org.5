Return-Path: <linux-kernel+bounces-167790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5378BAF36
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FA6283DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB02155300;
	Fri,  3 May 2024 14:46:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29834206A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747587; cv=none; b=O5T4w5xUty+hwMv8bPzAeUoorHFKPf0WXR6QwF6Hp59IB5FXddDY5ca2sSAL8z9bcSd8yj8bGHXaU5SkCQa3OjNxNfDQf2H4fwjkug8OgY4PbYbqoc5o1XeeSqX6gmf5PjqEjwTXwW652BDyGLAPt1qkuAqlev92WE+C1/eM0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747587; c=relaxed/simple;
	bh=A4qCWId5KDUYyrb/q1KpFPwsV7UtmRojwHfaLfM91gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l978//LmylsOpCSsBQjeY6WX9Rj4bJcP9kH8eWcycIC8xsysZWjvjQoAGfWdvRgVFDKCnXs0E2ckFJ7000Hbf0SVtJpSxtYSg9W2CJqyK7HbIjSf9zpxtY1/fAwc/mW6ita5+VRX0FDuy57FIWrDfP7zzOLOlhDKrQ64Y9kIdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADEB2143D;
	Fri,  3 May 2024 07:46:50 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8E83F73F;
	Fri,  3 May 2024 07:46:23 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] arm64/mm: Move PTE_PRESENT_INVALID to overlay PTE_NG
Date: Fri,  3 May 2024 15:46:01 +0100
Message-ID: <20240503144604.151095-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503144604.151095-1-ryan.roberts@arm.com>
References: <20240503144604.151095-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTE_PRESENT_INVALID was previously occupying bit 59, which when a PTE is
valid can either be IGNORED, PBHA[0] or AttrIndex[3], depending on the
HW configuration. In practice this is currently not a problem because
PTE_PRESENT_INVALID can only be 1 when PTE_VALID=0 and upstream Linux
always requires the bit set to 0 for a valid pte.

However, if in future Linux wants to use the field (e.g. AttrIndex[3])
then we could end up with confusion when PTE_PRESENT_INVALID comes along
and corrupts the field - we would ideally want to preserve it even for
an invalid (but present) pte.

The other problem with bit 59 is that it prevents the offset field of a
swap entry within a swap pte from growing beyond 51 bits. By moving
PTE_PRESENT_INVALID to a low bit we can lay the swap pte out so that the
offset field could grow to 52 bits in future.

So let's move PTE_PRESENT_INVALID to overlay PTE_NG (bit 11).

There is no need to persist NG for a present-invalid entry; it is always
set for user mappings and is not used by SW to derive any state from the
pte. PTE_NS was considered instead of PTE_NG, but it is RES0 for
non-secure SW, so there is a chance that future architecture may
allocate the bit and we may therefore need to persist that bit for
present-invalid ptes.

These are both marginal benefits, but make things a bit tidier in my
opinion.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  2 +-
 arch/arm64/include/asm/pgtable.h      | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 81f07b44f7b8..35c9de13f7ed 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -24,7 +24,7 @@
  * interpreted according to the HW layout by SW but any attempted HW access to
  * the address will result in a fault. pte_present() returns true.
  */
-#define PTE_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
+#define PTE_PRESENT_INVALID	(PTE_NG)		 /* only when !PTE_VALID */
 
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c0f4471423db..7f1ff59c43ed 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1254,15 +1254,15 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
- *	bits 3-7:	swap type
- *	bits 8-57:	swap offset
- *	bit  59:	PTE_PRESENT_INVALID (must be zero)
+ *	bits 6-10:	swap type
+ *	bit  11:	PTE_PRESENT_INVALID (must be zero)
+ *	bits 12-61:	swap offset
  */
-#define __SWP_TYPE_SHIFT	3
+#define __SWP_TYPE_SHIFT	6
 #define __SWP_TYPE_BITS		5
-#define __SWP_OFFSET_BITS	50
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
-#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+#define __SWP_OFFSET_SHIFT	12
+#define __SWP_OFFSET_BITS	50
 #define __SWP_OFFSET_MASK	((1UL << __SWP_OFFSET_BITS) - 1)
 
 #define __swp_type(x)		(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
-- 
2.43.0


