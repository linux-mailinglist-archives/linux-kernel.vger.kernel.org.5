Return-Path: <linux-kernel+bounces-110728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811868862F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369B1280DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FDA1369B8;
	Thu, 21 Mar 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmqDaG3Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C913698D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058895; cv=none; b=DljqkKUShiT5Ml56sREk8+SIKWxD41+17AO4tgI7JSvyvllufOuNvrrQkIfUBGIgB+VeVqN/lFsYZe769g+d+HwzmsVGaWmKrK6n2by+CyXJGW31fdTiCzmH5YE9tS6fr9x/xR8NbsIPFw0PBVl+FJPuUNiEC322JBYh0GMTA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058895; c=relaxed/simple;
	bh=+4tZFXGWGkSnTz93a1WxUt5Jp3XdX9cL1+SLoKZJKc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c80mW/P5WJS3Wpq/F8Ksurlxriy9S9XGWsqSvMxj9YW9Iw2UsSsQROAKOEKo3bE3g/WLgRB2HpVpc3wfo7M2uafRslP0xXvOKZcOHqn77oakzNp0BMEWCpYAQPE5NlUQm/mgWmoxowk0V1QNOe68rkvHpl0Pp1mpD+seL8zGG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmqDaG3Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz9rMLZ3uXx9gi3+G5qYwalRYpIGEA6fjYlj3iYlq7A=;
	b=KmqDaG3QJeibo6THK7uh9vMDJPbTPl9oAJVqUC1c0NNTrBsq7k+odxG/an31Kp+ZvKtRsh
	vYleRoMOOsdESN2dPgVXHUoTBqOwykMr+3gvuL46b6XxQdqCXpqB38aVYaSkCV8uJ0EXHE
	gkno7CQVHfTPM+0O6DuMhec4KjOuhu0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-L_DSMoqsNk2TWtPgRTkENg-1; Thu, 21 Mar 2024 18:08:10 -0400
X-MC-Unique: L_DSMoqsNk2TWtPgRTkENg-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4769277a5fbso157091137.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058889; x=1711663689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jz9rMLZ3uXx9gi3+G5qYwalRYpIGEA6fjYlj3iYlq7A=;
        b=hVvUlf0nz12zSS1bjFWic2G+CU0YdJ/9nQcHR1M5oVSa4TeyQKH1izkRRF5JaxJ9he
         IFwiEwCRWJPH8HiMf2kjiUZQkqrauUb95XsMvxzb1mFSy0irVwEN4X8aPyK73TEP+tOR
         k9firVsnsg8kUU2+VFWRSd3X/K8tJlJuObEIzskfh9kDQLhshQSUEJvWizadwCmt3skb
         LQ/VkPOAhKaqlu5Olak/iAaHZOX24ilehSI675C3jsTHc9F9pQfRNsUJuw1ZEFsgTCMN
         juUkKCZoviEOMTt5T7ZyQvcsInfD3AJE5/ao9sFEi4AynNcSbuYLMk3OTOECxS+sRtnv
         hcAA==
X-Forwarded-Encrypted: i=1; AJvYcCV3PdcQU9pZyeR07MZV3ML6fSm8LzKzUZm6wKkt0YWEnBHrNZxTwlw9insC7qgms2YnUFqJz3Nd+c6yn/XQ07nvmW1y5pPZBnNaVcfF
X-Gm-Message-State: AOJu0Ywnfw9/ADsNCPvfghDGkjNBJbmEUw/Np45iCO/C/dT47fAPTy68
	HGcWiVHSeVus/QhCxMPW7qtx/GVg352E4TwP6DnN/QBV4RYYXkluVaWNlJsbz/LuvIf++6f9hPN
	wBRUtnwiG9WtGEfLQBU4ISdQXkp3dJXTyz2N7xOe4AIrEpZ3iIEyfDXzrXongEA==
X-Received: by 2002:a05:6122:6b2:b0:4d3:3a78:60e2 with SMTP id r18-20020a05612206b200b004d33a7860e2mr108423vkq.1.1711058889439;
        Thu, 21 Mar 2024 15:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYDbaW1J9E1O0bYtn9bzXmgf1WJ4RRo+0b7nGhM7jp1NUFRItVBXPR4HtJOs8C30IHezp50w==
X-Received: by 2002:a05:6122:6b2:b0:4d3:3a78:60e2 with SMTP id r18-20020a05612206b200b004d33a7860e2mr108396vkq.1.1711058889030;
        Thu, 21 Mar 2024 15:08:09 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:08 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 02/12] mm/hugetlb: Declare hugetlbfs_pagecache_present() non-static
Date: Thu, 21 Mar 2024 18:07:52 -0400
Message-ID: <20240321220802.679544-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321220802.679544-1-peterx@redhat.com>
References: <20240321220802.679544-1-peterx@redhat.com>
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
index 300de33c6fde..52d9efcf1edf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,6 +174,9 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
+bool hugetlbfs_pagecache_present(struct hstate *h,
+				 struct vm_area_struct *vma,
+				 unsigned long address);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
@@ -1197,6 +1200,12 @@ static inline void hugetlb_register_node(struct node *node)
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
index 23ef240ba48a..abec04575c89 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6129,8 +6129,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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


