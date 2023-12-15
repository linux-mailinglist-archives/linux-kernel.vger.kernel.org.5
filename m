Return-Path: <linux-kernel+bounces-897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BF8147AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A741F2414E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E5C28E0E;
	Fri, 15 Dec 2023 12:08:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619D1A705
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VyXjgdG_1702642084;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VyXjgdG_1702642084)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 20:08:05 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	xuyu@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: fix getting incorrect page mapping during page migration
Date: Fri, 15 Dec 2023 20:07:52 +0800
Message-Id: <e60b17a88afc38cb32f84c3e30837ec70b343d2b.1702641709.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running stress-ng testing, we found below kernel crash after a few hours:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
pc : dentry_name+0xd8/0x224
lr : pointer+0x22c/0x370
sp : ffff800025f134c0
......
Call trace:
  dentry_name+0xd8/0x224
  pointer+0x22c/0x370
  vsnprintf+0x1ec/0x730
  vscnprintf+0x2c/0x60
  vprintk_store+0x70/0x234
  vprintk_emit+0xe0/0x24c
  vprintk_default+0x3c/0x44
  vprintk_func+0x84/0x2d0
  printk+0x64/0x88
  __dump_page+0x52c/0x530
  dump_page+0x14/0x20
  set_migratetype_isolate+0x110/0x224
  start_isolate_page_range+0xc4/0x20c
  offline_pages+0x124/0x474
  memory_block_offline+0x44/0xf4
  memory_subsys_offline+0x3c/0x70
  device_offline+0xf0/0x120
  ......

After analyzing the vmcore, I found this issue is caused by page migration.
The scenario is that, one thread is doing page migration, and we will use the
target page's ->mapping field to save 'anon_vma' pointer between page unmap and
page move, and now the target page is locked and refcount is 1.

Currently, there is another stress-ng thread performing memory hotplug,
attempting to offline the target page that is being migrated. It discovers that
the refcount of this target page is 1, preventing the offline operation, thus
proceeding to dump the page. However, page_mapping() of the target page may
return an incorrect file mapping to crash the system in dump_mapping(), since
the target page->mapping only saves 'anon_vma' pointer without setting
PAGE_MAPPING_ANON flag.

There are seveval ways to fix this issue:
(1) Setting the PAGE_MAPPING_ANON flag for target page's ->mapping when saving
'anon_vma', but this can confuse PageAnon() for PFN walkers, since the target
page has not built mappings yet.
(2) Getting the page lock to call page_mapping() in __dump_page() to avoid crashing
the system, however, there are still some PFN walkers that call page_mapping()
without holding the page lock, such as compaction.
(3) Using target page->private field to save the 'anon_vma' pointer and 2 bits
page state, just as page->mapping records an anonymous page, which can remove
the page_mapping() impact for PFN walkers and also seems a simple way.

So I choose option 3 to fix this issue, and this can also fix other potential
issues for PFN walkers, such as compaction.

Fixes: 64c8902ed441 ("migrate_pages: split unmap_and_move() to _unmap() and _move()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 397f2a6e34cb..bad3039d165e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1025,38 +1025,31 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 }
 
 /*
- * To record some information during migration, we use some unused
- * fields (mapping and private) of struct folio of the newly allocated
- * destination folio.  This is safe because nobody is using them
- * except us.
+ * To record some information during migration, we use unused private
+ * field of struct folio of the newly allocated destination folio.
+ * This is safe because nobody is using it except us.
  */
-union migration_ptr {
-	struct anon_vma *anon_vma;
-	struct address_space *mapping;
-};
-
 enum {
 	PAGE_WAS_MAPPED = BIT(0),
 	PAGE_WAS_MLOCKED = BIT(1),
+	PAGE_OLD_STATES = PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
 };
 
 static void __migrate_folio_record(struct folio *dst,
-				   unsigned long old_page_state,
+				   int old_page_state,
 				   struct anon_vma *anon_vma)
 {
-	union migration_ptr ptr = { .anon_vma = anon_vma };
-	dst->mapping = ptr.mapping;
-	dst->private = (void *)old_page_state;
+	dst->private = (void *)anon_vma + old_page_state;
 }
 
 static void __migrate_folio_extract(struct folio *dst,
 				   int *old_page_state,
 				   struct anon_vma **anon_vmap)
 {
-	union migration_ptr ptr = { .mapping = dst->mapping };
-	*anon_vmap = ptr.anon_vma;
-	*old_page_state = (unsigned long)dst->private;
-	dst->mapping = NULL;
+	unsigned long private = (unsigned long)dst->private;
+
+	*anon_vmap = (struct anon_vma *)(private & ~PAGE_OLD_STATES);
+	*old_page_state = private & PAGE_OLD_STATES;
 	dst->private = NULL;
 }
 
-- 
2.39.3


