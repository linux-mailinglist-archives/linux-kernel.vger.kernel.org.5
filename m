Return-Path: <linux-kernel+bounces-121497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29688E8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560351F23FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958A131BAF;
	Wed, 27 Mar 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp7mpPh6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398912F594
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553025; cv=none; b=FfYrBRgboXHzvlwT9CwEljsMg8LuQ3H5jO+23Ekkge3DX10FkPN0Jro9ew6N7a5RgtElZ/A5ZLtMZCxTsf/7qSWNDJbYan6Axn+LCOWjei2kfl0IVrqJ2ZaURP03z9YtlFzaHimexkiVHcOvROUEDwtgnvy0c/a2vdjMsn9RFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553025; c=relaxed/simple;
	bh=dgfgLZsqOn9isp9ediyDcsNww/iiopRn8l8/GuMNoJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky7/ggGPr/fAVrzJHp+LZriJNwoucYv/AFRZovYKYC4rRZli9pWMltGQxrp/nrvh+0MQ/IBqaOV/L+YLIwRq+tK+UkGmtioWoeEvdJUlVu9lo/ra0PrJQTKapa/cwqbkw4nvvQlpNUeC9ypmBm/plL3+MPTWJwr/Cw0aKLpmYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cp7mpPh6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DKy2rskdC2Yvy4b+7pXCefd1yMSUUO/lg/gxYCRDGA=;
	b=Cp7mpPh6xxs6pt5wlZ+QY+OxLxoAx+TdcecAKJMlPYwPopXAEvCYavFclAkp28rF4UGjOh
	VH6AfqUh0yMCtVAnRIKg9jW2obEq+wXidjBGallu7KOJNEqNlLSCkPy2LvMV5MZE0P5ZYg
	I8+X2Bl+OCDrwrsX4Dz7NS+XIp7bhZw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-rPk8VRtrNNK0YtsW2bQyQg-1; Wed, 27 Mar 2024 11:23:42 -0400
X-MC-Unique: rPk8VRtrNNK0YtsW2bQyQg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c377528ca3so585631b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553020; x=1712157820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DKy2rskdC2Yvy4b+7pXCefd1yMSUUO/lg/gxYCRDGA=;
        b=U2QVv77VIxv7i2Z5UTpeopK1CH5J/nl7EEqxsHV2UUp9L6x470exs+6KTkg2LLb6gX
         nOqP+eg/o9M/2a+Ci5oausTlTB8OfSuuJf2IJN1pFbD/BcVv2yfXyJsqMPdKn+CI5D22
         pVugqfUpRbpjM9o9pQBwQgJRnbdQ0jECtJ39m8KFapsUCO4T5dqknJabsOl0Fd9j1wIa
         hp9LX8MiFx+CXyUh70Cmalp2P5I4xW48ZPefhmnKOPnQVkMAKtMRhgE258NJa2I18zIw
         mmXLKgUKY07ZFFbqXI0VweKje4So8TYeC79l58mJXull9ji2lj4ctEMGIIjAqFV5r7Yz
         HZxg==
X-Forwarded-Encrypted: i=1; AJvYcCVP383nVmgI2CjyJejceCpspVm6IBi7Cc55I5zuKxkMqTbwYCfwblCZsHCZA3/p7gJOLyi0RWKkq7aJXzCLwp0HzJIdxOCdduN613uT
X-Gm-Message-State: AOJu0YwQKF/r1mF5JEoLKH9zsoYMOCdK9EzKigOygVvF8b7lQ//MtCrQ
	aVSdUMVDEuvfrIS0AK6+Pl6NuF5XzzW1SqkjbPLXPswn+lrWQio1ABLmXgoMu/L1zSphyEtkxs5
	Jx2D8LNkQBI5B4pK13DvhJMtQ5z0ZUpSWE1QhT6inaZGQ1hxHaeYMc8WAxqV8Mw==
X-Received: by 2002:a05:6808:1814:b0:3c3:d28a:b1a8 with SMTP id bh20-20020a056808181400b003c3d28ab1a8mr370352oib.0.1711553020019;
        Wed, 27 Mar 2024 08:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUSCRMAKzeIW51sHYtQ4kGfBJ1LCcy7xm5bPm4kr5W7dAQlFQDGhJMDaaF/OcaFnro9iqkpQ==
X-Received: by 2002:a05:6808:1814:b0:3c3:d28a:b1a8 with SMTP id bh20-20020a056808181400b003c3d28ab1a8mr370311oib.0.1711553019443;
        Wed, 27 Mar 2024 08:23:39 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:38 -0700 (PDT)
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
Subject: [PATCH v4 02/13] mm/hugetlb: Declare hugetlbfs_pagecache_present() non-static
Date: Wed, 27 Mar 2024 11:23:21 -0400
Message-ID: <20240327152332.950956-3-peterx@redhat.com>
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

It will be used outside hugetlb.c soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 9 +++++++++
 mm/hugetlb.c            | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d748628efc5e..294c78b3549f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,6 +174,9 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
+bool hugetlbfs_pagecache_present(struct hstate *h,
+				 struct vm_area_struct *vma,
+				 unsigned long address);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
@@ -1228,6 +1231,12 @@ static inline void hugetlb_register_node(struct node *node)
 static inline void hugetlb_unregister_node(struct node *node)
 {
 }
+
+static inline bool hugetlbfs_pagecache_present(
+    struct hstate *h, struct vm_area_struct *vma, unsigned long address)
+{
+	return false;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f9640a81226e..65b9c9a48fd2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6110,8 +6110,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 /*
  * Return whether there is a pagecache page to back given address within VMA.
  */
-static bool hugetlbfs_pagecache_present(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
+bool hugetlbfs_pagecache_present(struct hstate *h,
+				 struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = linear_page_index(vma, address);
-- 
2.44.0


