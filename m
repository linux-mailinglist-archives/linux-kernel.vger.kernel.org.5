Return-Path: <linux-kernel+bounces-59021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A687484EFF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF261F26844
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38656B8E;
	Fri,  9 Feb 2024 05:42:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17456B77
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457360; cv=none; b=pW/W3QaS/dRqw1yRfLQEOuGqDcA+42NcmogvjqQaezJkFykUlEAoVk0He4eEm5rza0qel9w1M5dXMpvIWuEzc3s2GbYZaUYE3NjO0MbSaP+zxuooxMf+XdThQTcRvCxTX8cZa+bEEhaBcAWu9U0k/4iB6GTqsFstKN/TUrZ1Pl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457360; c=relaxed/simple;
	bh=VRs3hYubAI9ge8HPHNqHbf1a/Zw/rp9qwxPduUJZgWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W7RilAS3SjWlHkm6L1u/JqEtEB5Wllb9GLmlxy+wUsDwY5YLN4McBDcXYCmy1tJRCfEXax6qALNK2f4crY3UN/xNqWt1IS8WD7kxRHaMMXC4xR96WYmee1YGwNWOHe98vDMDk7z/TzoWOrXBqhb7L8YYx088yMzgkP7Mt/Sxt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B737DA7;
	Thu,  8 Feb 2024 21:43:18 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 169583F762;
	Thu,  8 Feb 2024 21:42:32 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: Move page order check inside hugetlb_cma_reserve()
Date: Fri,  9 Feb 2024 11:12:21 +0530
Message-Id: <20240209054221.1403364-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All platforms could benefit from page order check against MAX_PAGE_ORDER
before allocating a CMA area for gigantic hugetlb pages. Let's move this
check from individual platforms to generic hugetlb.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc3
 
 arch/arm64/mm/hugetlbpage.c   | 7 -------
 arch/powerpc/mm/hugetlbpage.c | 4 +---
 mm/hugetlb.c                  | 7 +++++++
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 8116ac599f80..6720ec8d50e7 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -45,13 +45,6 @@ void __init arm64_hugetlb_cma_reserve(void)
 	else
 		order = CONT_PMD_SHIFT - PAGE_SHIFT;
 
-	/*
-	 * HugeTLB CMA reservation is required for gigantic
-	 * huge pages which could not be allocated via the
-	 * page allocator. Just warn if there is any change
-	 * breaking this assumption.
-	 */
-	WARN_ON(order <= MAX_PAGE_ORDER);
 	hugetlb_cma_reserve(order);
 }
 #endif /* CONFIG_CMA */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0a540b37aab6..16557d008eef 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -614,8 +614,6 @@ void __init gigantic_hugetlb_cma_reserve(void)
 		 */
 		order = mmu_psize_to_shift(MMU_PAGE_16G) - PAGE_SHIFT;
 
-	if (order) {
-		VM_WARN_ON(order <= MAX_PAGE_ORDER);
+	if (order)
 		hugetlb_cma_reserve(order);
-	}
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cf9c9b2906ea..345b3524df35 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7699,6 +7699,13 @@ void __init hugetlb_cma_reserve(int order)
 	bool node_specific_cma_alloc = false;
 	int nid;
 
+	/*
+	 * HugeTLB CMA reservation is required for gigantic
+	 * huge pages which could not be allocated via the
+	 * page allocator. Just warn if there is any change
+	 * breaking this assumption.
+	 */
+	VM_WARN_ON(order <= MAX_PAGE_ORDER);
 	cma_reserve_called = true;
 
 	if (!hugetlb_cma_size)
-- 
2.25.1


