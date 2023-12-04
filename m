Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1559A803663
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjLDOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjLDOWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D819A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SP+gQ2Yl7ptxMmm0EN/M4/z6MAPTYZkvBQ5MoVKoj/U=;
        b=JIOAxx9XAGxW58tGaxmqu0YBcg2Yjeodr7xD3/UnF1MgoHhmjntBJg9d6tq6ZVm6G8zUxh
        3lnZiE2WNltSUrgcBPHRDb6y7LWJ+m/WlnCLHIcehCUeCTIqEKZa+yZ9cL6QstgCSgcEIN
        fzWlDEXcDarZQ7bT+/fx1NunX77GwBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-LlQ3-zByOwSqnbEF8yG6og-1; Mon, 04 Dec 2023 09:22:19 -0500
X-MC-Unique: LlQ3-zByOwSqnbEF8yG6og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C80C18314FA;
        Mon,  4 Dec 2023 14:22:18 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3338B2026D4C;
        Mon,  4 Dec 2023 14:22:17 +0000 (UTC)
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
Subject: [PATCH RFC 16/39] mm/huge_memory: page_add_anon_rmap() -> folio_add_anon_rmap_pmd()
Date:   Mon,  4 Dec 2023 15:21:23 +0100
Message-ID: <20231204142146.91437-17-david@redhat.com>
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

Let's convert remove_migration_pmd(). No need to set RMAP_COMPOUND, that
we will remove soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2c037ab3f4916..332cb6cf99f38 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3310,12 +3310,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		pmde = pmd_mkdirty(pmde);
 
 	if (folio_test_anon(folio)) {
-		rmap_t rmap_flags = RMAP_COMPOUND;
+		rmap_t rmap_flags = RMAP_NONE;
 
 		if (!is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		page_add_anon_rmap(new, vma, haddr, rmap_flags);
+		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
 	} else {
 		folio_add_file_rmap_pmd(folio, new, vma);
 	}
-- 
2.41.0

