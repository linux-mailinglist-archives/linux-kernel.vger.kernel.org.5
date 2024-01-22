Return-Path: <linux-kernel+bounces-33769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEC836E59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0D11C25405
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C225F84A;
	Mon, 22 Jan 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdtUvXWX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C605F849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943880; cv=none; b=GYAUf18moAsybwQuunwaRzddVcYHsAYcdL401mdmryBHfj1U2CC0fKHc4LdHcMnhpSGuiIe6qYf5fkuxWsLWt13HTZERrqex+CzH90j1ZWXB4aAxsh0U0D2Mlernx0xVMLt6N0U3X5YNny5WB2qPZbcmlOf2RTdF/3iU778QC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943880; c=relaxed/simple;
	bh=AuAehTRQDKytPine/OlBkuYxFhvld+jjrKy3zbrkDJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irja//YGa9CLM6L4sSAzJ8Ef810PlbaXudylu9WxoRyo6bEp+Nw9AMKcXB0DyF3Q2MgtK7S1c0P1yMmmtwKZtL/NtEyjepvK0f4FRkQPLEiIW5v7J5gbKXTD5gww36vA0Q2XJ7StpUENMgOxLBseprozqhd66NKNp+FjQAJIKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdtUvXWX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705943878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XhLeC5Lfj4S0c9LG1F/fnKLVs62IL7U4zQ+n1ywYzhU=;
	b=JdtUvXWXW+aH8P8l7+pVX3PiuocstPVVHHT8wTX8j93UqrF7BOagxeNNacH4B/oU2Tdm7R
	U76Z+8z72KdEDVaGBWFCcZhkHusKJB2tpM23d6tRxpVcqt6NpRynKGYPSBwesAF5nhcTMn
	o2H/ANBaJr0vTCad6cFjMDWBPdQFvOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-9e0_w3lbNNu16t2quNW2Tw-1; Mon, 22 Jan 2024 12:17:54 -0500
X-MC-Unique: 9e0_w3lbNNu16t2quNW2Tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48ED1185A785;
	Mon, 22 Jan 2024 17:17:54 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B323C0FDCA;
	Mon, 22 Jan 2024 17:17:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] mm/memory: fix folio_set_dirty() vs. folio_mark_dirty() in zap_pte_range()
Date: Mon, 22 Jan 2024 18:17:51 +0100
Message-ID: <20240122171751.272074-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The correct folio replacement for "set_page_dirty()" is
"folio_mark_dirty()", not "folio_set_dirty()". Using the latter won't
properly inform the FS using the dirty_folio() callback.

This has been found by code inspection, but likely this can result in
some real trouble when zapping dirty PTEs that point at clean pagecache
folios.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lkml.kernel.org/r/2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com
Fixes: c46265030b0f ("mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()")
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463aa..89bcae0b224d6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1464,7 +1464,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			delay_rmap = 0;
 			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
-					folio_set_dirty(folio);
+					folio_mark_dirty(folio);
 					if (tlb_delay_rmap(tlb)) {
 						delay_rmap = 1;
 						force_flush = 1;
-- 
2.43.0


