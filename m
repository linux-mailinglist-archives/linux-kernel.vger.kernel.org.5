Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A2772921
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjHGP1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHGP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:27:12 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DED83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:27:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230807152705euoutp02627ca0a7cd99d022baef4f86a00e2be9~5I17kWr0U2981829818euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:27:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230807152705euoutp02627ca0a7cd99d022baef4f86a00e2be9~5I17kWr0U2981829818euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691422025;
        bh=iklEzqWKqrQegkJPehfsGPKu4Pefo/8e0IoAZmUUDW0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OWsfl2Pj6A8tYOuPRjQ+KUwt6uALILfTYNxjUU5kobvaL+WgAVBmKpmfXa9IGotBm
         iBpi7oCLS0n9Nsz9ng3Xnw6Pas09X+Bzo8k35mintxUhGMNI+F/tY6hqdRnQGgRC4S
         uGCjS3csMFhT9Cq91E4a3qa+ATsQwIo/edUuODso=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230807152705eucas1p2a346041402ee3b5ec69c1cec9beb30ba~5I17Uii1p1871418714eucas1p2I;
        Mon,  7 Aug 2023 15:27:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 83.A3.37758.94D01D46; Mon,  7
        Aug 2023 16:27:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e~5I17B7BLU0529705297eucas1p18;
        Mon,  7 Aug 2023 15:27:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230807152704eusmtrp2104109381cbc9401b455281f01abe001~5I17BYZmd0297802978eusmtrp29;
        Mon,  7 Aug 2023 15:27:04 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-cb-64d10d497adf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.A2.14344.84D01D46; Mon,  7
        Aug 2023 16:27:04 +0100 (BST)
