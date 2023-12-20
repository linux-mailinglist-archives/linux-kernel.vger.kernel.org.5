Return-Path: <linux-kernel+bounces-7607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7581AABF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6121F22E61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508F7AE77;
	Wed, 20 Dec 2023 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkZltjKZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3C7AE62
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwHHhlXrWPXO/4jePm24jC5xrVtR1eDI9aBc8Gwcrbg=;
	b=HkZltjKZC3ul53coi6baNmb8Xc+F8tG2XV18mKdXiKgeiYbbn9OPBeUWdh5ztAimjbnpFB
	2GilE/3J5f0GR7BFekMsnA105T6Tj1V3o4vskWNbm00HErq2KJUn8n+qngWdk5GDZkKe0E
	o5RyMOJJs+PYvY0E2HPFUJ4lXC+XsoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-ZzFw3tvFOO2FjpEXoDI-bg-1; Wed, 20 Dec 2023 17:46:53 -0500
X-MC-Unique: ZzFw3tvFOO2FjpEXoDI-bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 405B3863B83;
	Wed, 20 Dec 2023 22:46:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2D0D40C6EB9;
	Wed, 20 Dec 2023 22:46:49 +0000 (UTC)
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
Subject: [PATCH v2 40/40] mm: remove one last reference to page_add_*_rmap()
Date: Wed, 20 Dec 2023 23:45:04 +0100
Message-ID: <20231220224504.646757-41-david@redhat.com>
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

Let's fixup one remaining comment. Note that the only trace remaining of
the old rmap interface is in an example in Documentation/trace/ftrace.rst,
that we'll just leave alone.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 188807d2aebc5..ac40c3d003368 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -650,7 +650,7 @@ folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
  * should be called with vma's mmap_lock held for read or write,
  * under page table lock for the pte/pmd being added or removed.
  *
- * mlock is usually called at the end of page_add_*_rmap(), munlock at
+ * mlock is usually called at the end of folio_add_*_rmap_*(), munlock at
  * the end of folio_remove_rmap_*(); but new anon folios are managed by
  * folio_add_lru_vma() calling mlock_new_folio().
  */
-- 
2.43.0


