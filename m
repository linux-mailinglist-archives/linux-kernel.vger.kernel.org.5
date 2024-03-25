Return-Path: <linux-kernel+bounces-117314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB288A9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A25C2A6F66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F0173350;
	Mon, 25 Mar 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8TFUAdq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D560172BAB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378662; cv=none; b=I0m3zf+FOYCqhgvITIL5I9VmiTXsRD0E1lDmXxCFtb50Gl4Df0EvKHSgZa0TLL8vYY5EChqZpqmKCf4BtJMohUI7H7sOmKBdK8jIVYT4OfmyhJGhA2ERO5kqj6p0jKnLZCnV6hj66uaCZGB1tG/cGqy89TYujoc7eD5zIquC/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378662; c=relaxed/simple;
	bh=u9X0CB3RPiuglgfjF076zJXtAcTpbFFY2pMKpioSodE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ViZRFTniMh1ZXvUiXDWfdN1dRph2K47fs92/LPZu++N2nyCFlVrpZ/CzqkaDJGJ0ypkOWC1n1hxj15vQiqxb6Y4ZgzVGNz/X+Q7c/ocRypDl4CY5hxl+XjNoLc4VIgxNCOHOajd5K0JxDpUSNqkTKAPmcXsyfXFIJ5gYEdo23Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8TFUAdq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711378659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVO6euUmFTCPCHk6L2/T00GcEz6lDO4YO+24ug8h660=;
	b=Y8TFUAdqZZaorxa6P2UtKKFHsUU/GrXczkSoFL5yX5DwqU8f4HBrs7vlV11M1yWT8Ulk7I
	e977XArYUmZBCv4SI0XhcL/FHqKyV6/iJxPN8WGAaz+79Cz3OobQ6aPoEuQ5ess6wmANQf
	ByxLDe+cvXI6hBvnP73wUT8jGv6DGZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-mGMwkjhzOPWXpLUha1kWiA-1; Mon, 25 Mar 2024 10:57:37 -0400
X-MC-Unique: mGMwkjhzOPWXpLUha1kWiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E7FB8007A2;
	Mon, 25 Mar 2024 14:57:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69A9D3C22;
	Mon, 25 Mar 2024 14:57:33 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 5/6] mm/mm_init.c: remove unneeded calc_memmap_size()
Date: Mon, 25 Mar 2024 22:56:45 +0800
Message-ID: <20240325145646.1044760-6-bhe@redhat.com>
In-Reply-To: <20240325145646.1044760-1-bhe@redhat.com>
References: <20240325145646.1044760-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Nobody calls calc_memmap_size() now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/mm_init.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f71e56e83f3..e269a724f70e 100644
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


