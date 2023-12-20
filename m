Return-Path: <linux-kernel+bounces-7549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5881A978
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A7F284C04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CD4BAA3;
	Wed, 20 Dec 2023 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qzx6VMY9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651624F5F8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1ebH8KFDZAwQmMcpL7CVfnw0D0yWryPChREMd0TJrI=;
	b=Qzx6VMY9tescPO2U+WA1J5JTpUj1KyWwlVb/yOuneqg2Gz6TXVSe0eYcJwjIPMdNo/HREX
	u4UXWCKRyaNJH/V+TBYhcb5yU4u8hcgrVzRqMlbLu2Ul/+4OJRQxVmkmK3/FupCxHsNZcW
	I/zuC83P557ziqa5pPnaj4qYwjsCZTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-rl_PLPfaOFO5EtohbY1EwQ-1; Wed, 20 Dec 2023 17:46:10 -0500
X-MC-Unique: rl_PLPfaOFO5EtohbY1EwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD8D4101A52A;
	Wed, 20 Dec 2023 22:45:54 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D45040C6EB9;
	Wed, 20 Dec 2023 22:45:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 18/40] mm/ksm: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:42 +0100
Message-ID: <20231220224504.646757-19-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's convert replace_page(). While at it, perform some folio
conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8fa6053a225d9..146aa75fa6ff7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1369,6 +1369,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 static int replace_page(struct vm_area_struct *vma, struct page *page,
 			struct page *kpage, pte_t orig_pte)
 {
+	struct folio *kfolio = page_folio(kpage);
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
 	pmd_t *pmd;
@@ -1408,15 +1409,16 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		goto out_mn;
 	}
 	VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
-	VM_BUG_ON_PAGE(PageAnon(kpage) && PageAnonExclusive(kpage), kpage);
+	VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage),
+			kfolio);
 
 	/*
 	 * No need to check ksm_use_zero_pages here: we can only have a
 	 * zero_page here if ksm_use_zero_pages was enabled already.
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
-		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
+		folio_get(kfolio);
+		folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		/*
-- 
2.43.0


