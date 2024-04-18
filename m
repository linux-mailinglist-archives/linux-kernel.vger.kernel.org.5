Return-Path: <linux-kernel+bounces-150374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB18A9E24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4842865E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96C16C699;
	Thu, 18 Apr 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWtwB2+e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422815E20F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453524; cv=none; b=G8yEnNEGrPMNfJZLbE0yNqm4h6CnEPz+2QidKdd99YZDNhDJ7HWA4K0XP0TrB1ZLOBohHAW/EyBoEI9d8G1Q6VOsZaFIa0Cc/0NwYum8irrdFEglEMDrIgLvFPzQm2VQks0O5my4xdlFelmBD+F2m2J9I6KgwrlzClPZx2SUVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453524; c=relaxed/simple;
	bh=YwU6TGZyJFBdHkYGxkydvf9mq0nGI6wPqTIcDIgzqqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jb4wfi09ha46k5TuaUi6gHdn5sYJ3ukjowvpOY9HqHMqAM2oPpWjv5YcqR6LqPncGqhQGmjsQdyXaRT5Q1xG6DyrvvSJSWOlaJA+eZ6GW/4A+xJy3YSFJ2iMALEL95TvmQAApZOdWnCczDKkQ20wE9YJSLtv+pvORpqmDJeFDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWtwB2+e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713453521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fRqyqZZz/beIO4QHAyMNc12G8bTOX3CjIzAVeMQ2tbU=;
	b=BWtwB2+e2/eJeBUnN5AnFYwsikW0uNs/370YuD6TnT97dNGTvBS2JLyc/M6TcatB5lp4+a
	4JaJDwF0eQ5LRb4MmSayTcRuXxCUJC9KOU3r57Fzppfx68B3ZzJKm5tJCt33+lHQSvyHIz
	gBbpZtT/a2QFTxRTGr+m+65T9Hl4MJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-XPqDrA9YMa6ZQad_-ry7Zw-1; Thu, 18 Apr 2024 11:18:37 -0400
X-MC-Unique: XPqDrA9YMa6ZQad_-ry7Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56187104B501;
	Thu, 18 Apr 2024 15:18:37 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 62A84C2595D;
	Thu, 18 Apr 2024 15:18:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] mm/huge_memory: improve split_huge_page_to_list_to_order() return value documentation
Date: Thu, 18 Apr 2024 17:18:34 +0200
Message-ID: <20240418151834.216557-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The documentation is wrong and relying on it almost resulted in BUGs
in new callers: we return -EAGAIN on unexpected folio references, not
-EBUSY.

Let's fix that and also document which other return values we can
currently see and why they could happen.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee12726291f1b..824eff9211db8 100644
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
@@ -2975,8 +2975,15 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  *
  * Returns 0 if the huge page was split successfully.
  *
- * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
- * from under us.
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP).
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


