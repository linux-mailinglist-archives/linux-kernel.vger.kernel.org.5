Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6E76DE88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHCCuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjHCCuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:50:04 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E0E53
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:50:00 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230803024958epoutp01e4c80c46a922b2f3e9a76f1dae53e0a9~3v7vQiZZM2949529495epoutp01T
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:49:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230803024958epoutp01e4c80c46a922b2f3e9a76f1dae53e0a9~3v7vQiZZM2949529495epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691030998;
        bh=lONrHNsEkCBmY0gtyPzxjck/4+ABThiyZREGBOSdSJI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=V+eK/hB4X46Gop1awZNZec0RgAqITRz+SZs6DQildHdoA0sSwHyvmhOuAaMeEGYk0
         YIe46OyoK7RdHYEcL9IVFXrjAYTPgtaQwFueDy8agdChIjdY4sz+zUcoO3OIchIX1W
         h9m3k/g+bzumNw77oNOKLgRFa3FbDatOV5vFoIAc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230803024957epcas2p31983d25d59b29e60b32e8101169c09af~3v7usJOwG2133421334epcas2p3I;
        Thu,  3 Aug 2023 02:49:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RGYGs2487z4x9Pt; Thu,  3 Aug
        2023 02:49:57 +0000 (GMT)
X-AuditID: b6c32a45-83dfd7000000c2f9-9c-64cb15d5f7f2
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.AA.49913.5D51BC46; Thu,  3 Aug 2023 11:49:57 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 2/4] bio-integrity: update the payload size in
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
In-Reply-To: <20230803024827epcms2p838d9e9131492c86a159fff25d195658f@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230803024956epcms2p38186a17392706650c582d38ef3dbcd32@epcms2p3>
Date:   Thu, 03 Aug 2023 11:49:56 +0900
X-CMS-MailID: 20230803024956epcms2p38186a17392706650c582d38ef3dbcd32
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmue5V0dMpBt/f8FisvtvPZjHr9msW
        i5eHNC1OT1jEZDHp0DVGi723tC0u75rDZrH8+D8mi3Wv37M4cHqcv7eRxWPzCi2Py2dLPTat
        6mTz+Pj0FotH35ZVjB6fN8l5tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
        NbS0MFdSyEvMTbVVcvEJ0HXLzAG6TUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJT
        YF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbFy+1H2gosKFTuW7WRrYNwg3cXIySEhYCIxc+Zv
        1i5GLg4hgR2MEq3L9rB1MXJw8AoISvzdIQxiCgvESHzdygJSLiSgJHFuzSxGEFtYwECi5XYb
        WJxNQE9ix/Pd7CBjRATmMEtcWrOMFWI+r8SM9qcsELa0xPblW8GaOQX8JKZMbGSEiGtI/FjW
        ywxhi0rcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktKHDr0FexkCYF8iQ0HAiHCNRJtv95D
        letLXOvYCHYCr4CvxK+vb8FaWQRUJZou74U6zUViatt8sJOZBeQltr+dwwwykllAU2L9Ln2I
        6coSR26xQFTwSXQc/ssO82DDxt9Y2TvmPWGCaFWTWNRkBBGWkfh6eD77BEalWYhQnoVk7SyE
        tQsYmVcxiqUWFOempxYbFRjCIzY5P3cTIziJarnuYJz89oPeIUYmDsZDjBIczEoivNK/j6cI
        8aYkVlalFuXHF5XmpBYfYjQFengis5Rocj4wjeeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQ
        nliSmp2aWpBaBNPHxMEp1cAUKZGU0zQlJtr3cJqo4GUx/W8Z+4T2bVzC8uvAPIeaf6IL13VI
        z5uZlDJFln86i+Dph31xe3/ltpXuuS6/bnfYU7+f76ecKPT8J/879a72Dt33mRrhHsx79l3L
        ucZXO+u5AzuLLOfDVs6ix/ZJEfLsIld6hCYKHLY9Htexe/99B/YrizpXePq6L/EQlly25d2c
        i5m7zx8L1Wj6evE149MH04XWvHSRd85OdFjsq1otVTHxjbZxcHXOgamC93qXbF3ZM2f3RyVm
        f8GUh3u/RH36mdM1q23W9Mlcew5/eC0mNeWva3rZW0lzfb8//qvuxjGwzd565Edn4uTHFpvb
        rp78fmvj0QcN/zh0XlbEfDi4RYmlOCPRUIu5qDgRACILMk4rBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
References: <20230803024827epcms2p838d9e9131492c86a159fff25d195658f@epcms2p8>
        <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the bip's bi_size has been set before an integrity pages
were added. If a problem occurs in the process of adding pages for
bip, the bi_size mismatch problem must be dealt with.

When the page is successfully added to bvec, the bi_size is updated.

The parts affected by the change were also contained in this commit.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c               | 2 +-
 drivers/md/dm-crypt.c               | 1 -
 drivers/nvme/host/ioctl.c           | 1 -
 drivers/nvme/target/io-cmd-bdev.c   | 3 +--
 drivers/target/target_core_iblock.c | 3 +--
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 045553a164e0..6220a99977a4 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -137,6 +137,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
+	bip->bip_iter.bi_size += len;
 
 	return len;
 }
@@ -244,7 +245,6 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
-	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1dc6227d353e..f2662c21a6df 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1160,7 +1160,6 @@ static int dm_crypt_integrity_io_alloc(struct dm_crypt_io *io, struct bio *bio)
 
 	tag_len = io->cc->on_disk_tag_size * (bio_sectors(bio) >> io->cc->sector_shift);
 
-	bip->bip_iter.bi_size = tag_len;
 	bip->bip_iter.bi_sector = io->cc->start + io->sector;
 
 	ret = bio_integrity_add_page(bio, virt_to_page(io->integrity_metadata),
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 5c3250f36ce7..19a5177bc360 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -118,7 +118,6 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		goto out_free_meta;
 	}
 
-	bip->bip_iter.bi_size = len;
 	bip->bip_iter.bi_sector = seed;
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf));
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2733e0158585..468833675cc9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -206,12 +206,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		return PTR_ERR(bip);
 	}
 
-	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
 	/* virtual start sector must be in integrity interval units */
 	bip_set_seed(bip, bio->bi_iter.bi_sector >>
 		     (bi->interval_exp - SECTOR_SHIFT));
 
-	resid = bip->bip_iter.bi_size;
+	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 3d1b511ea284..a7050f63b7cc 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -689,7 +689,6 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		return PTR_ERR(bip);
 	}
 
-	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
 	/* virtual start sector must be in integrity interval units */
 	bip_set_seed(bip, bio->bi_iter.bi_sector >>
 				  (bi->interval_exp - SECTOR_SHIFT));
@@ -697,7 +696,7 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
 
-	resid = bip->bip_iter.bi_size;
+	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 
 		len = min_t(size_t, miter->length, resid);
-- 
2.34.1
