Return-Path: <linux-kernel+bounces-150193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366E8A9B87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6E4B22085
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E200160790;
	Thu, 18 Apr 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy1jzZe1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8B1635CA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447893; cv=none; b=WJhYREDlGzsTNXUZ7986ZXOqgkJ2ogFucxeL7CyISn5u6L23iGrCc7Q3DZCpZrHEkyB+cfR3Y2e/IzFL0kkFR7zbhn+e5qcl4OZ0mYWrcp+VkIFWmXZLfJsxzWTANitRUwzdqSEyp0Dd5qe403AyrpVlVenFeyMc6PIuMPGGF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447893; c=relaxed/simple;
	bh=vs6Beq48+kXNT5qsMOGp08C7Ii4wZzzBthcyqUl9lGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nN/6h94PItWrYu8WDQ0IyMOatLnx3CoqG0Fk3Qq7/2XVpOemLu0GpDTXc/VjU7yFX7sW9d2dFFZUjiJU4JuJZmoEBqZCgnNVkNTY5RVHwSMi6c1sl8FjRFKU/2d3LA0QN2T9WtqOfHvzLcncqxtSneYFVB0dNBZeS+9ZwGk+fdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy1jzZe1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2178b2cf2so7522085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447891; x=1714052691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XITq4/hgHmAHZ0ZHlNrd2qmUtOIaf33ePb9J0ZwzOSE=;
        b=fy1jzZe1tieU44OGut/eAKh14C0yk5j3Pr/YZ+XNHWdNgSsVSfAd9mRpYwGKpmYnK2
         1OntILn48k1YHKXBCZo6UhZIvgTb5YunBD35J2nGSGEfXDVJ7BGErOON8gXDLg3R1wzC
         17en/J/SZ+y9SZrL0xg/yKq4u0i5PyWW3iPNszUwts7y3RrZ7v84PjA7CQu7uDOmJj3v
         Bol8+mjXtzDM9pKnvgNauVlJgEnLkBF8hzg1ntM8lk1RYhykrNMu6U4YBjN4ZQABpqa6
         XH8FdMnJSgE3nPKKryn9mbfToRs/DKkczDy0LY+o0dJXAzL648/v5Je+EkmYA++o+VPe
         p9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447891; x=1714052691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XITq4/hgHmAHZ0ZHlNrd2qmUtOIaf33ePb9J0ZwzOSE=;
        b=N1BMGNljkWRgnVt44DlDFrEzRuA54t1A/N76NNO5bVLdKi824YxLj/pdaLS+134KvI
         9sNh2KiYD8XlSHKwsG75hk2FDIayBLaWNGv7xx3s9+ggGjYeDCieEKBQIa5lDk90PiX/
         bVmci+QIf3rYJAwp01SL8jXCIdAiIWqIvlMDi7v7M1DYXj/zY3FiAdW2m8sI72mgU7EJ
         fCyTIwIeacKrHZNvYy4U/5pWXBvx1lSYk3WUTximBjz3H/8mEccDbH9Jib08s23ah41O
         KxOevsxFTxuUGJKWf84xppybcZGd4vgodsJV1QVszSws668X1aTFQFrCMpXGEKUbBv6k
         SmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdtxMCRcNOxPQkkVLs4lT/iERWZAkguyf0tlJZ8jVsipaAiXvFsvo2FuzRUBlWrWCq/e9yi0EfHIO+1VH9oCV0KJ1FlkzYe5tcT6l8
X-Gm-Message-State: AOJu0Yx5eRpZy85SUmxifyQcNHb1ZDvhFQbmIlXpQkbKwEuJV8CXbJs3
	YJzhdkNXhGHS2ZLHpja/2GvM28LMeunbgLOZcUxD2ZA1vuZFfA3E
X-Google-Smtp-Source: AGHT+IFMvPYbcwWGZBEI/RPL6zIG2k4X3bC8gD2IhYt301UAgb/Og2L2LjKZC1QkdaZ8PQQDYIe8QA==
X-Received: by 2002:a17:902:db0a:b0:1e2:1db3:ebeb with SMTP id m10-20020a170902db0a00b001e21db3ebebmr3985587plx.57.1713447891167;
        Thu, 18 Apr 2024 06:44:51 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001e4fdcf67desm1504837pls.299.2024.04.18.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:44:50 -0700 (PDT)
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
Subject: [PATCH v10 2/4] mm/arm64: override clear_young_dirty_ptes() batch helper
Date: Thu, 18 Apr 2024 21:44:33 +0800
Message-Id: <20240418134435.6092-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240418134435.6092-1-ioworker0@gmail.com>
References: <20240418134435.6092-1-ioworker0@gmail.com>
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


