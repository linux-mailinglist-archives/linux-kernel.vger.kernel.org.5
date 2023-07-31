Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249A37696C7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjGaMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGaMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:50:50 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D2E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:50:49 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230731125048epoutp04ec80a68c96dc8d93c1e4dae0864a0e1f~29MeQijLR0709407094epoutp04Z
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:50:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230731125048epoutp04ec80a68c96dc8d93c1e4dae0864a0e1f~29MeQijLR0709407094epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690807848;
        bh=CwBsuvROgaXCJ8AMDL4SdXVgyJ0v6aiqhJAaPpU3dPk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=DE9H0E5JafS26+L9dYeozhjXTmc+zDkfi6KxCGUjyUNHwdEMPImXqs3XCyjuJJZIR
         BBbxpS2/ZPtp/vmSR1egMZadD+aFeZuT4iH4erqQPeyR3MxSBO/cI9a1WDdHpqGkjU
         tbAF9izOSRHDoMY2VAIGUG/b9qt9ku7ypmx7WTcs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230731125047epcas2p4e284dd7dd3652377a31d4e502b253998~29MdXVHY03085630856epcas2p4U;
        Mon, 31 Jul 2023 12:50:47 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RDylV4LjCz4x9Pq; Mon, 31 Jul
        2023 12:50:46 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-1e-64c7ae26d430
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.11.55279.62EA7C46; Mon, 31 Jul 2023 21:50:46 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 1/4] block: make bvec_try_merge_hw_page() non-static
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
Message-ID: <20230731125045epcms2p11a5566bc86fa448890c0af8fa14db307@epcms2p1>
Date:   Mon, 31 Jul 2023 21:50:45 +0900
X-CMS-MailID: 20230731125045epcms2p11a5566bc86fa448890c0af8fa14db307
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTXFdt3fEUg+e9ihar7/azWcy6/ZrF
        4uUhTYtJh64xWuy9pW1xedccNovlx/8xWax7/Z7FgcPj/L2NLB6Xz5Z6bFrVyebx8ektFo++
        LasYPT5vkvNoP9DNFMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
        aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
        XS8vtcTK0MDAyBSoMCE7Y9MO74Ienortb86yNzB2c3UxcnJICJhIzJjxjrGLkYtDSGAHo8TE
        H/1sXYwcHLwCghJ/dwiD1AgLuEtMWPeRBcQWElCSOLdmFiNE3ECi5XYbWJxNQE9ix/Pd7CBz
        RAQ+M0lc/vGBFWIBr8SM9qcsELa0xPblW8GaOQX8JKZef8sEEdeQ+LGslxnCFpW4ufotO4z9
        /th8RghbRKL13lmoGkGJBz93Q8UlJQ4d+gp2s4RAvsSGA4EQ4RqJtl/vocr1Ja51bAQ7gVfA
        F6jkFxNIOYuAqsSMyTkQJS4SH3efAbuYWUBeYvvbOcwgJcwCmhLrd+lDDFeWOHKLBaKCT6Lj
        8F92mP8aNv7Gyt4x7wkTRKuaxKImI4iwjMTXw/PZJzAqzUKE8iwka2chrF3AyLyKUSy1oDg3
        PTXZqMAQHq/J+bmbGMEJU8t5B+OV+f/0DjEycTAeYpTgYFYS4T0VcChFiDclsbIqtSg/vqg0
        J7X4EKMp0L8TmaVEk/OBKTuvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+
        Jg5OqQYmS3H9qCJvO9NJuy8KheperZfr731SbPJtBnNTmt+fs5frpaZPubC162G3T1v0TSnG
        vKurrLpKnjrw7K3jytLbMmnfPLWeSUenlWhMXixZOp3J4H7rE+b/gVcrMg2nNcwU/Wd9uFM8
        88ZPkX1nTObsjJRinJ4x+5KNFOflWqHn0t9fzNzUmFq2/Zj1fI7oxZ+/hBfkVqZNczeMnCKT
        PfWt/IrZy5KkpY/4JbdaPVNtrnIysGzuXnnaQneT7o1Tm1/K5pU55q6u23vKd8aHFn722pT4
        2RtfdmTcObOOX0hU8+vMDeofE4WKTk7q9qq5VPnx3HQ9Pe/67Wran34tetTbWZfa+GHThY0q
        QiF8vtVKLMUZiYZazEXFiQBVmLl+IQQAAA==
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
