Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55F78A443
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjH1CFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjH1CEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:51 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D4DA;
        Sun, 27 Aug 2023 19:04:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RYv5847Sjz4f3jqY;
        Mon, 28 Aug 2023 10:04:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S4;
        Mon, 28 Aug 2023 10:04:44 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 00/28] md: synchronize io with array reconfiguration
Date:   Mon, 28 Aug 2023 09:59:53 +0800
Message-Id: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxCw1UWF1ruFyUAw18Xwb_yoW5tFWUp3
        9rtFZIvw48JFy5Ar4xX34DGF95Jw4rKrZFkr9xCw1rC3W3GryrArW8Gr98XrZYkFyfAr9r
        Ja4DX34rGr18Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - rebase with latest md-next
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

Yu Kuai (28):
  md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
  md: use 'mddev->suspended' for is_md_suspended()
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
  md: quiesce before md_kick_rdev_from_array() for md-cluster
  md: use new apis to suspend array for ioctls involed array
    reconfiguration
  md: use new apis to suspend array for adding/removing rdev from
    state_store()
  md: use new apis to suspend array for bind_rdev_to_array()
  md: use new apis to suspend array related to serial pool in
    state_store()
  md: use new apis to suspend array in backlog_store()
  md: suspend array in md_start_sync() if array need reconfiguration
  md: cleanup mddev_create/destroy_serial_pool()
  md/md-linear: cleanup linear_add()
  md: remove old apis to suspend the array
  md: rename __mddev_suspend/resume() back to mddev_suspend/resume()

 drivers/md/dm-raid.c       |   8 +-
 drivers/md/md-autodetect.c |   4 +-
 drivers/md/md-bitmap.c     |  18 ++-
 drivers/md/md-linear.c     |   2 -
 drivers/md/md.c            | 250 ++++++++++++++++++++++---------------
 drivers/md/md.h            |  52 ++++++--
 drivers/md/raid5-cache.c   |  61 +++++----
 drivers/md/raid5.c         |  56 ++++-----
 8 files changed, 253 insertions(+), 198 deletions(-)

-- 
2.39.2

