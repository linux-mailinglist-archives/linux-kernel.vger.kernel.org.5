Return-Path: <linux-kernel+bounces-147306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F58A723A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B6D1F22BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A32134401;
	Tue, 16 Apr 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8XALg5n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EF13340D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288362; cv=none; b=BaUKzemER9EFNMUtPUO3EIA5y67/2ajG3sxCrUgxc6xbOCUTqf8WApyKmpNe8Ozu2ZxO3O2xN35jZxolXSGTe6AhZLEAYkWAiEjWhSwIwO7kmeWFdnqt6/W7uaBmp00kxp86xRjev2hpLcf4UL6qInUXqCEa2BENDf89bNlkKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288362; c=relaxed/simple;
	bh=IJuIYdnF0LWSygsLwsn6+waVDToijuxbtvLwjuDB96c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIRxUiICfNdtdcjaOm5Aji2P0gRw3xV4kLHC8J1ZAFoA8d23/cPqWgJBsiyMPZLFTP76lUgbHDIqo+B6zPnSsplkKk5/VbmChek/pFBDAS05+jmbmDq2Im+aAI/K3yBi7SbzC+BESAn6lV8YXrhbaJZN4uZYLxjulFYV5L5IT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8XALg5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713288359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1onEK+mjIGOBc7x6Ypb0bDNESgiVTW/1kwHRGIFFvkM=;
	b=c8XALg5nBqwNPx1DayV83y2zB9+ljr31D2dNqH1TSxhL7U0R1fgr2qbEa3+7xy+tStjB3e
	c4Xyf1tqtSWFVYpDFQqToSes1kbFa7UbMSqX4qogAOlPPa/UACkKCFamkQ/8aZQLPcucwV
	i9NcRbl9MfOYY4m711OezJK4M4Csbms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-CG4LeTsyOi2kOFzEDet5uA-1; Tue, 16 Apr 2024 13:25:56 -0400
X-MC-Unique: CG4LeTsyOi2kOFzEDet5uA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2837A811001;
	Tue, 16 Apr 2024 17:25:56 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.80])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB2A949106;
	Tue, 16 Apr 2024 17:25:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Shi <alexs@kernel.org>
Subject: [PATCH v1] mm/ksm: remove page_mapcount() usage in stable_tree_search()
Date: Tue, 16 Apr 2024 19:25:33 +0200
Message-ID: <20240416172533.663418-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary.

If our folio has a stable node, it is a (small) KSM folio -- see
folio_stable_node(). Let's use folio_mapcount() in stable_tree_search()
instead, which results in no functional change.

The mapcount > 1 check is a bit confusing, because that's usually a check
for page sharing. Looks like the reason is that we are guaranteed to not
exceed ksm_max_page_sharing for the tree KSM folio when merging with
that. Let's update the documentation to make that clearer.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi (tencent) <alexs@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 486c9974f8e20..159604ad47799 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1909,12 +1909,15 @@ static struct page *stable_tree_search(struct page *page)
 			if (page_node) {
 				VM_BUG_ON(page_node->head != &migrate_nodes);
 				/*
-				 * Test if the migrated page should be merged
-				 * into a stable node dup. If the mapcount is
-				 * 1 we can migrate it with another KSM page
-				 * without adding it to the chain.
+				 * If the mapcount of our migrated KSM folio is
+				 * at most 1, we can merge it with another
+				 * KSM folio where we know that we have space
+				 * for one more mapping without exceeding the
+				 * ksm_max_page_sharing limit: see
+				 * chain_prune(). This way, we can avoid adding
+				 * this stable node to the chain.
 				 */
-				if (page_mapcount(page) > 1)
+				if (folio_mapcount(folio) > 1)
 					goto chain_append;
 			}
 
-- 
2.44.0


