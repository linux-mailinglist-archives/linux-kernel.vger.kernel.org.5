Return-Path: <linux-kernel+bounces-30041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B589F831839
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE47288C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A0241E8;
	Thu, 18 Jan 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Zc89DB"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BC2375A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576367; cv=none; b=RJgC0rIF93fU42aT+Oi5zdcXf4L4+8hOHo/CktlHkMjE+erljvDi/LbvNidHwUQg/dlH+opSvsp+J3sUOCfCnb8gCBJa9xdg1PUdIMd3nZTIdLxMI1vXDlK8B1H/dYfKgJ1sPobCFGXuowi/+5efJBOCnqzsMs2XD93qTy4QQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576367; c=relaxed/simple;
	bh=2rkgrzFdO6JMP0Th3YTAsnG21pW/6krZABLQ6XKuipI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=H2yZcbwUsFKHxfBzQJAGXrShR2lcX11zyrNW5UogYU+eSFysELfpKxSdg/hyseNcbG0xXOEhvO/SsrUI4LtnaaU0rwt4tJ1qUx0rHsptY+gAMVzuEH9LIdTyT9HrCTfHpJ1JwaszoCFMVVX1kHIwWhn306Lji5gejztX59noONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6Zc89DB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so393869b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576365; x=1706181165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPRbXml8IYd9XMbGDp/b9xmA+KUiJTFI45JekYQVHFk=;
        b=E6Zc89DB+LpEirh8qGL7egVvFVf7h8DvkEwutnAf+0Fa9stFOkmSFxbMEW5O1I5F4C
         VShy7uqCZiqqlM9w3mIBVWZYBhne1utH6uXxipBQKWElab1S3uwpbrVcO6InSP3qKEMm
         kizI+eeZmgKoOu0TetJaDBXqTNy22gzzfR/5fhON3uVRzP9trVTuzGOOcb8ta+YzDIpF
         MxJgvLbTQDUoz/WvJ8P9Vj6HfJyJaGenWJMnmwWwW484RXKSk+28I8Gh6w4lVscv8SdP
         8ly1Is6DW7toDfqXVVHNodEHmdhgR0D2I/zumcaRcjSG7BrNMndbT7bveHb7jofZX+Hd
         m6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576365; x=1706181165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPRbXml8IYd9XMbGDp/b9xmA+KUiJTFI45JekYQVHFk=;
        b=Z7M5d4TN3dnu6kp+k8SQ2XowM762Aeo8sW0dcEbfo7pZf9vvjtXeeiMlgcwSUc/4mI
         j+InCj1j6t1i6rHjzrPYZdHYBCIykt5KKYY+aPHDs0WSBttQ1ds3r1WRuazmGSgjQlUi
         nbITmVed1QeatevGFRAe7b+rzEc+wNzRO2qBkUT5xhz4WHewSXFYDmBoV4/eregi7Uq/
         fGv9HfKsmGiB1EgOfo507AH2XUR+q7opcECW8WCPv1QWv1WfsFENzGrJXwMlg9/+2I99
         YlH47xKmV148OFJQ65CgeRCiBgVbbJtv5DRm6+YoIF9DrPjtB2rW0dTXW9ktOrWq+wbN
         9JGw==
X-Gm-Message-State: AOJu0YxPMCh6ue8UGID98rWVvn+mbXe3quvwBewVigokPNsDAIRwWydI
	Cb1YfEsmT08vFomEparx+lbr4ri/+aUzwv1h+13yzsJVJs+bLZEq
X-Google-Smtp-Source: AGHT+IHPb2V5o+Kp/DcFse2JrVkm3MDRb3SQdSn4vIY2cU1g3ZhVG+tEV+84Z29sP1LjBn1UyzwA9g==
X-Received: by 2002:a05:6a20:548b:b0:19a:fbfa:b16a with SMTP id i11-20020a056a20548b00b0019afbfab16amr1121941pzk.30.1705576364885;
        Thu, 18 Jan 2024 03:12:44 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:12:44 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
Date: Fri, 19 Jan 2024 00:10:36 +1300
Message-Id: <20240118111036.72641-7-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset has
supported swapping large folios out as a whole for vmscan case. This patch
extends the feature to madvise.

If madvised range covers the whole large folio, we don't split it. Otherwise,
we still need to split it.

This patch doesn't depend on ARM64's CONT-PTE, alternatively, it defines one
helper named pte_range_cont_mapped() to check if all PTEs are contiguously
mapped to a large folio.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/asm-generic/tlb.h | 10 +++++++
 include/linux/pgtable.h   | 60 +++++++++++++++++++++++++++++++++++++++
 mm/madvise.c              | 48 +++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 129a3a759976..f894e22da5d6 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -608,6 +608,16 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
