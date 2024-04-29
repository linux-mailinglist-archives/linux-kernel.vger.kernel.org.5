Return-Path: <linux-kernel+bounces-162412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42D8B5AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958BF28720C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEDF7D085;
	Mon, 29 Apr 2024 14:02:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E727640E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399346; cv=none; b=V85z6m8zDKf3vcforLtADZLDQ8wULMJJKzey5UfcEC/7l8SpdLFCu+bE4fZTakePQTilNsAhlXlB/1SZ2KuMI6WFsWrCs/jdLJVtcWRxTysu1DsETn7+WxJVNqzpnMWOsA5km2emthv5PnvSmOPfQ69zpmEwLWO0mDHzGxngO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399346; c=relaxed/simple;
	bh=dpgwzfDXAyjlCjcVpzjAFrRgKp5L0R9tG43ksvRymIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZriBQIGI+E2G8enmqv2iXEk3T0lgfNzAO2q67pta3M+F4yRw6ZbhUBkofKPXVFWVGHfd+FDLZXHhUW24hHW9BnGLP3loLJGeKDNufHyqQJq+kJf28aDRLEmmLRBDjgjOKjE8h7TPS+X6kPtwHOcmkgHQBMvIfSb5b7a1qV+iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B440DA7;
	Mon, 29 Apr 2024 07:02:49 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F553F793;
	Mon, 29 Apr 2024 07:02:20 -0700 (PDT)
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
Subject: [PATCH v2 2/3] arm64/mm: Move PTE_INVALID to overlay PTE_NS
Date: Mon, 29 Apr 2024 15:02:06 +0100
Message-Id: <20240429140208.238056-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429140208.238056-1-ryan.roberts@arm.com>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTE_INVALID was previously occupying bit 59, which when a PTE is valid
can either be IGNORED, PBHA[0] or AttrIndex[3], depending on the HW
configuration. In practice this is currently not a problem because
PTE_INVALID can only be 1 when PTE_VALID=0 and upstream Linux always
requires the bit set to 0 for a valid pte.

However, if in future Linux wants to use the field (e.g. AttrIndex[3])
then we could end up with confusion when PTE_INVALID comes along and
corrupts the field - we would ideally want to preserve it even for an
invalid (but present) pte.

The other problem with bit 59 is that it prevents the offset field of a
swap entry within a swap pte from growing beyond 51 bits. By moving
PTE_INVALID to a low bit we can lay the swap pte out so that the
offset field could grow to 53 bits in future.

So let's move PTE_INVALID to overlay PTE_NS (bit 5). PTE_NS is res0 for
SW outside of the secure state so Linux will never need to touch it.

These are both marginal benefits, but make things a bit tidier in my
opinion.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/include/asm/pgtable-prot.h  | 2 +-
 arch/arm64/include/asm/pgtable.h       | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index ef207a0d4f0d..7e1fea3a4328 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -160,6 +160,7 @@
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
 #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
 #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
+#define PTE_NS			(_AT(pteval_t, 1) << 5)		/* NS */
 #define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
 #define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
 #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index de62e6881154..ddf55895c9c2 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,7 +18,7 @@
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
-#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
+#define PTE_INVALID		(PTE_NS)		 /* only when !PTE_VALID */
 
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8dd4637d6b56..d966d2ee1097 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1244,11 +1244,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
- *	bits 3-7:	swap type
- *	bits 8-57:	swap offset
- *	bit  59:	PTE_INVALID (must be zero)
+ *	bit  5:		PTE_INVALID (must be zero)
+ *	bits 6-10:	swap type
+ *	bits 11-60:	swap offset
  */
-#define __SWP_TYPE_SHIFT	3
+#define __SWP_TYPE_SHIFT	6
 #define __SWP_TYPE_BITS		5
 #define __SWP_OFFSET_BITS	50
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
-- 
2.25.1


