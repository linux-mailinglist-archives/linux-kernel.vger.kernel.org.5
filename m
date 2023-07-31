Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39A768A00
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGaCax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGaCav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:30:51 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FBE4E;
        Sun, 30 Jul 2023 19:30:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RDj036rbXz4f3nq6;
        Mon, 31 Jul 2023 10:30:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgC3ltTUHMdkCiyOPA--.31595S4;
        Mon, 31 Jul 2023 10:30:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next] md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()
Date:   Mon, 31 Jul 2023 10:28:00 +0800
Message-Id: <20230731022800.1424902-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3ltTUHMdkCiyOPA--.31595S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1rGr15JrW8GF4DKw48WFg_yoW8Gw4rpa
        1IgF13Zr43Cas8Aw1DX34DCFyrtayDGrW8Ca93u3s8ZF13tFZ3K3y5XFW5WFWDuF95Jw1D
        tFn8C3yrAFyjgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

After commit 4d27e927344a ("md: don't quiesce in mddev_suspend()"),
'conf->barrier' will be leaked in the case that raid10 takeover raid0:

level_store
 pers->takeover -> raid10_takeover
  raid10_takeover_raid0
   WRITE_ONCE(conf->barrier, 1)

mddev_suspend
// still raid0
mddev->pers = pers
// switch to raid10
mddev_resume
// resume without suspend

After the above commit, mddev_resume() will not decrease 'conf->barrier'
that is set in raid10_takeover_raid0().

Fix this problem by remove the setting of 'conf->barrier' from
raid10_takeover_raid0().

By the way, this problem is found while I'm trying to make
mddev_suspend/resume() to be independent from raid personalities. rai10
is the only personality to use reference count in the quiesce() callback
and this problem is only related to raid10.

Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 16aa9d735880..7704a4c7f469 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4417,7 +4417,6 @@ static void *raid10_takeover_raid0(struct mddev *mddev, sector_t size, int devs)
 				rdev->new_raid_disk = rdev->raid_disk * 2;
 				rdev->sectors = size;
 			}
-		WRITE_ONCE(conf->barrier, 1);
 	}
 
 	return conf;
-- 
2.39.2

