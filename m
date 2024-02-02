Return-Path: <linux-kernel+bounces-49437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3B846A55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5053281DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9595102F;
	Fri,  2 Feb 2024 08:09:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717EE50A8F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861390; cv=none; b=iQ40t7IUBaIx3+P+8vkjIJTPtG11b2qwVI4YPN5ypyDnK8cWI0rIKda4ldysH/DJWf8Wn0zJ94dp5PCCsfTK75AOto1Q9BqIC43GhhYZ0YwAmMCEJ24xL0JFlsbUxcPdDdFER5ltz34SB0S79hAMXlipYsWIiWXPwCqtJjrglxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861390; c=relaxed/simple;
	bh=ExbEqfvzT1fzU5mx7AphI5+/hTRoouLXcKYYJ84Z8nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPZ3lxuJ9WR64mI48xcvP6EX+aXTt1+EQc8YWdsdVTDznQOhh2NTGkaRxcWWI98wpI/LM2qVQies9z5h2pOn0Nf9ez0pbqphy7AHISmbU4ubRXkdqDoOger/g+i6T0mnEXS4KSdAQrhuWDI+FfW64NgzUqVRBn/igzT367x1i3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 599431BF7;
	Fri,  2 Feb 2024 00:10:30 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8E53F5A1;
	Fri,  2 Feb 2024 00:09:44 -0800 (PST)
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
Subject: [PATCH v5 24/25] arm64/mm: __always_inline to improve fork() perf
Date: Fri,  2 Feb 2024 08:07:55 +0000
Message-Id: <20240202080756.1453939-25-ryan.roberts@arm.com>
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

As set_ptes() and wrprotect_ptes() become a bit more complex, the
compiler may choose not to inline them. But this is critical for fork()
performance. So mark the functions, along with contpte_try_unfold()
which is called by them, as __always_inline. This is worth ~1% on the
fork() microbenchmark with order-0 folios (the common case).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 353ea67b5d75..cdc310880a3b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1213,8 +1213,8 @@ extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
 
-static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, pte_t pte)
+static __always_inline void contpte_try_unfold(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep, pte_t pte)
 {
 	if (unlikely(pte_valid_cont(pte)))
 		__contpte_try_unfold(mm, addr, ptep, pte);
@@ -1279,7 +1279,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 }
 
 #define set_ptes set_ptes
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+static __always_inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	pte = pte_mknoncont(pte);
@@ -1361,8 +1361,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 
 #define wrprotect_ptes wrprotect_ptes
-static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, unsigned int nr)
+static __always_inline void wrprotect_ptes(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 	if (likely(nr == 1)) {
 		/*
-- 
2.25.1


