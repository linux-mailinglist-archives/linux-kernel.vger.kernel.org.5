Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62E80D041
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjLKP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbjLKP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F018F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuC5xwuqcP7rQWdUGs+5SfITvp1Oi5oe13QDRULS4WU=;
        b=HVGBbowyJeZXhiFjYSfHcHcDig0oaeQOMpoMNqRNrvNHxB+p+gOi9qcEBWMvgX+SpuV5M+
        WgSGu556vNpqZoqW8PeSsNg5VXfCYCSp9Yutb4mMkrPJHu4tbclv5Ae6YqUoH2ZrmHEEUR
        hY3tMyiDlb/3GyuTsSmjHhA9sy0fdC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-hqCqiiJtNeeYflAwvpNPtw-1; Mon, 11 Dec 2023 10:57:52 -0500
X-MC-Unique: hqCqiiJtNeeYflAwvpNPtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8E6585A597;
        Mon, 11 Dec 2023 15:57:51 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25E491121306;
        Mon, 11 Dec 2023 15:57:50 +0000 (UTC)
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
Subject: [PATCH v1 22/39] mm/rmap: remove RMAP_COMPOUND
Date:   Mon, 11 Dec 2023 16:56:35 +0100
Message-ID: <20231211155652.131054-23-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
index bd4edae4dbe7..0acebe41ab8e 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -177,20 +177,14 @@ struct anon_vma *folio_get_anon_vma(struct folio *folio);
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
index 83cba8909848..9212726268ba 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2663,8 +2663,6 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  * The following two functions are for anonymous (private mapped) hugepages.
  * Unlike common anonymous pages, anonymous hugepages have no accounting code
  * and no lru code, because we handle hugepages differently from common pages.
- *
- * RMAP_COMPOUND is ignored.
  */
 void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
-- 
2.43.0

