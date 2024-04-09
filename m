Return-Path: <linux-kernel+bounces-137525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003E089E360
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955101F23BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7901586F1;
	Tue,  9 Apr 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC8aDXkA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F01586E6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690716; cv=none; b=JyWzV5dgrxZ3zEel9lyo1EAuC4nhsM5doncHyiU9CtbChj1FIGEZfrNHGRFbXMS/vTNLg68MpRS+sB7WHmz4xAnrNNLpb1lNakU3c03L6kUTPd/fPgWvRIxuwQLYRlbYENLBMRwPmG9JSBh+/uJO7AmLMLbA1LMTJdNVnvuyRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690716; c=relaxed/simple;
	bh=U2FYI/zDEFEDbvVedqLdfE5jV/TmoU4yobw78EI2s0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCeS46bKOuttB7bPOp0COJLlQPsLh6s+6Bhi2GCGrGLaTp6EBfTvwh4jfAjK0KbpDxqNIFdyCfbTjXk45WqsnHl3kB0Ib71ZNHAjDZhIbK69/5BKa3hll2PmDe6C9oNAfVkpz1UU0C57zn5awijN3XuxRInYfz76UqBTcn/CMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC8aDXkA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2g8VbuF2c0rw+gA2SjXZjA9kizkfkgdJ7YGUNRZUqA=;
	b=DC8aDXkAZBc+rAllDUwK8JjAWhnIX/zwt22po0Vtyi/gMIjxo95pgRdP9gk6pR+njYTgCv
	cCVp6rX4+UpNYSTnOlNrbxAhN8RNe2Vb6aqD7fdMC2zaDATr90Km1yIKEPQCqGNaEDK7lY
	KMMqS04dKUguOUmOfn7ESKMGfhL6u78=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-9JpVPi_eMcaHlYj18Lcjpg-1; Tue, 09 Apr 2024 15:25:10 -0400
X-MC-Unique: 9JpVPi_eMcaHlYj18Lcjpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AB78806625;
	Tue,  9 Apr 2024 19:25:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCB3B40B4980;
	Tue,  9 Apr 2024 19:24:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 08/18] mm/huge_memory: use folio_mapcount() in zap_huge_pmd() sanity check
Date: Tue,  9 Apr 2024 21:22:51 +0200
Message-ID: <20240409192301.907377-9-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary. Let's similarly check for folio_mapcount() underflows
instead of page_mapcount() underflows like we do in
zap_present_folio_ptes() now.

Instead of the VM_BUG_ON(), we should actually be doing something like
print_bad_pte(). For now, let's keep it simple and use WARN_ON_ONCE(),
performing that check independently of DEBUG_VM.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d8d2ed80b0bf..68ac27d229ef 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1851,7 +1851,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 			folio = page_folio(page);
 			folio_remove_rmap_pmd(folio, page, vma);
-			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
+			WARN_ON_ONCE(folio_mapcount(folio) < 0);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else if (thp_migration_supported()) {
 			swp_entry_t entry;
-- 
2.44.0


