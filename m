Return-Path: <linux-kernel+bounces-121500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1988E902
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035801C304A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD41384B1;
	Wed, 27 Mar 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl1xieMF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780C136E1D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553031; cv=none; b=hxWpecX0OmxWWFqnECVlvDLd39Z5BfyzrxA8HtzWXUjkGuGs5YSCQoganNUTwkwPEPtftKEBvSlTdI0UxRjiDYeU1FYtl+CU2s6c5R2m7DwAhxVJ4pd8n4bOXoYm+YcwLzMVUJZ+Z1iaBtLmrpfuVdbpi3vvzTG7OTrea3XnRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553031; c=relaxed/simple;
	bh=CQelMMSK+S0Ub4u3Xa9b5n9JNVFuWTjPuPc5FYvFp0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdfWXftrxmwzBQzG7bthjFpWmBtzyuWB8JbmfM4lmI66+Nn1eH21m4z2mgKm0XsbjB7CS4z+N4eCe37KJ61dx3qlNVGwpMuoMQprZtgSZeTHaHvJcqe/hAkIpW17G1mk/M7adRsuIDw08Y5apOWqyxBQ6IqA8udEK/Kdwb1P4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl1xieMF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkfUQlJiw2YmDi669w4oXgCkjfbnGDZMVpc2LJneNK4=;
	b=Bl1xieMFV9z8hGu/mV/QsQBPxzMI7wSLvwuqHp9W09vkRKoYAJMLOjhAPvjcJEP1UcD52h
	ZKsfvMDZZmXaQOFSZLS6Gnsf/+dINvY9JIwTQRAR9YjYGHhRxSGrKWAPVyzqs3KfPDCohU
	Wc8DUEfQBRE0s26dA4iO1M9TYWb/zt4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-3oIGIPfaM1GiI3c3JSLpEA-1; Wed, 27 Mar 2024 11:23:47 -0400
X-MC-Unique: 3oIGIPfaM1GiI3c3JSLpEA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-690c19ee50bso2421916d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553027; x=1712157827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkfUQlJiw2YmDi669w4oXgCkjfbnGDZMVpc2LJneNK4=;
        b=B76dJ1y0df52kWYWIC9OpymBYGSajfTLsvdVPkNcQVZrbUGf1I56POY3Z0WTDT3Bvk
         YwxxlenEvrjIUWcblZ0i+c8anv6NhXRrOHzuZCyagyfJNr3LVUcImGFd87nwBlt6A6iH
         7xy/4mp31mAoIiN8PURQgD6Bmw491qT3lJ+bHCEqgkpnFHcmxz/DeKcWc52QaOKP2hXY
         nW1w9HSiiAgP7Imz/YrOmvjJTaJZln177zc9/ZmWKt+Cs0BfJyShOFaSOyagoFDnuwEO
         dhugoj7jFnsEzTgx2sJp29rJxNwaWNYKminai6jaraMG+XNlAep6LlDZlCnTsJy5ibwJ
         yJDw==
X-Forwarded-Encrypted: i=1; AJvYcCXJQCH5XZzp4eprlb0Xyn63/jIVhnQDMbjWGnMPRtJLnL48O44QNZ2dprMurkUQW7GJDvf17Zh/JUO5ZyvP29v1P+DtBk8O9/tZBnBq
X-Gm-Message-State: AOJu0YxCwWcm6WTTWtGcapTA4i6LVd94ifnU9RRWxnlC0iw7fnJZbpbt
	ebp3EF2wWSA9Ysf4bm3VnfZeTVuHeuAGKEhbyy+ogkejuQQ/2I9Vh4tu265sfSnalUdYdEc6g1c
	5/C/bhcxZJMUXFb7Q7gfrLFo0pViU65thsswtZL8UtpS7g41r/qp0FSNOmXNsYg==
X-Received: by 2002:a05:6214:3105:b0:696:6f59:4d19 with SMTP id ks5-20020a056214310500b006966f594d19mr14917326qvb.1.1711553026985;
        Wed, 27 Mar 2024 08:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/cvaZbNzejgmgOgxRck5pBSr/g3hsLSZETHWpBhBPVR+VZkVf7lYhXdSr9+e3t1xSA2Wfog==
X-Received: by 2002:a05:6214:3105:b0:696:6f59:4d19 with SMTP id ks5-20020a056214310500b006966f594d19mr14917279qvb.1.1711553026413;
        Wed, 27 Mar 2024 08:23:46 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:45 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 05/13] mm/arch: Provide pud_pfn() fallback
Date: Wed, 27 Mar 2024 11:23:24 -0400
Message-ID: <20240327152332.950956-6-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152332.950956-1-peterx@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

The comment in the code explains the reasons.  We took a different approach
comparing to pmd_pfn() by providing a fallback function.

Another option is to provide some lower level config options (compare to
HUGETLB_PAGE or THP) to identify which layer an arch can support for such
huge mappings.  However that can be an overkill.

Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/include/asm/pgtable.h    |  1 +
 arch/s390/include/asm/pgtable.h     |  1 +
 arch/sparc/include/asm/pgtable_64.h |  1 +
 arch/x86/include/asm/pgtable.h      |  1 +
 include/linux/pgtable.h             | 10 ++++++++++
 5 files changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 20242402fc11..0ca28cc8e3fa 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -646,6 +646,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 
 #define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1a71cb19c089..6cbbe473f680 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1414,6 +1414,7 @@ static inline unsigned long pud_deref(pud_t pud)
 	return (unsigned long)__va(pud_val(pud) & origin_mask);
 }
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	return __pa(pud_deref(pud)) >> PAGE_SHIFT;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4d1bafaba942..26efc9bb644a 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -875,6 +875,7 @@ static inline bool pud_leaf(pud_t pud)
 	return pte_val(pte) & _PAGE_PMD_HUGE;
 }
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index cefc7a84f7a4..273f7557218c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -234,6 +234,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
 }
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	phys_addr_t pfn = pud_val(pud);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 600e17d03659..75fe309a4e10 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1817,6 +1817,16 @@ typedef unsigned int pgtbl_mod_mask;
 #define pte_leaf_size(x) PAGE_SIZE
 #endif
 
+/*
+ * We always define pmd_pfn for all archs as it's used in lots of generic
+ * code.  Now it happens too for pud_pfn (and can happen for larger
+ * mappings too in the future; we're not there yet).  Instead of defining
+ * it for all archs (like pmd_pfn), provide a fallback.
+ */
+#ifndef pud_pfn
+#define pud_pfn(x) ({ BUILD_BUG(); 0; })
+#endif
+
 /*
  * Some architectures have MMUs that are configurable or selectable at boot
  * time. These lead to variable PTRS_PER_x. For statically allocated arrays it
-- 
2.44.0


