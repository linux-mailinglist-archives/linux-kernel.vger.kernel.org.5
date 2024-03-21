Return-Path: <linux-kernel+bounces-110730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA208862F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A25281964
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F02137769;
	Thu, 21 Mar 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTEh77H6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53ED1369B7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058897; cv=none; b=DbuEqZSuyvd3CCAqTB4JZzQxanMWDLJOUxJwbO/xCy2AU3KfrsDikblT7SPGx2rZIm/U5XeptVUhTaeIR/WrqF88BaXXUSTFfQc9CIavws0qXvSC2L1Id0lV5I5AVdp1/Sz0CerTr+Vspvunv1QWW6O7ob+4RCyMhEY1ybQRCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058897; c=relaxed/simple;
	bh=Kixc0NMymkuIn9yHI5UxvEO7k03XXmYFgYWQVgrv4R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVp8jvOUyzOsJbYG+echIBtXKmU6WgwYgrnYRn0SlprV3II7tLiT0kb3HgRXBgx7uZ4RpAzsDWPESYufzRJAarK6soC0gRhdggQyIGvbbcP/YMgHulPJ/0uhN5sPGOPrlmBZGzHTtcD+MprnSn4f1aIsyaHRG3HKGqij60OYW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTEh77H6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwZ/C3Y+mq5srgVBOLaWiB530mwVuOVA1xifIUFcqIU=;
	b=gTEh77H6jYYKjNin2pl2EQN1I/WTJRQ3NVBs2IHAsPBY4D/8nDnlJz9KZ2deWbQqpnN2Gw
	AVYjcvd6rFrvpv7yrw32BVLOgXiLs2/U66PxI8W8uw1ITRE/6R6VjW5bCKOuB0TmPS5+0r
	6ED+ezhMv6m2u5/+gB2QqsDSR85iSlA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-coX52MI6OLC2UDlMig_9DA-1; Thu, 21 Mar 2024 18:08:13 -0400
X-MC-Unique: coX52MI6OLC2UDlMig_9DA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430b4572a97so4829221cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058893; x=1711663693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwZ/C3Y+mq5srgVBOLaWiB530mwVuOVA1xifIUFcqIU=;
        b=Dnu4vgFl97Yfr6DMgdytKYQwPeSrIqftjwa1VvK5/Y0Cf0flYnPNzIdMgXJmG/PpU+
         L9jIHTrIPoTmAUp/LCgcAfOo3T9FbXzT+8TAR3zh+DtSTBbOTOHrg6jAQJEtDWcZHm2h
         VACA20M/cNqS2glXEzGcV51Hq21hkWKq2/8JsUeDU9mGA5UaFGNQVguMmD+Ad4MLDkpF
         q4Hcz12FLJSxv26PWPWZtDpuOzKvIuUun4bommMnlDDHAi0GhPjeo4xtYu6w2ToFdr5K
         B4WSJ5k5QJAlrOGbMZtG5OShrwyJD9qunJWDRdJQNo7NntW89VsRbgcPZOpRJVw3L8UH
         B5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYu+3zb5Q/vES3OFSr/1a9LNKRY4/Y9g8JtPe6Jjwgd5JdvS4EwxNEuAFSbhjS/E310ZInWVWE15tVSc2b+22OKtjKVEIuSc9X4c/c
X-Gm-Message-State: AOJu0Yw8qHfJeUYfhs3wpPPu47VQsnMPYOWsZ9XNNfZIYnaXatHl/TXf
	nMxL/qaqv89Q8Rg9qulOMhNyQiSjAbns2KFDUWm13VKX/pzIPyitSGRDdSiWBSPHRGet8oG8n1K
	4XVwgm9sUsboo5x9pic+M7nsblmp6rfl5ycPgOWQc0s80mBxjdYRcbdh0vy507w==
X-Received: by 2002:a05:6214:3f89:b0:690:c35c:7590 with SMTP id ow9-20020a0562143f8900b00690c35c7590mr218137qvb.2.1711058893171;
        Thu, 21 Mar 2024 15:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl1Qmf0wBzWRoAAACR5bZA/I9hFYAFMFu/sm/LF6+WMAng7TWyPkikdWZMgBZCHnmtXnvmwg==
X-Received: by 2002:a05:6214:3f89:b0:690:c35c:7590 with SMTP id ow9-20020a0562143f8900b00690c35c7590mr218110qvb.2.1711058892727;
        Thu, 21 Mar 2024 15:08:12 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:12 -0700 (PDT)
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
Subject: [PATCH v3 04/12] mm: Introduce vma_pgtable_walk_{begin|end}()
Date: Thu, 21 Mar 2024 18:07:54 -0400
Message-ID: <20240321220802.679544-5-peterx@redhat.com>
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
index 8147b1302413..d10eb89f4096 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4198,4 +4198,7 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
 
+void vma_pgtable_walk_begin(struct vm_area_struct *vma);
+void vma_pgtable_walk_end(struct vm_area_struct *vma);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index 9bce1fa76dd7..4f2caf1c3c4d 100644
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


