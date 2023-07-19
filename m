Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F37759537
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGSMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGSMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:36:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7713E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:36:36 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230719123633epoutp04b66c1f313d2f5ac21e15de418fdb8662~zRQnDxLZ01268112681epoutp04E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230719123633epoutp04b66c1f313d2f5ac21e15de418fdb8662~zRQnDxLZ01268112681epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689770193;
        bh=Hif75bRAzib4zYxvClP6M+ybRL/9J1vZwD85Go2NhRs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eRQRSRTz0WoCIhWatmDoGxo8TjguANR+61vKjEGV717kNUMfXdLknKM3ezhJ1GCEK
         BQDfG47JmQRfUMRfUiqJisubjwFB5dDwLmHgMdNwtDEmtDSe6iHZNBm3cZNt8hTqrC
         c2lc4+FElUK2ObDRlrA7s8+PfLWMDUeTLsig9FuE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230719123632epcas5p4d3509481ff7a12ce4f36369b322b0687~zRQmMq6It0655806558epcas5p4g;
        Wed, 19 Jul 2023 12:36:32 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R5b0Z6YQSz4x9Pv; Wed, 19 Jul
        2023 12:36:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.CA.57354.DC8D7B46; Wed, 19 Jul 2023 21:36:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8~zRBstlAip3080830808epcas5p3Q;
        Wed, 19 Jul 2023 12:19:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230719121928epsmtrp246371f8757919d0dab71fa5e9d6c4bb4~zRBss9kdp0378803788epsmtrp2h;
        Wed, 19 Jul 2023 12:19:28 +0000 (GMT)
X-AuditID: b6c32a44-007ff7000001e00a-85-64b7d8cd8dd9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.78.64355.0D4D7B46; Wed, 19 Jul 2023 21:19:28 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230719121927epsmtip2a78974ac8469e31b8bd2ea71f8f36d25~zRBrus1er1907719077epsmtip2f;
        Wed, 19 Jul 2023 12:19:27 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     martin.petersen@oracle.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: refactor to use helper
Date:   Wed, 19 Jul 2023 17:46:08 +0530
Message-Id: <20230719121608.32105-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmlu7ZG9tTDDr3cFqsvtvPZnHzwE4m
        i723tC0u75rDZrH8+D8mi22/5zM7sHlcPlvq8fHpLRaPvi2rGD0+b5ILYInKtslITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWq2kUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7Yu2gNe0EnR8Wc
        zu1sDYyn2LoYOTkkBEwkXn05y9jFyMUhJLCbUeLeqSMsEM4nRomFGxsRnDUTngI5HGAty8+p
        Q8R3Mkp0bVvEDOG0Mkn8bzgFVsQmoC1x+j8HyAoRAQWJnt8r2UBqmAVmMUoc7J7NCJIQFtCT
        OHfrEZjNIqAqsWg5hM0rYCXRP/sDG8QyfYn++4IQYUGJkzOfsIDYzALyEs1bZ4PtlRDYxS5x
        ZPVOFoh/XCSW7vvIDmELS7w6vgXKlpL4/G4v1M/lEiunrGCDaG5hlJh1fRYjRMJeovVUPzPI
        YmYBTYn1u/QhwrISU0+tY4JYzCfR+/sJE0ScV2LHPBhbWWLN+gVQ8yUlrn1vhLI9JC7e7GIG
        sYUEYiV+PD3PMoFRfhaSf2Yh+WcWwuYFjMyrGCVTC4pz01OTTQsM81LL4RGbnJ+7iRGcArVc
        djDemP9P7xAjEwfjIUYJDmYlEd5Hl7elCPGmJFZWpRblxxeV5qQWH2I0BYbxRGYp0eR8YBLO
        K4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qB6UaX3s7C52f5U5/8
        PnnpgyzHi3Vf8+aIzuquWXWXuePM5Vvpyl6fhPfJ3I5asev0p0551jf9J4/9s1vC66xlFbnL
        N+edoZqSnu8l/hbWDXJPJ6/VPlG+e9rEew9mfr7evZq/jaeove+Gf06Bg1PZwSV3F/56oHJS
        fmFrB8utzjeNP764mhUHlTF8SY1Tej4jrXt2Al/r2z4uleJvgoH2p90nZO3JfmPrM5FN8vvF
        Z5wKvT6s1q7yod9b1qmFOZxICNIpd+nf9IDp8QO9u9eer+/qZLnWoiOqd0li/qL19jL3PiwR
        /xvkZFy85aBH8C2+Q6WM7Fyftrq78gW95UyQm8PqpP6y6NiCguY/ptKtSizFGYmGWsxFxYkA
        QHg29AoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvO6FK9tTDG6/UbVYfbefzeLmgZ1M
        FntvaVtc3jWHzWL58X9MFtt+z2d2YPO4fLbU4+PTWywefVtWMXp83iQXwBLFZZOSmpNZllqk
        b5fAlbF30Rr2gk6Oijmd29kaGE+xdTFycEgImEgsP6fexcjJISSwnVGi62MliC0hICmx7O8R
        ZghbWGLlv+fsXYxcQDXNTBL/zoA4HBxsAtoSp/9zgNSICChI9PxeyQZSwywwj1Fi34z9YM3C
        AnoS5249YgSxWQRUJRYth7B5Bawk+md/gLpBX6L/viBEWFDi5MwnLCA2s4C8RPPW2cwTGPlm
        IUnNQpJawMi0ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4ALWCdjAuW/9X7xAjEwfjIUYJ
        DmYlEd5Hl7elCPGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBK
        NTBFuhvflzWLWN94X11mT/ffL6u66m9vYl79qvGFM/O+69ee2sW8kOmIFZat31bEG5sdIWtU
        3e1azJHaNmPRkjaO4hNHS76xirNGfG0957Km5Kjx55dO994f8T2+tCVSv0Zhqt+r3Swqf+3/
        W/21iPFQW636vrF6h7+Q9ewLT9W4X4m9/FixbtbhtY3T39vZC355Xzlr+UNe1+mnrjMpRe+K
        uJ/y9Ua4wvcp6nsu7lH1K/Re05v6yW8Xt/ZJ1cYEG5c2rfsrnvxbL5gpsEQwrSX90uq57kfF
        nFQ9/934bfTkCquE/VKxDVqeMb9ncd3cfjPhfe/hiyLLdza9D+C5c/lbZf6FCbvuay0+kNB6
        xyZfiaU4I9FQi7moOBEAKFkBLK8CAAA=
X-CMS-MailID: 20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8
References: <CGME20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce some code by making use of bio_integrity_bytes().

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/bio-integrity.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb491661..8f0af7ac8573 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -199,7 +199,6 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned long start, end;
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
-	unsigned int intervals;
 	blk_status_t status;
 
 	if (!bi)
@@ -224,10 +223,9 @@ bool bio_integrity_prep(struct bio *bio)
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
 	}
-	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
 
 	/* Allocate kernel buffer for protection data */
-	len = intervals * bi->tuple_size;
+	len = bio_integrity_bytes(bi, bio_sectors(bio));
 	buf = kmalloc(len, GFP_NOIO);
 	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
-- 
2.34.1

