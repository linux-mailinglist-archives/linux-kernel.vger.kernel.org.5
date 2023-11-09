Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563FE7E62AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 04:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjKIDbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 22:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjKIDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 22:31:34 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139626B1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 19:31:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699500368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFdep+48cn5+ZFbHO3HlhiGibtZePlz/+w+2QxfYwYY=;
        b=C4B7IH4JlssLIKZU77TqalG3IHvqAIr7PjXfY1Uudqf1Vd5DDtHxXho00q/GTaq6FsPUhW
        NEYOXgwXMACBf2JDt8bMaObYEq1V9T24mVQ0qIO+xqNU1J7N3XzJxhKAut+d3fcIDN3Rxb
        fQOAhHvoFza5KCRwK3es8m5e/PwvwXo=
From:   Jeff Xie <jeff.xie@linux.dev>
To:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        xiehuan09@gmail.com, Jeff Xie <jeff.xie@linux.dev>
Subject: [RFC][PATCH 4/4] mm/rmap: implement anonmap allocate post callback for page_owner
Date:   Thu,  9 Nov 2023 11:25:21 +0800
Message-Id: <20231109032521.392217-5-jeff.xie@linux.dev>
In-Reply-To: <20231109032521.392217-1-jeff.xie@linux.dev>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the callback function anon_alloc_post_page_owner for the page_owner
to make the owner of the anon page clearer

For the pid 98:
[root@JeffXie ]# cat /proc/98/maps 
00400000-00401000 r--p 00000000 fd:00 1954	/test/mm/a.out
00401000-00499000 r-xp 00001000 fd:00 1954      /test/mm/a.out
00499000-004c2000 r--p 00099000 fd:00 1954      /test/mm/a.out
004c2000-004c6000 r--p 000c1000 fd:00 1954      /test/mm/a.out
004c6000-004c9000 rw-p 000c5000 fd:00 1954      /test/mm/a.out
004c9000-004ce000 rw-p 00000000 00:00 0 
01d97000-01db9000 rw-p 00000000 00:00 0                 [heap]
7f1588fc8000-7f1588fc9000 rw-p 00000000 fd:00 1945      /a.txt
7ffda207a000-7ffda209b000 rw-p 00000000 00:00 0         [stack]
7ffda2152000-7ffda2156000 r--p 00000000 00:00 0         [vvar]
7ffda2156000-7ffda2158000 r-xp 00000000 00:00 0         [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0 [vsyscall]

added: "ANON_PAGE address 0x4c4000"

Page allocated via order 0, mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 98, tgid 98 (a.out), ts 28442066180 ns
ANON_PAGE address 0x4c4000
PFN 0x2c3db type Movable Block 353 type Movable Flags 0x1fffc00000a0028(uptodate|lru|mappedtodisk|swapbacked|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 vma_alloc_folio+0x5c/0xd0
 do_wp_page+0x288/0xe30
 __handle_mm_fault+0x8ca/0x1760
 handle_mm_fault+0xbc/0x2f0
 do_user_addr_fault+0x158/0x5e0
 exc_page_fault+0x73/0x170
 asm_exc_page_fault+0x26/0x30
Charged to memcg / 

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
 include/linux/rmap.h |  7 +++++++
 mm/rmap.c            | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b26fe858fd44..d85650c9c520 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -502,4 +502,11 @@ static inline int page_mkclean(struct page *page)
 {
 	return folio_mkclean(page_folio(page));
 }
+#ifndef CONFIG_PAGE_OWNER
+static inline int anon_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
+		void *data, char *kbuf, size_t count)
+{
+	return 0;
+}
+#endif
 #endif	/* _LINUX_RMAP_H */
diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..41c8a387cd37 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -75,7 +75,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mm_inline.h>
-
+#include <linux/page_owner.h>
 #include <asm/tlbflush.h>
 
 #define CREATE_TRACE_POINTS
@@ -1151,6 +1151,18 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 	 */
 	WRITE_ONCE(folio->mapping, anon_vma);
 }
+#ifdef CONFIG_PAGE_OWNER
+static int anon_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
+			void *data, char *kbuf, size_t count)
+{
+	int ret;
+	unsigned long address = (unsigned long)data;
+
+	ret = scnprintf(kbuf, count, "ANON_PAGE address 0x%lx\n", address);
+
+	return ret;
+}
+#endif
 
 /**
  * __folio_set_anon - set up a new anonymous rmap for a folio
@@ -1182,6 +1194,7 @@ static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
 	folio->index = linear_page_index(vma, address);
+	set_folio_alloc_post_page_owner(folio, anon_alloc_post_page_owner, (void *)address);
 }
 
 /**
-- 
2.34.1

