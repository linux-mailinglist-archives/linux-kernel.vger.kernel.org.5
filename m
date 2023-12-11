Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5380D040
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbjLKP6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344550AbjLKP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657218B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErbCAGluk3VXsqVDEiyD10ub89UxQEpB3+XojBc5SDY=;
        b=d3ue1kfigJmW7Qyl3FBhDf1gxNbrsTPwuHZuEFMSXkJBWM/Qr3kV6QJhsDT1lDmScT51X6
        OTgxkz1J6Ts4hGCXvRSFFxw4NEnP9OrAmIuSqlX3nkdDdG79hBthjM/7Uby8pM0WAD21gw
        KqbJRhk4WS0PhZZhfbgg86uzg1rDiE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-mgQppAEyP5iFD7nuwA5GFg-1; Mon, 11 Dec 2023 10:57:47 -0500
X-MC-Unique: mgQppAEyP5iFD7nuwA5GFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57849870831;
        Mon, 11 Dec 2023 15:57:47 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2D511121306;
        Mon, 11 Dec 2023 15:57:44 +0000 (UTC)
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
Subject: [PATCH v1 20/39] mm/memory: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date:   Mon, 11 Dec 2023 16:56:33 +0100
Message-ID: <20231211155652.131054-21-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Let's convert restore_exclusive_pte() and do_swap_page(). While at it,
perform some folio conversion in restore_exclusive_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 70754fd65788..97e064883992 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -710,6 +710,7 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 				  struct page *page, unsigned long address,
 				  pte_t *ptep)
 {
+	struct folio *folio = page_folio(page);
 	pte_t orig_pte;
 	pte_t pte;
 	swp_entry_t entry;
@@ -725,14 +726,15 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	else if (is_writable_device_exclusive_entry(entry))
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 
-	VM_BUG_ON(pte_write(pte) && !(PageAnon(page) && PageAnonExclusive(page)));
+	VM_BUG_ON_FOLIO(pte_write(pte) && (!folio_test_anon(folio) &&
+					   PageAnonExclusive(page)), folio);
 
 	/*
 	 * No need to take a page reference as one was already
 	 * created when the swap entry was made.
 	 */
-	if (PageAnon(page))
-		page_add_anon_rmap(page, vma, address, RMAP_NONE);
+	if (folio_test_anon(folio))
+		folio_add_anon_rmap_pte(folio, page, vma, address, RMAP_NONE);
 	else
 		/*
 		 * Currently device exclusive access only supports anonymous
@@ -4073,7 +4075,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
+		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
-- 
2.43.0

