Return-Path: <linux-kernel+bounces-7541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0BC81A961
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7BB1C22A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6D4E604;
	Wed, 20 Dec 2023 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMyI3CYm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDD4E1D9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqDId8uyvnGLvlQWpKrOuAVvsXstgtUNoP8HJVv8bTA=;
	b=KMyI3CYmhqsOxPcwg7v1uVmTsd6P1d/1rQvtlm+psZ0FUQ+pakAy4XOrxytgmHhET9a0xI
	dTcxKCEOSj8T0h1vRRCd8Ksa+Kw7ULC+UONlfJpMg0Slk2YWdtTbmiuOEstwfg5iO3ZPNE
	LJoNtLhFouN3C1k0yGcUsJAmBZDqd7o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-X02swWYoMrmIknXW0v73xQ-1; Wed,
 20 Dec 2023 17:45:50 -0500
X-MC-Unique: X02swWYoMrmIknXW0v73xQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19FE538425AD;
	Wed, 20 Dec 2023 22:45:50 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8187140C6EB9;
	Wed, 20 Dec 2023 22:45:47 +0000 (UTC)
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
Subject: [PATCH v2 16/40] mm/huge_memory: page_add_anon_rmap() -> folio_add_anon_rmap_pmd()
Date: Wed, 20 Dec 2023 23:44:40 +0100
Message-ID: <20231220224504.646757-17-david@redhat.com>
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

Let's convert remove_migration_pmd(). No need to set RMAP_COMPOUND, that
we will remove soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d4c5d22d16117..1f438326b69bc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3611,12 +3611,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		pmde = pmd_mkdirty(pmde);
 
 	if (folio_test_anon(folio)) {
-		rmap_t rmap_flags = RMAP_COMPOUND;
+		rmap_t rmap_flags = RMAP_NONE;
 
 		if (!is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		page_add_anon_rmap(new, vma, haddr, rmap_flags);
+		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
 	} else {
 		folio_add_file_rmap_pmd(folio, new, vma);
 	}
-- 
2.43.0


