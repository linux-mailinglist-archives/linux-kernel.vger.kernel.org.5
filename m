Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FD76DE82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjHCCsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjHCCsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:48:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A81AA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:48:31 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230803024829epoutp0475e0e32981c097cfd23a0856b8ab0e45~3v6cwSvZE1686416864epoutp04R
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:48:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230803024829epoutp0475e0e32981c097cfd23a0856b8ab0e45~3v6cwSvZE1686416864epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691030909;
        bh=CwBsuvROgaXCJ8AMDL4SdXVgyJ0v6aiqhJAaPpU3dPk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=G7CQKH3gIpIIWY7zdwYmI1MuoQOnskpH802WAnQjJsZK1J4fOJ30Y5vhe9p5T8bTm
         E1+xrwTZUH2BtKsG222bBjbEuivyO7I7MSDII5dgAP+qVr3/8VUu5WiW1zdCKTZGMg
         ggxKvriatT+jiwVutJ3GnUu95AnLCXRA5kxK4oxo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230803024829epcas2p34e6b1542e6e1e5849517c7ca28ab2287~3v6cOK3eI2760627606epcas2p36;
        Thu,  3 Aug 2023 02:48:29 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RGYF85ZKbz4x9Pv; Thu,  3 Aug
        2023 02:48:28 +0000 (GMT)
X-AuditID: b6c32a43-84dfa7000000c342-61-64cb157c45d9
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.23.49986.C751BC46; Thu,  3 Aug 2023 11:48:28 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 1/4] block: make bvec_try_merge_hw_page() non-static
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230803024827epcms2p838d9e9131492c86a159fff25d195658f@epcms2p8>
Date:   Thu, 03 Aug 2023 11:48:27 +0900
X-CMS-MailID: 20230803024827epcms2p838d9e9131492c86a159fff25d195658f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmqW6N6OkUgx9vtCxW3+1ns5h1+zWL
        xctDmhanJyxisph06Bqjxd5b2haXd81hs1h+/B+TxbrX71kcOD3O39vI4rF5hZbH5bOlHptW
        dbJ5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzti0w7ugh6di+5uz7A2M3VxdjJwcEgImEvMez2MD
        sYUEdjBKbD9a1MXIwcErICjxd4cwSFhYwF1iR/MCqBIliXNrZjFCxA0kWm63sYDYbAJ6Ejue
        72bvYuTiEBGYwyxxac0yVoj5vBIz2p+yQNjSEtuXbwVr5hTwk7g0bTZUXEPix7JeZghbVOLm
        6rfsMPb7Y/MZIWwRidZ7Z6FqBCUe/NwNFZeUOHToKxvIzRIC+RIbDgRChGsk2n69hyrXl7jW
        sRFsFa+Ar8SyWSuZQGwWAVWJdZ/vQp3pIrHn/n0wm1lAXmL72znMICOZBTQl1u/Sh5iuLHHk
        FgtEBZ9Ex+G/7DAPNmz8jZW9Y94TJohWNYlFTUYQYRmJr4fns09gVJqFCOZZSNbOQli7gJF5
        FaNYakFxbnpqslGBITxek/NzNzGCU6iW8w7GK/P/6R1iZOJgPMQowcGsJMIr/ft4ihBvSmJl
        VWpRfnxRaU5q8SFGU6CHJzJLiSbnA5N4Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZ
        qakFqUUwfUwcnFINTL17riy0TXn2LbBtx4NvX4O+LTz9OF72wJ30qTnLq2xyzAz4d+guKnN6
        6NiqcPel/8rQPIWd6tdc3m22XN6utjFlRubJ2h1xss0OqyKqH/2Xr4wMKZJf3pxuyao5+1zp
        t9yD6nfOx67/ZlZ3q1WGsSHWnOfa9f38d2+GuvWsOjP7bVxJe3VGziH9ki3V5nMNbLZflvaz
        XSnHty9tuuyVNmdhyfTVdVkrDJr3trevqLbW/13ye2/cxtvNAskdM3u5tefz+VySTPrL4HLy
        fcTJb63F9+s+TfksdqOMx9ZVZvuu+yVVN7hXfl9e1s0w/VmiYqNp+/uolniFotLFtX5fmxUC
        uGwPH2pZuaysO0hOiaU4I9FQi7moOBEA51Mc+yoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
References: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used for multi-page configuration for integrity payload.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio.c | 2 +-
 block/blk.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index c92dda962449..8d1533af7c60 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -934,7 +934,7 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
  * size limit.  This is not for normal read/write bios, but for passthrough
  * or Zone Append operations that we can't split.
  */
-static bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
+bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset,
 		bool *same_page)
 {
diff --git a/block/blk.h b/block/blk.h
index 686712e13835..9d22ec3a53bc 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -75,6 +75,10 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
 
+bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
+		struct page *page, unsigned len, unsigned offset,
+		bool *same_page);
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
-- 
2.34.1
