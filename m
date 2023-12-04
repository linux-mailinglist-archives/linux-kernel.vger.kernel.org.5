Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B781803668
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjLDOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjLDOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F59D107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YcgEyKtjLabsj9Cw4VckjmMQxcp5kDVs71EjXlBqC+E=;
        b=BBNBL3QWhxrNegllyxURZlMhK5hkYA9nbW2PMgkNBJ69gpjZm7Id24NOwODrJlj0ga+TRT
        UiF1OcKkhs12NSjlred/OFhWPPu3S5r0kiiVfp1bew20KTLlIJ8Ww9CN9X4jw4Yd+RkeH4
        tGpjx8JxkVptn988OGeuOo1Yle7tEVA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-YeNg8xp2Pg69b3ArcI-xHw-1; Mon,
 04 Dec 2023 09:22:27 -0500
X-MC-Unique: YeNg8xp2Pg69b3ArcI-xHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 464973C025D8;
        Mon,  4 Dec 2023 14:22:26 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5C672026D6E;
        Mon,  4 Dec 2023 14:22:24 +0000 (UTC)
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
Subject: [PATCH RFC 20/39] mm/memory: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:27 +0100
Message-ID: <20231204142146.91437-21-david@redhat.com>
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

Let's convert restore_exclusive_pte() and do_swap_page(). While at it,
perform some folio conversion in restore_exclusive_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index be7fe58f7c297..9543b6e2b749b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -706,6 +706,7 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 				  struct page *page, unsigned long address,
 				  pte_t *ptep)
 {
+	struct folio *folio = page_folio(page);
 	pte_t orig_pte;
 	pte_t pte;
 	swp_entry_t entry;
@@ -721,14 +722,15 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
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
@@ -4065,7 +4067,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
+		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
-- 
2.41.0

