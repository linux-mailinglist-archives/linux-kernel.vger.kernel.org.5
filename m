Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507337665F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjG1H62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjG1H56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:58 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A871BD9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:57:56 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230728075754epoutp025c8a8e6857aee59f5e7bb1682dc3c6aa~1_Q4nIRcY3242832428epoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:57:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230728075754epoutp025c8a8e6857aee59f5e7bb1682dc3c6aa~1_Q4nIRcY3242832428epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690531074;
        bh=IDkiw2vf88CcoMUHaM6eAT6Gr0C3s0HY76p/6GA6/wU=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=cA2PBxKQX8jix6HceWy7+QLtcYJuYG7KA31as9cTtiRay7XO7GyjfNhbrsbuAn6+v
         /fqxhE7wMBaPMUEHdtnPUC7KEmWQzLt/tgEjh6YidyClfNlhRb0nUoFRPlHXix0zTE
         suEKFRjcdrNX4IdJ5PMzSw4x4kILS89WYg5An1LA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230728075753epcas2p380d26b48e4c405d19a16f046682176d9~1_Q4J1Q8m1230112301epcas2p3w;
        Fri, 28 Jul 2023 07:57:53 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RC0Nx2Ctzz4x9Q0; Fri, 28 Jul
        2023 07:57:53 +0000 (GMT)
X-AuditID: b6c32a43-557fb7000001d7ef-99-64c37501a6d9
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.A2.55279.10573C46; Fri, 28 Jul 2023 16:57:53 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/2] bio-integrity: create multi-page bvecs in
 bio_integrity_add_page()
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
Message-ID: <20230728075753epcms2p7354d445f1888ab3942a16e26a13d5bbd@epcms2p7>
Date:   Fri, 28 Jul 2023 16:57:53 +0900
X-CMS-MailID: 20230728075753epcms2p7354d445f1888ab3942a16e26a13d5bbd
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmmS5j6eEUg2eL+C1W3+1ns5h1+zWL
        xctDmhYrVx9lsph06Bqjxd5b2haXd81hs1h+/B+TxbrX71kcOD3O39vI4nH5bKnHplWdbB67
        bzaweXx8eovFo2/LKkaPz5vkPNoPdDMFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
        KTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44NPEZY8EbyYrOFc4NjJtFuhg5OSQETCRO77jP
        3sXIxSEksINRYsvfw0xdjBwcvAKCEn93CIPUCAtESjR0n2ECsYUElCTOrZnFCBE3kGi53cYC
        YrMJ6EnseL4bbI6IwARmic2bbjNDLOCVmNH+lAXClpbYvnwrWDOngJ/E+rUvWSHiGhI/lvVC
        1YtK3Fz9lh3Gfn9sPiOELSLReu8sVI2gxIOfu6HikhKHDn1lA7lZQiBfYsOBQIhwjUTbr/dQ
        5foS1zo2gp3AK+ArceUGxP0sAqoS/VOWQ9W4SHSd/w12DrOAvMT2t3OYQUYyC2hKrN+lDzFd
        WeLILRaICj6JjsN/2WEebNj4Gyt7x7wnTBCtahKLmowgwjISXw/PZ5/AqDQLEcyzkKydhbB2
        ASPzKkax1ILi3PTUZKMCQ3jEJufnbmIEp1Et5x2MV+b/0zvEyMTBeIhRgoNZSYT3VMChFCHe
        lMTKqtSi/Pii0pzU4kOMpkAPT2SWEk3OBybyvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNIT
        S1KzU1MLUotg+pg4OKUamPL/PJpvoPUrb+p677UfraR1lhTIzN52T85EjiU0pH9mfTX7hdnf
        FucJfDniVyioeudXycUGrzs9WWXPbr2onnpRN9xM67L6ZNmUa9bMciFHvrp+/ZmacdD9sn7o
        7eM5uhMe9Ji+k676tfLqeibf/jKnM+nWf7/x2T2/cMbp2dQ4TqP7j+fMe+5/5Kra78nTV9t6
        bD7P66jGyBn4zUBh7jFbxakTN9yKzvz152tgwINLmivcVFmPfP2o4B4d/EXRJNvz3d6uC0u/
        fDj24fti7fX9b7YXFpZzpjrcVJB0CnTXtj3+38pjyxSh3MXxTp9MCvjXJOUUnNIUi7v1Zl1g
        zIqog4o7fMxuBtlGiPJvs1RiKc5INNRiLipOBAB+wR8KLAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63
References: <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
        <CGME20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow bio_integrity_add_page to create multi-page bvecs, just like
the bio payloads. This simplifies adding larger payloads, and fixes
support for non-tiny workloads with nvme, which stopped using
scatterlist for metadata a while ago

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 50 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 045553a164e0..ae054c6a06cb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -123,21 +123,38 @@ void bio_integrity_free(struct bio *bio)
 int bio_integrity_add_page(struct bio *bio, struct page *page,
 			   unsigned int len, unsigned int offset)
 {
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
-		printk(KERN_ERR "%s: bip_vec full\n", __func__);
+	if (((bip->bip_iter.bi_size + len) >> SECTOR_SHIFT) >
+	    queue_max_hw_sectors(q))
 		return 0;
-	}
 
-	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
-			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
-		return 0;
+	if (bip->bip_vcnt > 0) {
+		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
+		bool same_page = false;
+
+		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
+					   &same_page)) {
+			bip->bip_iter.bi_size += len;
+			return len;
+		}
+
+		if (bip->bip_vcnt >=
+		    min(bip->bip_max_vcnt, queue_max_integrity_segments(q)))
+			return 0;
+
+		/*
+		 * If the queue doesn't support SG gaps and adding this segment
+		 * would create a gap, disallow it.
+		 */
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
+			return 0;
+	}
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
-
+	bip->bip_iter.bi_size += len;
 	return len;
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
@@ -244,7 +261,6 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
-	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
@@ -252,27 +268,18 @@ bool bio_integrity_prep(struct bio *bio)
 
 	/* Map it */
 	offset = offset_in_page(buf);
-	for (i = 0 ; i < nr_pages ; i++) {
-		int ret;
+	for (i = 0; i < nr_pages && len > 0; i++) {
 		bytes = PAGE_SIZE - offset;
 
-		if (len <= 0)
-			break;
-
 		if (bytes > len)
 			bytes = len;
 
-		ret = bio_integrity_add_page(bio, virt_to_page(buf),
-					     bytes, offset);
-
-		if (ret == 0) {
+		if (bio_integrity_add_page(bio, virt_to_page(buf),
+					   bytes, offset) < bytes) {
 			printk(KERN_ERR "could not attach integrity payload\n");
 			goto err_end_io;
 		}
 
-		if (ret < bytes)
-			break;
-
 		buf += bytes;
 		len -= bytes;
 		offset = 0;
@@ -291,7 +298,6 @@ bool bio_integrity_prep(struct bio *bio)
 	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
 	return false;
-
 }
 EXPORT_SYMBOL(bio_integrity_prep);
 
-- 
2.34.1
