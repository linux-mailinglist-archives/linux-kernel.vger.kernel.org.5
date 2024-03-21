Return-Path: <linux-kernel+bounces-110731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206DB8862F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837A21F2271B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0C137915;
	Thu, 21 Mar 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRWAdnJe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BACC137766
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058901; cv=none; b=AH4ul1D94SAZFh1/eKrbLlZThSP68fHDsPuFeVyRo8GUYWGqKAZgoM73wG6vySw30Nqn4tD4iob7ruI2ulZNUdbA9mkkhkq4P61YrINA7vnrUJYxqJhxEWxyW5A7cTHgj1iIVYv718/Eik8w86JVFfV9s3THolTpiKzGAtHVpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058901; c=relaxed/simple;
	bh=kGkGjH9m/y0RS3YSsTAfsfr/ljhTQ3+fy8C6MUt+UTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By59petyimTX7QHRJejgHb2iRHvz0fqgA8FBCfxHPNwY7jnE0v4UjUXO++BiOn5XN/uTXLVQdWQfCLbx7frCxAZtyxnPfYqjNufHUVzlHIs7N4fInFuq0zA/rr1Q2XDIOYAqFklCAvM5+1vUOfVqdPChg8Il/lPVY2ld2bflsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRWAdnJe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUPAT0rXQJh3Nc2mzYzsdwstyixoWF7iCZ8XsZkm6u0=;
	b=bRWAdnJeZM60ToFbKNNGK/wmobEWhc+HluD2f2gxBOK21zZ+3Hws4ZcnQLGjlEaCVG8deZ
	Q9pbU9iQXYL8USAbirGe8Al0l1nhdhEuRLWOEj2ENW+/mGkrH3fiTs1yLqlxt7jHB4//Me
	f+9sOfCkMxs2HtzRs+XqpAsRBoUFpgk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-IzMwvxmePIWfBKkIqdaVmw-1; Thu, 21 Mar 2024 18:08:15 -0400
X-MC-Unique: IzMwvxmePIWfBKkIqdaVmw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78a364064b7so14872585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058895; x=1711663695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUPAT0rXQJh3Nc2mzYzsdwstyixoWF7iCZ8XsZkm6u0=;
        b=lh9CJF3NuMPv3ci1ffDruQgr9x9LmXrENk/9QYAnKgIkN8MtbUr15X/3dxL3myqaVw
         69vXhu6i8gKO9JLpE5lRZDC7EaN61BJIJP2v6v9X/PhM9VpeH7JqNx/Rvjw5hy6tB+0G
         xWFSxZ/72gMsj1to5Z+pUrkvJmerQK7qm5rRxlS9HFUtHfTwbH/0An+3Nw/sdEq6qOQp
         1zgxRDUtXkd1t+x+jlZw3+Ij01qtbwNbc0FNa2sDsL+YhyqEyMHqkJWfIGxD/Jy4M/iL
         iZooaDnySF8RTRGq2117/v/9gJ5eu0ihI6eRs692axcQtc4/RdxSPXLwxvEjT/8HLp4C
         YPYA==
X-Forwarded-Encrypted: i=1; AJvYcCWVg3BdkidEhEJgIuQO+ToTcUx23Mm4dcwcyMPZnzdbZuu81uTZ0g3McFxaPZlusukeclpSasxb3xm1PSITBL/ZsVAXUDoYSci2RwLj
X-Gm-Message-State: AOJu0YzfmoXQiy+091hg3zOBqzPQp3R33CXs3jOK293E0Mh+9tgzYYWd
	zI8T9Ix5dscBixwnEt4rch+oy0xPzJJuX6eYqD+9z+YEozcaFz2D4MsT30+nT9++jYSk8qTeM6F
	RO/odcAZ1TwBPw2C2CremwqoUafL9dGvXzM5IA5bpKmJWMO4+f9/PuW8vwSX6cg==
X-Received: by 2002:a05:6214:3f89:b0:691:2524:2d87 with SMTP id ow9-20020a0562143f8900b0069125242d87mr214719qvb.2.1711058895189;
        Thu, 21 Mar 2024 15:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuIdayMB3K1ezoBSvCD0gJVl53LosR8J8AUw6cJS5L0fxLggs0ufmC9b8hoGFmk2jAJqKnIA==
X-Received: by 2002:a05:6214:3f89:b0:691:2524:2d87 with SMTP id ow9-20020a0562143f8900b0069125242d87mr214690qvb.2.1711058894780;
        Thu, 21 Mar 2024 15:08:14 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:14 -0700 (PDT)
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
Subject: [PATCH v3 05/12] mm/gup: Drop folio_fast_pin_allowed() in hugepd processing
Date: Thu, 21 Mar 2024 18:07:55 -0400
Message-ID: <20240321220802.679544-6-peterx@redhat.com>
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

Hugepd format for GUP is only used in PowerPC with hugetlbfs.  There are
some kernel usage of hugepd (can refer to hugepd_populate_kernel() for
PPC_8XX), however those pages are not candidates for GUP.

Commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
file-backed mappings") added a check to fail gup-fast if there's potential
risk of violating GUP over writeback file systems.  That should never apply
to hugepd.  Considering that hugepd is an old format (and even
software-only), there's no plan to extend hugepd into other file typed
memories that is prone to the same issue.

Drop that check, not only because it'll never be true for hugepd per any
known plan, but also it paves way for reusing the function outside
fast-gup.

To make sure we'll still remember this issue just in case hugepd will be
extended to support non-hugetlbfs memories, add a rich comment above
gup_huge_pd(), explaining the issue with proper references.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 484a7c70d121..9127ec5515ac 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2831,11 +2831,6 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
-		gup_put_folio(folio, refs, flags);
-		return 0;
-	}
-
 	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
@@ -2846,6 +2841,14 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	return 1;
 }
 
+/*
+ * NOTE: currently GUP for a hugepd is only possible on hugetlbfs file
+ * systems on Power, which does not have issue with folio writeback against
+ * GUP updates.  When hugepd will be extended to support non-hugetlbfs or
+ * even anonymous memory, we need to do extra check as what we do with most
+ * of the other folios. See writable_file_mapping_allowed() and
+ * folio_fast_pin_allowed() for more information.
+ */
 static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 		unsigned int pdshift, unsigned long end, unsigned int flags,
 		struct page **pages, int *nr)
-- 
2.44.0


