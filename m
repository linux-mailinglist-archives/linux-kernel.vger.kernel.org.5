Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272407D6402
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjJYHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjJYHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:50:11 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9B18B;
        Wed, 25 Oct 2023 00:50:08 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SFh0l3Dqpz4f3npx;
        Wed, 25 Oct 2023 15:49:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 4B1D61A03DA;
        Wed, 25 Oct 2023 15:50:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd2iyDhlvAiVDw--.13048S4;
        Wed, 25 Oct 2023 15:50:05 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     axboe@kernel.dk, mcgrof@kernel.org, hare@suse.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] block: Set memalloc_noio to false in the error path
Date:   Wed, 25 Oct 2023 15:54:36 +0800
Message-Id: <20231025075436.2212468-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd2iyDhlvAiVDw--.13048S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur4ruF1DJF47Wr47uFy7trb_yoWftFb_A3
        4fZ3s5Wrs5ZFs8Gr9IvF18Xr18trW8tayjgFyvyFsxZa47G3ZY9w1UWr1rGrn7Ja45CFW5
        Ww4qvF1DAr48tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

In del_gendisk, memalloc_noio is set to false, so it would be better to do
the same thing in the error path.

Fixes: 83cbce957446 ("block: add error handling for device_add_disk / add_disk")
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 block/genhd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 3d287b32d50d..736215e9ddc3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -542,6 +542,11 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	kobject_put(disk->part0->bd_holder_dir);
 out_del_block_link:
 	sysfs_remove_link(block_depr, dev_name(ddev));
+	/*
+	 * The error path needs to set memalloc_noio to false
+	 * consistent with del_gendisk.
+	 */
+	 pm_runtime_set_memalloc_noio(ddev, false);
 out_device_del:
 	device_del(ddev);
 out_free_ext_minor:
-- 
2.31.1

