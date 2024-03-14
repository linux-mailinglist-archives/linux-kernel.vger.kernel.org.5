Return-Path: <linux-kernel+bounces-102980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91587B96B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26D11C21790
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4256BB39;
	Thu, 14 Mar 2024 08:40:02 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95C433D4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405602; cv=none; b=BFSAvzK+jJdLavruDPLup6jeKSdULnC0Ao/xPtTWW085gxvzy3T7OZ272/MpKW7bxKR3/7u81NcUfcem+UHRQdZydpnMj0yqz9jvT8qebvsoN7O02Iyt11kMdKW+EGPp0BhHAot3MIfR4kxdAN+oSykdCj7klh2zxSgUkbtvSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405602; c=relaxed/simple;
	bh=hXBkc2lnJyVmaqMJ7BzFl8A8231c++GoATT9FbJj3YY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T09oZq1t/cInw5ulavJEbgQ/Ie4uIJWst/pGg4KM3p4dA8TBzDKfWx2huRupQlctJFU/RwThGW7AmtFj0v5d7gjw9oMFhBPaj0377oOaIQ5iiYEm6Zau7oNUmdOc8PkUAhaShWIGJoAfHPCzKaNXfdBhakfGAgKcQzfMWaOj+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42E8dQ2t042813;
	Thu, 14 Mar 2024 16:39:26 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TwLPF1QZbz2L2Bvr;
	Thu, 14 Mar 2024 16:38:09 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 14 Mar 2024 16:39:24 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: fix a race scenario in folio_isolate_lru
Date: Thu, 14 Mar 2024 16:39:21 +0800
Message-ID: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 42E8dQ2t042813

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Panic[1] reported which is caused by lruvec->list break. Fix the race
between folio_isolate_lru and release_pages.

race condition:
release_pages could meet a non-refered folio which escaped from being
deleted from LRU but add to another list_head
  #0 folio_isolate_lru          #1 release_pages
  if (folio_test_clear_lru())
                                   if (folio_put_testzero())
                                   if (!folio_test_lru())
                                    <failed to delete folio from LRU>
    folio_get(folio)
                                       list_add(&folio->lru,)
    list_del(&folio->lru,)

fix action 1:
have folio_get prior to folio_test_clear_lru is not enough as there
could be concurrent folio_put(filemap_remove_folios) to make
release_pages pass refcnt check and failed in delete from LRU

  #0 folio_isolate_lru          #1 release_pages
  folio_get(folio)
  if (folio_test_clear_lru())
                                   if (folio_put_testzero())
                                   if (!folio_test_lru())
                                    <failed to delete folio from LRU>
                                       list_add(&folio->lru,)
    list_del(&folio->lru,)

fix action 2:
folio_test_clear_lru should be considered as part of critical section of
lruvec which require be within lruvec->lock.

  #0 folio_isolate_lru          #1 release_pages
  spin_lock(lruvec->lock)
  folio_get(folio)
  if (folio_test_clear_lru())
    list_del(&folio->lru,)
    <delete folio from LRU>
  spin_unlock(lruvec->lock)        spin_lock(lruvec->lock)
                                   if (folio_put_testzero())
                                   if (!folio_test_lru())
                                       list_add(&folio->lru,)

