Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208E07665DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjG1H5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjG1H5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3053588
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:57:08 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230728075705epoutp019147b83ea6f19048bec67c27e13344a9~1_QLby_Hm0322503225epoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:57:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230728075705epoutp019147b83ea6f19048bec67c27e13344a9~1_QLby_Hm0322503225epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690531025;
        bh=fEBI3jFG7Yl1AWZ7NNNtJEMNDWilG4sULmX3Oko94OE=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=o/6Abm2zLDWk8oTBJ9gMmOehqk2OirOD1tmtGyvRKwm4noiKn2E1AEc0kG79ILPZR
         GBZ5gSj3JQqvBDJv6uo1Mz2YiayUa/cr4c/PfHeDSV1W1vBTLpiqUIbjpwM4KqPdaI
         6i8xf81HDexicAEaA2cBWQlCprJsoVuvpMqh2QmY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230728075705epcas2p2624e302aa77c663146ee97f7418e8739~1_QK4C-ot3006630066epcas2p2S;
        Fri, 28 Jul 2023 07:57:05 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RC0N04msqz4x9Q3; Fri, 28 Jul
        2023 07:57:04 +0000 (GMT)
X-AuditID: b6c32a45-e43e0a800000c2f9-7c-64c374d0b755
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.B2.49913.0D473C46; Fri, 28 Jul 2023 16:57:04 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/2] block: make bvec_try_merge_hw_page() non-static
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230728075704epcms2p1fec48202cbda466411c44437cf788dea@epcms2p1>
Date:   Fri, 28 Jul 2023 16:57:04 +0900
X-CMS-MailID: 20230728075704epcms2p1fec48202cbda466411c44437cf788dea
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmue6FksMpBjc2qlisvtvPZjHr9msW
        i5eHNC1Wrj7KZDHp0DVGi723tC0u75rDZrH8+D8mi3Wv37M4cHqcv7eRxePy2VKPTas62Tx2
        32xg8/j49BaLR9+WVYwenzfJebQf6GYK4IjKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
        1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
        U2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ3xZ+529oL73BVPP4Y3MD7m7GLk5JAQMJE4/PkQ
        axcjF4eQwA5GibcLdzN2MXJw8AoISvzdIQxSIyzgIjHz8jU2EFtIQEni3JpZjBBxA4mW220s
        IDabgJ7Ejue72UHmiAhMYJbYvOk2M8QCXokZ7U9ZIGxpie3Lt4I1cwr4Saxf+5IVIq4h8WNZ
        L1S9qMTN1W/ZYez3x+YzQtgiEq33zkLVCEo8+LkbKi4pcejQVzaQmyUE8iU2HAiECNdItP16
        D1WuL3GtYyPYCbwCvhIXrhwGs1kEVCXe3+5jg6hxkVh07DLYWmYBeYntb+cwg4xkFtCUWL9L
        H2K6ssSRWywQFXwSHYf/ssM82LDxN1b2jnlPmCBa1SQWNRlBhGUkvh6ezz6BUWkWIphnIVk7
        C2HtAkbmVYxiqQXFuempxUYFhvCITc7P3cQITqNarjsYJ7/9oHeIkYmD8RCjBAezkgjvqYBD
        KUK8KYmVValF+fFFpTmpxYcYTYEensgsJZqcD0zkeSXxhiaWBiZmZobmRqYG5krivPda56YI
        CaQnlqRmp6YWpBbB9DFxcEo1MJ1ZafXy0fPpR2e1vfrwX3ubu75S/3u1NezeQTPCVkjIVJeu
        c53pUfLp3VU5t7qA9O7r0blWn3YtNPir9OFk97Wo+bNNVzx0VPm6JMNSrCXzZLDSZdVKiytm
        0zI2PDYXMomS3uLzqv/GC+XGyqy8vTzrbNcf7e7+8tDwua3pg9XXjG8wb4i6msTZsov3yK/1
        +zUnu952rLj1Lldd4UaRVGR2ZNBqtq60eLbtVssY7qXm2Wd2TCttc11YOm9Xe3hPwlW/DcaH
        JqRmG2j8n5uYdzZPOp5X6sfjufUHPDtW6rRznJm0+NLvWMm5C67O/Jd84ueM9XcF3hy8l2dk
        v//slfmtLbLnCxtDIwV32GRq9iqxFGckGmoxFxUnAgBSZj6jLAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63
References: <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
        <CGME20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used for multi-page configuration for integrity payload.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

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
