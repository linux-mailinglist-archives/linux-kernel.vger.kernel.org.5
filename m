Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26067C622B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJLBWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjJLBWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:22:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C97D98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:21:59 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231012012154epoutp03efaf986c6f9cd57cc51374d2c062020a~NN40yx3dF0057900579epoutp03H
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:21:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231012012154epoutp03efaf986c6f9cd57cc51374d2c062020a~NN40yx3dF0057900579epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697073714;
        bh=7H0v5Ho0xCMOHAlATsQ+2agtg+oJP2k/heeGuFBWmXk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YpzJXSWQlcSAeqaeS3irZlUyN6fKeZTrG3YJuSTifoTeqmoRdat93jYnPhDhw5K7+
         wns40FaCdZW7Lh1ynaXh97lg8YBQancDEK5E4tpggwRJwyA2zj+r6sR26hlHbq6vPB
         bnSd+K46kd4AT+3UIPruqCSRPcWadg0qEEv43oQk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231012012153epcas2p2544b47305521e527fa664ef08c3a8dbe~NN40ZJaq92121121211epcas2p2z;
        Thu, 12 Oct 2023 01:21:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S5X0x35WCz4x9Q3; Thu, 12 Oct
        2023 01:21:53 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.28.09693.13A47256; Thu, 12 Oct 2023 10:21:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d~NN4zuYfw-1690416904epcas2p3I;
        Thu, 12 Oct 2023 01:21:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231012012153epsmtrp2ad75a250d8ac9aba399a830f068c9818~NN4ztra1Q2295322953epsmtrp20;
        Thu, 12 Oct 2023 01:21:53 +0000 (GMT)
X-AuditID: b6c32a45-abbfd700000025dd-b5-65274a31f973
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.4D.18916.03A47256; Thu, 12 Oct 2023 10:21:52 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231012012152epsmtip1d3663edb6846e000ef6ca2fdbc07e4b1~NN4zmAgks0828408284epsmtip1f;
        Thu, 12 Oct 2023 01:21:52 +0000 (GMT)
From:   Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Hyesoo Yu <hyesoo.yu@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: check the order of compound page event when
 the order is 0
Date:   Thu, 12 Oct 2023 10:11:06 +0900
Message-Id: <20231012011106.2425309-1-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmma6hl3qqweU34hZz1q9hs/jbeYHV
        4vKuOWwW99b8Z3Vg8dj0aRK7x4kZv1k8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjxcZ/jAWbeCr+vZ/D1MD4j7OL
        kZNDQsBEYsXB6+xdjFwcQgI7GCUmHJ7EDOF8YpT4+HE+E5xzbtF3FpiWWd/PQrXsZJT48OAT
        I0hCSOAzo8Sd6TogNpuAusSJLcvA4iICLBIrv4M0c3EwC7QxSkx+excsISwQK9He9AFoEgcH
        i4CqxLT5CiBhXgEbiTcLzrJBLJOXmHnpOztEXFDi5MwnYEcwA8Wbt84GO1VCYB27xOslrWwg
        cyQEXCQ+96dA9ApLvDq+hR3ClpL4/G4v1MxsibsfJ0DZJRLrzjRA1RhLzHrWzggyhllAU2L9
        Ln2IicoSR25BbeWT6Dj8lx0izCvR0SYE0agssX/ZPGjoSEo8WtvOClHiIdG1Jx4SNrESt2+d
        YJzAKD8LySuzkLwyC2HtAkbmVYxiqQXFuempxUYFhvAYTc7P3cQITnJarjsYJ7/9oHeIkYmD
        8RCjBAezkgjvo0yVVCHelMTKqtSi/Pii0pzU4kOMpsCwncgsJZqcD0yzeSXxhiaWBiZmZobm
        RqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1MBnt6I3/rXXtoMO6/fsZLb7LXDizsoF/
        9/MsPu288oiq1qYLjTUCGyMFX1bta76Wf1ZzfcF9//TtT9+t1SncWH4jME+vMe/d3h3ayir5
        qxbX9VXIqZ7zz/y5i+Wcav3h8Pmzzq5+dmlhjfNPl9kW/gxng5trDpW+47/6j33a+r/bPCsm
        W+RIxpnFLN6XdLDDieE13/YDGt+q2NRyuE4rXBeyiYmLjnijbb5nyZbzKidWBf/+t/3H5BM7
        Bc+9tJhZmF+/fIvaiuD3qYuj09XDN/lfmM/1ZvZ/sauGnzeLB+1dqTRtejhLaku3k31i4Rrx
        J3xd4u0PpqV0eHwrn7HMRsLkyp4nuzM6d0iJsqyNEVViKc5INNRiLipOBACCaQUF+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnK6Bl3qqwbIfVhZz1q9hs/jbeYHV
        4vKuOWwW99b8Z3Vg8dj0aRK7x4kZv1k8+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+PFxn+M
        BZt4Kv69n8PUwPiPs4uRk0NCwERi1vez7F2MXBxCAtsZJRZ1P2CBSEhKzPp8kgnCFpa433KE
        FaLoI6PEi1vX2UASbALqEie2LGMEsUUEWCRWfv/OAlLELNDBKLHzxgmwhLBAtMSv+eeBVnBw
        sAioSkybrwAS5hWwkXiz4CwbxAJ5iZmXvrNDxAUlTs58AnYEM1C8eets5gmMfLOQpGYhSS1g
        ZFrFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJERx2WkE7GJet/6t3iJGJg/EQowQHs5II76NM
        lVQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGpo5LNnP0
        J/6dvKexbEKU0LotzBcOTlQVfaqjk+4s9d/LbZpxW8mZsq60q0uWGtyw9f4WfvSbx5vQ/rLT
        nS8CZugt2HFBtuCIixqnQ3ir386Wp18aHRfP25QaJOPzu2y94a59RbY3WStLZn3NUN3NvlPu
        n0CAz0LezDnTO9iFPbOevfujFKcfG+KQJHlcZmqW6S0fWRtxibgk7v+98lqHMl13b1p5MVB6
        Vk0Sk27V/GZdj6z/QS8a1Er/JP/wPyuyYrIcu2lR5YbH8vpacv8Pf3212ufxrqop2QtlMpXb
        s6u1pqptMXIxFJ6Zt3jl3ZfbzWOj1QzLpq1dsjF13pr0j+/LzqonzZCp/RvCcfm5EktxRqKh
        FnNRcSIAzyK6T6oCAAA=
X-CMS-MailID: 20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d
References: <CGME20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For compound pages, the head sets the PG_head flag and
the tail sets the compound_head to indicate the head page.
If a user allocates a compound page and frees it with a different
order, the compound page information will not be properly
initialized. To detect this problem, compound_page(page) and
the order are compared, but it is not checked when the order is 0.
That error should be checked regardless of the order.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..fc92ac93c7c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1078,6 +1078,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
 	bool init = want_init_on_free();
+	bool compound = PageCompound(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1096,16 +1097,15 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		return false;
 	}
 
+	VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
+
 	/*
 	 * Check tail pages before head page information is cleared to
 	 * avoid checking PageCompound for order-0 pages.
 	 */
 	if (unlikely(order)) {
-		bool compound = PageCompound(page);
 		int i;
 
-		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
-
 		if (compound)
 			page[1].flags &= ~PAGE_FLAGS_SECOND;
 		for (i = 1; i < (1 << order); i++) {
-- 
2.25.1

