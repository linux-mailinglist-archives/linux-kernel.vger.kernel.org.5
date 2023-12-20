Return-Path: <linux-kernel+bounces-7543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D887A81A964
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAAE285FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9D4E63E;
	Wed, 20 Dec 2023 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0ckCY9j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D14E628
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIY4woM6QT5vXKPOcZRD72sCPk41egGwN4b1+ampIqs=;
	b=Q0ckCY9jH/Rw7+VX7RBUOtlEq4bCoqocbGxcMwPXhjjv39OBeEF+cOqCdx9wgKCQlkVQPX
	pTF/4faRgU2hBET32FyhVTazWhKyEHZ9nwHKTvSnsvHdP7cYZpSOTdB6j8qwxvkjPDyms4
	7MfIrETk/HBiucaA+28LSSCwbfIho1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-u30R_eRpM7yzGggrf7qJug-1; Wed, 20 Dec 2023 17:45:58 -0500
X-MC-Unique: u30R_eRpM7yzGggrf7qJug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 708A1848C02;
	Wed, 20 Dec 2023 22:45:57 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2EAC40C6EB9;
	Wed, 20 Dec 2023 22:45:54 +0000 (UTC)
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
Subject: [PATCH v2 19/40] mm/swapfile: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:43 +0100
Message-ID: <20231220224504.646757-20-david@redhat.com>
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

Let's convert unuse_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2f877ca445137..3eec686484ef5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1806,7 +1806,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		if (pte_swp_exclusive(old_pte))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		page_add_anon_rmap(page, vma, addr, rmap_flags);
+		folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
 	} else { /* ksm created a completely new copy */
 		folio_add_new_anon_rmap(folio, vma, addr);
 		folio_add_lru_vma(folio, vma);
-- 
2.43.0


