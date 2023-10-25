Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F37D6565
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJYIls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:41:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C39C;
        Wed, 25 Oct 2023 01:41:45 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SFj8N0lhxz4f3prr;
        Wed, 25 Oct 2023 16:41:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 06C941A016E;
        Wed, 25 Oct 2023 16:41:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd3E1DhlVE+YDw--.27079S4;
        Wed, 25 Oct 2023 16:41:41 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     axboe@kernel.dk, penguin-kernel@i-love.sakura.ne.jp
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com
Subject: [PATCH] block: Fix minor range check in device_add_disk()
Date:   Wed, 25 Oct 2023 16:46:21 +0800
Message-Id: <20231025084621.2338604-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd3E1DhlVE+YDw--.27079S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur4rKF4kJw1rCF4rtFW3Awb_yoWDCFX_Gr
        y5Xr95Wr1rWr1rCrn8urnFyry0yr95Way8CFy0vFZxXayxCF9Fq34DKr1FgF1DWFyjkFW5
        ur1UZrn8tr4IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbr8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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

Checks added in patch:
commit e338924bd05d ("block: check minor range in device_add_disk()")
ignore the problem of first_minore < 0 and disk->minors < 0.

Fix it by adding first_minore < 0 and disk->minors < 0 check.

Fixes: e338924bd05d ("block: check minor range in device_add_disk()")
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 736215e9ddc3..8292a1e265cf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -432,7 +432,9 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 				DISK_MAX_PARTS);
 			disk->minors = DISK_MAX_PARTS;
 		}
-		if (disk->first_minor + disk->minors > MINORMASK + 1)
+		if (disk->first_minor > MINORMASK ||
+			disk->minors > (1U << MINORBITS) ||
+			disk->first_minor + disk->minors > MINORMASK + 1)
 			goto out_exit_elevator;
 	} else {
 		if (WARN_ON(disk->minors))
-- 
2.31.1

