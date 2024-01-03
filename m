Return-Path: <linux-kernel+bounces-15317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD140822A17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD11B2333A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A818E18;
	Wed,  3 Jan 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyLdagZo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C418E14
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704273308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYdbUpgayprdP7mOXYmvw/zAFGJlyw1zyb2FaqhnNyk=;
	b=eyLdagZoQKSxjruraGbK7BkKzn/SQWlTSmyUFA7CDkEyv2lIGO/Xb5ZK6DFaoTBIrrHxvv
	T+kiWTmQPx5DtE4sfjfcA0mNqfz4VsB43nIms0WJ0b+evWSs+WcJUH+CByMhtZE/Ym1zFN
	XAOn2nX9u4ik6lYtdjBIOlz3evqZOdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-bCcbehl8OCy9I42YtKqcXA-1; Wed, 03 Jan 2024 04:15:05 -0500
X-MC-Unique: bCcbehl8OCy9I42YtKqcXA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20CC685CBA6;
	Wed,  3 Jan 2024 09:15:04 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B69E3492BE6;
	Wed,  3 Jan 2024 09:14:52 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Jones <andrew.jones@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 02/13] mm/hugetlb: Declare hugetlbfs_pagecache_present() non-static
Date: Wed,  3 Jan 2024 17:14:12 +0800
Message-ID: <20240103091423.400294-3-peterx@redhat.com>
In-Reply-To: <20240103091423.400294-1-peterx@redhat.com>
References: <20240103091423.400294-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Peter Xu <peterx@redhat.com>

It will be used outside hugetlb.c soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 9 +++++++++
 mm/hugetlb.c            | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..e8eddd51fc17 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,6 +174,9 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
+bool hugetlbfs_pagecache_present(struct hstate *h,
+				 struct vm_area_struct *vma,
+				 unsigned long address);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
@@ -1221,6 +1224,12 @@ static inline void hugetlb_register_node(struct node *node)
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
index 0d262784ce60..bfb52bb8b943 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6017,8 +6017,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
2.41.0


