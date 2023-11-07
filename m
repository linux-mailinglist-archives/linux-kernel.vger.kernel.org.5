Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE17E344F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjKGDuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjKGDuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:50:50 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C1D47;
        Mon,  6 Nov 2023 19:50:46 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SPZ131gsNz1P7w1;
        Tue,  7 Nov 2023 11:47:35 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 11:50:41 +0800
Subject: Re: [PATCH] blk-core: use pr_warn_ratelimited() in bio_check_ro()
To:     Yu Kuai <yukuai1@huaweicloud.com>, <hch@lst.de>, <axboe@kernel.dk>
References: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <6549B3FC.1010700@huawei.com>
Date:   Tue, 7 Nov 2023 11:50:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
Content-Type: multipart/mixed;
        boundary="------------020702050505000504040008"
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------020702050505000504040008
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/11/7 19:12, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> If one of the underlying disks of raid or dm is set to read-only, then
> each io will generate new log, which will cause message storm. This
> environment is indeed problematic, however we can't make sure our
> naive custormer won't do this, hence use pr_warn_ratelimited() to
> prevent message storm in this case.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9d51e9894ece..fdf25b8d6e78 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -501,8 +501,8 @@ static inline void bio_check_ro(struct bio *bio)
>   	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
>   		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
>   			return;
> -		pr_warn("Trying to write to read-only block-device %pg\n",
> -			bio->bi_bdev);
> +		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
> +				    bio->bi_bdev);
Acctually, before commit  57e95e4670d1 ("block: fix and cleanup 
bio_check_ro") , there's only print warning once.
I wrote a patch earlier, set GD_ROWR_WARNED flag for disk after emit 
warning. You can look at the patch in the
attachment, Is it possible to solve your problem.
>   		/* Older lvm-tools actually trigger this */
>   	}
>   }


--------------020702050505000504040008
Content-Type: text/x-patch;
	name="0001-block-only-print-warning-once-when-write-to-readonly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-block-only-print-warning-once-when-write-to-readonly.pa";
	filename*1="tch"

From 82b7dd41eb447e9fdd3d7c5d5e3a002a9f284d82 Mon Sep 17 00:00:00 2001
From: Ye Bin <yebin10@huawei.com>
Date: Wed, 9 Aug 2023 16:11:39 +0800
Subject: [PATCH] block: only print warning once when write to readonly bdev

After commit 57e95e4670d1 there will print warning unconditionally.As a result,
alarm logs are flooded.
To solve above issue, introduce GD_ROWR_WARNED state for every partition to
record if warning has been printed.

Fixes: 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/blk-core.c       | 3 +++
 block/genhd.c          | 1 +
 block/ioctl.c          | 6 +++++-
 include/linux/blkdev.h | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece..69d9757a013a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -501,6 +501,9 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
+		if (test_and_set_bit(GD_ROWR_WARNED,
+				     &bio->bi_bdev->bd_disk->state))
+			return;
 		pr_warn("Trying to write to read-only block-device %pg\n",
 			bio->bi_bdev);
 		/* Older lvm-tools actually trigger this */
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..c05d2cd4a87b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1455,6 +1455,7 @@ void set_disk_ro(struct gendisk *disk, bool read_only)
 		if (!test_and_clear_bit(GD_READ_ONLY, &disk->state))
 			return;
 	}
+	clear_bit(GD_ROWR_WARNED, &disk->state);
 	set_disk_ro_uevent(disk, read_only);
 }
 EXPORT_SYMBOL(set_disk_ro);
diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..a2158c5e8e3e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_read_only = n;
+	if (!bdev->bd_read_only != !n) {
+		bdev->bd_read_only = n;
+		clear_bit(GD_ROWR_WARNED, &bdev->bd_disk->state);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..832f7f81e46c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -157,6 +157,7 @@ struct gendisk {
 #define GD_ADDED			4
 #define GD_SUPPRESS_PART_SCAN		5
 #define GD_OWNS_QUEUE			6
+#define GD_ROWR_WARNED			7
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.31.1


--------------020702050505000504040008--
