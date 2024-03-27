Return-Path: <linux-kernel+bounces-121503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A688EACE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDA1B39EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854C13C3C3;
	Wed, 27 Mar 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNYvmzAK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABE139CEE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553036; cv=none; b=TsGnehcMcEb4e9KPOxOiOs+2NB/6uRMRC8LunkS6cW3D9RplL1UsfG4YVRSycKnRaCE8JoJCvXoyuShQFk/BB2tU7svSyxaaib4mzgFMAPxnjw7H1pQyor1RqSGl4UAJdlvsfsWm0zggZ8mKY6p+fLX6Fxw3Mwg73Ug2nGpI4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553036; c=relaxed/simple;
	bh=wYNV9XWYyUBPvblVuYGjSnaJhu/4sp2LbBGj9uz8/A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy+Szy3GMgO+ISH1ZURfWglJ+Ft+lGNNMUXoU4C4EO/2PDCRUw1trLAynVCtDDoPTpfoZyFGs6Z1jGVcdZQC0u0TMURD8UZWKmqyHCyHmuxF30+ipH5L3QF77oXZkufDhv8JJO4+zHArCT5jIKkKK6jMRUfjziDtSdewMpabUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNYvmzAK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDTtuz/iBLnx3uLIw0aNQbjjBf12gK6PRqFn//yUSp8=;
	b=aNYvmzAKlSyQST73WTN7Llka5855qjn3W0tnjCYXF3ev8g+Os8ArLxA5L9BPti4cPlHlVL
	RTVypN3eIIKQmSj6HHMHQVUYUouaKuQpWJkEmgdoUIeM1DtTjWjYjbciV679YYxZyizV83
	vrKNrxAh+i0Hmvj1LEOKdJttXBz+f+E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-vv9_xcttO3WQUO-wAAoQyQ-1; Wed, 27 Mar 2024 11:23:52 -0400
X-MC-Unique: vv9_xcttO3WQUO-wAAoQyQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69672754479so14006746d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553031; x=1712157831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDTtuz/iBLnx3uLIw0aNQbjjBf12gK6PRqFn//yUSp8=;
        b=Uobm3suYA3NP10I3+9iR+KqHMG1qsaOjsGufSXhRiDorOT3CHHUmUFDbZ1mC/imr5F
         r1+3ia+MfnGun+LF5ZcXViYkmLQmej0sIYVJ4rzTX3mpQkTE5sRbU6Ko5nuaHBnMUCVy
         gw9FIopFm9YSH3iO62KYPo/+LwQIp5bKSCF1KDLFcgDwTBfK+WlOqDMQwboTPtwsdKjE
         CTND76ORAr7pPuDCR1LY+Mpnr4WUDFrPuvuGTxARPOss17H/dkU8YRJ1ieB2QWfi6vgr
         Kfw8AYOR0k3z0wkC14wNn0cYI/y0mz2QvOUm4gmV8xSGZEkQDcqHK3Rc2CuGyU1gekzx
         DQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCULyBuuhGrL8ayRijbylhPUTlTTPfZPom9Kck3YhhZQCWNeD6l23h8eZrc4Ehc/40SSrM0wxdfxgQwrz7a2WXfihx3VK8o2BkoDjunk
X-Gm-Message-State: AOJu0YzWKU+NYzc6e1NBFzMyijAxfbIOLe7pWkcnxkaYLYlRYGuFPruM
	P6/lqYQkcb71KlJKLsBYIio0jzZDWCXSvgQ+YYf9pRcgWUtHIhIHnP3HSz8sKA3XFfCRTAsvPLt
	nfJImNkMDeBKmj8Zf9FJh8GjG8sfVH7LZmT/vgwDs6LSu0YturqrdhRk/ZWX9QQ==
X-Received: by 2002:a05:6214:2b86:b0:690:de72:316f with SMTP id kr6-20020a0562142b8600b00690de72316fmr14582151qvb.1.1711553030743;
        Wed, 27 Mar 2024 08:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWXp2F9loH7HSDfuOw6HflxlC5J0wiBYnMNwM1iqpFTIhT0c0cqQhWkIb89hM3i5euenCqpA==
X-Received: by 2002:a05:6214:2b86:b0:690:de72:316f with SMTP id kr6-20020a0562142b8600b00690de72316fmr14582105qvb.1.1711553030174;
        Wed, 27 Mar 2024 08:23:50 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:49 -0700 (PDT)
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
Subject: [PATCH v4 07/13] mm/gup: Refactor record_subpages() to find 1st small page
Date: Wed, 27 Mar 2024 11:23:26 -0400
Message-ID: <20240327152332.950956-8-peterx@redhat.com>
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

All the fast-gup functions take a tail page to operate, always need to do
page mask calculations before feeding that into record_subpages().

Merge that logic into record_subpages(), so that it will do the nth_page()
calculation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index db35b056fc9a..c2881772216b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2779,13 +2779,16 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 }
 #endif
 
-static int record_subpages(struct page *page, unsigned long addr,
-			   unsigned long end, struct page **pages)
+static int record_subpages(struct page *page, unsigned long sz,
+			   unsigned long addr, unsigned long end,
+			   struct page **pages)
 {
+	struct page *start_page;
 	int nr;
 
+	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(page, nr);
+		pages[nr] = nth_page(start_page, nr);
 
 	return nr;
 }
@@ -2820,8 +2823,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pte_page(pte);
+	refs = record_subpages(page, sz, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2894,8 +2897,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pmd_page(orig);
+	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2938,8 +2941,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pud_page(orig);
+	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2978,8 +2981,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 
 	BUILD_BUG_ON(pgd_devmap(orig));
 
-	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pgd_page(orig);
+	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
-- 
2.44.0


