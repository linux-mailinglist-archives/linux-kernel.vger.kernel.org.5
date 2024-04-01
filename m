Return-Path: <linux-kernel+bounces-126515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45C8938E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B614BB212D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA4BE66;
	Mon,  1 Apr 2024 08:20:22 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121578BF0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959622; cv=none; b=BF8EQaySO4eET1BXbQPXDFexBcgIlasHpu37U+nDFuCxYk1A0tGhTfvqgnUUCcW9r2kc8A3JdDS1XaYBcQpsz9LTpBM8vuQdVHYnwVu3ALMifYOGU4EB8v8bOWpsGOy++uctbNHIkQ/8svPHBgFkkvuPJpsvbnLoQWLZtPczOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959622; c=relaxed/simple;
	bh=mLvBsBy2vP+9pDtVl7gEb7V/ctm5B+nb9Klb/z/TDOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d56eLHXSMBtPlfYh8YJSJ+k3hD8v3G8TH/aYslzxPdkwhQ5BCCS8IlgRFMVrMwSdEopcZqopAptgbKS7T/t306N1GV2Yd51OTqoF3XVjDAM1yOYSuS4cSKJNQGCi7UiYgHHQbPjlj5vvpg0ydVH6Gi4DESwRAfiNL80YbAOH/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4318HlFb028029;
	Mon, 1 Apr 2024 16:17:47 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V7P3G46yjz2MDQdm;
	Mon,  1 Apr 2024 16:15:54 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 1 Apr 2024 16:17:45 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, NeilBrown <neilb@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
CC: Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig
	<hch@infradead.org>
Subject: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in read_pages
Date: Mon, 1 Apr 2024 16:17:34 +0800
Message-ID: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4318HlFb028029

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
unproperly during the procedure of read_pages()->readahead_folio->folio_put.
This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
->readpages doesn't process all pages")'.

key steps of[1] in brief:
2'. Thread_truncate get folio to its local fbatch by find_get_entry in step 2
7'. Last refcnt remained which is not as expect as from alloc_pages
    but from thread_truncate's local fbatch in step 7
8'. Thread_reclaim succeed to isolate the folio by the wrong refcnt(not
    the value but meaning) in step 8
9'. Thread_truncate hit the VM_BUG_ON in step 9

[1]
Thread_readahead:
0. folio = filemap_alloc_folio(gfp_mask, 0);
       (refcount 1: alloc_pages)
1. ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
       (refcount 2: alloc_pages, page_cache)

Thread_truncate:
2. folio = find_get_entries(&fbatch_truncate);
       (refcount 3: alloc_pages, page_cache, fbatch_truncate))

Thread_readahead:
3. Then we call read_pages()
       First we call ->readahead() which for some reason stops early.
4. Then we call readahead_folio() which calls folio_put()
       (refcount 2: page_cache, fbatch_truncate)
5. Then we call folio_get()
       (refcount 3: page_cache, fbatch_truncate, read_pages_temp)
6. Then we call filemap_remove_folio()
       (refcount 2: fbatch_truncate, read_pages_temp)
7. Then we call folio_unlock() and folio_put()
       (refcount 1: fbatch_truncate)

Thread_reclaim:
8. collect the page from LRU and call shrink_inactive_list->isolate_lru_folios
        shrink_inactive_list
        {
            isolate_lru_folios
            {
               if (!folio_test_lru(folio)) //false
                   bail out;
               if (!folio_try_get(folio)) //false
                   bail out;
            }
         }
         (refcount 2: fbatch_truncate, reclaim_isolate)

9. call shrink_folio_list->__remove_mapping
        shrink_folio_list()
        {
            folio_try_lock(folio);
            __remove_mapping()
            {
                if (!folio_ref_freeze(2)) //false
                    bail out;
            }
            folio_unlock(folio)
            list_add(folio, free_folios);
        }
        (folio has refcount 0)

Thread_truncate:
10. Thread_truncate will hit the refcnt VM_BUG_ON(refcnt == 0) in
release_pages->folio_put_testzero
        truncate_inode_pages_range
        {
            folio = find_get_entries(&fbatch_truncate);
            truncate_inode_pages(&fbatch_truncate);
            folio_fbatch_release(&fbatch_truncate);
            {
                folio_put_testzero(folio); //VM_BUG_ON here
            }
        }

fix: commit 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't process all pages")'

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
patch v2: update commit message
---
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 130c0e7df99f..657736200a92 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -163,7 +163,7 @@ static void read_pages(struct readahead_control *rac)
 		 * may be used to size the next readahead, so make sure
 		 * they accurately reflect what happened.
 		 */
-		while ((folio = readahead_folio(rac)) != NULL) {
+		while ((folio = __readahead_folio(rac)) != NULL) {
 			unsigned long nr = folio_nr_pages(folio);
 
 			folio_get(folio);
-- 
2.25.1


