Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0207E3324
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjKGCj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:39:55 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52716115;
        Mon,  6 Nov 2023 18:39:52 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPXVq0jb5z4f3l7D;
        Tue,  7 Nov 2023 10:39:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 220661A0177;
        Tue,  7 Nov 2023 10:39:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhBxo0ll3yj7AA--.25469S4;
        Tue, 07 Nov 2023 10:39:47 +0800 (CST)
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
To:     josef@toxicpanda.com
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com, lilingfeng3@huawei.com
Subject: [PATCH v2] nbd: fix uaf in nbd_open
Date:   Tue,  7 Nov 2023 18:34:35 +0800
Message-Id: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhBxo0ll3yj7AA--.25469S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4rur1ktr1xKryUWw1kGrg_yoW8ZryxpF
        s8XF4DKay8Gw4Iga18Jw43Xr1rKw18G3yIgFW7u34avF93ArZIqFyvyFy8XFn0qrWxJFsr
        AF4jqryxZ3WxCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Zr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x0pRQo7tUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
disk->private_data as NULL as before. UAF may be triggered in nbd_open()
if someone tries to open nbd device right after nbd_put() since nbd has
been free in nbd_dev_remove().

Fix this by implementing ->free_disk and free private data in it.

Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
  v1->v2: Implemente ->free_disk and free nbd in it instead of setting
          disk->private_data as NULL before free nbd.

 drivers/block/nbd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 800f131222fc..855fdf5c3b4e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -250,7 +250,6 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	struct gendisk *disk = nbd->disk;
 
 	del_gendisk(disk);
-	put_disk(disk);
 	blk_mq_free_tag_set(&nbd->tag_set);
 
 	/*
@@ -261,7 +260,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	idr_remove(&nbd_index_idr, nbd->index);
 	mutex_unlock(&nbd_index_mutex);
 	destroy_workqueue(nbd->recv_workq);
-	kfree(nbd);
+	put_disk(disk);
 }
 
 static void nbd_dev_remove_work(struct work_struct *work)
@@ -1608,6 +1607,13 @@ static void nbd_release(struct gendisk *disk)
 	nbd_put(nbd);
 }
 
+static void nbd_free_disk(struct gendisk *disk)
+{
+	struct nbd_device *nbd = disk->private_data;
+
+	kfree(nbd);
+}
+
 static const struct block_device_operations nbd_fops =
 {
 	.owner =	THIS_MODULE,
@@ -1615,6 +1621,7 @@ static const struct block_device_operations nbd_fops =
 	.release =	nbd_release,
 	.ioctl =	nbd_ioctl,
 	.compat_ioctl =	nbd_ioctl,
+	.free_disk =	nbd_free_disk,
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-- 
2.31.1

