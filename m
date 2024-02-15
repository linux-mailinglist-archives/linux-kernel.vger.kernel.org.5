Return-Path: <linux-kernel+bounces-66648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09112856108
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825D6B32F33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFD12F59B;
	Thu, 15 Feb 2024 10:33:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F012F38D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993180; cv=none; b=MKTveGHENdRDJAb3iZsXJrfwGTAKvxLIm7uiXMK4ZkzQH9hk47NdVOfpqHbcscktIaMECtNU4lfyWBfULH+N3B+mzBFSMA8Mf4EWMRDWveTeX0FO0g7ujsTUAjLhJ9ZYMhjw07Vt60TgQq7IKMFCLp0Fp0/Gis02IzgByFgtF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993180; c=relaxed/simple;
	bh=7hm98Uy4uzJ8moWfBkXOKwgSvNFZT6zUX8a/wpE/3D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhZCIDTh/YoMke6UJr7oV0TobnPA9odORjdckqVvniytUCwJCtlT9Rux8bTm8G3gLmP5X9IqYocQInQtErFkOw7HnAhsmm4OJ6KRT89J9UWKshYPsHTmtU9VAWNF5cPcJhE13Kq6cjJ6we2DkYtYErqJYSIZ82gf8P+rXu15Ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79677DA7;
	Thu, 15 Feb 2024 02:33:38 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5073F7B4;
	Thu, 15 Feb 2024 02:32:54 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/18] arm64/mm: Split __flush_tlb_range() to elide trailing DSB
Date: Thu, 15 Feb 2024 10:31:58 +0000
Message-Id: <20240215103205.2607016-12-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215103205.2607016-1-ryan.roberts@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split __flush_tlb_range() into __flush_tlb_range_nosync() +
__flush_tlb_range(), in the same way as the existing flush_tlb_page()
arrangement. This allows calling __flush_tlb_range_nosync() to elide the
trailing DSB. Forthcoming "contpte" code will take advantage of this
when clearing the young bit from a contiguous range of ptes.

Ordering between dsb and mmu_notifier_arch_invalidate_secondary_tlbs()
has changed, but now aligns with the ordering of __flush_tlb_page(). It
has been discussed that __flush_tlb_page() may be wrong though.
Regardless, both will be resolved separately if needed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 1deb5d789c2e..3b0e8248e1a4 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -422,7 +422,7 @@ do {									\
 #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
 	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false, kvm_lpa2_is_enabled());
 
-static inline void __flush_tlb_range(struct vm_area_struct *vma,
+static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level,
 				     int tlb_level)
@@ -456,10 +456,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
 				     tlb_level, true, lpa2_is_enabled());
 
-	dsb(ish);
 	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
 }
 
+static inline void __flush_tlb_range(struct vm_area_struct *vma,
+				     unsigned long start, unsigned long end,
+				     unsigned long stride, bool last_level,
+				     int tlb_level)
+{
+	__flush_tlb_range_nosync(vma, start, end, stride,
+				 last_level, tlb_level);
+	dsb(ish);
+}
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
-- 
2.25.1


