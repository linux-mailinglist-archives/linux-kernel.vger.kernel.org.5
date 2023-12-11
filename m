Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8480D03E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbjLKP6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344536AbjLKP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435A184
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EJB9NGtrAo1f2+F9yoIp/qkcy9rFrccif86+rqYixU=;
        b=OZB2h8yNR6wjBuya4G/w2HVruSvog7S6Z3Zq5ttjb0EY3haMICk+hPf7zV2INahKI0+UqO
        HuT7kkLy365cPFUROgP3SAEZGn2YP9pkrzfKMaoq91Q5MDMxJMVKTpPO/95ntdjx4jmmf7
        0R3s+s8SX5hA7pbR58y7leuokn1TsZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-_8Xjipn3N8OVVf8cQocN-w-1; Mon, 11 Dec 2023 10:57:42 -0500
X-MC-Unique: _8Xjipn3N8OVVf8cQocN-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9971B101E155;
        Mon, 11 Dec 2023 15:57:41 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 587D01121306;
        Mon, 11 Dec 2023 15:57:39 +0000 (UTC)
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
Subject: [PATCH v1 18/39] mm/ksm: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date:   Mon, 11 Dec 2023 16:56:31 +0100
Message-ID: <20231211155652.131054-19-david@redhat.com>
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

Let's convert replace_page(). While at it, perform some folio
conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b93389a3780e..2b6888ad1470 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1199,6 +1199,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 static int replace_page(struct vm_area_struct *vma, struct page *page,
 			struct page *kpage, pte_t orig_pte)
 {
+	struct folio *kfolio = page_folio(kpage);
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
 	pmd_t *pmd;
@@ -1238,15 +1239,16 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		goto out_mn;
 	}
 	VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
-	VM_BUG_ON_PAGE(PageAnon(kpage) && PageAnonExclusive(kpage), kpage);
+	VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage),
+			kfolio);
 
 	/*
 	 * No need to check ksm_use_zero_pages here: we can only have a
 	 * zero_page here if ksm_use_zero_pages was enabled already.
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
-		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
+		folio_get(kfolio);
+		folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		/*
-- 
2.43.0

