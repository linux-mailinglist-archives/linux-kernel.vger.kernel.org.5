Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F341803662
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbjLDOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbjLDOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190B1994
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhcry2rMTXBwyY+r1UEd/G15BeM6OBHeZJqknbajPVE=;
        b=EIrO8iVzv5bjb4oji3deYqexQozuete2XjPB3KR/4WzBVSejdY6AIFumPDl2u9atj1lKS+
        RFZ96MJ8BkGGMEKz9pDp675dH8XItQcVLG8MXhzRd05+CHF7SiH24KEl2bW9gENmEc/hua
        Yj4ah+yn0d+gaDhWefGPi9lATDjF3yI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ZWpJIdMyMpmAHNLnESmGHw-1; Mon, 04 Dec 2023 09:22:21 -0500
X-MC-Unique: ZWpJIdMyMpmAHNLnESmGHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A76AF85A58B;
        Mon,  4 Dec 2023 14:22:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C38F2026D4C;
        Mon,  4 Dec 2023 14:22:18 +0000 (UTC)
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
Subject: [PATCH RFC 17/39] mm/migrate: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:24 +0100
Message-ID: <20231204142146.91437-18-david@redhat.com>
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

Let's convert remove_migration_pte().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index efc19f53b05e6..0e78680589bcc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -259,8 +259,8 @@ static bool remove_migration_pte(struct folio *folio,
 #endif
 		{
 			if (folio_test_anon(folio))
-				page_add_anon_rmap(new, vma, pvmw.address,
-						   rmap_flags);
+				folio_add_anon_rmap_pte(folio, new, vma,
+							pvmw.address, rmap_flags);
 			else
 				folio_add_file_rmap_pte(folio, new, vma);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
-- 
2.41.0

