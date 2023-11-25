Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099DA7F8918
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjKYIQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYIQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:16:30 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2EB5;
        Sat, 25 Nov 2023 00:16:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scl725TN3z4f3kKv;
        Sat, 25 Nov 2023 16:16:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 86A201A02E9;
        Sat, 25 Nov 2023 16:16:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgCnqxFfrWFlP8KIBw--.32848S4;
        Sat, 25 Nov 2023 16:16:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 0/5] md: remove rcu protection to access rdev from conf
Date:   Sat, 25 Nov 2023 16:15:59 +0800
Message-Id: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxFfrWFlP8KIBw--.32848S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGry7Ary8Jry5JFy8Xr47urg_yoW5AFWkpa
        yftFy3WrWUJr45XrWDJa9rCr1rJw42q3yqy343W3W8Za4Y9ry2qw1rtFy8ZFy5CasIyFWU
        X3W5XrsrJFyUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - remove patch 1 from v2, and since all the print_conf() is called
 while 'reconfig_mutex' is held, it's safe to remove
 rcu_read_lock/unlock() directly.
 - remove the definition of flag RemoveSynchronized;

Changes in v2:
 - add cover leter in details.

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

   // triggered by sysfs/ioctl
   mddev_lock()
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

Yu Kuai (5):
  md: remove flag RemoveSynchronized
  md/raid10: remove rcu protection to access rdev from conf
  md/raid1: remove rcu protection to access rdev from conf
  md/raid5: remove rcu protection to access rdev from conf
  md/md-multipath: remove rcu protection to access rdev from conf

 drivers/md/md-multipath.c |  32 +++---
 drivers/md/md.c           |  37 ++-----
 drivers/md/md.h           |   5 -
 drivers/md/raid1.c        |  71 ++++--------
 drivers/md/raid10.c       | 222 ++++++++++----------------------------
 drivers/md/raid5-cache.c  |  11 +-
 drivers/md/raid5-ppl.c    |  16 +--
 drivers/md/raid5.c        | 191 +++++++++++---------------------
 drivers/md/raid5.h        |   4 +-
 9 files changed, 168 insertions(+), 421 deletions(-)

-- 
2.39.2