Received: from AMDC4653.eu.corp.samsungelectronics.net (unknown
        [106.120.51.32]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230807152704eusmtip25c0ce70cae15fa0e1f2078cb6b3c7482~5I16jbo5f1091410914eusmtip20;
        Mon,  7 Aug 2023 15:27:04 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Date:   Mon,  7 Aug 2023 17:26:57 +0200
Message-Id: <20230807152657.1692414-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjld+92d1teuc5snyuzRmkt0iKLRWkPKq5FIRJBRuRwNzN1xuaj
        B5VR1lwhrvLRtpZW5BzZSu0xI2TLWjbUVBolqUWllfRSI0t7uF0r/zvnfOf8vvPBj8RFRr6E
        TFFlsmqVIk1KCHk3H3xvmRdLtSrnN/VNlJtsVwh59SsPX95eZyLkzqK7SF7V0CmQN9huYfLh
        IROxQsC0e1pxpsYiY6qt+QTzsHSYx9RcOsQU1FoRM1A9LU6QIFymZNNSsll1ZEyicGfetxr+
        7rf+e4aaEnOR20+HJpBAR4F+0CrQISEpoi0ImuvNBEcGEVjtRXyODCB40vdO8DdiatONRSoQ
        fCp0YRzJw6DCrOV5XQS9AHQfdIQXT6LXwtPDWp8Jpz0IbtWdwr2DQDoBvn58xvdiHj0LnBeP
        +sIUvRzyB+w8bl0o1DuacE4PgMazr306PqofuWHEvY8CXUmC7foQnwusBnepY6xrILx31Y7h
        qfDbfh7jAscRlA13j5FCBLm9HYhzLYXnzT9Ge5OjK+aArS6Sk1dC040unwy0Pzz9EMCV8IdT
        N0twTqZAe0zEucPA4Lr6b63jcRvOYQZaDV2+/iJ6G9iN3Vghmm4Yd5ph3GmG/x3KEG5FYjZL
        k57Mahaq2JwIjSJdk6VKjkjKSK9Go//H/cv19TayvP8S4UQYiZwISFw6iTK/blGKKKVi7z5W
        nbFdnZXGapxoCsmTiqm50Y1JIjpZkcmmsuxuVv13ipETJLlYMZMnybqcP3S/Ib47bM2cZXce
        3Q3IXtOx6GKl/CDlt5+eqPb7WZFp+/1opPhk0EbPig5zT0QiobgcF7IolZSJ+8/1jbyLnVFV
        XmLZVMiGyVzKhMD6Y0LLmw3B4SUyLO4NJVH6tzXGRhe5pi8eseVXhau0M5PWUeoCovaQ1ul2
        E3ar2FkRNFzs0ce7zWc6c3r26Xfd7ujty1lP/thMh56QRi/Upn0Jca6M6uRt7AFzwzVxRqg+
        6GWLMaC3M/fA5zuRgwUJ/cmOYDa7f7J59o4oleGeKeZn11VHWXj83BMj5WjLi8OnV1UGztMv
        kZSHM/oHUVUXPgYFG5OmhGRv3SzlaXYqFshwtUbxB+1zgRSuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xe7oevBdTDDY9NrKYs34Nm8Wmx9dY
        LS7vmsNmcWjqXkaLtUfuslscWb+dyeL3jzlsDuwel69dZPbYvELLY9OqTjaPEzN+s3hsXlLv
        0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZ
        ZalF+nYJehmt3zezFrzgq/hxNqGB8TRPFyMnh4SAicScS13sXYxcHEICSxklFn/+zQiRkJE4
        Oa2BFcIWlvhzrYsNoqiZSaJty0ewIjYBQ4mutyAJTg4RAQ+Jtn/3mEGKmAVuMUpM2P6OHSQh
        LBAh0TTtFNgkFgFViUOLW1hAbF4Be4nOzztZIDbIS+w/eJYZIi4ocXLmE7A4M1C8eets5gmM
        fLOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kRGPTbjv3csoNx5auPeocYmTgY
        DzFKcDArifDOe3I+RYg3JbGyKrUoP76oNCe1+BCjKdB9E5mlRJPzgXGXVxJvaGZgamhiZmlg
        amlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtP/l+2U12ZeFL+r/uPluj9eRfY9zDuxw
        C3s15Y+v1vKTt2JPFlpxTVEytgnvqD/D8u2UAYup7pOH3hGCTvsOGH6Qsnz1NXJGkuKEahmG
        X9zdue9M+XeuKAo60inatzBOpv/J/J+z1r0R8pXMVku7vra4PXXm5E+2hQUWuZoaTk5Om8vb
        vKqfSDy5LJ0UO2ueX/aGSK4jjv0LbyiJbd3//cWT8PVhs7TFerIM81q8zX8s3r3saFqaScW6
        xepb/+a1L34UJMSzg/dcZlpEz/Lv8pN+yb7wP3rzqZHWo6Vv32/tL5xy/MNP3eXr32inySV9
        my/t8kW3hvXlksWiF5elHnosLtRXLRSV90do+tuT65RYijMSDbWYi4oTAa23kCMDAwAA
X-CMS-MailID: 20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e
References: <CGME20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that the folio_size() of the next folio returns zero, so
avoid looping with 'left' equals to zero in D-cache cleaning loop.

This fixes the following endless loop observed by RCU stall:
--->8---
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:     0-....: (27320 ticks this GP) idle=e414/1/0x40000002 softirq=36/36 fqs=13044
rcu:     (t=27385 jiffies g=-1067 q=34 ncpus=8)
CPU: 0 PID: 93 Comm: kworker/0:1H Not tainted 6.5.0-rc5-next-20230807 #6981
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: mmc_complete mmc_blk_mq_complete_work
PC is at _set_bit+0x28/0x44
LR is at __dma_page_dev_to_cpu+0xdc/0x170
..
 _set_bit from __dma_page_dev_to_cpu+0xdc/0x170
 __dma_page_dev_to_cpu from dma_direct_unmap_sg+0x100/0x130
 dma_direct_unmap_sg from dw_mci_post_req+0x68/0x6c
 dw_mci_post_req from mmc_blk_mq_post_req+0x34/0x100
 mmc_blk_mq_post_req from mmc_blk_mq_complete_work+0x50/0x60
 mmc_blk_mq_complete_work from process_one_work+0x20c/0x4d8
 process_one_work from worker_thread+0x58/0x54c
 worker_thread from kthread+0xe0/0xfc
 kthread from ret_from_fork+0x14/0x2c
--->8---

Fixes: cc24e9c0895c ("arm: implement the new page table range API")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 70cb7e63a9a5..02250106e5ed 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -718,7 +718,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 			folio = folio_next(folio);
 		}
 
-		while (left >= (ssize_t)folio_size(folio)) {
+		while (left && left >= (ssize_t)folio_size(folio)) {
 			set_bit(PG_dcache_clean, &folio->flags);
 			left -= folio_size(folio);
 			folio = folio_next(folio);
-- 
2.34.1

