Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF77696DD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjGaM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGaM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:56:20 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DC9E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:56:19 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230731125618epoutp030c06d8eb9d689053496124fe27404dca~29RRwcfy00659606596epoutp039
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:56:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230731125618epoutp030c06d8eb9d689053496124fe27404dca~29RRwcfy00659606596epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690808178;
        bh=PoQdjC9lBed1xqyEfsVkXd2x90gYvZd/Stb7lCXTnc0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=LuUu7/5fRl/u/nmzXK28mdlMVJO716v2tHVJ/FeOjosWbXvgkrzD9pLB4q5RVg3ay
         YqYSO0bZ8TDHs7JOl9bnqBBXgG3s5znchJgh3LEhRYo4Oh7SkM8FnWkd7BVD9557F6
         lvfu8ioe7NFYAfH3vmus+Vx8e7vMJaL4EL5Mpfwk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230731125617epcas2p2bb52468597e84125e3aa7f80af87b0af~29RROibJM2783127831epcas2p2k;
        Mon, 31 Jul 2023 12:56:17 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RDyss17kgz4x9Pv; Mon, 31 Jul
        2023 12:56:17 +0000 (GMT)
X-AuditID: b6c32a4d-853ff70000047356-10-64c7af70f776
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.00.29526.07FA7C46; Mon, 31 Jul 2023 21:56:17 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 4/4] bio-integrity: create multi-page bvecs in
 bio_integrity_add_page()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230731125616epcms2p15f142bc599785edac8be3ab9eb63fecc@epcms2p1>
Date:   Mon, 31 Jul 2023 21:56:16 +0900
X-CMS-MailID: 20230731125616epcms2p15f142bc599785edac8be3ab9eb63fecc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmhW7h+uMpBm0drBar7/azWcy6/ZrF
        4uUhTYtJh64xWuy9pW1xedccNovlx/8xWax7/Z7FgcPj/L2NLB6Xz5Z6bFrVyebx8ektFo++
        LasYPT5vkvNoP9DNFMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
        aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
        XS8vtcTK0MDAyBSoMCE7Y07DcpaCHqGKNdtXMjYwPuTrYuTkkBAwkXiwpJu1i5GLQ0hgD6PE
        hgXnmbsYOTh4BQQl/u4QBjGFBWIktszQASkXElCSOLdmFiOILSxgINFyu40FxGYT0JPY8Xw3
        O8gYEYHPTBKXf3xghZjPKzGj/SkLhC0tsX35VrBmTgE/ianX3zJBxDUkfizrZYawRSVurn7L
        DmO/PzafEcIWkWi9dxaqRlDiwc/dUHFJiUOHvrKB3CkhkC+x4UAgRLhGou3Xe6hyfYlrHRvB
        TuAV8JX4ce0IWJxFQFXi8aR1UDUuErdPPQJbyywgL7H97RxwKDALaEqs36UPMV1Z4sgtFogK
        PomOw3/ZYR5s2PgbK3vHvCdMEK1qEouajCDCMhJfD89nn8CoNAsRyrOQrJ2FsHYBI/MqRqnU
        guLc9NRkowJD3bzUcnjkJufnbmIEp04t3x2Mr9f/1TvEyMTBeIhRgoNZSYT3VMChFCHelMTK
        qtSi/Pii0pzU4kOMpkBPT2SWEk3OBybvvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1Kz
        U1MLUotg+pg4OKUamGYUGbeXVCR8Yjnt/XaXbL+nU8TL8HVPcwV3ydguvuTioPppXd/G6pvX
        f3xYv8trneHtoMp1a8ovfTFrtVzCO7m+5dpp60VcNY+28zsx1cZt6G1ROzJnrecJn6p19y5U
        eNv88Szebhzrca75VubUAzHsOh+4v9+YOU10sdLXk/kn3hYUBqas/ujRPGWuaJjBE47u6vky
        Ri6JhTYFeT0FsbHXHz/775W1fUvsatFZy35t8o3vvxqvt+7d1hX1Lw4G5/gd/th37AW7LbfQ
        b1WRIxzzfxnM/dbfNi1W9/MW1Zv77ufdPHfI6OHG7UsK/y74uNP/tohp8jy5yOxC2VW/dmSq
        VcdsjHH/73WrqFRIMk2JpTgj0VCLuag4EQBrJolpJgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5
References: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
        <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
