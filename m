Return-Path: <linux-kernel+bounces-137532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9989E37D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF401C2100E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E3F1586CF;
	Tue,  9 Apr 2024 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PifanRhK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4315749E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690783; cv=none; b=c6gdEb+K9dlQFiLZS/i0DnY0S6BocGztuTmYlDtqFRG4bWkHMdiAYiiv1tSv01xkNJ9QGIjPgqIzhkSwOjikoKgRqLfZ2ZoIlUB1k0c3EnFCAKXZxT32jPy/CWo1cTuFv+puXxbnvnTYtKeHU3TDdM/nWhfV5X5AhfZ8OpLrXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690783; c=relaxed/simple;
	bh=67HUJ37QTSZsMQ5QZmRvA1nLGckTDZres9pW7a3nEco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq8XtZqTx47ko/en8H7X9vAuewgr/w8+wz8sKahiE2pEMiJtXqp7m5w6tNoXeyGWytM31bKOfcYGBmBgwZ8Qm6y/WPKNO9Wgwjp66WV+XtF4ZD95v9LmjLo/wJxelaQqY5liWIQIaG4aMFUVZBZv86C/zx1X1PLHG/m5J6qG1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PifanRhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0NYc9fiw7RbFbzUOP+c9IZVrablCrwSqa05Gf/mEjM=;
	b=PifanRhKtHC+q6DszmwWXFttV97v5KhkTV3r2fI5cE1bRgpmNae5jnjfW/wHKQpPVSY8R5
	TwYAbl6uffl9hQjoXa88gEt8mp7ip92TJ5em/WWi4RIpx7sRy14eV8T3Wg8+dQSablh+QT
	ZZCZrADcXiY+GotAcoIuPBCo7EAg888=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-LSK2VHheNtull5pEDNikGw-1; Tue, 09 Apr 2024 15:26:18 -0400
X-MC-Unique: LSK2VHheNtull5pEDNikGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA28890521;
	Tue,  9 Apr 2024 19:26:16 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9815E40B4979;
	Tue,  9 Apr 2024 19:26:08 +0000 (UTC)
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
Subject: [PATCH v1 14/18] mm/migrate_device: use folio_mapcount() in migrate_vma_check_page()
Date: Tue,  9 Apr 2024 21:22:57 +0200
Message-ID: <20240409192301.907377-15-david@redhat.com>
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
absolutely necessary. Let's convert migrate_vma_check_page() to work on
a folio internally so we can remove the page_mapcount() usage.

Note that we reject any large folios.

There is a lot more folio conversion to be had, but that has to wait for
another day. No functional change intended.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate_device.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d40b46ae9d65..b929b450b77c 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -324,6 +324,8 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
  */
 static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
 {
+	struct folio *folio = page_folio(page);
+
 	/*
 	 * One extra ref because caller holds an extra reference, either from
 	 * isolate_lru_page() for a regular page, or migrate_vma_collect() for
@@ -336,18 +338,18 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
 	 * check them than regular pages, because they can be mapped with a pmd
 	 * or with a pte (split pte mapping).
 	 */
-	if (PageCompound(page))
+	if (folio_test_large(folio))
 		return false;
 
 	/* Page from ZONE_DEVICE have one extra reference */
-	if (is_zone_device_page(page))
+	if (folio_is_zone_device(folio))
 		extra++;
 
 	/* For file back page */
-	if (page_mapping(page))
-		extra += 1 + page_has_private(page);
+	if (folio_mapping(folio))
+		extra += 1 + folio_has_private(folio);
 
-	if ((page_count(page) - extra) > page_mapcount(page))
+	if ((folio_ref_count(folio) - extra) > folio_mapcount(folio))
 		return false;
 
 	return true;
-- 
2.44.0


