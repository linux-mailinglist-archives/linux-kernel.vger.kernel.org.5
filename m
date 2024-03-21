Return-Path: <linux-kernel+bounces-110732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219C8862F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7197B22C38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF1137921;
	Thu, 21 Mar 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSRaYRRh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA137909
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058903; cv=none; b=WZ6D0gEDaBKPawE+ydntycgHfnBI5ZF8cKXbZ/Gy2pQYPMIkfp242plboWCYI0Ivl9olBv73IJT6KHejiwjinKDAGK8/UQhgPvRIBvy7Ey+F8khvvJTB/WqP5iBhc+aEMY0bdPwldpO+BUt080eNzT5hnev7CZkrTyQH4PDaeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058903; c=relaxed/simple;
	bh=QkztVZc/S8PWXxZ29LUGyIvEPUuXd1KAQiedbYq07Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoqBsaDfWH4StyZZSZhNavL3CS+50+eANhelwbm3Pfoe7WIGSrzZ7x4/IZaSlSmOY3xD2/M4htbfE8MEP/GpBNT8Kft8zQ32R9zvqvrOXRXQwIdH3so8ERXChJO6l6CFfMbpYsY3g/7Nuc8mGofWW7D8Y1oL7e2/1Kq3Fd1JdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSRaYRRh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI3BkO2nCtQEnBDt3PLoa+NL/Gig0J3ZsiByK6YiGEU=;
	b=fSRaYRRh0mb3sOrJiUnGZ73F2yFGbm0nbdHTkjFmvEafXJR+Ou3kolGbfIh1kwAoXrYSNc
	CkWwt0XeZO8Vq/w+Z3NczGbx7QF3qi4dx7Q0FdqUGNsce9b+lWuwhtuE8nTJWmjL1DHmWs
	Mh5GPc8ksik6WH0Mv/ba2LUm2di1vcI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-BudFdKofOrONiL_HQr_1rA-1; Thu, 21 Mar 2024 18:08:17 -0400
X-MC-Unique: BudFdKofOrONiL_HQr_1rA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7830635331bso30345885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058897; x=1711663697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI3BkO2nCtQEnBDt3PLoa+NL/Gig0J3ZsiByK6YiGEU=;
        b=eBQBaevr/kOwGggZO6+zqAvVDOBd8O73uQt17wvsvXJEbA8X0i2pMjX02Fe2X5BmtH
         FHHBXjEeyjS6xcsKzirsjzWDHN7HlOd3SpNzKfLNPCXs53OcK4sSfxKpli1ncq1aFbE8
         vOzWFfRtudkBIRC1QAPtjwgd26PgH16IIa364FWBbYZS/nZ99KvOBzkktyyP34LGiAbV
         KwgG1+X/z23vJqVrS+5g3KbwlbvPfz8sGkTY6AQ3YsVqFJ8bjXRPQ3heKI+xo4mfTAxS
         /K6nxp/vXfLkE0ftyR4DjLIEGq8/RG0LGtL2kOBukIEQNataMiWaI7FVQCGpU+lvjXNV
         d7uA==
X-Forwarded-Encrypted: i=1; AJvYcCVC/AGG1z/tyNGx1BZ+JxG5RI+/9j2UcOd6wekMlgDEy5lmoyovAPMDOAdrXlWxrmEm8PXWP3EdSH30vkdPYhWDKY3xb7J87UhdyBZ2
X-Gm-Message-State: AOJu0YxsFo/P2NG4/HdegfRrTUEDb+IJ7fYuD0xAymmbPfHDq/HcNW7h
	29KWLH5yoRHupRi3oWWzVYudMzYo1vKZYOpvTxMkdt2eaLpSy2dQGBvPNWhVEYz6mJ66rqNnBXQ
	BlaYsTD7MkDf/ZXLeTGyPstPaBqxlcx/2IU8KP8QWZGOx7fzjO85AEI4oofAbLg==
X-Received: by 2002:a05:6214:4489:b0:68f:e779:70f2 with SMTP id on9-20020a056214448900b0068fe77970f2mr443533qvb.3.1711058897149;
        Thu, 21 Mar 2024 15:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGuIUGmtGDilXkO+Txm1IkzpifWGQBAYBHvb3QP196cSPWL36y2snARbq2rVPrLWqoQw6FQA==
X-Received: by 2002:a05:6214:4489:b0:68f:e779:70f2 with SMTP id on9-20020a056214448900b0068fe77970f2mr443515qvb.3.1711058896774;
        Thu, 21 Mar 2024 15:08:16 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:16 -0700 (PDT)
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
Subject: [PATCH v3 06/12] mm/gup: Refactor record_subpages() to find 1st small page
Date: Thu, 21 Mar 2024 18:07:56 -0400
Message-ID: <20240321220802.679544-7-peterx@redhat.com>
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
index 9127ec5515ac..f3ae8f6ce8a4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2778,13 +2778,16 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
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
@@ -2819,8 +2822,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pte_page(pte);
+	refs = record_subpages(page, sz, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2893,8 +2896,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pmd_page(orig);
+	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2937,8 +2940,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pud_page(orig);
+	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2977,8 +2980,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 
 	BUILD_BUG_ON(pgd_devmap(orig));
 
-	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pgd_page(orig);
+	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
-- 
2.44.0


