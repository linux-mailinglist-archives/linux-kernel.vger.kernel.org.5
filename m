Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5197B1290
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjI1GWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1GWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:22:01 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103E9C;
        Wed, 27 Sep 2023 23:21:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx3KZ0F6vz4f3jLv;
        Thu, 28 Sep 2023 14:21:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyCGxVl3v1WBg--.22861S4;
        Thu, 28 Sep 2023 14:21:56 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 00/25] md: synchronize io with array reconfiguration
Date:   Thu, 28 Sep 2023 14:15:18 +0800
Message-Id: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyCGxVl3v1WBg--.22861S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy7Xw47tF45tryfAFyrZwb_yoWrJw4Dp3
        9FqFZIvw48JFy5Ar4xX34DWF93Jw4FkrZFkr9xWw4rC3W3GryrCrW8Jr98Xr9YkFyfAr9r
        Ja48Xw1rCr18AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

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

After previous four patchset of preparatory work, this patchset impelement
a new version of mddev_suspend(), the new apis:
 - reconfig_mutex is not required;
 - the weird logical that suspend array hold 'reconfig_mutex' for
   mddev_check_recovery() to update superblock is not needed;
 - the special handling, 'pers->prepare_suspend', for raid456 is not
   needed;
 - It's safe to be called at any time once mddev is allocated, and it's
   designed to be used from slow path where array configuration is changed;

And use the new api to replace:

mddev_lock
mddev_suspend or not
// array reconfiguration
mddev_resume or not
mddev_unlock

With:

mddev_suspend
mddev_lock
// array reconfiguration
mddev_unlock
mddev_resume

However, the above change is not possible for raid5 and raid-cluster in
some corner cases, and mddev_suspend/resume() is replaced with quiesce()
callback, which will suspend the array as well.

This patchset is tested in my VM with mdadm testsuite with loop device
except for 10ddf tests(they always fail before this patchset).

A lot of cleanups will be started after this patchset.

Yu Kuai (25):
  md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
  md: replace is_md_suspended() with 'mddev->suspended' in
    md_check_recovery()
  md: add new helpers to suspend/resume array
  md: add new helpers to suspend/resume and lock/unlock array
  md: use new apis to suspend array for suspend_lo/hi_store()
  md: use new apis to suspend array for level_store()
  md: use new apis to suspend array for serialize_policy_store()
  md/dm-raid: use new apis to suspend array
  md/md-bitmap: use new apis to suspend array for location_store()
  md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
  md/raid5-cache: use new apis to suspend array for
    r5c_disable_writeback_async()
  md/raid5-cache: use new apis to suspend array for
    r5c_journal_mode_store()
  md/raid5: use new apis to suspend array for raid5_store_stripe_size()
  md/raid5: use new apis to suspend array for raid5_store_skip_copy()
  md/raid5: use new apis to suspend array for
    raid5_store_group_thread_cnt()
  md/raid5: use new apis to suspend array for
    raid5_change_consistency_policy()
  md/raid5: replace suspend with quiesce() callback
  md: use new apis to suspend array for ioctls involed array
    reconfiguration
  md: use new apis to suspend array for adding/removing rdev from
    state_store()
  md: use new apis to suspend array before
    mddev_create/destroy_serial_pool
  md: cleanup mddev_create/destroy_serial_pool()
  md/md-linear: cleanup linear_add()
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

