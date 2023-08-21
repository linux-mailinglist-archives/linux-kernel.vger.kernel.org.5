Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552C782DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjHUQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjHUQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69410F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692634146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXgxSUiHlACYEZ8/tewWc2FJCrUF3dBlQ9Skg2Bh23k=;
        b=Pq/BL3S7WZzvJ9buNcwNKPZofA9JOOlKM8lT9Kk80y4FN1T0HdqTTkEk+gDv6OCFfFsDWE
        IrXQmQ2oYY1dT6xyZ+bmz9pKstgaJ6be3OOYwtI1ChqRyfd6ZgirrG0P2WvJNGpn2DZ5wN
        IVwvsbAEaBOabyXvFbuC3umJznEJjx0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-gUGvI0rJOSu3AbVA6NUL9A-1; Mon, 21 Aug 2023 12:09:01 -0400
X-MC-Unique: gUGvI0rJOSu3AbVA6NUL9A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 807BE3C11A04;
        Mon, 21 Aug 2023 16:08:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EBE9492C13;
        Mon, 21 Aug 2023 16:08:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH mm-unstable v1 2/4] mm/swap: use dedicated entry for swap in folio
Date:   Mon, 21 Aug 2023 18:08:47 +0200
Message-ID: <20230821160849.531668-3-david@redhat.com>
In-Reply-To: <20230821160849.531668-1-david@redhat.com>
References: <20230821160849.531668-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <willy@infradead.org>

Let's stop working on the private field and use an explicit swap field.
We have to move the swp_entry_t typedef.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 23 +++++++++++++----------
 include/linux/swap.h     |  5 ++---
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 61361f1750c3..438a07854f8c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -259,6 +259,14 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
  */
 #define  TAIL_MAPPING_REUSED_MAX  (2)
 
+/*
+ * A swap entry has to fit into a "unsigned long", as the entry is hidden
+ * in the "index" field of the swapper address space.
+ */
+typedef struct {
+	unsigned long val;
+} swp_entry_t;
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -269,7 +277,7 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
  * @index: Offset within the file, in units of pages.  For anonymous memory,
  *    this is the index from the beginning of the mmap.
  * @private: Filesystem per-folio data (see folio_attach_private()).
- *    Used for swp_entry_t if folio_test_swapcache().
+ * @swap: Used for swp_entry_t if folio_test_swapcache().
  * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
  *    find out how many times this folio is mapped by userspace.
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
@@ -312,7 +320,10 @@ struct folio {
 			};
 			struct address_space *mapping;
 			pgoff_t index;
-			void *private;
+			union {
+				void *private;
+				swp_entry_t swap;
+			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
 #ifdef CONFIG_MEMCG
@@ -1220,14 +1231,6 @@ enum tlb_flush_reason {
 	NR_TLB_FLUSH_REASONS,
 };
 
- /*
-  * A swap entry has to fit into a "unsigned long", as the entry is hidden
-  * in the "index" field of the swapper address space.
-  */
-typedef struct {
-	unsigned long val;
-} swp_entry_t;
-
 /**
  * enum fault_flag - Fault flag definitions.
  * @FAULT_FLAG_WRITE: Fault was a write fault.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 84fe0e94f5cd..82859a1944f5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -335,8 +335,7 @@ struct swap_info_struct {
 
 static inline swp_entry_t folio_swap_entry(struct folio *folio)
 {
-	swp_entry_t entry = { .val = page_private(&folio->page) };
-	return entry;
+	return folio->swap;
 }
 
 static inline swp_entry_t page_swap_entry(struct page *page)
@@ -350,7 +349,7 @@ static inline swp_entry_t page_swap_entry(struct page *page)
 
 static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
 {
-	folio->private = (void *)entry.val;
+	folio->swap = entry;
 }
 
 /* linux/mm/workingset.c */
-- 
2.41.0

