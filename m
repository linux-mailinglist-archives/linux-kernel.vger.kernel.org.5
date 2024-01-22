Return-Path: <linux-kernel+bounces-33875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F043E836FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA97FB324B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF64F889;
	Mon, 22 Jan 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1W2a4ob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED74F882
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946057; cv=none; b=R6zJZ5btoPq2LnNOovg80xA8OgCcBHRQUcwVkY5JDS0nwQ7mAzhYnPMja28iYdJAxjKJ9H6Fh+39oDhpLF/bcoeH+26E3C1CUQVzEp1/koj7OuVxBZXP2f029PKWLxY+9pApeQLTiJDP8PTjCWHTJZB476WPp8aHuKd0mXCk3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946057; c=relaxed/simple;
	bh=tg9utdLp57nc9+REw2xsAtuWEOdCmguZmjEX7pmM2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xcuz+Ije9EymiCwxAwJ33r6RpXTx5QV+KU9/i/8vYoQmwPZgxaduYAN27MDZa2W8+CSLO5VMkvsn2ACyuDXycT6c2t5hD9TpWtnIdIXba95kVUmoBN0z4Jmmyhxy/vCVHH1cnszE7e7AhbbocQ804qyhJyTxgRo4/umrWeDHVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1W2a4ob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705946055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=biwSam+t0PPy6PPpzP9oz0wUwC7UyF14RlOoYLHaCEw=;
	b=Y1W2a4obDbuqfqxscOXmWS/U0wqjFaaGrCGSvHy+4uu+issX5lD00vfC1eopYSDLNSk75I
	VopyDKcBMJOFzSgjm7glMLXpZuc5Bs7VlhKJFfQoLkDGVlqDtQLFSvNrUQJLelqvn5jdiF
	5jGS165vY5lBNSgZRwZSn2+qGpNcJRU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-pPwM8tCnOhSZpJ2qAO1VIg-1; Mon,
 22 Jan 2024 12:54:10 -0500
X-MC-Unique: pPwM8tCnOhSZpJ2qAO1VIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D6D3C025CB;
	Mon, 22 Jan 2024 17:54:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 147482166B33;
	Mon, 22 Jan 2024 17:54:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] mm/huge_memory: fix folio_set_dirty() vs. folio_mark_dirty()
Date: Mon, 22 Jan 2024 18:54:07 +0100
Message-ID: <20240122175407.307992-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The correct folio replacement for "set_page_dirty()" is
"folio_mark_dirty()", not "folio_set_dirty()". Using the latter won't
properly inform the FS using the dirty_folio() callback.

This has been found by code inspection, but likely this can result in
some real trouble.

Fixes: a8e61d584eda0 ("mm/huge_memory: page_remove_rmap() -> folio_remove_rmap_pmd()")
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b4596..5f31e51f22356 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2437,7 +2437,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
 			if (!folio_test_dirty(folio) && pmd_dirty(old_pmd))
-				folio_set_dirty(folio);
+				folio_mark_dirty(folio);
 			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
 				folio_set_referenced(folio);
 			folio_remove_rmap_pmd(folio, page, vma);
@@ -3563,7 +3563,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	}
 
 	if (pmd_dirty(pmdval))
-		folio_set_dirty(folio);
+		folio_mark_dirty(folio);
 	if (pmd_write(pmdval))
 		entry = make_writable_migration_entry(page_to_pfn(page));
 	else if (anon_exclusive)
-- 
2.43.0


