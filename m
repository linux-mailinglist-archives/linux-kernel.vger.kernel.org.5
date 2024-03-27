Return-Path: <linux-kernel+bounces-121505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C788E907
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA561C305F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A95113DB98;
	Wed, 27 Mar 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZBUUQ1t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAF137752
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553039; cv=none; b=YqCpySA/mlQGxZUkicLpSy/T/DDPbw6dnEvmngreFk7R+vrPENSf4yMGpqKZxKQQeOEPFHyaeB10TMKA0FQ9EUacWkPc4/iuVdWv4jYXvoiHG5SFSsbOUvkLUV/+4A8eoTCDVtsUxlvkFp5etzaThxJXJhxWjJ0dLEmH49nP1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553039; c=relaxed/simple;
	bh=LP9xY+SfzwUZk4UYjL/cCTlaLX0S30RgPNe581NajRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlRRoqHZ+lvoOlXS+7+6zKwHQ/BAyTxLiLBnuM7kq0Dddx3jAssEkm5DJ04tWO0h33li7QMmh6s8oBGy7STzs826DdI77WY7XVhuKSHkypM0WYOLNUXyj6x+UK7mPacY+js0QOgVpTffQ/T07r6XfeA8NampkNNNc+xA8WPxTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZBUUQ1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClTZB7edrSwahK3rulsC63VROBcD1QOdNuRXa61Ddg=;
	b=aZBUUQ1t2WyqGMCB1eDYk4LhLIOErL3VlhjBF+hPJsf1aQ0zyOtLRjOewKJf3tbRDUz6mm
	Dypys88NPWOGGlxUF6ZPLs+cNCAr7GR1oSaJaDTbESR1p7QCtjNdq+YcAMft90qb5YcPXg
	WybX8dM2meYZGojN4LfLIFtymK6byyQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651--WrbOiAMO2qgV8Da5Fpnbw-1; Wed, 27 Mar 2024 11:23:55 -0400
X-MC-Unique: -WrbOiAMO2qgV8Da5Fpnbw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-696a5972507so4146906d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553035; x=1712157835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ClTZB7edrSwahK3rulsC63VROBcD1QOdNuRXa61Ddg=;
        b=srzPHnZW/RYPYPjACLBfBlr3SnMEd90siHWamjwpZmIlxoYr29jiRe74Oo6VqVKWQC
         6wS+sTAoLZSYnEvS5UUyjk3AbFBS+nJZIRaDKaV4Aapz7LFYFTO7jaMnXiov+0ph4tFf
         LrYCdfw5MBvkBrk5W8A5Lw53vvctgdnzoI3O/Z42Uetgjre8WilBBm2sJYXavINCT9uI
         W7uVKB1ESqA9UOa5nJScYufySpdV1O+z09P7DzHNOlznEW5zesTrQK06D/8Qpjin7FPc
         QMXfg6NdvzunPHS9ksaZaKdbQ+OaM7HoFjcKzRvioXJ4CW5+dsuNIy7e/fKVv0VAj10X
         tGFA==
X-Forwarded-Encrypted: i=1; AJvYcCWy1Xg6CZFHhtIeisZDG0etjKxP+XOqmSQETkTPaOb3bHNjMP6nv+JScXdhANs/x38+2ow4lUtdc/3u7yHiA2sSX7ZNhTPOtP8WIbxg
X-Gm-Message-State: AOJu0YynjHxBbqXr0y9EA4GosDoFIY4WQZa+5zClc0sX4UvT2DOFss/r
	vkeooCezabuekJaKuZRU77jxoBtPnH4dwH4SYf0cZizN+24C+0lA2lGdH3+J3lt7mtD9AxuX0Rf
	Z8HIbnlf2ZuWkiM1FVyJQKKAdCmu5e/BYQZyng1bFMdUfHOQRCv6RZ8CE0o3yjA==
X-Received: by 2002:a05:6214:3d8c:b0:696:1892:c19f with SMTP id om12-20020a0562143d8c00b006961892c19fmr15035536qvb.3.1711553035007;
        Wed, 27 Mar 2024 08:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT3GjlhPAIM0f0tWP3PNax9bFYBunh5winrPqMP8FazkZOSJ/P00xdKeX4lX2Up3S+10Z8OQ==
X-Received: by 2002:a05:6214:3d8c:b0:696:1892:c19f with SMTP id om12-20020a0562143d8c00b006961892c19fmr15035509qvb.3.1711553034516;
        Wed, 27 Mar 2024 08:23:54 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:54 -0700 (PDT)
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
Subject: [PATCH v4 09/13] mm/gup: Cache *pudp in follow_pud_mask()
Date: Wed, 27 Mar 2024 11:23:28 -0400
Message-ID: <20240327152332.950956-10-peterx@redhat.com>
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

Introduce "pud_t pud" in the function, so the code won't dereference *pudp
multiple time.  Not only because that looks less straightforward, but also
because if the dereference really happened, it's not clear whether there
can be race to see different *pudp values if it's being modified at the
same time.

Acked-by: James Houghton <jthoughton@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ef46a7053e16..26b8cca24077 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -753,26 +753,27 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				    unsigned int flags,
 				    struct follow_page_context *ctx)
 {
-	pud_t *pud;
+	pud_t *pudp, pud;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
-	pud = pud_offset(p4dp, address);
-	if (pud_none(*pud))
+	pudp = pud_offset(p4dp, address);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_devmap(*pud)) {
-		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
+	if (pud_devmap(pud)) {
+		ptl = pud_lock(mm, pudp);
+		page = follow_devmap_pud(vma, address, pudp, flags, &ctx->pgmap);
 		spin_unlock(ptl);
 		if (page)
 			return page;
 		return no_page_table(vma, flags, address);
 	}
-	if (unlikely(pud_bad(*pud)))
+	if (unlikely(pud_bad(pud)))
 		return no_page_table(vma, flags, address);
 
-	return follow_pmd_mask(vma, address, pud, flags, ctx);
+	return follow_pmd_mask(vma, address, pudp, flags, ctx);
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
-- 
2.44.0


