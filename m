Return-Path: <linux-kernel+bounces-49432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F0846A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B374828E5B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0F4CE19;
	Fri,  2 Feb 2024 08:09:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90C4CB45
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861372; cv=none; b=Fl0zMyfdTb/V4Xr4ls9BL/1igJg2ylqmc2cUgHzxadStRZK1JrtNTmRlGSCPM1TW/fc4gkOVbD1Eg5yzGhrMeW7LGstM0yU7JODvSgxObwEP3rHlsyX1UZ45fCTTG/z8P6tddiNwWFdnbHJTrnCuVGC7xSuPXIlQbvkG7sCcaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861372; c=relaxed/simple;
	bh=6v3bAuhb3ybuKr98CSTFl92HE/KFoLGWUOZA4ZM01Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhEUei6q2Xwor6fCTXD1nfbPYidPa7hCfuIo2zZEkx9v6gb8tqPHCDZTuDDEdpV79EjyS6Cm2cAYnO0bteYT4GN40lj0XHIWYoOiYO5II672dU3vMGwtjr9sE8ghXLS+/FiiPlz6wFg/W8Q9XHYgxn6QWDqiciqux/chunGFXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704231BC0;
	Fri,  2 Feb 2024 00:10:12 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DE43F5A1;
	Fri,  2 Feb 2024 00:09:21 -0800 (PST)
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
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
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
Subject: [PATCH v5 18/25] arm64/mm: Split __flush_tlb_range() to elide trailing DSB
Date: Fri,  2 Feb 2024 08:07:49 +0000
Message-Id: <20240202080756.1453939-19-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
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

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 79e932a1bdf8..50a765917327 100644
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


