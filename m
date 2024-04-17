Return-Path: <linux-kernel+bounces-148225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7D8A7F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AC4B22871
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615412F37C;
	Wed, 17 Apr 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvhj8g+e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC312FB3E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345815; cv=none; b=GoTK1fSejrrttSJxd4LIFWr/ExqcmEJ1a8RWqt0tUvQQg8HSx50mPr9rIWVukLXliWuhEXKlQ+2hhfcahN25zxi09aC+bqJDrzYrnG8WoUl3EG79HheQ1gIrDZvmg+8wXtTkI3UdjaXPr2pIVJVxrpFuBt4cZclZUuF+7mMrbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345815; c=relaxed/simple;
	bh=6/aOw9dUqBfjPQSRan8VN1NA3JWXNdX0DKCTq/jBgsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9nhrUwRLDBOv+8vbi8FKUDwLJIPxvlGScnj8N/45P7kZEbhz9IXOPu3fcxismTstyK/5knyFVVLiDEGBYj22NRmiCZLUFHJhLkUj+O7vOB+29utJ3auGIin+3AyzXdWLI7ZZYFqDcJuMdLemifdwexgxx5ySknmjTbUfK1UBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvhj8g+e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713345812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KJlX59pWoV+9ju0XmT0Dv5XXIefdKD1ijqlf4oKq4Q=;
	b=Tvhj8g+esjqrVKLf0yRPmhJIDFqhBx4xS+SVcpnPmgAkoWLZsbjLJMnO9/iYL+lg5fN4In
	J3+VjCs+wwUaeI6zUPPYYenO+n1XQrcvF3IRDX7GFnRMcKfaopsQD2ePOqmyOPohPxFZk/
	HY+R9JUPAtSGcb7GAIWFGF6ZdAucEds=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Tteg5mGVN_yPaHS7lxTX6w-1; Wed,
 17 Apr 2024 05:23:25 -0400
X-MC-Unique: Tteg5mGVN_yPaHS7lxTX6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1D1938116ED;
	Wed, 17 Apr 2024 09:23:24 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F31922166B32;
	Wed, 17 Apr 2024 09:23:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 2/2] fs/proc/task_mmu: convert smaps_hugetlb_range() to work on folios
Date: Wed, 17 Apr 2024 11:23:13 +0200
Message-ID: <20240417092313.753919-3-david@redhat.com>
In-Reply-To: <20240417092313.753919-1-david@redhat.com>
References: <20240417092313.753919-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Let's get rid of another page_mapcount() check and simply use
folio_likely_mapped_shared(), which is precise for hugetlb folios.

While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
vm_normal_page(), just like we do in pagemap_hugetlb_range().

No functional change intended.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cd6e45e0cde8e..f4259b7edfded 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -730,19 +730,20 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	struct page *page = NULL;
-	pte_t ptent = ptep_get(pte);
+	pte_t ptent = huge_ptep_get(pte);
+	struct folio *folio = NULL;
 
 	if (pte_present(ptent)) {
-		page = vm_normal_page(vma, addr, ptent);
+		folio = page_folio(pte_page(ptent));
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
-			page = pfn_swap_entry_to_page(swpent);
+			folio = pfn_swap_entry_folio(swpent);
 	}
-	if (page) {
-		if (page_mapcount(page) >= 2 || hugetlb_pmd_shared(pte))
+	if (folio) {
+		if (folio_likely_mapped_shared(folio) ||
+		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
 			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
-- 
2.44.0


