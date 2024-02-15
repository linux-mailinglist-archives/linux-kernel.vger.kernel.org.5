Return-Path: <linux-kernel+bounces-66640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05227855F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E5B289859
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F212C7E9;
	Thu, 15 Feb 2024 10:32:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193512BF16
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993158; cv=none; b=WdZTKndtZgBn/CYJQ2hlzzKcWVqS6bbXZUqnO3Bq2/YLUIKa0s0KQKavPS+G7C7UXw0kqhkD98ixwqMlWRP2U6BJmNU9K826xv4kjNa4Flco12h7t+PlWCGufcGKXrJwSSr8P8xXPgBAkZTFipkEjqU9OZY1bTJpmim10CVC4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993158; c=relaxed/simple;
	bh=QKKxOEWZPFqFjzK7t69u40gkIRbUK4JElui7wOCLF0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7j9B71u0jj5vFiV4OQU94zrXqtCYzoTsB4Q0cwu2jfuVO1bbdTEhNaVIQMtFUhresRbRK4yEoDGsJWqtnY+HkfPCm+eSovvwKgXSIYb/g9Z7vebOJD4C9soewive9RA6+evZLOfS9lG68PVXm4Cn99v8AMIyMxL/ugZeMh6Ejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA7C1515;
	Thu, 15 Feb 2024 02:33:17 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D34703F7B4;
	Thu, 15 Feb 2024 02:32:33 -0800 (PST)
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
Subject: [PATCH v6 05/18] x86/mm: Convert pte_next_pfn() to pte_advance_pfn()
Date: Thu, 15 Feb 2024 10:31:52 +0000
Message-Id: <20240215103205.2607016-6-ryan.roberts@arm.com>
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

Core-mm needs to be able to advance the pfn by an arbitrary amount, so
override the new pte_advance_pfn() API to do so.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/x86/include/asm/pgtable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b50b2ef63672..69ed0ea0641b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -955,13 +955,13 @@ static inline int pte_same(pte_t a, pte_t b)
 	return a.pte == b.pte;
 }
 
-static inline pte_t pte_next_pfn(pte_t pte)
+static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 {
 	if (__pte_needs_invert(pte_val(pte)))
-		return __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
-	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+		return __pte(pte_val(pte) - (nr << PFN_PTE_SHIFT));
+	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
 }
-#define pte_next_pfn	pte_next_pfn
+#define pte_advance_pfn	pte_advance_pfn
 
 static inline int pte_present(pte_t a)
 {
-- 
2.25.1


