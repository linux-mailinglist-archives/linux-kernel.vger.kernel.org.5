Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878407BF436
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442515AbjJJHXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442386AbjJJHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCEB4;
        Tue, 10 Oct 2023 00:23:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S4S7C389Xz4f3kpS;
        Tue, 10 Oct 2023 15:23:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S4;
        Tue, 10 Oct 2023 15:23:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 00/19] md: synchronize io with array reconfiguration
Date:   Tue, 10 Oct 2023 23:19:39 +0800
Message-Id: <20231010151958.145896-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S4
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWfGr1UJr15XFyUKrWxZwb_yoWxuFWxp3
        y2qan8Zw1DGr17ZrsrX3y8u3WfX3yrGFW5Gr9ag34rC3W3Ary0vrWxua15urZYkry3Ja4D
        XFW8Gw4kCFy8AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v4:
 - add detailed explanation of backgroud and design in cover letter;
 - merge some patches;

Changes in v3:
 - rebase with latest md-next;
 - remove patch 2 from v2, and replace it with a new patch;
 - fix a null-ptr-derefrence in rdev_attr_store() that mddev is used
 before checking;
 - merge patch 20-22 from v1 into one patch;
 - mddev_lock() used to be called first and can be interruptted, allow new
 api, which is called before mddev_lock() now, to be interruptted as well;
 - improve some comments and coding;

Changes in v2:
 - rebase with latest md-next;
 - remove some follow up cleanup patches, these patches will be sent
 later after this patchset.

##### Background

Our testers started to test raid10 last year, and we found that there are
lots of problems in the following test scenario:

- add or remove disks to the array
- issue io to the array

At first, we fixed each problem independently respect that io can
concurrent with array reconfiguration. However, on the one hand new
issues are continuously reported, on the other hand other personalities
might have the same problems. I'm thinking about how to fix these problems
thoroughly.

Refer to how block layer protect io with queue reconfiguration(for example,
change elevator):

```
blk_mq_freeze_queue
-> wait for all io to be done, and prevent new io to be dispatched
// reconfiguration
blk_mq_unfreeze_queue
```

Then it comes to my mind that I can do something similar to synchronize io
with array reconfiguration.

##### rcu introduction

see details in https://www.kernel.org/doc/html/next/RCU/whatisRCU.html

- writer should replace old data with new data first, and free old data
after grace period;
- reader should handle both cases that old data and new data is read, and
the data that is read should not be dereferenced after critical section;

##### Current synchronization

Add or remove disks to the array can be triggered by ioctl/sysfs/daemon
thread:

1. hold 'reconfig_mutex';

2. check that rdev can be added/removed, one condition is that there is no
IO, for example:

   ```
   raid10_remove_disk
    if (atomic_read(&rdev->nr_pending))
     err = -EBUSY;
   ```

3. do the actual operations to add/remove a rdev, one procedure is
set/clear a pointer to rdev, for example:

   ```
   raid10_remove_disk
    p = conf->mirrors[xx]
    rdevp = &p->rdev/replacement
    *rdevp = NULL
   ```

4. check if there is still no io on this rdev, if not, revert the pointer
to rdev and return failure, for example:

   ```
   raid10_remove_disk
    synchronize_rcu()
    if (atomic_read(&rdev->nr_pending))
     err = -EBUSY
     *rdevp = rdev
   ```

IO path is using rcu_read_lock/unlock() to access rdev, for example:

```
raid10_write_request
 rcu_read_lock
 rdev = rcu_dereference(mirror->rdev/replacement)
 ...
 rcu_read_unlock

raid10_end_write_request
 rdev = conf->mirrors[dev].rdev/replacement
 -> rdev/rrdev is still used after rcu_read_unlock()
```

##### Current problems

- rcu is used wrongly;
- There are lots of places involved that old rdev can be read, however,
many places doesn't handle old value correctly;
- Between step 3 and 4, if new io is dispatched, NULL will be read for
the rdev, and data will be lost if step 4 failed.

