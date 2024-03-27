Return-Path: <linux-kernel+bounces-121499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60388E908
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3CEB39950
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4CF136E18;
	Wed, 27 Mar 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZvan6kS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5613281E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553029; cv=none; b=gTi34zAB56W5/RripVgpTX2EWHTafrVy7V3MgmfLTSeD8NdqJ74PQODhwe9IlarPYxXJMxo9PuPBRsSc7CgKKd76ksWIS91QCUtiuwkns4/KZ640KxUFLHrzsl+d8tP+DPh9FPJlexzYg9SnX0Z/h/1eilEjSH5sq11slP19sHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553029; c=relaxed/simple;
	bh=AoS7mf4a6Dp10U2gUQehSk1IWMDM1kG7yPxjJ7XH/Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxZ0XczP6C/Ca4y3XAKaMRRfSBCdf2hW8jPxGR+JVGa9a0UA29xKEIMaQ+F4Eugxol7urK435QORXUFlWZKW30tr4MwmAMJ0qERpjDbPpZGdl0hUfV+2TaCZoXw+y2jzC3UcYacg1BGdnGzEOPFFZqxLznsgjnfeMOz0f3arNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZvan6kS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iN7hVKxpU9yGNoa0FvV6QQfaV15Sbc5QZKf/pqr08oc=;
	b=OZvan6kSnGSVzfX5zXQfgueJ/5IF50WurcfG5QC1o4MY5b9az+R0TdTmej+PzLHL9eMhLB
	Pm0jzs4gYZ6RjxzW0YUu2AN/6P0mHBp0cHk3G/elelG9wJK9tKfXJqP/Z8Ax8WMYHBwiDx
	+ghxymiLqyWJQeyWwcFEfnmwFX5DtkE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-iUB2lyTXM1eipbwLaXlMHg-1; Wed, 27 Mar 2024 11:23:45 -0400
X-MC-Unique: iUB2lyTXM1eipbwLaXlMHg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-696a9c482a4so3595856d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553025; x=1712157825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN7hVKxpU9yGNoa0FvV6QQfaV15Sbc5QZKf/pqr08oc=;
        b=T9aj9TTB8wdmHkIZo8el0rsVRzmiSVwMfbQU5kgwS5fbD8HW/MY6w+4DvlhCBAYeFe
         quQYVjqfoI9ARh8fhq1g9+I8Cqa2EF2He4PThYNWu01hbBjQK5f+s5hQAmfK37YEEZv4
         3HJpShJrYwd8whyglhFKmdLp1Glwf2dj+APhwCb/TxDl7omMmU0iaCQ9S/ga83SsPfU9
         AC3281qwpx3NtYD1JZmSzIZ2NhqDUECx3gf6fG4sLvt8l1kp6f6EcVMDN4JX2/h8vg7D
         XLVTx/s8eNeGS49VS+6gAEqdznCZBd/SrmVzk2dUaLa/k6CURNzrkOaoug7cyDaII/pe
         RpYA==
X-Forwarded-Encrypted: i=1; AJvYcCUMbOdIl3cH3TVBFdVeIq597Eh0693+Rdj8E9WnlM5MqR3iT70WYsH35vZiK4BQGcb7RxFJxqdJm9q5dPadvWFabwCsxmqoQ0e3/cr9
X-Gm-Message-State: AOJu0Yxl5gaJj167uVz1coPTZDXLhB12T5qmN5AiAk5BY57qvViAIByq
	M3Po6PGvsagwiFESbt8AZsoivKuVrWrnugokRrL24lTQa43Z6oBuehq30/Y2K2dVLlAqahNBpJr
	kUpd8GrAo2fa4SvdA0Mp9IppYdVojgi4kuNOCyOTtJ+iMsyWXlvisRU2U5Dm6wg==
X-Received: by 2002:a05:6214:4598:b0:696:7b32:cceb with SMTP id op24-20020a056214459800b006967b32ccebmr13869554qvb.6.1711553024689;
        Wed, 27 Mar 2024 08:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS0Dr3UNRPnI4el/D5x8gcrtCXLMsQwIvd4dOzHJoXuoNg03xhCSCfsu9VpmJMAiYn3G+95A==
X-Received: by 2002:a05:6214:4598:b0:696:7b32:cceb with SMTP id op24-20020a056214459800b006967b32ccebmr13869513qvb.6.1711553024070;
        Wed, 27 Mar 2024 08:23:44 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:43 -0700 (PDT)
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
Subject: [PATCH v4 04/13] mm: Introduce vma_pgtable_walk_{begin|end}()
Date: Wed, 27 Mar 2024 11:23:23 -0400
Message-ID: <20240327152332.950956-5-peterx@redhat.com>
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

Introduce per-vma begin()/end() helpers for pgtable walks.  This is a
preparation work to merge hugetlb pgtable walkers with generic mm.

The helpers need to be called before and after a pgtable walk, will start
to be needed if the pgtable walker code supports hugetlb pages.  It's a
hook point for any type of VMA, but for now only hugetlb uses it to
stablize the pgtable pages from getting away (due to possible pmd
unsharing).

Reviewed-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  3 +++
 mm/memory.c        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index afe27ff3fa94..d8f78017d271 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4233,4 +4233,7 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
 
+void vma_pgtable_walk_begin(struct vm_area_struct *vma);
+void vma_pgtable_walk_end(struct vm_area_struct *vma);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index 3d0c0cc33c57..27d173f9a521 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6438,3 +6438,15 @@ void ptlock_free(struct ptdesc *ptdesc)
 	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
+
+void vma_pgtable_walk_begin(struct vm_area_struct *vma)
+{
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_lock_read(vma);
+}
+
+void vma_pgtable_walk_end(struct vm_area_struct *vma)
+{
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_unlock_read(vma);
+}
-- 
2.44.0


