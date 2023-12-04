Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF380366F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345267AbjLDOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjLDOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C069D19BC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yM8m6ebsRHp16rDmw00I1U0rPyCAW3pmLtjnA6MDqao=;
        b=OfxSlGadlI4HtLxajMWXZbw3nuyK3JkFvFvj9sBje577HEXparIGrwYgrP7sOgC1e2e7xD
        4/DVKx9aPOU7kSwRHIPOMyvikwYEp+ebr3SFAj3GoabwSFc93CMTZo3hbhCm+f2kPhk25q
        guLg1WsjjWzphOh+XA2U6jbXcnuw/Tc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-EoSRB73-NTeakXqzF60bBg-1; Mon, 04 Dec 2023 09:22:31 -0500
X-MC-Unique: EoSRB73-NTeakXqzF60bBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2B7C101A550;
        Mon,  4 Dec 2023 14:22:29 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 599D82026D4C;
        Mon,  4 Dec 2023 14:22:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH RFC 22/39] mm/rmap: remove RMAP_COMPOUND
Date:   Mon,  4 Dec 2023 15:21:29 +0100
Message-ID: <20231204142146.91437-23-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No longer used, let's remove it and clarify RMAP_NONE/RMAP_EXCLUSIVE a
bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 12 +++---------
 mm/rmap.c            |  2 --
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 865d83148852d..017b216915f19 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -172,20 +172,14 @@ struct anon_vma *folio_get_anon_vma(struct folio *folio);
 typedef int __bitwise rmap_t;
 
 /*
- * No special request: if the page is a subpage of a compound page, it is
- * mapped via a PTE. The mapped (sub)page is possibly shared between processes.
+ * No special request: A mapped anonymous (sub)page is possibly shared between
+ * processes.
  */
 #define RMAP_NONE		((__force rmap_t)0)
 
-/* The (sub)page is exclusive to a single process. */
+/* The anonymous (sub)page is exclusive to a single process. */
 #define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
 
-/*
- * The compound page is not mapped via PTEs, but instead via a single PMD and
- * should be accounted accordingly.
- */
-#define RMAP_COMPOUND		((__force rmap_t)BIT(1))
-
 /*
  * Internally, we're using an enum to specify the granularity. Usually,
  * we make the compiler create specialized variants for the different
diff --git a/mm/rmap.c b/mm/rmap.c
index 4cb9d8b7d1d65..3587225055c5e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2615,8 +2615,6 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  * The following two functions are for anonymous (private mapped) hugepages.
  * Unlike common anonymous pages, anonymous hugepages have no accounting code
  * and no lru code, because we handle hugepages differently from common pages.
- *
- * RMAP_COMPOUND is ignored.
  */
 void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
-- 
2.41.0