##### New synchronization

Similar to how blk_mq_freeze_queue() works

Add or remove disks:

1. suspend the array, this should guarantee no new io is dispatched and
wait for dispatched io to be done;
2. add or remove rdevs to array;
3. resume the array;

IO path doesn't need to change for now, and all rcu implementation can
be removed.

There are already apis to suspend/resume the array, unfortunately, they
can't be used here because:

- old apis only wait for io to be dispatched, not to be done;
- old apis is only supported for the personality that implement quiesce
callback;
- old apis can only be called after the array start running;
- old apis must hold 'reconfig_mutex', and will wait for io to be done,
this behavior is risky because 'reconfig_mutex' is used for daemon thread
to update super_block and handle io. In order to prevent potential
problems, there is a weird logical that suspend array hold 'reconfig_mutex'
for mddev_check_recovery() to update super_block, however, this is still
not enough;

Then main work is divided into 3 steps, at first make sure new apis to
suspend the array is general:

- make sure suspend array will wait for io to be done(Done by [1]);
- make sure suspend array can be called for all personalities(Done by [2]);
- make sure suspend array can be called at any time(Done by [3]);
- make sure suspend array doesn't rely on 'reconfig_mutex'(PATCH 3-5);

The second step is to replace old apis with new apis(PATCH 6-16):

```
From:
lock reconfig_mutex
suspend array
resume array
unlock reconfig_mutex

To:
suspend array
lock reconfig_mutex
unlock reconfig_mutex
resume array
```

Finally, for the remain path that involved reconfiguration, suspend the
array first(PATCH 11,12, [4] and PATCH 17):

```
From:
// reconfiguration

To:
suspend array
// reconfiguration
resume array
```

Preparatory work:
[1] https://lore.kernel.org/all/20230621165110.1498313-1-yukuai1@huaweicloud.com/
[2] https://lore.kernel.org/all/20230628012931.88911-2-yukuai1@huaweicloud.com/
[3] https://lore.kernel.org/all/20230825030956.1527023-1-yukuai1@huaweicloud.com/
[4] https://lore.kernel.org/all/20230825031622.1530464-1-yukuai1@huaweicloud.com/

Yu Kuai (19):
  md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
  md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
  md: replace is_md_suspended() with 'mddev->suspended' in
    md_check_recovery()
  md: add new helpers to suspend/resume array
  md: add new helpers to suspend/resume and lock/unlock array
  md/dm-raid: use new apis to suspend array
  md/md-bitmap: use new apis to suspend array for location_store()
  md/raid5-cache: use new apis to suspend array
  md/raid5: use new apis to suspend array
  md: use new apis to suspend array for sysfs apis
  md: use new apis to suspend array for adding/removing rdev from
    state_store()
  md: use new apis to suspend array for ioctls involed array
    reconfiguration
  md: use new apis to suspend array before
    mddev_create/destroy_serial_pool
  md: cleanup mddev_create/destroy_serial_pool()
  md/md-linear: cleanup linear_add()
  md/raid5: replace suspend with quiesce() callback
  md: suspend array in md_start_sync() if array need reconfiguration
  md: remove old apis to suspend the array
  md: rename __mddev_suspend/resume() back to mddev_suspend/resume()

 drivers/md/dm-raid.c       |  10 +-
 drivers/md/md-autodetect.c |   4 +-
 drivers/md/md-bitmap.c     |  18 ++-
 drivers/md/md-linear.c     |   2 -
 drivers/md/md.c            | 233 ++++++++++++++++++++-----------------
 drivers/md/md.h            |  43 +++++--
 drivers/md/raid5-cache.c   |  64 +++++-----
 drivers/md/raid5.c         |  56 ++++-----
 8 files changed, 226 insertions(+), 204 deletions(-)

-- 
2.39.2

