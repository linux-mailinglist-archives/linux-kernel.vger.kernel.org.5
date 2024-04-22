Return-Path: <linux-kernel+bounces-153927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9EB8AD4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5C61C2157C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621C155346;
	Mon, 22 Apr 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz99ZMEZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C2153837
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814948; cv=none; b=taGOhwaFbON+9Da47oaQNmZ4aOTNJSY3Lkp7byhWUU+t/v/rT0120+CAB4HlF5HBJ6lfOfjvzZ5c+RYLlp4xfODOxvihVouMjErtBMGPEh0iunSVWtR72nBg/ihlj3AF/kRF/xTziadmrbjT/MMqhRYouvHgjNZ8EbXf6NB3L9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814948; c=relaxed/simple;
	bh=hVJxRhMiKvmJgAmPeGobX/MJeoNE6UnGxtAnC2NjbKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu2lvebNe5dxnE6SW4LVVhWiBDOYYkMFv3YlIjdmQhI4lbrEQO6Vg1ASY69RwOM4S7z4je+ZgwgOr2eiHiVUJJZdBu1gmIg8JNepRwmPfO3d24EwXz/J8iLVqWDIj4GSWiz1xmdBQczakcuL4lC8cR/Ir3nPa5IMEprjUSgex7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zz99ZMEZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713814945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ucWdKV158GrYn1kO4pc3kHGoGPk+vBTZiotaaItH/pY=;
	b=Zz99ZMEZyTj20FQEuApCI/mOt5Z+qlP2CKAQdckGSXVhVuovH7gYre0nfI8ED5RXGgoUZs
	ply/x0qU4L7rrzcv0+FY9YKx/bqC/9h/KsLirccGC32XaGeoNhUAFO9HZYCq8f2L+qwZyK
	Urs4h8n/MYB6OgikcK+P01eXL24KeZk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-wSKHFJSgNk-g6QeCqelw5Q-1; Mon,
 22 Apr 2024 15:42:22 -0400
X-MC-Unique: wSKHFJSgNk-g6QeCqelw5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD7BC29ABA16;
	Mon, 22 Apr 2024 19:42:21 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86E1C40C5C2;
	Mon, 22 Apr 2024 19:42:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v2] mm/huge_memory: improve split_huge_page_to_list_to_order() return value documentation
Date: Mon, 22 Apr 2024 21:42:17 +0200
Message-ID: <20240422194217.442933-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The documentation is wrong and relying on it almost resulted in BUGs in
new callers: ever since fd4a7ac32918 ("mm: migrate: try again
if THP split is failed due to page refcnt") we return -EAGAIN on
unexpected folio references, not -EBUSY.

Let's fix that and also document which other return values we can
currently see and why they could happen.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
* Also document concurrent removal from the page cache (likely we should
  return -EBUSY -- but likely it doesn't really matter).
* Reference fd4a7ac32918 in patch description

---
 mm/huge_memory.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee12726291f1b..a7406267323ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2956,7 +2956,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  *
  * 3) The folio must not be pinned. Any unexpected folio references, including
  *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EBUSY.
+ *    will receive an -EAGAIN.
  *
  * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
  *    supported for non-file-backed folios, because folio->_deferred_list, which
@@ -2975,8 +2975,16 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  *
  * Returns 0 if the huge page was split successfully.
  *
- * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
- * from under us.
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
  */
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 				     unsigned int new_order)
-- 
2.44.0


