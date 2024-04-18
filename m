Return-Path: <linux-kernel+bounces-149933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15668A9803
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968952826BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2615ECEC;
	Thu, 18 Apr 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+ZNKWXP"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A115ECE7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437906; cv=none; b=q41jGKyWCfzTKWIIEAd3jXT4q/GKRkPts/WBmYrgPcOIv9OuEIRMu/lUlNUFYCR1CdZ6Xo6HGVYLIzh2vmDtgmvuuhgDJOLx6F/lNHtI/RY9XOFnNZ8d1hjD0KEZgwiUaIlsj2gV1lMaQi6k6oWQ4Pg9hItK7vw8nYtA7wojltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437906; c=relaxed/simple;
	bh=vs6Beq48+kXNT5qsMOGp08C7Ii4wZzzBthcyqUl9lGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbvbv2cIdnckBNuVIHCojXP5185Jwu/ZIsHpYJ+EwYAvclXgmiltUD5y4ngiLMSnZniSpRc8QiaKcwIL/QKweWOEnYgwBeoAbLVQcn8NZDrz5jqjetAL5SJHJJpKXep5El06GOb98YVoG71mGOKOLBJ+s0lc1aiNZ+R+mDfiDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+ZNKWXP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso718821b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437905; x=1714042705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XITq4/hgHmAHZ0ZHlNrd2qmUtOIaf33ePb9J0ZwzOSE=;
        b=d+ZNKWXP2xgwpmKE9rwVmxr1K5GPgU6i3WJeRuO/0a65CVqLG3cYJE/0t5FjmBxISF
         iKN6nAA+onp7pMnDIhmT/FWVQQw5gtLcd/j8Et1fEVON6AAN6r1VU0MirmEhcKAT7ZPm
         eYUlbx0fE17w01GFDqkur2Og8BtPStAyEtA+LOUb+BPlYlLHt02K/ziFR5gZ5TDmSDQe
         b5jJwsSYqYunt8/5g/obV81sF9HTlL0CbbV/Xl0TTvmLcg3HGMWl2mtyIPmZSlsJd5hp
         1W3hulBIGtWusj1zIBuBolu0CgrLNBYP3h3xFUySMOwYOOSjCrTTxhqqaQaXkKZfF5JR
         dIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437905; x=1714042705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XITq4/hgHmAHZ0ZHlNrd2qmUtOIaf33ePb9J0ZwzOSE=;
        b=fFAd7AWrsaQo/EfC/uxEVkZd4ahsjHMC9GKRAs3DZK5zZqNVwNdVHo0fYKJ79/uzpY
         o8pB5lIy7wdUpquQP938ynuX7OqruPr2odkS/u901HfMemdP7ZWnbXBnSbfQZahlmbck
         H6pyIfSokI/pRUc3IpYNRITf9eD9kDIT5eGqjyeCFsCiD8ersfverKap6XX2ivWwFCPx
         zA3WRB2vjRUWdHPvB5ZgGXFdAKTpgmviMUqv7xibfB4TpdBW1H0JKgCe9ccc+3VwOTGw
         8bm8lsbA9TnWcBNKuOpzTr2KNzMO/O25jzxq15MpDFg4EB1xMp5p1ZhBfH6ouLdqCpkb
         2J7w==
X-Forwarded-Encrypted: i=1; AJvYcCUlQ8IiW3NaA1Bsw8m3naxcegM41ZUji3hlK2FDQaAnprNfUd1ukVObJZUbzTSNyE6IriWlHN/JpQDV5tjwNF/N8XS2peSuVOvliTFz
X-Gm-Message-State: AOJu0Yxaa+4YXWcv8BNTOuzqWrpKtdXfmwp/fr695FWDaBYb5lSVr5g8
	/AhaRD5iZqa7Qle+wLPl5jUXHJ0O0/BrrW+FZvQN0FzmpsfnV9fk
