Return-Path: <linux-kernel+bounces-49417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E9846A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B08A1F2AEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611328373;
	Fri,  2 Feb 2024 08:08:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260117C67
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861318; cv=none; b=jk4ZG+G4l5Db4daKidxwuwlraxrCermAPzNfCDmR7+zfmqRZOdpGJ4zm9VUp+1ZSVFEcN+q1SenxNfrPSi0Sob20rfiBS/vFCCkTK6yUbyLWO0uyw24Bk2jF55GsazgPMmWP7yO6Em3tzM3+BLC/289CYBTr3sH3cEmaVSNQfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861318; c=relaxed/simple;
	bh=ANhmHka+h9ajCDCxtSgwGVd7uqj0IoMiS8o8hWXf4cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCzeWXJvoaZn9HVSCeaZFSAez6HKZZ90ID7P+Pon8r7pHCxAR8Kcu3pC/R4kBjgvg20PvztbnHdA1IDSnWRDa03LJk52f8bqkUFV7UJV7S1PIFfeZ/fJn5OXd+kNqtQXc5ufT2XOhtFKRNpSdRe+Zdo4YZPIiQIaaNwCAJa9lX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9921764;
	Fri,  2 Feb 2024 00:09:17 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F633F5A1;
	Fri,  2 Feb 2024 00:08:31 -0800 (PST)
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
Subject: [PATCH v5 05/25] arm64/mm: Convert pte_next_pfn() to pte_advance_pfn()
Date: Fri,  2 Feb 2024 08:07:36 +0000
Message-Id: <20240202080756.1453939-6-ryan.roberts@arm.com>
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
 arch/arm64/include/asm/pgtable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9428801c1040..6a6cc78cf879 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -351,10 +351,10 @@ static inline pgprot_t pte_pgprot(pte_t pte)
 	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
 }
 
-#define pte_next_pfn pte_next_pfn
-static inline pte_t pte_next_pfn(pte_t pte)
+#define pte_advance_pfn pte_advance_pfn
+static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 {
-	return pfn_pte(pte_pfn(pte) + 1, pte_pgprot(pte));
+	return pfn_pte(pte_pfn(pte) + nr, pte_pgprot(pte));
 }
 
 static inline void set_ptes(struct mm_struct *mm,
@@ -370,7 +370,7 @@ static inline void set_ptes(struct mm_struct *mm,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = pte_next_pfn(pte);
+		pte = pte_advance_pfn(pte, 1);
 	}
 }
 #define set_ptes set_ptes
-- 
2.25.1


