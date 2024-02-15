Return-Path: <linux-kernel+bounces-66655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF916855F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D81F21599
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2836024B26;
	Thu, 15 Feb 2024 10:33:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6384FC0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993199; cv=none; b=fRouSnQaQBuWEi1EAz0GniIXYifCbss4HCkEAqolYa5j4awccZhG6kil8TuqxlpdlH9uBT0SegX9wzGul4H4ohiVLoXASLbajEVEADBjG2Q7RpLzk1V9SYyhb2AJtpxjSul+50vZL6VOSbZFSWh8r5qJjjIKLm9DhK7YBukA0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993199; c=relaxed/simple;
	bh=BKVaPuYqBaCIkAqRyGQu29xHpMe0/fa3OcqaDOFtyTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkazlLNyb6J5MgMuYGlhwSPYTA1s5KdSNlGPdYRVBKGSyAIIk4spvGECd9rMwx65eiFK1/8QLx0aow7k8YeEVH+ZpeT/BEOaIya5QdsLH5g/5rbTzOAHnLAj4GmCxNCDa+3nG3jtAcxfWf+ihl0BIvkxSjKk478a/jh9P6XmNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA3215DB;
	Thu, 15 Feb 2024 02:33:58 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26CB3F7B4;
	Thu, 15 Feb 2024 02:33:14 -0800 (PST)
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
Subject: [PATCH v6 17/18] arm64/mm: __always_inline to improve fork() perf
Date: Thu, 15 Feb 2024 10:32:04 +0000
Message-Id: <20240215103205.2607016-18-ryan.roberts@arm.com>
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

As set_ptes() and wrprotect_ptes() become a bit more complex, the
compiler may choose not to inline them. But this is critical for fork()
performance. So mark the functions, along with contpte_try_unfold()
which is called by them, as __always_inline. This is worth ~1% on the
fork() microbenchmark with order-0 folios (the common case).

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d759a20d2929..8310875133ff 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1206,8 +1206,8 @@ extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
 
-static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, pte_t pte)
+static __always_inline void contpte_try_unfold(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep, pte_t pte)
 {
 	if (unlikely(pte_valid_cont(pte)))
 		__contpte_try_unfold(mm, addr, ptep, pte);
@@ -1278,7 +1278,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 }
 
 #define set_ptes set_ptes
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+static __always_inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	pte = pte_mknoncont(pte);
@@ -1360,8 +1360,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
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


