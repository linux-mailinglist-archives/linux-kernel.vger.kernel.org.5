Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E77D1A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 04:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjJUCZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjJUCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 22:25:21 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92379D7E;
        Fri, 20 Oct 2023 19:25:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SC4zl34hDz4f3mK2;
        Sat, 21 Oct 2023 10:25:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnt9aHNjNlZ+cUDg--.5642S4;
        Sat, 21 Oct 2023 10:25:12 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 0/6] md: remove rcu protection to access rdev from conf
Date:   Sat, 21 Oct 2023 18:20:53 +0800
Message-Id: <20231021102059.3198284-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnt9aHNjNlZ+cUDg--.5642S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fGFy8Jr1rWr4rJr1DZFb_yoW5Xw1fpa
        yftFy3W3yUJrW5XrWDJa9rCw15Jw40q3yqy343W348Za4Y9r92vw1rtFy8ZFy5CFZIyFWU
        Xa4UWrsrXFyUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

The lifetime of rdev:

1. md_import_device() generate a rdev based on underlying disk;

   mddev_lock()
   rdev = kzalloc();
   rdev->bdev = blkdev_get_by_dev();
   mddev_unlock()

2. bind_rdev_to_array() add this rdev to mddev->disks;

   mddev_lock()
   kobject_add(&rdev->kobj, &mddev->kobj, ...);
   list_add_rcu(&rdev->same_set, &mddev->disks);
   mddev_unlock()

3. remove_and_add_spares() add this rdev to conf;

   mddev_lock()
   rdev_addable();
   pers->hot_add_disk();
   rcu_assign_pointer(conf->rdev, rdev);
   mddev_unlock()

4. Use this array with rdev;

5. remove_and_add_spares() remove rdev from conf;

   mddev_lock()
   // triggered by sysfs/ioctl
   rdev_removeable();
   pers->hot_remove_disk();
    rcu_assign_pointer(conf->rdev, NULL);
    synchronize_rcu();
   mddev_unlock()

   // triggered by daemon
   mddev_lock()
   rdev_removeable();
   synchronize_rcu(); -> this can't protect accessing rdev from conf
   pers->hot_remove_disk();
    rcu_assign_pointer(conf->rdev, NULL);
   mddev_unlock()

6. md_kick_rdev_from_array() remove rdev from mddev->disks;

   mddev_lock()
   list_del_rcu(&rdev->same_set);
   synchronize_rcu();
   list_add(&rdev->same_set, &mddev->deleting)
   mddev_unlock()
    export_rdev

There are two separate rcu protection for rdev, and this pathset remove
the protection of conf(step 3 and 5), because it's safe to access rdev
from conf in following cases:

 - If 'reconfig_mutex' is held, because rdev can't be added or rmoved to
 conf;
 - If there is normal IO inflight, because mddev_suspend() will wait for
 IO to be done and prevent rdev to be added or removed to conf;
 - If sync thread is running, because remove_and_add_spares() can only be
 called from daemon thread when sync thread is done, and
 'MD_RECOVERY_RUNNING' is also checked for ioctl/sysfs;
 - if any spinlock or rcu_read_lock() is held, because synchronize_rcu()
 from step 6 prevent rdev to be freed until spinlock is released or
 rcu_read_unlock();

Yu Kuai (6):
  md: remove useless debug code to print configuration
  md: remove flag RemoveSynchronized
  md/raid1: remove rcu protection to access rdev from conf
  md/raid10: remove rcu protection to access rdev from conf
  md/raid5: remove rcu protection to access rdev from conf
  md/md-multipath: remove rcu protection to access rdev from conf

 drivers/md/md-multipath.c |  29 ++---
 drivers/md/md.c           |  37 +-----
 drivers/md/raid1.c        |  94 ++++-----------
 drivers/md/raid10.c       | 248 +++++++++-----------------------------
 drivers/md/raid5-cache.c  |  11 +-
 drivers/md/raid5-ppl.c    |  16 +--
 drivers/md/raid5.c        | 225 ++++++++++------------------------
 drivers/md/raid5.h        |   4 +-
 8 files changed, 163 insertions(+), 501 deletions(-)

-- 
2.39.2

