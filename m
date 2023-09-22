Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041C7AA9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjIVHKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjIVHKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:10:33 -0400
Received: from out-217.mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC318F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:10:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695366626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NMcmRX/w2n3M3EQea1/2ZhpgRQyZV6LdD1tfFyUHrY=;
        b=fPPxKFrTLFfvL3jUV7itB9gMnKWR/r7Snjv26hnF+iiC5cBKWt1EOcJiso/9kwp07Pc/E/
        xO9LzRFYie1qlDtSrkxynAhhzP/0j+M5qMOLAGoypKYac3zL2PZvrY3sznXwcP3QWg6wwc
        6fDf5t+PpwLmQdL+crOn+jgf7v0Hej8=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, glider@google.com, elver@google.com,
        dvyukov@google.com, rppt@kernel.org, david@redhat.com,
        osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 4/4] mm: don't set page count in deferred_init_pages
Date:   Fri, 22 Sep 2023 15:09:23 +0800
Message-Id: <20230922070923.355656-5-yajun.deng@linux.dev>
In-Reply-To: <20230922070923.355656-1-yajun.deng@linux.dev>
References: <20230922070923.355656-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operations of page count in deferred_init_pages and deferred_free_range
is the opposite operation. It's unnecessary and time-consuming.

Don't set page count in deferred_init_pages, as it'll be reset later.

The following data was tested on an x86 machine with 190GB of RAM.

before:
node 0 deferred pages initialised in 78ms

after:
node 0 deferred pages initialised in 72ms

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mm_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1cc310f706a9..fe78f6916c66 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1984,7 +1984,7 @@ static void __init deferred_free_range(unsigned long pfn,
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
 			set_pageblock_migratetype(page + i, MIGRATE_MOVABLE);
-		__free_pages_core(page, MAX_ORDER, MEMINIT_LATE);
+		__free_pages_core(page, MAX_ORDER, MEMINIT_EARLY);
 		return;
 	}
 
@@ -1994,7 +1994,7 @@ static void __init deferred_free_range(unsigned long pfn,
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, 0, MEMINIT_LATE);
+		__free_pages_core(page, 0, MEMINIT_EARLY);
 	}
 }
 
@@ -2068,7 +2068,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid, true, false);
+		__init_single_page(page, pfn, zid, nid, false, false);
 		nr_pages++;
 	}
 	return (nr_pages);
-- 
2.25.1

