Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132097D66AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjJYJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjJYJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:23:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A570C8F;
        Wed, 25 Oct 2023 02:23:26 -0700 (PDT)
X-UUID: 2365d7e2731811eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GD07mFMHD4ZCgjq6WI7FIX+ZSbE7ZY0N7D7XCgHgxDs=;
        b=DSL30w6qIjB8sRl+shY6Eu/derXnAgpR2r8Wg4fmAqtrl9Ke6lZvLHb5tSpSYioor4pOdka7aP+7X85+74MdoYIqBDHjkYHzi9TLgba2ur/xrp0HW5v2FIulUtPc03iKitVhmyrBOBNrAnSPlEiEeVlop1VSq4ahm+v3BziZkm0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6108b7c4-b02b-4440-82b1-487b849a3e5d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:9d454dd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2365d7e2731811eea33bb35ae8d461a2-20231025
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 776131182; Wed, 25 Oct 2023 17:23:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 17:23:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 17:23:19 +0800
From:   <ed.tsai@mediatek.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <peter.wang@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <naomi.chu@mediatek.com>,
        <will.shiu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <casper.li@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] block: Check the queue limit before bio submitting
Date:   Wed, 25 Oct 2023 17:22:52 +0800
Message-ID: <20231025092255.27930-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.727700-8.000000
X-TMASE-MatchedRID: BmApTv+lLq0waD7CCdj96ei9l247YAX3lFphfRKYquoUtdRZTmEaIS3u
        UJEx/mLPreNj5HHxl21nGN5KPPuDsG31PKYofPF/XTwa0AqaSsKLB4sTRpOnCdCb26mGD2jLFXo
        +i3C0P4mvLLwTZdNynSvcqxXFsTtBue4A1S8vO3qM29hkek7XdwRryDXHx6oX2m/9xxi5QYn0Vn
        grMLma4CACA5ub2VruHVVF1Gr4vCs9d1nHWxkekOKXavbHY/C1uCESrx7wlnI4FRAn4eAUA31Qr
        wyU0uRkPdC7NjHVzscy2ii2lrm+Dx8TzIzimOwPC24oEZ6SpSk6XEE7Yhw4FgRTi3vHGzbgVIN/
        lHwV0gMDutLgGfA+guP9LE9sG2stVbTvIYsYMpM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.727700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7092A3517B8EBB70E790EACEFA197BBBB6340BDF01AC26F8DD7E4A6F9D08CF272000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Tsai <ed.tsai@mediatek.com>

Referring to commit 07173c3ec276 ("block: enable multipage bvecs"),
each bio_vec now holds more than one page, potentially exceeding
1MB in size and causing alignment issues with the queue limit.

In a sequential read/write scenario, the file system maximizes the
bio's capacity before submitting. However, misalignment with the
queue limit can result in the bio being split into smaller I/O
operations.

For instance, assuming the maximum I/O size is set to 512KB and the
memory is highly fragmented, resulting in each bio containing only
one 2-pages bio_vec (i.e., bi_size = 1028KB). This would cause the
bio to be split into two 512KB portions and one 4KB portion. As a
result, the originally expected continuous large I/O operations are
interspersed with many small I/O operations.

To address this issue, this patch adds a check for the max_sectors
before submitting the bio. This allows the upper layers to proactively
detect and handle alignment issues.

I performed the Antutu V10 Storage Test on a UFS 4.0 device, which
resulted in a significant improvement in the Sequential test:

Sequential Read (average of 5 rounds):
Original: 3033.7 MB/sec
Patched: 3520.9 MB/sec

Sequential Write (average of 5 rounds):
Original: 2225.4 MB/sec
Patched: 2800.3 MB/sec

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 block/bio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..a4a1f775b9ea 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1227,6 +1227,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_extraction_t extraction_flags = 0;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)->limits;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
@@ -1275,6 +1276,11 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
+		if (bio->bi_iter.bi_size + len >
+		    lim->max_sectors << SECTOR_SHIFT) {
+			ret = left;
+			break;
+		}
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			ret = bio_iov_add_zone_append_page(bio, page, len,
 					offset);
-- 
2.18.0

