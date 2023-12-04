Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E580365C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjLDOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbjLDOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630ADD50
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcozSwix+76TtkWexeYoWqf1En6dAEapeBtTC2bk/5E=;
        b=Ik7hIMgfP2ulxvd0KMg8QH8/0DOwV62IgmkUV2kR2mPnQ/lO+OnYPxxgM/5wfKsrWacWzI
        AKSBnE3owc78rHYAgPQ/iQtblRFSgXmwYjZuAemD9tIoSwEoBkPZbm5ciX1eAy124w4jcA
        agMJ280xg8/Xwjvgw3BH4KmWCnnwgcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261--TlKEsHfM9OY2J5oZszMwg-1; Mon, 04 Dec 2023 09:22:09 -0500
X-MC-Unique: -TlKEsHfM9OY2J5oZszMwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 290B08F9206;
        Mon,  4 Dec 2023 14:22:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF132026D68;
        Mon,  4 Dec 2023 14:22:07 +0000 (UTC)
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
Subject: [PATCH RFC 11/39] mm/userfaultfd: page_add_file_rmap() -> folio_add_file_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:18 +0100
Message-ID: <20231204142146.91437-12-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Let's convert mfill_atomic_install_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0b6ca553bebec..abf4c579d328a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -114,7 +114,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 		/* Usually, cache pages are already added to LRU */
 		if (newly_allocated)
 			folio_add_lru(folio);
-		page_add_file_rmap(page, dst_vma, false);
+		folio_add_file_rmap_pte(folio, page, dst_vma);
 	} else {
 		page_add_new_anon_rmap(page, dst_vma, dst_addr);
 		folio_add_lru_vma(folio, dst_vma);
-- 
2.41.0

