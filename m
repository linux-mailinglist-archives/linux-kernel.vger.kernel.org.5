Return-Path: <linux-kernel+bounces-7546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1A81A96A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EAF285F79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA5F4F20F;
	Wed, 20 Dec 2023 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbvSK66n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46C4F1F1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6kyFjjwWNovISb45JpAxGunVS8pf5Q0izk9V4kCoBM=;
	b=GbvSK66nnGGh5Zv5Z7ZsJydCD2pfM63MJybRGwWAwSk01Dk2stEZKljrZeRPZOIR/XoP5+
	L23xTmFeUXEYZ6+Q0P6r35m++h7ijigGA+/7v1+8ZAzkgwVeRXQZmdlMYp1SdhRtIe3iKN
	gzitjg9/I6AH8BufQ/mH2PWdR7pUGog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-BPRXZUsgNgykeRsAk0KDlQ-1; Wed, 20 Dec 2023 17:46:05 -0500
X-MC-Unique: BPRXZUsgNgykeRsAk0KDlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09319101A5DC;
	Wed, 20 Dec 2023 22:46:05 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90EFA40C6EB9;
	Wed, 20 Dec 2023 22:46:02 +0000 (UTC)
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
Subject: [PATCH v2 22/40] mm/rmap: remove RMAP_COMPOUND
Date: Wed, 20 Dec 2023 23:44:46 +0100
Message-ID: <20231220224504.646757-23-david@redhat.com>
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

No longer used, let's remove it and clarify RMAP_NONE/RMAP_EXCLUSIVE a
bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 12 +++---------
 mm/rmap.c            |  2 --
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index fe7b5a8b0e75b..bf6cb79aa7a0a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -177,20 +177,14 @@ struct anon_vma *folio_get_anon_vma(struct folio *folio);
 typedef int __bitwise rmap_t;
 
 /*
- * No special request: if the page is a subpage of a compound page, it is
- * mapped via a PTE. The mapped (sub)page is possibly shared between processes.
+ * No special request: A mapped anonymous (sub)page is possibly shared between
+ * processes.
  */
 #define RMAP_NONE		((__force rmap_t)0)
 
-/* The (sub)page is exclusive to a single process. */
+/* The anonymous (sub)page is exclusive to a single process. */
 #define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
 
-/*
- * The compound page is not mapped via PTEs, but instead via a single PMD and
- * should be accounted accordingly.
- */
-#define RMAP_COMPOUND		((__force rmap_t)BIT(1))
-
 /*
  * Internally, we're using an enum to specify the granularity. We make the
  * compiler emit specialized code for each granularity.
diff --git a/mm/rmap.c b/mm/rmap.c
index 87415bbf24022..2b386b9f6791c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2662,8 +2662,6 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  * The following two functions are for anonymous (private mapped) hugepages.
  * Unlike common anonymous pages, anonymous hugepages have no accounting code
  * and no lru code, because we handle hugepages differently from common pages.
- *
- * RMAP_COMPOUND is ignored.
  */
 void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
-- 
2.43.0


