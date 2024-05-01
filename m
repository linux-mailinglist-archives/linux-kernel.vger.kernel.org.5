Return-Path: <linux-kernel+bounces-165394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DE8B8C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413652836C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1212F59D;
	Wed,  1 May 2024 14:54:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B612E1D5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575273; cv=none; b=EQtSGeh3j+u/IH4SkAUdO4UY6k9Nm5Rx1JfdLpqecbja+WNXxeH0juWKJylcXHtdbvjG5egIMg6QgMWADzy4egsBvLp5GnMqD+rd1il2iEgsljxMWy0DB06yjKP+L/klzkvOM1EU65TI8MTSkA3MQpuQGqiNbZ68ASvN1vtqraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575273; c=relaxed/simple;
	bh=7WDYicDnUfN1hyvIeXACAqSqDr+ItvElKGj7u/dOzNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njmZMpv4zo5q2MhBqS76f5YbzBjpL4/HioZlePO45hl+tZU8I148eQ/c70sBV835d1wvT6UaTpDmF1Wd7Kx1xBG/bvhq0RGhY4UmxCDTv2GIyiUdnvm2FB42pXrQW9JCPRxoY3o6Ezw2gUW2tMIErFe7ULYPD0u92oGB3mVfgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B31C52F4;
	Wed,  1 May 2024 07:54:57 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02C893F793;
	Wed,  1 May 2024 07:54:29 -0700 (PDT)
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
Subject: [PATCH v3 2/3] arm64/mm: Move PTE_PRESENT_INVALID to overlay PTE_NG
Date: Wed,  1 May 2024 15:54:18 +0100
Message-Id: <20240501145419.1390363-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501145419.1390363-1-ryan.roberts@arm.com>
References: <20240501145419.1390363-1-ryan.roberts@arm.com>
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
index cd8c06f5fb02..3047d10987fd 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,7 +18,7 @@
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
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
2.25.1


