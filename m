Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6109C80C2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjLKISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLKISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:18:35 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BAEED;
        Mon, 11 Dec 2023 00:18:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SpZQ40fQzz4f3kjD;
        Mon, 11 Dec 2023 16:18:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 7F7321A0837;
        Mon, 11 Dec 2023 16:18:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDHyhDcxXZlKwVbDQ--.7085S4;
        Mon, 11 Dec 2023 16:18:38 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, zlliu@suse.com, neilb@suse.com, shli@fb.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan666@huaweicloud.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop
Date:   Mon, 11 Dec 2023 16:17:14 +0800
Message-Id: <20231211081714.1923567-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHyhDcxXZlKwVbDQ--.7085S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13Zr18XryUAw4DCFy5CFg_yoW8Zr45pF
        4xWF98KrWUGr9I9w4Utw4kXFyYq34aqrWvyry29a4rWa4Yyr9rJryFg398tryxGrZ5JFs8
        Xa1UCa1Uu3WxW3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSApUUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

The raid should not be opened anymore when it is about to be stopped.
However, other processes can open it again if the flag MD_CLOSING is
cleared before exiting. From now on, this flag will not be cleared when
the raid will be stopped.

Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e9fe5cbeedc..ebdfc9068a60 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6238,7 +6238,6 @@ static void md_clean(struct mddev *mddev)
 	mddev->persistent = 0;
 	mddev->level = LEVEL_NONE;
 	mddev->clevel[0] = 0;
-	mddev->flags = 0;
 	mddev->sb_flags = 0;
 	mddev->ro = MD_RDWR;
 	mddev->metadata_type[0] = 0;
@@ -7614,7 +7613,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7698,7 +7696,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7742,10 +7739,13 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	case STOP_ARRAY:
 		err = do_md_stop(mddev, 0, bdev);
+		if (err)
+			clear_bit(MD_CLOSING, &mddev->flags);
 		goto unlock;
 
 	case STOP_ARRAY_RO:
 		err = md_set_readonly(mddev, bdev);
+		clear_bit(MD_CLOSING, &mddev->flags);
 		goto unlock;
 
 	case HOT_REMOVE_DISK:
@@ -7840,8 +7840,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 				     mddev_unlock(mddev);
 
 out:
-	if(did_set_md_closing)
-		clear_bit(MD_CLOSING, &mddev->flags);
 	return err;
 }
 #ifdef CONFIG_COMPAT
-- 
2.39.2

