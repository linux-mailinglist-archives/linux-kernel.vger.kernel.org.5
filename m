Return-Path: <linux-kernel+bounces-49415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4F846A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8078C1C2650B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8D18EA5;
	Fri,  2 Feb 2024 08:08:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361218E1A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861310; cv=none; b=c881Vo5p4UE9Iq9fK7pUNnw8KNTcH0bDe9Gj4ftMmrXnZl2tu7byklPwDROvPiSGGwKn2kW+bnT3WTZz3CuGZ8Oxx2gk/1q9MMCdKLpeKL3mdG5xJEQWZPTtSnFMxG5xclvrPC+wfXFy+ZowC7g+Ojf5Mb0Xp5UvjU19awlBzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861310; c=relaxed/simple;
	bh=ilkctyHCFTKph7SguchDk3Oqzwpxdv9pwaYrbYycKgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khWin5suZO0qkx6sPjk7iohPp7VxrDncpmKVhK1kOxJgFlB0jy2kLoS16BkZulkAbJlBcPT91N9MLKHC2jWeqKVPY6/gxQewynHclxgUJ0THYiKVE02Y/qtckUuOVORWbkJTvCdyKgsLyi6X/0eORCULwphVzmeF5hVeIsBw4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2865B169E;
	Fri,  2 Feb 2024 00:09:10 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7A53F5A1;
	Fri,  2 Feb 2024 00:08:24 -0800 (PST)
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
Subject: [PATCH v5 03/25] mm: Make pte_next_pfn() a wrapper around pte_advance_pfn()
Date: Fri,  2 Feb 2024 08:07:34 +0000
Message-Id: <20240202080756.1453939-4-ryan.roberts@arm.com>
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

The goal is to be able to advance a PTE by an arbitrary number of PFNs.
So introduce a new API that takes a nr param.

We are going to remove pte_next_pfn() and replace it with
pte_advance_pfn(). As a first step, implement pte_next_pfn() as a
wrapper around pte_advance_pfn() so that we can incrementally switch the
architectures over. Once all arches are moved over, we will change all
the core-mm callers to call pte_advance_pfn() directly and remove the
wrapper.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5e7eaf8f2b97..815d92dcb96b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -214,9 +214,15 @@ static inline int pmd_dirty(pmd_t pmd)
 
 
 #ifndef pte_next_pfn
+#ifndef pte_advance_pfn
+static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
+{
+	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
+}
+#endif
 static inline pte_t pte_next_pfn(pte_t pte)
 {
-	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+	return pte_advance_pfn(pte, 1);
 }
 #endif
 
-- 
2.25.1


