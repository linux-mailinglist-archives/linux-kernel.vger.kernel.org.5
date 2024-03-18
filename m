Return-Path: <linux-kernel+bounces-106214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A087EAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC461C210FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABEE50A6E;
	Mon, 18 Mar 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VylSzZAr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870950249
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771734; cv=none; b=W/5aXp59SWewdIYU/s5OKC1LLOyjLOb6nHFXvaOz5TspJsDJ9hQ55xdT0INHBUKU6oxbSY/OwbTsPVXuqn+sbJuhvbQAS2YBv0in8nKbenInlqQHWUjiZAaD0ltSRVQ5XNM9O33RUixRtEjS1M9wmf7mcNeXdTsAfPye8I51G4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771734; c=relaxed/simple;
	bh=aCpM8olVWTDqlQQ3qCGzzgkbORWDHDqfLUd80t/l6Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=AQmVZZ5LjTZ8ZXUXLcCkLZQMsb20tMwO+Oezx1Mz9QlSiN15eDp9+ZIFkxH7BIgv3dHmehv+U6W4V24b+Txn1JG5sTxCy529l15VpGKDbj9hb4UuXZ8J/w+jneY1HZUe2Fr1LTRS2mTY63NCURrTg9uEiIFcd5tNV5f7CWTi/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VylSzZAr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/H22rgu+0Eg3oELZT1F8mB3L7t/pq1y95Fbs8e1Y/U=;
	b=VylSzZAreP9kRBvSEZa64BanHcu9Barai+HSKGWraD6eFrEWtWHs2mpVXIK/HHrN1uVchG
	vRl/YX9YEMgZlfNi1gicBs9TFYcXfr+TG+8Amy8ISblrfKqKUbmthVEOo2uIiNMOYqtJTb
	QOiDk7uvTnwEt3MBgwrSa0HX8p930rk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-gnPigdkEN5yTi6k7RKI_9g-1; Mon, 18 Mar 2024 10:22:09 -0400
X-MC-Unique: gnPigdkEN5yTi6k7RKI_9g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F4BF800265;
	Mon, 18 Mar 2024 14:22:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65BA7492BD1;
	Mon, 18 Mar 2024 14:22:05 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 5/6] mm/mm_init.c: remove unneeded calc_memmap_size()
Date: Mon, 18 Mar 2024 22:21:37 +0800
Message-ID: <20240318142138.783350-6-bhe@redhat.com>
In-Reply-To: <20240318142138.783350-1-bhe@redhat.com>
References: <20240318142138.783350-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Nobody calls calc_memmap_size() now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/mm_init.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 55a2b886b7a6..9ed4b9e77c4a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1331,26 +1331,6 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }
 
-static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
-						unsigned long present_pages)
-{
-	unsigned long pages = spanned_pages;
-
-	/*
-	 * Provide a more accurate estimation if there are holes within
-	 * the zone and SPARSEMEM is in use. If there are holes within the
-	 * zone, each populated memory region may cost us one or two extra
-	 * memmap pages due to alignment because memmap pages for each
-	 * populated regions may not be naturally aligned on page boundary.
-	 * So the (present_pages >> 4) heuristic is a tradeoff for that.
-	 */
-	if (spanned_pages > present_pages + (present_pages >> 4) &&
-	    IS_ENABLED(CONFIG_SPARSEMEM))
-		pages = present_pages;
-
-	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pgdat_init_split_queue(struct pglist_data *pgdat)
 {
-- 
2.41.0