+#define tlb_remove_nr_tlb_entry(tlb, ptep, address, nr)			\
+	do {                                                    	\
+		int i;							\
+		tlb_flush_pte_range(tlb, address,			\
+				PAGE_SIZE * nr);			\
+		for (i = 0; i < nr; i++)				\
+			__tlb_remove_tlb_entry(tlb, ptep + i,		\
+					address + i * PAGE_SIZE);	\
+	} while (0)
+
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	do {							\
 		unsigned long _sz = huge_page_size(h);		\
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 37fe83b0c358..da0c1cf447e3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -320,6 +320,42 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
 }
 #endif
 
+#ifndef pte_range_cont_mapped
+static inline bool pte_range_cont_mapped(unsigned long start_pfn,
+					 pte_t *start_pte,
+					 unsigned long start_addr,
+					 int nr)
+{
+	int i;
+	pte_t pte_val;
+
+	for (i = 0; i < nr; i++) {
+		pte_val = ptep_get(start_pte + i);
+
+		if (pte_none(pte_val))
+			return false;
+
+		if (pte_pfn(pte_val) != (start_pfn + i))
+			return false;
+	}
+
+	return true;
+}
+#endif
+
+#ifndef pte_range_young
+static inline bool pte_range_young(pte_t *start_pte, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		if (pte_young(ptep_get(start_pte + i)))
+			return true;
+
+	return false;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
@@ -580,6 +616,23 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 }
 #endif
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_RANGE_FULL
+static inline pte_t ptep_get_and_clear_range_full(struct mm_struct *mm,
+						  unsigned long start_addr,
+						  pte_t *start_pte,
+						  int nr, int full)
+{
+	int i;
+	pte_t pte;
+
+	pte = ptep_get_and_clear_full(mm, start_addr, start_pte, full);
+
+	for (i = 1; i < nr; i++)
+		ptep_get_and_clear_full(mm, start_addr + i * PAGE_SIZE,
+					start_pte + i, full);
+
+	return pte;
+}
 
 /*
  * If two threads concurrently fault at the same page, the thread that
@@ -995,6 +1048,13 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 })
 #endif
 
+#ifndef pte_nr_addr_end
+#define pte_nr_addr_end(addr, size, end)				\
+({	unsigned long __boundary = ((addr) + size) & (~(size - 1));	\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
+#endif
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..262460ac4b2e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -452,6 +452,54 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
+			if (!folio_test_pmd_mappable(folio)) {
+				int nr_pages = folio_nr_pages(folio);
+				unsigned long folio_size = PAGE_SIZE * nr_pages;
+				unsigned long start_addr = ALIGN_DOWN(addr, nr_pages * PAGE_SIZE);;
+				unsigned long start_pfn = page_to_pfn(folio_page(folio, 0));
+				pte_t *start_pte = pte - (addr - start_addr) / PAGE_SIZE;
+				unsigned long next = pte_nr_addr_end(addr, folio_size, end);
+
+				if (!pte_range_cont_mapped(start_pfn, start_pte, start_addr, nr_pages))
+					goto split;
+
+				if (next - addr != folio_size) {
+					goto split;
+				} else {
+					/* Do not interfere with other mappings of this page */
+					if (folio_estimated_sharers(folio) != 1)
+						goto skip;
+
+					VM_BUG_ON(addr != start_addr || pte != start_pte);
+
+					if (pte_range_young(start_pte, nr_pages)) {
+						ptent = ptep_get_and_clear_range_full(mm, start_addr, start_pte,
+										      nr_pages, tlb->fullmm);
+						ptent = pte_mkold(ptent);
+
+						set_ptes(mm, start_addr, start_pte, ptent, nr_pages);
+						tlb_remove_nr_tlb_entry(tlb, start_pte, start_addr, nr_pages);
+					}
+
+					folio_clear_referenced(folio);
+					folio_test_clear_young(folio);
+					if (pageout) {
+						if (folio_isolate_lru(folio)) {
+							if (folio_test_unevictable(folio))
+								folio_putback_lru(folio);
+							else
+								list_add(&folio->lru, &folio_list);
+						}
+					} else
+						folio_deactivate(folio);
+				}
+skip:
+				pte += (next - PAGE_SIZE - (addr & PAGE_MASK))/PAGE_SIZE;
+				addr = next - PAGE_SIZE;
+				continue;
+
+			}
+split:
 			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
-- 
2.34.1


