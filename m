Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955AB7E8180
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjKJS3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346511AbjKJS0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:55 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39426A65;
        Thu,  9 Nov 2023 22:20:57 -0800 (PST)
X-UUID: cc3217387f8811ee8051498923ad61e6-20231110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7FpHD2kCR7YbMx+aNsQ1mmOFFVb+8A9sWA6xzZIMrmg=;
        b=Y93eMJbebs/vWyTU8xoREfqtqbBXjnBdi03BE/RjNPHFakvv0Egb7klCGJEzKCksoGvSrhy9rTDBqLX6cWCIAcgPpv1tnYDJwCDuj5prPd7kz6nYTeFUocnh5aLe4C6I8sP/jSvuIYRvi29A+QvH+ENXl9mPIbGXwMXfcwDmD0c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:223e8155-0dac-4a27-bc5e-bc7010b555f6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:40e65efc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cc3217387f8811ee8051498923ad61e6-20231110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1782307766; Fri, 10 Nov 2023 13:20:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Nov 2023 13:19:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Nov 2023 13:19:59 +0800
From:   <ed.tsai@mediatek.com>
To:     <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <casper.li@mediatek.com>, <will.shiu@mediatek.com>,
        <light.hsieh@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] block: limit the extract size to align queue limit
Date:   Fri, 10 Nov 2023 13:19:49 +0800
Message-ID: <20231110051950.21972-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.071000-8.000000
X-TMASE-MatchedRID: GRLfTco7/5d8XbDftE7Is4DCiwMF64/BF7ufiw/c2JC+1E7kR3IIODAp
        i0hTr2bdzAa7mENQbcdODBHPjwMoZMXordq7zYYlG5mg0pzqmX5dymZBcuGGRE1KG1YrOQW/SHg
        UVMoIv2E+Ajr5JCJKWHYzUtuMFaSG5G8kIlfiBw6S2fL5IypDsQrefVId6fzV+45sY5SzyDLBXs
        R9mHtjgVlIo52/rCDQ232LjmYwhKqkwTZnxyBJ8wPZZctd3P4B7f6JAS2hKPi1YUw9VHYKvEAVp
        ZTwLLImA02Wf/A3XRP4/eeNk8pxCQJ0w/AKVkU5ngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIx1FP
        lNAAmcCaaytbuWqW4EJ/sa/XOh/KqZzj70/su53LD62wY7gH956oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.071000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 16776E1C9EE34DD3DF3EA7DE413DEC2CBF793C528D41CD11BDB7143234A2273E2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Tsai <ed.tsai@mediatek.com>

When an application performs a large IO, it fills and submits multiple
full bios to the block layer. Referring to commit 07173c3ec276
("block: enable multipage bvecs"), the full bio size is no longer fixed
at 1MB but can vary based on the physical memory layout.

The size of the full bio no longer aligns with the maximum IO size of
the queue. Therefore, in a 64MB read, you may see many unaligned bios
being submitted.

Executing the command to perform a 64MB read:

	dd if=/data/test_file of=/dev/null bs=64m count=1 iflag=direct

It demonstrates the submission of numerous unaligned bios:

	block_bio_queue: 254,52 R 2933336 + 2136
	block_bio_queue: 254,52 R 2935472 + 2152
	block_bio_queue: 254,52 R 2937624 + 2128
	block_bio_queue: 254,52 R 2939752 + 2160

This patch limits the number of extract pages to ensure that we submit
the bio once we fill enough pages, preventing the block layer from
spliting small I/Os in between.

I performed the Antutu V10 Storage Test on a UFS 4.0 device, which
resulted in a significant improvement in the Sequential test:

Sequential Read (average of 5 rounds):
Original: 3033.7 MB/sec
Patched: 3520.9 MB/sec

Sequential Write (average of 5 rounds):
Original: 2225.4 MB/sec
Patched: 2800.3 MB/sec

Link: https://lore.kernel.org/linux-arm-kernel/20231025092255.27930-1-ed.tsai@mediatek.com/
Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>

---
 block/bio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..8d3a112e68da 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1227,8 +1227,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_extraction_t extraction_flags = 0;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	struct block_device *bdev = bio->bi_bdev;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
+	ssize_t max_extract = UINT_MAX - bio->bi_iter.bi_size;
 	ssize_t size, left;
 	unsigned len, i = 0;
 	size_t offset;
@@ -1242,7 +1244,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
+	if (bdev && blk_queue_pci_p2pdma(bdev->bd_disk->queue))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 
 	/*
@@ -1252,16 +1254,21 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_extract_pages(iter, &pages,
-				      UINT_MAX - bio->bi_iter.bi_size,
+	if (bdev && bio_op(bio) != REQ_OP_ZONE_APPEND) {
+		unsigned int max = queue_max_bytes(bdev_get_queue(bdev));
+
+		max_extract = bio->bi_iter.bi_size ?
+			max - bio->bi_iter.bi_size & (max - 1) : max;
+	}
+	size = iov_iter_extract_pages(iter, &pages, max_extract,
 				      nr_pages, extraction_flags, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
-	if (bio->bi_bdev) {
-		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+	if (bdev) {
+		size_t trim = size & (bdev_logical_block_size(bdev) - 1);
 		iov_iter_revert(iter, trim);
 		size -= trim;
 	}
-- 
2.18.0

