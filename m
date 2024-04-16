Return-Path: <linux-kernel+bounces-146181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EF8A61C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B8F2869AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112D1CD06;
	Tue, 16 Apr 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8FrvfbH"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693901BF3F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238529; cv=none; b=GXoSV8hyk4s5TCLSvrYdJHWNvjZZwmwD8UCKO9XbMJGpy8gO3KlTX+tEoKKztlZBxbNEK+MhF02JjhjsAYamMfjlmw/DdmWtDEO+Fsq+p3rxd3dSy3T6F3qBTjliIVh92gU8HpJIJlWnh6uVd35a1/Fb7Bdkp5Z1DBKUuWZczek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238529; c=relaxed/simple;
	bh=0h4Wm3udrJbqframZc/pycjTWsnl8R7vEO2NuwnHsiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4Pga50Qt86rkXAKdOwpJHCRdKB90V/YlqdC5VQs545GC19Ln6iXp6f0O7ajgsMlqt7Q7t669SXWEQvo+DTPrvHlh2dvdQKJ8jo/u5GziVNS7BepiF2Wkz/tyF/FnwKKpiWQQfO8ifPwkObslctRiFW5DZbf4I6Lwj5d1iGsJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8FrvfbH; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22edbef3b4eso1364217fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713238527; x=1713843327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa5U5Lslaz+G0m1rVPRlrShOq/KcuLodfgFv0sEM+Zs=;
        b=K8FrvfbHpYhbIcSmuks7msBi8EZ7tqV8BXvmYJPo3J0BCPSR9KXaH50A0C6jYLdVuy
         UHZSfULduekhm17DCumy901uSpo3eN6VZ4xTv8vM/d8mHF8RKkeaBDp4a+ZFW2UhrIJW
         5BV/wcwX3m/vIC5zg8/sdaRtxl0bfDAy03VS6o4L6KXgC6cvOlAciwHzmsjjRUzu6DYf
         4q31Pxe8umPSWgDnpBRhWdU3jov9SAwSVTb+Resob5KwO8j7bBeogIJ1emgIGiQMXjQF
         QrQwpE06gTyLw0V254BgZ9a8KBdJOgS4Y4frIniC3se32ue13ztH06P9D5IH1DYV7Xap
         SivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713238527; x=1713843327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa5U5Lslaz+G0m1rVPRlrShOq/KcuLodfgFv0sEM+Zs=;
        b=cNU2WnITAcemLL07yuLwTE5ejaz218vKctwAaKFkxqLmRMBDu3QvKcbeSrHIeBqQtw
         NeIlojbZchmCHo7iH0sEj+Ourpar36m52ah666L9mU8PHaJpzJscPDA3X3rjun8Qe8qa
         xoG5Y86Woc++3Bd2996jQl/0TfsuVTbn9zp+7w5E1m3sRAR7UPZQqBMzBBl/hZLVlE9E
         X8lpzVoCK9Oi2ICsE2chxG1kBwngSFpezM2TPiMAe9JkRHrjZy/+2azOPwR4MqtjsWy4
         IkC43BG8OWkj3E/5iLAw5EtrkJZx4W9v4D7DQUTinhQDTlxuuR6XB+naRgJ7aS4T5xj/
         k3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVYOMGq5TQur5jHqoqF9CUxTmKjr9mKi/qOSGj1wx+yKY5n2TnAaP0/eTLTpiVtrJd1flaoXNXv3JdxaF++7apr3DJhzEFNOpw4ShQu
X-Gm-Message-State: AOJu0Yzg0aP23dxHJpSp8on/ElwYQAcaCnjhmLgYeFq4NbceUU0e7miJ
	r1tHpiOly7EAkIOjWibe0Z3rUBt6jWmCTaM04yQJnlT0pNmagkJT
X-Google-Smtp-Source: AGHT+IHwk5g3eb1ccJ96pB5R5kMJw+NcK5BFd59uPH2p5YulEU/Mhp5PXvWdZqm/wREsRZ7pVF+wYA==
X-Received: by 2002:a05:6870:63a9:b0:22e:d382:87dc with SMTP id t41-20020a05687063a900b0022ed38287dcmr14773843oap.22.1713238527433;
        Mon, 15 Apr 2024 20:35:27 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm7906737pfb.8.2024.04.15.20.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:35:27 -0700 (PDT)
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
Subject: [PATCH v7 2/3] mm/arm64: override clear_young_dirty_ptes() batch helper
Date: Tue, 16 Apr 2024 11:34:56 +0800
Message-Id: <20240416033457.32154-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240416033457.32154-1-ioworker0@gmail.com>
References: <20240416033457.32154-1-ioworker0@gmail.com>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
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


