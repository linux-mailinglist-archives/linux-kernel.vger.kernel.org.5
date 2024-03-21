Return-Path: <linux-kernel+bounces-110734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D786B8862FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF661F22B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DF137C39;
	Thu, 21 Mar 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="II4mt2Pf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1913792C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058906; cv=none; b=KHI3MlGNElb4WQJcSyb32+KkLQqy2H7eG0Ap8AvMcpt8gbKEfhlYwWOG3Bodm1CSdEHgwikenxcwBH18hRpMFS27p7ch2ccgVdCdpxfZrX6qp0dyb5HA6tTc4sX7dzX9ClImrGRfJupoaNFMivdJOQslgnXCKbi5JgiiQYucld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058906; c=relaxed/simple;
	bh=wKfRUGs3K5Ab+ccxiD9h4kv+tcYnw5IVBdQPdiucKgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lro5Xvmfoj6KkdJ5HoFozBjdf32F4LrXbLy/4LlyyMVDNsZ2Gd5jVCg356FSZykhIepQvCVYs4JDzgmaIS0ogxHuCXasMvkfUjCcuTp5xBNAYlW8//r7DfxZQg4eTcTYdHa3Q2PvP4DVKmcDlpXBd1zT9rCqftFuRTynHFq8EsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=II4mt2Pf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ha5DGM0IN3r6kIFCrMZt60pb/ho2ZGKh4AhFb2qqPrM=;
	b=II4mt2PfxszPtdlzKAceCecc5PQSX5AEpsaaZu4xnPO1LcdZPfyR3N2b0Fklpvz44qGwA6
	4HpQJj/l3MHBqu+YZV8ExD7Z2aEe8uIqLj3Zn+hHqaS5642AUmSZwqLDmMyp67J5g59xQf
	g97mBJZAW+KhsX8tY1qnthUjh2V+Iy0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ZkPjh8X0PPGVa9Mgrf_nHw-1; Thu, 21 Mar 2024 18:08:21 -0400
X-MC-Unique: ZkPjh8X0PPGVa9Mgrf_nHw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690d3f5af86so3056936d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058901; x=1711663701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha5DGM0IN3r6kIFCrMZt60pb/ho2ZGKh4AhFb2qqPrM=;
        b=NLJQNosJoG9Zxql0crHr+JLfQKG1VSW/Pt0LhdY/qb5sYZvZm1wDXHYQ4eEwpLNyQo
         dVoIXTlsJDSfjjmXwHH8HUOTRw3qBhk/RfceHEALtVFI4qbcw0irQ4Oo2gbPYLIQD8Ol
         mEqi/CdXdhxZ85v7WJefUIh1YesrbuuZMY0z0xrAKLE0tHmt9su6hGgFCH4s7ubK6Vbz
         Nj0wlwXHLAHKmrg4tBCOYxZ7WIfmDTXaWsM8cdSdXioU5XrvoWEC6fdhhppYKi7PJoT3
         BFDBJS8UnfmvBUk7lXuZW27TChoN34yADpg6XtKr6dhnY+BQos0VIsQiGqm31bSBjf0H
         zT+A==
X-Forwarded-Encrypted: i=1; AJvYcCWx8BRxCuMvl/HhE8wf2w6RGmUfdq7dVb175Axo8SgeB3Kwl+TLRRPJtu2arBF2IZ1SrXoUVDa2u6fptNja5MCDjdwrqCzZ3wulCkZb
X-Gm-Message-State: AOJu0YwQbqUqrKs8QZ36TlS/2XTiMfoCvZn8TkQPEK5C9NRPEoKr9Pei
	lD594S8yxOihC55K7aU+rw0SE7YUxlVt+cuCkdRyuUliMmQ/TTjHalbX5tz0fGYOT19T1MuaRbM
	dj4yap4uni4pRIIjn3kniIOUARMBf5FETnLVybZlTjG7iqxNWEjTGk/5/NsoSnA==
X-Received: by 2002:a05:6214:3f89:b0:690:de72:316f with SMTP id ow9-20020a0562143f8900b00690de72316fmr214835qvb.1.1711058900924;
        Thu, 21 Mar 2024 15:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Op81dSYI2sDIbFIL6Ox+mlvTFr9echbLfQb+zyBeeZ6FRPjC6M2m9xSIjZkrEy5V/lebFg==
X-Received: by 2002:a05:6214:3f89:b0:690:de72:316f with SMTP id ow9-20020a0562143f8900b00690de72316fmr214791qvb.1.1711058900463;
        Thu, 21 Mar 2024 15:08:20 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:20 -0700 (PDT)
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
Subject: [PATCH v3 08/12] mm/gup: Cache *pudp in follow_pud_mask()
Date: Thu, 21 Mar 2024 18:07:58 -0400
Message-ID: <20240321220802.679544-9-peterx@redhat.com>
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
index 943671736080..a338944e4425 100644
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


