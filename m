Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1078F7F9930
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjK0GWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjK0GWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:22:00 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C8E4;
        Sun, 26 Nov 2023 22:22:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SdwV16fHsz4f3jHl;
        Mon, 27 Nov 2023 14:22:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id B48421A0C1A;
        Mon, 27 Nov 2023 14:22:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hB+NWRlrcU8CA--.57866S9;
        Mon, 27 Nov 2023 14:22:02 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@infradead.org, ming.lei@redhat.com, axboe@kernel.dk,
        roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
        joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org,
        chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        agruenba@redhat.com, jack@suse.com, konishi.ryusuke@gmail.com,
        dchinner@redhat.com, linux@weissschuh.net, min15.li@samsung.com,
        yukuai3@huawei.com, dlemoal@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH block/for-next v2 05/16] s390/dasd: use new helper to get inode from block_device
Date:   Mon, 27 Nov 2023 14:21:05 +0800
Message-Id: <20231127062116.2355129-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hB+NWRlrcU8CA--.57866S9
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1rWw4fAF15Kw1DXry3CFg_yoW3Cwc_CF
        13JryIqw18Crnakw1YvF4rZr9a9F1kWr1IvFy5tr1fXF9rXF4Svw4kua13JrZ7GayUG3s8
        JF9rXr1jvr15WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Which is more efficiency, and also prepare to remove the field
'bd_inode' from block_device.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/s390/block/dasd_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 61b9675e2a67..a34554ace310 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -221,7 +221,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 	 * enabling the device later.
 	 */
 	if (fdata->start_unit == 0) {
-		block->gdp->part0->bd_inode->i_blkbits =
+		bdev_inode(block->gdp->part0)->i_blkbits =
 			blksize_bits(fdata->blksize);
 	}
 
-- 
2.39.2

