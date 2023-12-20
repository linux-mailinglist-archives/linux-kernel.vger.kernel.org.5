Return-Path: <linux-kernel+bounces-7544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A440881A967
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60656285E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129584EB39;
	Wed, 20 Dec 2023 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZmH7XcE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100784EB32
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Tzzmpk6zqHgghmJ+i7focJ8fdDU2jQOAW0uh5TyPi4=;
	b=TZmH7XcEH6I+TnAUQC5PbvA8H4rjhL8hcY9nXHqOm0Wv8wNTilU1/qPY4/tuwHenBbIRqY
	fjikaA5glv0y5iRtkTNcmyWsVXCddkWTasyKfIWm2UVOO1HgQljY3spt+UbY1PFDOW6Y2n
	KR+tZXbIGUHuPk3iVlprPeH6M1j6EgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-LliV0quuP_Oqxcmuv5B2DA-1; Wed, 20 Dec 2023 17:46:00 -0500
X-MC-Unique: LliV0quuP_Oqxcmuv5B2DA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E106486EB20;
	Wed, 20 Dec 2023 22:45:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD18440C6EB9;
	Wed, 20 Dec 2023 22:45:57 +0000 (UTC)
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
Subject: [PATCH v2 20/40] mm/memory: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:44 +0100
Message-ID: <20231220224504.646757-21-david@redhat.com>
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

Let's convert restore_exclusive_pte() and do_swap_page(). While at it,
perform some folio conversion in restore_exclusive_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c77d3952d261f..6552ea27b0bfa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -710,6 +710,7 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 				  struct page *page, unsigned long address,
 				  pte_t *ptep)
 {
+	struct folio *folio = page_folio(page);
 	pte_t orig_pte;
 	pte_t pte;
 	swp_entry_t entry;
@@ -725,14 +726,15 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	else if (is_writable_device_exclusive_entry(entry))
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 
-	VM_BUG_ON(pte_write(pte) && !(PageAnon(page) && PageAnonExclusive(page)));
+	VM_BUG_ON_FOLIO(pte_write(pte) && (!folio_test_anon(folio) &&
+					   PageAnonExclusive(page)), folio);
 
 	/*
 	 * No need to take a page reference as one was already
 	 * created when the swap entry was made.
 	 */
-	if (PageAnon(page))
-		page_add_anon_rmap(page, vma, address, RMAP_NONE);
+	if (folio_test_anon(folio))
+		folio_add_anon_rmap_pte(folio, page, vma, address, RMAP_NONE);
 	else
 		/*
 		 * Currently device exclusive access only supports anonymous
@@ -4075,7 +4077,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_add_new_anon_rmap(folio, vma, vmf->address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
+		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
-- 
2.43.0


