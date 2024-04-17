Return-Path: <linux-kernel+bounces-148224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C006C8A7F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F162D1C2113A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD72130A77;
	Wed, 17 Apr 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfiYuU+c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1912EBE2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345809; cv=none; b=jJsLKw6x7a+bHsxm+gzS7NnEk/Kr14LSeHJp6CVfhS8LmYnHPfkXzlPLFOzFnehdvESVRd4o6NHS5/bDXXUuuuEzENHbxWih/4UawJso6Kjxuzebs0V2gHbPuBMv7af5vG9a3/94UDzx5DZDZMdfoQWchNYUm6Xk9D1cyrRMVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345809; c=relaxed/simple;
	bh=kR7NgpoqseIcWNXCbEV890XSu1aVULd4AJRo63fLdGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmFT6ZI6ZmmSMQQZ0ix1hxBjQCOrE0oJyvpm5zBxr8E+eMqzHoEAVZhanijS6PnRduhOckez7nyEVuxMH8zZn90bRmT6TwkEtl7ExpzpcxJgths4VA5Bi3zdmHem4Q4Tl15wukgc+V6qe+a+yg69Vt4N2QDjSlDZLVRRBEl1iNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfiYuU+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713345807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XkSYCF8J11KhT1kD3yECHdoktxsLGeadBVxc6aZ2IU=;
	b=WfiYuU+cNDI+tUaotrawNtkbzhKH+u72O7HOZqL1iRGTT5UtYvgAuvjGONM7paQ0qJz8bC
	xt6Dtm6+MtTi3IAi49Xt8ifby5/hs5erBLjOIU2sn+LfuIrVVPUbOmYRFgCkwSzxncRq4a
	7+CH7CD8B1yAslg5bSuD3gsOAPi9264=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-pdv014c2NOGreuXLt_k0MQ-1; Wed, 17 Apr 2024 05:23:22 -0400
X-MC-Unique: pdv014c2NOGreuXLt_k0MQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91F0A830E7D;
	Wed, 17 Apr 2024 09:23:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F22C2166B36;
	Wed, 17 Apr 2024 09:23:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 1/2] fs/proc/task_mmu: convert pagemap_hugetlb_range() to work on folios
Date: Wed, 17 Apr 2024 11:23:12 +0200
Message-ID: <20240417092313.753919-2-david@redhat.com>
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

While at it, also check for PMD table sharing, like we do in
smaps_hugetlb_range().

No functional change intended, except that we would now detect hugetlb
folios shared via PMD table sharing correctly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8ff79bd427ec6..cd6e45e0cde8e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1578,12 +1578,13 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 
 	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
-		struct page *page = pte_page(pte);
+		struct folio *folio = page_folio(pte_page(pte));
 
-		if (!PageAnon(page))
+		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 
-		if (page_mapcount(page) == 1)
+		if (!folio_likely_mapped_shared(folio) &&
+		    !hugetlb_pmd_shared(ptep))
 			flags |= PM_MMAP_EXCLUSIVE;
 
 		if (huge_pte_uffd_wp(pte))
-- 
2.44.0


