Return-Path: <linux-kernel+bounces-148661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519648A85AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CC51C20BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B491411E6;
	Wed, 17 Apr 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgMvqu6F"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82E13F444
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363309; cv=none; b=OR1EanP7aFPLrtGTFXmzqIhXCcMyjeN2DW940fWLdHJtjtkZX0OJj6j8L2ZZIVe5FU89Pgzj9Deq8jHKAqwEyYuIUMsUd/4RTtdVMplZM+mBnuD/zh46mY7wwdUgnl0TdWJARZOepLGAsgcccK1LfW0FJiPGGgck1MR+aZUoRVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363309; c=relaxed/simple;
	bh=vs6Beq48+kXNT5qsMOGp08C7Ii4wZzzBthcyqUl9lGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5/ippqZnYFUHoYvJZ0jThKjU8eSuWcpaiNrRXc/Zy0r1r5843Ohi5uT33uxoebC/j8pjAbl2F3heLacbDIAvKsjcqpqYLM6w5ovki0WZGU4T2P/eDzNK7fWa5atVXKqtQ86rFfSIKcY/JFDsZ/CGp3NE8BYUEctoIjOuexX0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgMvqu6F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0bec01232so47107315ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713363307; x=1713968107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XITq4/hgHmAHZ0ZHlNrd2qmUtOIaf33ePb9J0ZwzOSE=;
        b=MgMvqu6FqStoQlHg8irmeyAy5bymH8PICNssyWp8LGvCju1YZ6HsePZrnXylyhu9Km
         D210aPGM5Jp9ztS4W/KVPwIdPMZXpFzkh0TfkQillGtjkCtCAr1XbMPnH0ZU/DmjYZfM
         SFejjqXZ/hNZM+kKL83Rc1KcHdEwAeyCQ4xagebHZkaa6XPjtVRHRePzM5dOeZB3ua3q
         vvVKeSVgK9nf99hoR4z+YpD5uEpbhxnF7FxLR3V+UoPynFugLiCd+aik8Oj5omn4bIPn
         ZsnlSmVJTcLNdvdRcVoudGO15uIFYaAKnM02SpXjrh1bG6P0BPgptLbZPFLkhAUgZUvE
         a5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363307; x=1713968107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XITq4/hgHmAHZ0ZHlNrd2qmUtOIaf33ePb9J0ZwzOSE=;
        b=FqT80IF0JB0O9kqjcM+/qo8/B3+IDMjasg7RhmTfor5oPZsGGvS3war0x3d3E2ihzv
         Jzo0OadPpLCwkNaPlv07fK7dOFslNMV0qq6mLPT6zF5AVbYsd1On1gWvlIN0UgYat3fj
         Q5KUOagT3mD2NWd/xX7kQ06lUM0QKIDMP2Y1u7YjOyU6j3M2FLTvRIKD1tvwG5UoLIXr
         ClEzC4VNEqAIeZ58b1mQ4tclCUorBZm+6aKxOm0PP5arLq8rNZItllyJSJH3rWe5alQy
         H7OnK+76BaUWX/ZNTF3TPnZxIuYRADmn5dHn1VO/yKCtX6F9FTwY3Xd4rjnoCbLll/RW
         S9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJj70t3mDkpejnqEunvFo5q4Nsi9Qj9XQewhguB/NS5HFTkUueymr6PfP6Wn9cwm3+KlhVMpI/ICDJ5g2YnT6gD5xDOkIb0if4v8gT
X-Gm-Message-State: AOJu0Yx4Cmk8VAwOq3j6m1d17rozF+R77E8eRVA4v+PIzHeehZiA8e6P
	+ECyOZGEe/5jBCEIglM3wPA0iQp9vMqjYo8nokqrXECyTTpwR3H8
X-Google-Smtp-Source: AGHT+IEDm4KbIbQ0YdOSAbJN1v6q6PUuVmA+Q24uMMWeXUZznbyNrcroRNDGswYL5SuQ2L2kRGe+oA==
X-Received: by 2002:a17:902:6b0b:b0:1de:e6a5:e51d with SMTP id o11-20020a1709026b0b00b001dee6a5e51dmr12852592plk.16.1713363307446;
        Wed, 17 Apr 2024 07:15:07 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902a50e00b001ddc83fda95sm11613562plq.186.2024.04.17.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:15:07 -0700 (PDT)
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
Subject: [PATCH v8 2/3] mm/arm64: override clear_young_dirty_ptes() batch helper
Date: Wed, 17 Apr 2024 22:14:35 +0800
Message-Id: <20240417141436.77963-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240417141436.77963-1-ioworker0@gmail.com>
References: <20240417141436.77963-1-ioworker0@gmail.com>
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


