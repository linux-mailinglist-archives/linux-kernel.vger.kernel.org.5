Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4796476EAA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjHCNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjHCNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:33:43 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A5C4694;
        Thu,  3 Aug 2023 06:32:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqX83Vg5z4f3l7M;
        Thu,  3 Aug 2023 21:32:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtqrMtkWHLlPQ--.49699S4;
        Thu, 03 Aug 2023 21:32:27 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 00/29] md: synchronize io with array reconfiguration
Date:   Thu,  3 Aug 2023 21:29:01 +0800
Message-Id: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtqrMtkWHLlPQ--.49699S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4DWr48Cr1xWryxKr1Utrb_yoW5trWfp3
        9rtFZIvw48JFy5Ar4xX3yDGF95Jw1rKrW2kr9xCw4rC3W3GryrZrWUGr98XrZYkFyfAF9r
        Ja4UX34rGr18Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb7GYJUUUUU==
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

Yu Kuai (29):
  md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
  md: use 'mddev->suspended' for is_md_suspended()
  md: add new helpers to suspend/resume array
  md: add new helpers to suspend/resume and lock/unlock array
  md: use new apis to suspend array for suspend_lo/hi/store()
  md: use new apis to suspend array for level_store()
  md: use new apis to suspend array for serialize_policy_store()
  md/dm-raid: use new apis to suspend array
  md/md-bitmap: use new apis to suspend array for location_store()
  md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
  md/raid5-cache: use new apis to suspend array for r5c_disable_writeback_async()
  md/raid5-cache: use new apis to suspend array for r5c_journal_mode_store()
  md/raid5: use new apis to suspend array for raid5_store_stripe_size()
  md/raid5: use new apis to suspend array for raid5_store_skip_copy()
  md/raid5: use new apis to suspend array for raid5_store_group_thread_cnt()
  md/raid5: use new apis to suspend array for raid5_change_consistency_policy()
  md/raid5: replace suspend with quiesce() callback
  md: quiesce before md_kick_rdev_from_array() for md-cluster
  md: use new apis to suspend array for ioctls involed array reconfiguration
  md: use new apis to suspend array for adding/removing rdev from state_store()
  md: use new apis to suspend array for bind_rdev_to_array()
  md: use new apis to suspend array related to serial pool in state_store()
  md: use new apis to suspend array in backlog_store()
  md: suspend array in md_start_sync() if array need reconfiguration
  md: cleanup mddev_create/destroy_serial_pool()
  md/md-linear: cleanup linear_add()
  md: remove mddev_suspend() and mddev_resume()
  md/raid5: Revert "md/raid5: fix a deadlock in the case that reshape is interrupted"
  md: Revert "md: add a new api prepare_suspend() in md_personality"

 drivers/md/dm-raid.c       |  12 +-
 drivers/md/md-autodetect.c |   4 +-
 drivers/md/md-bitmap.c     |  18 ++-
 drivers/md/md-linear.c     |   2 -
 drivers/md/md.c            | 267 ++++++++++++++++++++++---------------
 drivers/md/md.h            |  57 ++++++--
 drivers/md/raid5-cache.c   |  65 +++++----
 drivers/md/raid5.c         | 100 +++-----------
 8 files changed, 267 insertions(+), 258 deletions(-)

-- 
2.39.2

