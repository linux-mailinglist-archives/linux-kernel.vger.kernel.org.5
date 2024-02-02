Return-Path: <linux-kernel+bounces-49436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33472846A52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656BC1C28066
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B85026C;
	Fri,  2 Feb 2024 08:09:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33F50264
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861386; cv=none; b=NUF0sKmGPsQ9fVxR1dUyN5HeNEVYpTY2zUJl/FemqCeYcHMD79EnDj1D9gfvQoCP5UEft1Q+j9Y/YjIq+N0CKvJFKPJ4dyKblWFkyOrei0O45lg8wGFNMc1jxS9MOo4BpK5VajywJ8A1JWyI6gVFHDOyMPUY1cMdj2nFP6iR7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861386; c=relaxed/simple;
	bh=gA3rmQESQEtijo//ggjn7IksyLg2S12e6/K2IAx3W1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rE+pRQ8eTfTFQn7N7K1We4UKdrTRcG3bgBNG5z2RIMJRd0erz76J6VfTWZgwFglK9NB1A0h0AR/QTcPmNy+FzXJZtV8gi3g/qpBu37FrEdK2T4fghb/V4lyiXvapJCNuk3Fcczl3JN/1H6Nkm20wm+KZadfULlLoMhJnzuZvE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87EF01BF3;
	Fri,  2 Feb 2024 00:10:26 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C0C43F5A1;
	Fri,  2 Feb 2024 00:09:40 -0800 (PST)
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
Subject: [PATCH v5 23/25] arm64/mm: Implement pte_batch_hint()
Date: Fri,  2 Feb 2024 08:07:54 +0000
Message-Id: <20240202080756.1453939-24-ryan.roberts@arm.com>
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

When core code iterates over a range of ptes and calls ptep_get() for
each of them, if the range happens to cover contpte mappings, the number
of pte reads becomes amplified by a factor of the number of PTEs in a
contpte block. This is because for each call to ptep_get(), the
implementation must read all of the ptes in the contpte block to which
it belongs to gather the access and dirty bits.

This causes a hotspot for fork(), as well as operations that unmap
memory such as munmap(), exit and madvise(MADV_DONTNEED). Fortunately we
can fix this by implementing pte_batch_hint() which allows their
iterators to skip getting the contpte tail ptes when gathering the batch
of ptes to operate on. This results in the number of PTE reads returning
to 1 per pte.

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ad04adb7b87f..353ea67b5d75 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1220,6 +1220,15 @@ static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 		__contpte_try_unfold(mm, addr, ptep, pte);
 }
 
+#define pte_batch_hint pte_batch_hint
+static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
+{
+	if (!pte_valid_cont(pte))
+		return 1;
+
+	return CONT_PTES - (((unsigned long)ptep >> 3) & (CONT_PTES - 1));
+}
+
 /*
  * The below functions constitute the public API that arm64 presents to the
  * core-mm to manipulate PTE entries within their page tables (or at least this
-- 
2.25.1


