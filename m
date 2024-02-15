Return-Path: <linux-kernel+bounces-66654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88DB855F89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770DC1F22074
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B529B131734;
	Thu, 15 Feb 2024 10:33:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074AC130E50
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993196; cv=none; b=No4i58qOCFk/hFPf4CRdE290bQF1VdRMEZ+GmtTKs2qcFGm+4e9hCKMqf0Ksfk33HFnJhDn15ycm1a8QNoJOyPFmtGrV4QIq2OCWGYD8odFFnXatJlRUb6lge9oJacWcFHv0dp2deXjLGtX00s8Rk1/dmUZ82+8s5lUzvrtoJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993196; c=relaxed/simple;
	bh=UQ5MbKtdXY2+2WI/a5CIOKIBnSOSlIvamDyhPiGi7rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/LqXb3rhk4udjzf3/GVZRPY2jHlSlcHqTECQ1rS3mWMQi0+zjabyxjOir9jFJo6dsFGCiyIUFu/fNdfQD3Afh2H35kvSVP2PK8wXIExYsgsliiL68ck/KB+/pfs+wwEmDCYlSbLPGG1LfJ+QIzzi/ZYPtmm/lsStuDbt3koN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 871BF15BF;
	Thu, 15 Feb 2024 02:33:55 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9B93F7B4;
	Thu, 15 Feb 2024 02:33:11 -0800 (PST)
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
Subject: [PATCH v6 16/18] arm64/mm: Implement pte_batch_hint()
Date: Thu, 15 Feb 2024 10:32:03 +0000
Message-Id: <20240215103205.2607016-17-ryan.roberts@arm.com>
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

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a8f1a35e3086..d759a20d2929 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1213,6 +1213,15 @@ static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
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