X-Google-Smtp-Source: AGHT+IESWKGXs5SVUDQDCP4J36Ikudx/CjpP5NVMmnbx2ui5miMXKMf1AI2xrY+wo35NeL00v+rfzA==
X-Received: by 2002:a05:6a00:1acf:b0:6ec:db05:36d2 with SMTP id f15-20020a056a001acf00b006ecdb0536d2mr3186097pfv.4.1713437904694;
        Thu, 18 Apr 2024 03:58:24 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id gd26-20020a056a00831a00b006ea923678a6sm1200487pfb.137.2024.04.18.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:58:24 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v9 2/4] mm/arm64: override clear_young_dirty_ptes() batch helper
Date: Thu, 18 Apr 2024 18:57:48 +0800
Message-Id: <20240418105750.98866-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240418105750.98866-1-ioworker0@gmail.com>
References: <20240418105750.98866-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-pte get_and_clear/modify/set approach would result in
unfolding/refolding for contpte mappings on arm64. So we need
to override clear_young_dirty_ptes() for arm64 to avoid it.

Suggested-by: Barry Song <21cnbao@gmail.com>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 55 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          | 29 +++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9fd8613b2db2..1303d30287dc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1223,6 +1223,46 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
 		__ptep_set_wrprotect(mm, address, ptep);
 }
 
+static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
+					   unsigned long addr, pte_t *ptep,
+					   pte_t pte, cydp_t flags)
+{
+	pte_t old_pte;
+
+	do {
+		old_pte = pte;
+
+		if (flags & CYDP_CLEAR_YOUNG)
+			pte = pte_mkold(pte);
+		if (flags & CYDP_CLEAR_DIRTY)
+			pte = pte_mkclean(pte);
+
+		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
+					       pte_val(old_pte), pte_val(pte));
+	} while (pte_val(pte) != pte_val(old_pte));
+}
+
+static inline void __clear_young_dirty_ptes(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned int nr, cydp_t flags)
+{
+	pte_t pte;
+
+	for (;;) {
+		pte = __ptep_get(ptep);
+
+		if (flags == (CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY))
+			__set_pte(ptep, pte_mkclean(pte_mkold(pte)));
+		else
+			__clear_young_dirty_pte(vma, addr, ptep, pte, flags);
+
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
@@ -1379,6 +1419,9 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
+extern void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep,
+				unsigned int nr, cydp_t flags);
 
 static __always_inline void contpte_try_fold(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep, pte_t pte)
@@ -1603,6 +1646,17 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
 
+#define clear_young_dirty_ptes clear_young_dirty_ptes
+static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  unsigned int nr, cydp_t flags)
+{
+	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
+		__clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
+	else
+		contpte_clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
+}
+
 #else /* CONFIG_ARM64_CONTPTE */
 
 #define ptep_get				__ptep_get
@@ -1622,6 +1676,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define wrprotect_ptes				__wrprotect_ptes
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
+#define clear_young_dirty_ptes			__clear_young_dirty_ptes
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1b64b4c3f8bf..9f9486de0004 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -361,6 +361,35 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
 
+void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep,
+				    unsigned int nr, cydp_t flags)
+{
+	/*
+	 * We can safely clear access/dirty without needing to unfold from
+	 * the architectures perspective, even when contpte is set. If the
+	 * range starts or ends midway through a contpte block, we can just
+	 * expand to include the full contpte block. While this is not
+	 * exactly what the core-mm asked for, it tracks access/dirty per
+	 * folio, not per page. And since we only create a contpte block
+	 * when it is covered by a single folio, we can get away with
+	 * clearing access/dirty for the whole block.
+	 */
+	unsigned long start = addr;
+	unsigned long end = start + nr;
+
+	if (pte_cont(__ptep_get(ptep + nr - 1)))
+		end = ALIGN(end, CONT_PTE_SIZE);
+
+	if (pte_cont(__ptep_get(ptep))) {
+		start = ALIGN_DOWN(start, CONT_PTE_SIZE);
+		ptep = contpte_align_down(ptep);
+	}
+
+	__clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
+}
+EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
-- 
2.33.1


