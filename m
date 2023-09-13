Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4F79E856
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbjIMMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbjIMMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3694119BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iURFDA2RdJWU1H9IedgFZuHwYBnEAwvtokGRQic4P+w=;
        b=bK8NUHwZbHB1MYsGiOEMfonkJW9PoUyEEQtuBqPNIHv7LxjKQxof7JtYfeKB0dxS65AGZ/
        fkT3oai9/QHPWrhCoIN26aBquRvCOLwjUTbOwjczo8C4OS3jWuXeFL9z9glT/1XAfQG/eJ
        alNKnBpMfq0aH/bNjveBRBw/peTCP/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-uy6DAjTwN3CYPzjjmN_0TQ-1; Wed, 13 Sep 2023 08:51:26 -0400
X-MC-Unique: uy6DAjTwN3CYPzjjmN_0TQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB2A58030CB;
        Wed, 13 Sep 2023 12:51:25 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A94721B20B1;
        Wed, 13 Sep 2023 12:51:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 4/6] mm/rmap: warn on new PTE-mapped folios in page_add_anon_rmap()
Date:   Wed, 13 Sep 2023 14:51:11 +0200
Message-ID: <20230913125113.313322-5-david@redhat.com>
In-Reply-To: <20230913125113.313322-1-david@redhat.com>
References: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If swapin code would ever decide to not use order-0 pages and supply a
PTE-mapped large folio, we will have to change how we call
__folio_set_anon() -- eventually with exclusive=false and an adjusted
address. For now, let's add a VM_WARN_ON_FOLIO() with a comment about the
situation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1ac5bd1b8169..489c142d073b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1238,6 +1238,13 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 
 	if (unlikely(!folio_test_anon(folio))) {
 		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+		/*
+		 * For a PTE-mapped large folio, we only know that the single
+		 * PTE is exclusive. Further, __folio_set_anon() might not get
+		 * folio->index right when not given the address of the head
+		 * page.
+		 */
+		VM_WARN_ON_FOLIO(folio_test_large(folio) && !compound, folio);
 		__folio_set_anon(folio, vma, address,
 				 !!(flags & RMAP_EXCLUSIVE));
 	} else if (likely(!folio_test_ksm(folio))) {
-- 
2.41.0

