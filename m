Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315EE76DE8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjHCCwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjHCCwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:52:07 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36A1A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:52:05 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230803025203epoutp036454ad267763f0338c540111bc32182c~3v9kEsLq43239032390epoutp035
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:52:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230803025203epoutp036454ad267763f0338c540111bc32182c~3v9kEsLq43239032390epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691031123;
        bh=PoQdjC9lBed1xqyEfsVkXd2x90gYvZd/Stb7lCXTnc0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=TDbnLOJFuQJogZjHquL6qwrCnLtTWOshSi29pJ52cz/Rw2yzAEw6/Wde1phkzo81P
         8w+NenQZdPi3IVTcRsFbqfOFPQcMJmTv+hB3FZwKjmE0OwT4gwz+N5WwV5ekXh3fRr
         7MYqNVGj2R33kdaBGlcql0lIiboZkfsphhFH5zDM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230803025203epcas2p22fd826ad8ebfbc1bc720885cc81be973~3v9jtijML0956209562epcas2p2A;
        Thu,  3 Aug 2023 02:52:03 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RGYKG6b9sz4x9Py; Thu,  3 Aug
        2023 02:52:02 +0000 (GMT)
X-AuditID: b6c32a43-84dfa7000000c342-bd-64cb1652b575
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.44.49986.2561BC46; Thu,  3 Aug 2023 11:52:02 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 4/4] bio-integrity: create multi-page bvecs in
 bio_integrity_add_page()
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
Message-ID: <20230803025202epcms2p82f57cbfe32195da38c776377b55aed59@epcms2p8>
Date:   Thu, 03 Aug 2023 11:52:02 +0900
X-CMS-MailID: 20230803025202epcms2p82f57cbfe32195da38c776377b55aed59
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmqW6Q2OkUg7dPDSxW3+1ns5h1+zWL
        xctDmhanJyxisph06Bqjxd5b2haXd81hs1h+/B+TxbrX71kcOD3O39vI4rF5hZbH5bOlHptW
        dbJ5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpjTsJyloEeoYs32lYwNjA/5uhg5OSQETCTu3G9m
        7GLk4hAS2MEoseLTMiCHg4NXQFDi7w5hkBphgRiJSfuXsILYQgJKEufWzGKEiBtItNxuYwGx
        2QT0JHY8380OMkdEYA6zxKU1y1ghFvBKzGh/ygJhS0tsX74VrJlTwE/i0rTZUHENiR/Lepkh
        bFGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLQoa9sIDdLCORLbDgQCBGukWj79R6q
        XF/iWsdGsFW8Ar4Sf5efArNZBFQlTm75BDXGReJVXwcbiM0sIC+x/e0cZpCRzAKaEut36UNM
        V5Y4cosFooJPouPwX3aYBxs2/sbK3jHvCRNEq5rEoiYjiLCMxNfD89knMCrNQgTzLCRrZyGs
        XcDIvIpRLLWgODc9NdmowBAes8n5uZsYwWlUy3kH45X5//QOMTJxMB5ilOBgVhLhlf59PEWI
        NyWxsiq1KD++qDQntfgQoynQwxOZpUST84GJPK8k3tDE0sDEzMzQ3MjUwFxJnPde69wUIYH0
        xJLU7NTUgtQimD4mDk6pBiZv1tMrtFavaVJ3X6vF4+qnfH6JwcZvSdO2f4/79HzB9npGn6x/
        m2zcVGoOtq+745XxcqfAhgj2BQ8fFCQnBMad0p46fep77umxt2WOn+h2nhjyZM6v1TXzkr1T
        13xnKz0rbrYx4qmhTYVDJvuLpKYyVXmxiqOTNjKdtdd+yH4o1vfRvpwzfyKTr786lsl04puA
        4CmFeVOFdza3rj67U1orWCvh4Z1OkSPsv857VSnI2va1q6qb/yw6vbz6S8Hr6xy/121xEpSU
        m5DN94XV6JtRP++nlkPVa9t/5sSzL/p2auvP6XXr/GwSr97f9SSt6LzcBp5jiUZRLpdvPnCY
        +e5y/OZnq5LPrJ21vLDGavkUJZbijERDLeai4kQA7+eTQCwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
References: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, the bvec data structure consists of one for physically
continuous pages. But, in the bvec configuration for bip, physically
continuous integrity pages are composed of each bvec.

Allow bio_integrity_add_page() to create multi-page bvecs, just like
the bio payloads. This simplifies adding larger payloads, and fixes
support for non-tiny workloads with nvme, which stopped using
scatterlist for metadata a while ago.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index c6b3bc86e1f9..ec8ac8cf6e1b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -123,17 +123,34 @@ void bio_integrity_free(struct bio *bio)
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
-- 
2.34.1
