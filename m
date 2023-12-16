Return-Path: <linux-kernel+bounces-1978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93138156A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF461F25730
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AF1C2E;
	Sat, 16 Dec 2023 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yhxt23ns"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFF1846
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702695916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1jN0EDFNeQwt1P7nCWzZVthgRck6ZfeaXYZBtgJYnzA=;
	b=Yhxt23nsnltWoRJLnt6JKCI1vbfVo8Ui8sdV0GXbz6ZYu17OW1V8drLnRlF0Dgf175zcrQ
	I2Fs6yVnBDM2+Ybse72SfdDh25yu9271ynXdny8amaSMMQsgLAgkiZUcymIVZnIcxC38VX
	gEMoBvJ69tE6Ro6ECWCB9YR2u8UyFBE=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm: page_alloc: Simplify __free_pages_ok()
Date: Sat, 16 Dec 2023 11:05:03 +0800
Message-Id: <20231216030503.2126130-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is redundant code in __free_pages_ok(). Use free_one_page()
simplify it.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/page_alloc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2f646773a934..f46af8616cac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1262,7 +1262,6 @@ static void free_one_page(struct zone *zone,
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags)
 {
-	unsigned long flags;
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
@@ -1277,13 +1276,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	 */
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
-	spin_lock_irqsave(&zone->lock, flags);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
-	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
-	spin_unlock_irqrestore(&zone->lock, flags);
+	free_one_page(zone, page, pfn, order, migratetype, fpi_flags);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
-- 
2.25.1


