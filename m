Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4786480D03B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjLKP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344565AbjLKP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68297119
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzjxFSmJorC6pNmLrufiiZpWu6JbL+HXYJ1oUv8JfJw=;
        b=ZSv0bp5tpJK7KzwWeRRRi7MU0gLY0KSzNdnJvJxSNC4j6yNpBCw9M2VUZ99ubhtdt+umoS
        C1shLfUkgRKXYD1NpX+GZrDgEa3hYlfsef9bnOuOq3lxiyI4InQDmdYjaBiGSrIBlPQwLM
        DV4GEkvbXLSND6P0qDY7k+3waZX7TGI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-2Y4Cj1kpO9CR1D_HN3qvZQ-1; Mon,
 11 Dec 2023 10:57:37 -0500
X-MC-Unique: 2Y4Cj1kpO9CR1D_HN3qvZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB36238425B3;
        Mon, 11 Dec 2023 15:57:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D12261121306;
        Mon, 11 Dec 2023 15:57:34 +0000 (UTC)
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
Subject: [PATCH v1 16/39] mm/huge_memory: page_add_anon_rmap() -> folio_add_anon_rmap_pmd()
Date:   Mon, 11 Dec 2023 16:56:29 +0100
Message-ID: <20231211155652.131054-17-david@redhat.com>
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

Let's convert remove_migration_pmd(). No need to set RMAP_COMPOUND, that
we will remove soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 82ad68fe0d12..b03374d1bb94 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3611,12 +3611,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
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
2.43.0

