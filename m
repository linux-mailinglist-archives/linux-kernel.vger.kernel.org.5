Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1076091F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGYFSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGYFSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:18:48 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01203173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:18:44 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230725051840epoutp01d8aa55205bcdd7c3d3b7db62f381f2dd~1BKAgFqaD0158701587epoutp01-
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:18:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230725051840epoutp01d8aa55205bcdd7c3d3b7db62f381f2dd~1BKAgFqaD0158701587epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690262320;
        bh=+rtM1aYdkwBMTDQFePMCBtN59+CcRMnrphsS+pdR4Kc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=FblWcX20dUOQtMjzgQUzH7AFasKoPk7Wk6UL7fjReIApxQ5a0jXWL7Kk6/jMnqdwA
         SPBp2mH+n5TQGedit8B/CeQ3r+MVyVhXP2tBrkZbtRNG5ynKh5ZAsX40f2fx/LP9kf
         X7uYTuPILNuj1t+HzfqclkIi4mLYX6T3W+g99apI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230725051840epcas2p310fa83ea1083369015ccb5e13d45a280~1BKAO7b0d0386503865epcas2p31;
        Tue, 25 Jul 2023 05:18:40 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R950c1jfwz4x9Py; Tue, 25 Jul
        2023 05:18:40 +0000 (GMT)
X-AuditID: b6c32a46-6fdfa70000009cc5-66-64bf5b30ec94
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.26.40133.03B5FB46; Tue, 25 Jul 2023 14:18:40 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] block: cleanup bio_integrity_prep
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
Date:   Tue, 25 Jul 2023 14:18:39 +0900
X-CMS-MailID: 20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTVNcgen+KwZFDnBar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ1x
        cOdS1oJe3opDH7exNzAe5upi5OSQEDCRuHjlKWMXIxeHkMAORomNR6+xdzFycPAKCEr83SEM
        UiMsYCTRv3cRC4gtJKAkcW7NLEaIuIFEy+02sDibgJ7Ejue72UHmiAgsZ5Q4vP4mWBGzQJTE
        2kNH2SGW8UrMaH/KAmFLS2xfvpURwtaQ+LGslxnCFpW4ufotO4z9/th8qBoRidZ7Z6FqBCUe
        /NwNFZeUOHToKxvIzRIC+RIbDgRChGsk2n69hyrXl7jWsRFsLa+Ar8S5/QfB4iwCqhJTdn+F
        GuMi8eXrYlaIk+Ultr+dwwwykllAU2L9Ln2I6coSR26xQFTwSXQc/gv3VMPG31jZO+Y9YYJo
        VZNY1GQEEZaR+Hp4PvsERqVZiGCehWTtLIS1CxiZVzGKpRYU56anFhsVGMFjNjk/dxMjOC1q
        ue1gnPL2g94hRiYOxkOMEhzMSiK8hjH7UoR4UxIrq1KL8uOLSnNSiw8xmgI9PJFZSjQ5H5iY
        80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYJpb9urN9Pp0Wfbt
        5pGvJ++fzHPjV+vMy/Wc+7pudD9tfLie4XpYfnGU1IQTs75/W/AtWmlNnGDfyh3fO+K/TU1m
        6X0V13LfZG+P8JTyr6vMrNbs9z20e95mfgaRkzdfzmNe+nmvQfZ6xaZce+3qgne5hS7y7n+n
        TPquUP0oN413+SOuKU9nGq5becq4O8Yr8l1PTBxr4YIAj97H1x5qfatquvMnbYKgf9ct0ewd
        HJK7NKb6Vf3LTjZ+8P3TLweLAwrLz8X16M5cqxnF4TnBWi5Yr/BI4lbG0Ek8NedOrGFSmLlr
        Uf1pqUSW+5Jdt6cVGMf3tviz3H992rrznlC1UO1i7Vu+Wgu9KuQm3eqb+VSJpTgj0VCLuag4
        EQAbn+gIFAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa
References: <CGME20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
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

If a problem occurs in the process of creating an integrity payload, the
status of bio is always BLK_STS_RESOURCE.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8f0af7ac8573..045553a164e0 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -199,7 +199,6 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned long start, end;
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
-	blk_status_t status;
 
 	if (!bi)
 		return true;
@@ -227,7 +226,6 @@ bool bio_integrity_prep(struct bio *bio)
 	/* Allocate kernel buffer for protection data */
 	len = bio_integrity_bytes(bi, bio_sectors(bio));
 	buf = kmalloc(len, GFP_NOIO);
-	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
@@ -242,7 +240,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (IS_ERR(bip)) {
 		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
-		status = BLK_STS_RESOURCE;
 		goto err_end_io;
 	}
 
@@ -270,7 +267,6 @@ bool bio_integrity_prep(struct bio *bio)
 
 		if (ret == 0) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
 
@@ -292,7 +288,7 @@ bool bio_integrity_prep(struct bio *bio)
 	return true;
 
 err_end_io:
-	bio->bi_status = status;
+	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
 	return false;
 
-- 
2.34.1
