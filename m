Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF337B5516
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbjJBOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjJBOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382BCB0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696257002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tnnd1i96YoBpg2Wk1+SUJX4WepSITGLgtW2LVCbh8ow=;
        b=gdxffqR5WYhgRxe/ZADdLcraC3CbWZeOZUdt8MfBQM7Gd+1makCMtW+CtEKPY3yxgK3iXc
        RpxEaNA7Q0G0Gqxmz8v455aPxEJlexwNM2v3giSWL4GiS6hj2fM1Zuamd1k3OQ7yjX4OD7
        1FMN2ToaymwixrqypLYGjPphpvIcY/U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-SD06yepTPyaOIWqDKjRAKw-1; Mon, 02 Oct 2023 10:29:56 -0400
X-MC-Unique: SD06yepTPyaOIWqDKjRAKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 805873826D2C;
        Mon,  2 Oct 2023 14:29:55 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F47B1005B90;
        Mon,  2 Oct 2023 14:29:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v1 3/3] memory: move exclusivity detection in do_wp_page() into wp_can_reuse_anon_folio()
Date:   Mon,  2 Oct 2023 16:29:49 +0200
Message-ID: <20231002142949.235104-4-david@redhat.com>
In-Reply-To: <20231002142949.235104-1-david@redhat.com>
References: <20231002142949.235104-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's clean up do_wp_page() a bit, removing two labels and making it
a easier to read.

wp_can_reuse_anon_folio() now only operates on the whole folio. Move the
SetPageAnonExclusive() out into do_wp_page(). No need to do this under
page lock -- the page table lock is sufficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 88 +++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f0e3317cbdd..512f6f05620e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3358,6 +3358,44 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 	return ret;
 }
 
+static bool wp_can_reuse_anon_folio(struct folio *folio,
+				    struct vm_area_struct *vma)
+{
+	/*
+	 * We have to verify under folio lock: these early checks are
+	 * just an optimization to avoid locking the folio and freeing
+	 * the swapcache if there is little hope that we can reuse.
+	 *
+	 * KSM doesn't necessarily raise the folio refcount.
+	 */
+	if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
+		return false;
+	if (!folio_test_lru(folio))
+		/*
+		 * We cannot easily detect+handle references from
+		 * remote LRU caches or references to LRU folios.
+		 */
+		lru_add_drain();
+	if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
+		return false;
+	if (!folio_trylock(folio))
+		return false;
+	if (folio_test_swapcache(folio))
+		folio_free_swap(folio);
+	if (folio_test_ksm(folio) || folio_ref_count(folio) != 1) {
+		folio_unlock(folio);
+		return false;
+	}
+	/*
+	 * Ok, we've got the only folio reference from our mapping
+	 * and the folio is locked, it's dark out, and we're wearing
+	 * sunglasses. Hit it.
+	 */
+	folio_move_anon_rmap(folio, vma);
+	folio_unlock(folio);
+	return true;
+}
+
 /*
  * This routine handles present pages, when
  * * users try to write to a shared page (FAULT_FLAG_WRITE)
@@ -3444,49 +3482,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	/*
 	 * Private mapping: create an exclusive anonymous page copy if reuse
 	 * is impossible. We might miss VM_WRITE for FOLL_FORCE handling.
+	 *
+	 * If we encounter a page that is marked exclusive, we must reuse
+	 * the page without further checks.
 	 */
-	if (folio && folio_test_anon(folio)) {
-		/*
-		 * If the page is exclusive to this process we must reuse the
-		 * page without further checks.
-		 */
-		if (PageAnonExclusive(vmf->page))
-			goto reuse;
-
-		/*
-		 * We have to verify under folio lock: these early checks are
-		 * just an optimization to avoid locking the folio and freeing
-		 * the swapcache if there is little hope that we can reuse.
-		 *
-		 * KSM doesn't necessarily raise the folio refcount.
-		 */
-		if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
-			goto copy;
-		if (!folio_test_lru(folio))
-			/*
-			 * We cannot easily detect+handle references from
-			 * remote LRU caches or references to LRU folios.
-			 */
-			lru_add_drain();
-		if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
-			goto copy;
-		if (!folio_trylock(folio))
-			goto copy;
-		if (folio_test_swapcache(folio))
-			folio_free_swap(folio);
-		if (folio_test_ksm(folio) || folio_ref_count(folio) != 1) {
-			folio_unlock(folio);
-			goto copy;
-		}
-		/*
-		 * Ok, we've got the only folio reference from our mapping
-		 * and the folio is locked, it's dark out, and we're wearing
-		 * sunglasses. Hit it.
-		 */
-		folio_move_anon_rmap(folio, vma);
-		SetPageAnonExclusive(vmf->page);
-		folio_unlock(folio);
-reuse:
+	if (folio && folio_test_anon(folio) &&
+	    (PageAnonExclusive(vmf->page) || wp_can_reuse_anon_folio(folio, vma))) {
+		if (!PageAnonExclusive(vmf->page))
+			SetPageAnonExclusive(vmf->page);
 		if (unlikely(unshare)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return 0;
@@ -3494,7 +3497,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		wp_page_reuse(vmf);
 		return 0;
 	}
-copy:
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-- 
2.41.0

