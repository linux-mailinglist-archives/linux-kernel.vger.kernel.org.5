Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AE1788D70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjHYQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbjHYQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0756E77
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692982200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dFbyl65fOMx95bWsq7D1d9gpilx7s+IbQPWJBjX/wV0=;
        b=LxoFLt0PHo6rYo4VfDElv6uBsCL3Fq+ZjBDSzF6CgqXQm28ZdyUnE1h8Sd8VUIVW/vnhSR
        pvbyFkxdhHv6XfmFluqLLu/wavHD6drflY79dxrD1J4a49Ppd/ivru2hnw1yk2bqLdL5IF
        /D+LooZelEju4KazWeT1Nf2P+KMWYfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-Czpd90lvPDyB7m5MUA3VeA-1; Fri, 25 Aug 2023 12:49:57 -0400
X-MC-Unique: Czpd90lvPDyB7m5MUA3VeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DD9A8D40A0;
        Fri, 25 Aug 2023 16:49:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6D82166B28;
        Fri, 25 Aug 2023 16:49:56 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/kmemleak: Move up cond_resched() call in page scanning loop
Date:   Fri, 25 Aug 2023 12:49:47 -0400
Message-Id: <20230825164947.1317981-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bde5f6bc68db ("kmemleak: add scheduling point to kmemleak_scan()")
added a cond_resched() call to the struct page scanning loop to prevent
soft lockup from happening. However, soft lockup can still happen in
that loop in some corner cases when the pages that satisfy the "!(pfn &
63)" check are skipped for some reasons.

Fix this corner case by moving up the cond_resched() check so that it
will be called every 64 pages unconditionally.

Fixes: bde5f6bc68db ("kmemleak: add scheduling point to kmemleak_scan()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d34226e3c8..114d8dcdcf70 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1579,6 +1579,9 @@ static void kmemleak_scan(void)
 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 			struct page *page = pfn_to_online_page(pfn);
 
+			if (!(pfn & 63))
+				cond_resched();
+
 			if (!page)
 				continue;
 
@@ -1589,8 +1592,6 @@ static void kmemleak_scan(void)
 			if (page_count(page) == 0)
 				continue;
 			scan_block(page, page + 1, NULL);
-			if (!(pfn & 63))
-				cond_resched();
 		}
 	}
 	put_online_mems();
-- 
2.31.1