[1]
[   37.562326] pc : __list_del_entry_valid_or_report+0xec/0xf0
[   37.562344] lr : __list_del_entry_valid_or_report+0xec/0xf0
[   37.562351] sp : ffffffc085953990
[   37.562355] x29: ffffffc0859539d0 x28: ffffffc082144000 x27: 000000000000000f
[   37.562367] x26: 000000000000000d x25: 000000000000000d x24: 00000000ffffffff
[   37.562377] x23: ffffffc085953a08 x22: ffffff8080389000 x21: ffffff8080389000
[   37.562388] x20: fffffffe05c54180 x19: ffffffc085953b30 x18: ffffffc085989098
[   37.562399] x17: 20747562202c3838 x16: ffffffffffffffff x15: 0000000000000004
[   37.562409] x14: ffffff8176980000 x13: 0000000000007fff x12: 0000000000000003
[   37.562420] x11: 00000000ffff7fff x10: ffffffc0820f51c4 x9 : 53b71233d5d50e00
[   37.562431] x8 : 53b71233d5d50e00 x7 : ffffffc081161ff0 x6 : 0000000000000000
[   37.562441] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
[   37.562451] x2 : ffffff817f2c4178 x1 : ffffff817f2b71c8 x0 : 000000000000006d
[   37.562461] Call trace:
[   37.562465]  __list_del_entry_valid_or_report+0xec/0xf0
[   37.562472]  release_pages+0x410/0x4c0
[   37.562482]  __folio_batch_release+0x34/0x4c
[   37.562490]  truncate_inode_pages_range+0x368/0x63c
[   37.562497]  truncate_inode_pages+0x14/0x24
[   37.562504]  blkdev_flush_mapping+0x60/0x120
[   37.562513]  blkdev_put+0x114/0x298
[   37.562520]  blkdev_release+0x28/0x40
[   37.562526]  __fput+0xf8/0x2a8
[   37.562533]  ____fput+0x10/0x20
[   37.562539]  task_work_run+0xc4/0xec
[   37.562546]  do_exit+0x32c/0xa3c
[   37.562554]  do_group_exit+0x98/0x9c
[   37.562561]  __arm64_sys_exit_group+0x18/0x1c
[   37.562568]  invoke_syscall+0x58/0x114
[   37.562575]  el0_svc_common+0xac/0xe0
[   37.562582]  do_el0_svc+0x1c/0x28
[   37.562588]  el0_svc+0x50/0xe4
[   37.562593]  el0t_64_sync_handler+0x68/0xbc
[   37.562599]  el0t_64_sync+0x1a8/0x1ac

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/swap.c   | 25 +++++++++++++++++--------
 mm/vmscan.c | 25 +++++++++++++++++++------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..287cf7379927 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -968,6 +968,7 @@ void release_pages(release_pages_arg arg, int nr)
 
 	for (i = 0; i < nr; i++) {
 		struct folio *folio;
+		struct lruvec *prev_lruvec;
 
 		/* Turn any of the argument types into a folio */
 		folio = page_folio(encoded_page_ptr(encoded[i]));
@@ -996,9 +997,24 @@ void release_pages(release_pages_arg arg, int nr)
 				free_zone_device_page(&folio->page);
 			continue;
 		}
+		/*
+		 * lruvec->lock need to be prior to folio_put_testzero to
+		 * prevent race with folio_isolate_lru
+		 */
+		prev_lruvec = lruvec;
+		lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
+				&flags);
+
+		if (prev_lruvec != lruvec)
+			lock_batch = 0;
 
-		if (!folio_put_testzero(folio))
+		if (!folio_put_testzero(folio)) {
+			if (lruvec) {
+				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec = NULL;
+			}
 			continue;
+		}
 
 		if (folio_test_large(folio)) {
 			if (lruvec) {
@@ -1010,13 +1026,6 @@ void release_pages(release_pages_arg arg, int nr)
 		}
 
 		if (folio_test_lru(folio)) {
-			struct lruvec *prev_lruvec = lruvec;
-
-			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
-									&flags);
-			if (prev_lruvec != lruvec)
-				lock_batch = 0;
-
 			lruvec_del_folio(lruvec, folio);
 			__folio_clear_lru_flags(folio);
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4255619a1a31..13a4a716c67a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1721,18 +1721,31 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 bool folio_isolate_lru(struct folio *folio)
 {
 	bool ret = false;
+	struct lruvec *lruvec;
 
 	VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio);
 
-	if (folio_test_clear_lru(folio)) {
-		struct lruvec *lruvec;
+	/*
+	 * The folio_get needs to be prior to clear lru for list integrity.
+	 * Otherwise:
+	 *   #0  folio_isolate_lru	      #1 release_pages
+	 *   if (folio_test_clear_lru())
+	 *				      if (folio_put_testzero())
+	 *				      if (!folio_test_lru())
+	 *				       <failed to del folio from LRU>
+	 *     folio_get(folio)
+	 *                                        list_add(&folio->lru,)
+	 *     list_del(&folio->lru,)
+	 */
+	lruvec = folio_lruvec_lock_irq(folio);
+	folio_get(folio);
 
-		folio_get(folio);
-		lruvec = folio_lruvec_lock_irq(folio);
+	if (folio_test_clear_lru(folio)) {
 		lruvec_del_folio(lruvec, folio);
-		unlock_page_lruvec_irq(lruvec);
 		ret = true;
-	}
+	} else
+		folio_put(folio);
+	unlock_page_lruvec_irq(lruvec);
 
 	return ret;
 }
-- 
2.25.1


