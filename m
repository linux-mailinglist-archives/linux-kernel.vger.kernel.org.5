Return-Path: <linux-kernel+bounces-120475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D688D817
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA30B21522
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059E2C1B4;
	Wed, 27 Mar 2024 07:56:05 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21124C81
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526165; cv=none; b=ghiUOSt6S1bDU2D+AxoMhJIALPxqBGGmCZZhK6y4QCKw9ZuCbhie5GlLkD1CxvvM4j65E/JILYls81i0ILuHy8DaKH7aMFcOwy1Q3iIuGA00rtKxavs4BEwo2wmIPvIrzSIirYA0K3yswvALn/PgFrQCQT/JRnmEZrzk2qCDOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526165; c=relaxed/simple;
	bh=UUlN669h6JKDJmNPQpWaHRrgFptpJalBabslS5/qzX0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXEXqwSu6SojwCIfC6SAp6iu2L3mkqjse5REC3hm3bjzw59HgDDft99OEiGxj7pQLntcCS25kB9wQR6Yf0MngI/RKIos2ZCPumPlnpzFZrPRkXKIznw7QTRgP23lWMiOX0nW79EKVRzgeQov1xFvFCLS97U0hO/p1kkP0cOUl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42R7tMMt081647;
	Wed, 27 Mar 2024 15:55:22 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V4Jnv0Sg0z2Klktn;
	Wed, 27 Mar 2024 15:53:39 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 27 Mar 2024 15:55:20 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: get the folio's refcnt before clear PG_lru in folio_isolate_lru
Date: Wed, 27 Mar 2024 15:55:16 +0800
Message-ID: <20240327075516.1367097-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 42R7tMMt081647

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Bellowing race happens when the caller of folio_isolate_lru rely on the
refcnt of page cache. Moving folio_get ahead of folio_test_clear_lru to
make it more robust.

0. Thread_isolate calls folio_isolate_lru by holding one refcnt of page
   cache and get preempted before folio_get.
       folio_isolate_lru
           VM_BUG_ON(!folio->refcnt)
           if (folio_test_clear_lru(folio))
               <preempted>
               folio_get()
1. Thread_release calls release_pages and meet the scenario of the folio
   get its refcnt of page cache removed before folio_put_testzero
       release_pages
           <folio is removed from page cache>
           folio_put_testzero(folio) == true
           <refcnt added by collection is the only one here and get
deducted>
           if(folio_test_clear_lru(folio))
                 lruvec_del_folio(folio)
           <folio failed to be deleted from LRU>
           list_add(folio, pages_to_free);
           <LRU's integrity is broken by above list_add>

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ef654addd44..42f15ca06e09 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1731,10 +1731,10 @@ bool folio_isolate_lru(struct folio *folio)
 
 	VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio);
 
+	folio_get(folio);
 	if (folio_test_clear_lru(folio)) {
 		struct lruvec *lruvec;
 
-		folio_get(folio);
 		lruvec = folio_lruvec_lock_irq(folio);
 		lruvec_del_folio(lruvec, folio);
 		unlock_page_lruvec_irq(lruvec);
-- 
2.25.1


