Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC267F6066
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbjKWNgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjKWNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:36:26 -0500
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [IPv6:2001:41d0:1004:224b::af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAABD1B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:36:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700746272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmVKGX3xWVsiaI1L9mmzJOcNAtj7qPzayoGRggtSBII=;
        b=Ztzwn0HQtIgdF3nrfOjRTmuus6uH05VuvO5saXWr5t12Q51VOnt0v0Tdqe3fTgV29LfEAj
        ZlpS/GGfT1xwjVdXl9k5LFCEe038RDKIRwdprffhWUuffvY73PgEemYmViGVybE5iBDRMn
        6grrj48RxSO/qOyc0/yPWH8AYNiUtwQ=
From:   Gang Li <gang.li@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [RFC PATCH v1 3/4] hugetlb: add timing to hugetlb allocations on boot
Date:   Thu, 23 Nov 2023 21:30:35 +0800
Message-Id: <20231123133036.68540-4-gang.li@linux.dev>
In-Reply-To: <20231123133036.68540-1-gang.li@linux.dev>
References: <20231123133036.68540-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gang Li <ligang.bdlg@bytedance.com>

Add timing to hugetlb allocations for further optimization.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7f9ff0855dd0..ac8558724cc2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3563,7 +3563,7 @@ static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(struct hstat
  */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
-	unsigned long allocated;
+	unsigned long allocated, start;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3576,11 +3576,13 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 
 	/* below will do all node balanced alloc */
+	start = jiffies;
 	if (!hstate_is_gigantic(h)) {
 		allocated = hugetlb_hstate_alloc_pages_non_gigantic(h);
 	} else {
 		allocated = hugetlb_hstate_alloc_pages_gigantic(h);
 	}
+	pr_info("HugeTLB: Allocation takes %u ms\n", jiffies_to_msecs(jiffies - start));
 
 	hugetlb_hstate_alloc_pages_report(allocated, h);
 }
-- 
2.20.1

