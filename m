Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351AA7DFE22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjKCCSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjKCCSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:18:38 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECFA1B2;
        Thu,  2 Nov 2023 19:18:35 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SM4D20MhMz4f3kFj;
        Fri,  3 Nov 2023 10:18:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 4B8101A016E;
        Fri,  3 Nov 2023 10:18:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3gtJ3WERlzdy+Eg--.64019S4;
        Fri, 03 Nov 2023 10:18:32 +0800 (CST)
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
To:     josef@toxicpanda.com
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com, lilingfeng3@huawei.com
Subject: [PATCH] nbd: fix uaf in nbd_open
Date:   Fri,  3 Nov 2023 18:13:34 +0800
Message-Id: <20231103101334.1750094-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3gtJ3WERlzdy+Eg--.64019S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4DtrW3uFy3WrW8Xw18Krg_yoWDJFg_C3
        48Awn2qr4Fkry8Cr4jyF1DZrW5tw1FqF4rCw1Sqas3Zay7Xas3GF4xZrW5A3yDGFy7Ga47
        ZF1Yqr43Ar4xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
        k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK
        6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj
        6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjTRM_M-UUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
disk->private_data as NULL as before. UAF may be triggered in nbd_open()
if someone tries to open nbd device right after nbd_put() since refcount
of nbd device is zero and private_data is not NULL.

Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 800f131222fc..aab93b836e84 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -250,6 +250,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	struct gendisk *disk = nbd->disk;
 
 	del_gendisk(disk);
+	disk->private_data = NULL;
 	put_disk(disk);
 	blk_mq_free_tag_set(&nbd->tag_set);
 
-- 
2.31.1

