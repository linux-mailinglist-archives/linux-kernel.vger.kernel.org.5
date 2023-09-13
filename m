Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBE79E853
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbjIMMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjIMMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C783219B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcwyuEyPhUjibl+UPXTZ+YZfX1YncqC+LcRBkk4rhVQ=;
        b=TcwgLUjcSt8KyaNcTRWSDsebjVmcB6IeEn6C4e003MHugNCvu3vXw0ws9oc7VOC1GX3vBX
        o77ublDLqWL9ARchHN3xVKGkmgiQO2kIXkbKaRnvIPvzWf4wrB/qClW/X8GXKQhcwyRzJq
        k6Zkr9k2rXm+yT7JH2Z7hSE/AUiJ+Zc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-skkLD7dfNDCSC0zIh01gyA-1; Wed, 13 Sep 2023 08:51:19 -0400
X-MC-Unique: skkLD7dfNDCSC0zIh01gyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CA79857A9A;
        Wed, 13 Sep 2023 12:51:19 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FF2D2156721;
        Wed, 13 Sep 2023 12:51:17 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 1/6] mm/rmap: drop stale comment in page_add_anon_rmap and hugepage_add_anon_rmap()
Date:   Wed, 13 Sep 2023 14:51:08 +0200
Message-ID: <20230913125113.313322-2-david@redhat.com>
In-Reply-To: <20230913125113.313322-1-david@redhat.com>
References: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That comment was added in commit 5dbe0af47f8a ("mm: fix kernel BUG at
mm/rmap.c:1017!") to document why we can see vma->vm_end getting
adjusted concurrently due to a VMA split.

However, the optimized locking code was changed again in bf181b9f9d8
("mm anon rmap: replace same_anon_vma linked list with an interval tree.").

... and later, the comment was changed in commit 0503ea8f5ba7 ("mm/mmap:
remove __vma_adjust()") to talk about "vma_merge" although the original
issue was with VMA splitting.

Let's just remove that comment. Nowadays, it's outdated, imprecise and
confusing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ec7f8e6c9e48..ca2787c1fe05 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1245,7 +1245,6 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 
 	if (likely(!folio_test_ksm(folio))) {
-		/* address might be in next vma when migration races vma_merge */
 		if (first)
 			__page_set_anon_rmap(folio, page, vma, address,
 					     !!(flags & RMAP_EXCLUSIVE));
@@ -2536,7 +2535,6 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(!anon_vma);
-	/* address might be in next vma when migration races vma_merge */
 	first = atomic_inc_and_test(&folio->_entire_mapcount);
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
-- 
2.41.0

