Return-Path: <linux-kernel+bounces-49419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E3846A34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3571F2AF78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963C3FE36;
	Fri,  2 Feb 2024 08:08:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675FD3FB34
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861325; cv=none; b=qNLHIaKC7R/MYlm8aM+1hwLiKzYcb/fui0UZX2Cni4iM18bw7oyIyTuADhqSyjX4ydh2dzoDZyKFhYMNbKORoSdxxe0JFzYrXETca6lOQbYnXAz782GEv/tAUjeoJfAyWHnhQNgjKVO7VEArJYvLf4gZX3GoXTJZ+V7LMt1wSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861325; c=relaxed/simple;
	bh=1bnCWOCo19towQ1NBag6+0h207ceYs77u/vdiiGC3Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZLqhZ9vKRZBFAOu/cNrJ0r3jPZsLOwBJUUb8tXm/LMZO/avcdf0E9i0nG5t8Tm3ELfJpr8WRcTIOvh3iaAlpFzLASkCvgSdfoTG9NbZJoeKmbsaVOlIyyjv91gMWkgRlJbE030YNdiL1ufFHX6Gn+67UTuJvf8WuYbhxkR9qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6299E176B;
	Fri,  2 Feb 2024 00:09:25 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76D9A3F5A1;
	Fri,  2 Feb 2024 00:08:39 -0800 (PST)
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
Subject: [PATCH v5 07/25] x86/mm: Convert pte_next_pfn() to pte_advance_pfn()
Date: Fri,  2 Feb 2024 08:07:38 +0000
Message-Id: <20240202080756.1453939-8-ryan.roberts@arm.com>
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

Core-mm needs to be able to advance the pfn by an arbitrary amount, so
improve the API to do so and change the name.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/x86/include/asm/pgtable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9d077bca6a10..b60b0c897b4c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -956,13 +956,13 @@ static inline int pte_same(pte_t a, pte_t b)
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


