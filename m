Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2296803675
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbjLDOYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjLDOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C3210E4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IO1sF7V8N+lGKeYvOYG0Xi/4CGC4wNOlZZ1+xeF2jmE=;
        b=dlIijEOgxDk40B2weiJNEqwQYsfVxJMvaiGQuCclUd/LumrZ+9yrMd0a8gQZaunCUXqZDM
        C/+uQPHhDU80t3x5OFEvxw1LhmHgrMasArQgXkRJ91fBfwn7zWYckqz8EofhQ/tXvFMVI9
        EF3hfZ05ZeGUdON6pVS9u4EdNqpQPAA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-EsHpcshiPLKnjsrxEa5ujA-1; Mon,
 04 Dec 2023 09:22:40 -0500
X-MC-Unique: EsHpcshiPLKnjsrxEa5ujA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3E941C03D95;
        Mon,  4 Dec 2023 14:22:39 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2055C2026D68;
        Mon,  4 Dec 2023 14:22:38 +0000 (UTC)
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
Subject: [PATCH RFC 27/39] mm/ksm: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:34 +0100
Message-ID: <20231204142146.91437-28-david@redhat.com>
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

Let's convert replace_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 357944588a9a9..c23aed4f1a344 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1279,7 +1279,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	set_pte_at_notify(mm, addr, ptep, newpte);
 
 	folio = page_folio(page);
-	page_remove_rmap(page, vma, false);
+	folio_remove_rmap_pte(folio, page, vma);
 	if (!folio_mapped(folio))
 		folio_free_swap(folio);
 	folio_put(folio);
-- 
2.41.0

