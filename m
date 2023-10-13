Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A07C8D75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjJMTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjJMTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7007DBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697223862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjtK2o/m5KP3/dyNmmPPz1m7WWyth7vyB+quu5YHBuU=;
        b=b4XcgHrvqT0gmuX7MdNm4FmHTOn1X0mOOvMtyIaIdZaVDwAWl8+Ss8Ar91CJku5lP34SJp
        WfYmuqA04TX9pQFOmdr0pnbTNzGFU63gauLJvTfzTY6qeMOrz5gCI/fJe3LTPnRv6mDfpo
        e1oBW+1yxcMCaZDt91Dq4ZvSaK8IX6k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-1r44kpejO3C42J4SMTd1YA-1; Fri, 13 Oct 2023 15:04:06 -0400
X-MC-Unique: 1r44kpejO3C42J4SMTd1YA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E803382A68B;
        Fri, 13 Oct 2023 19:04:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD86B2157F5A;
        Fri, 13 Oct 2023 19:04:05 +0000 (UTC)
From:   Audra Mitchell <audra@redhat.com>
To:     linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm/page_owner: Remove free_ts from page_owner output
Date:   Fri, 13 Oct 2023 15:03:45 -0400
Message-ID: <20231013190350.579407-2-audra@redhat.com>
In-Reply-To: <20231013190350.579407-1-audra@redhat.com>
References: <20231013190350.579407-1-audra@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printing page_owner data via the sysfs interface, no free pages will
ever be dumped due to the series of checks in read_page_owner():

    /*
     * Although we do have the info about past allocation of free
     * pages, it's not relevant for current memory usage.
     */
     if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))

The free_ts values are still used when dump_page_owner() is called, so
keeping the field for other use cases but removing them for the typical
page_owner case.

Fixes: 866b48526217 ("mm/page_owner: record the timestamp of all pages during free")
Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 mm/page_owner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4e2723e1b300..4f13ce7d2452 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -408,11 +408,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = scnprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns, free_ts %llu ns\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
 			page_owner->tgid, page_owner->comm,
-			page_owner->ts_nsec, page_owner->free_ts_nsec);
+			page_owner->ts_nsec);
 
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
-- 
2.41.0

