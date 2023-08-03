Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311576EA6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjHCNcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjHCNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:32:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3445A2D69;
        Thu,  3 Aug 2023 06:30:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqVH20Tmz4f400M;
        Thu,  3 Aug 2023 21:30:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MGrMtkNVvlPQ--.7517S4;
        Thu, 03 Aug 2023 21:30:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 0/7] md: initialize 'active_io' while allocating
Date:   Thu,  3 Aug 2023 21:27:44 +0800
Message-Id: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MGrMtkNVvlPQ--.7517S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1fXw17uw1Uuw1UGw1xZrb_yoW8CrWkp3
        ySqFW3Zw1UWr1fJr43J3y8ur90qws3WrZrKr9xXw4rC3W3ua4kCw1fWa1Fqr9FyFy3A3ZI
        yr98X348CF18ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

This is the 4th patchset to do some preparatory work to synchronize
io with array reconfiguration.

1) The first patchset refactor 'active_io', make sure that mddev_suspend()
will wait for io to be done. [1]

2) The second patchset remove 'quiesce' callback from mddev_suspend(), so
that mddev_suspend() doesn't rely on 'quiesce' callback is registered,
and can be used for all personalites; [2]

3) Make array reconfiguration independent from daemon thread,
and synchronize it with io will be much easier because io may rely on
daemon thread to be done.

4) This patchset move initialization of 'active_io' from md_run() to
md_alloc(), so that mddev_suspend() won't rely on holding 'reconfig_mutex'
to check if 'mddev->pers' is set, and it can be called at any time after
mddev is allocated.(Done by patch 1, and other patches are cleanup)

Yu Kuai (7):
  md: initialize 'active_io' while allocating mddev
  md: initialize 'writes_pending' while allocating mddev
  md: don't rely on 'mddev->pers' to be set in mddev_suspend()
  md-bitmap: remove the checking of 'pers->quiesce' from
    location_store()
  md-bitmap: suspend array earlier in location_store()
  md: don't check 'mddev->pers' from suspend_hi_store()
  md: don't check 'mddev->pers' and 'pers->quiesce' from
    suspend_lo_store()

[1] https://lore.kernel.org/all/20230621165110.1498313-1-yukuai1@huaweicloud.com/
[2] https://lore.kernel.org/all/20230628012931.88911-2-yukuai1@huaweicloud.com/

 drivers/md/dm-raid.c   |   7 ++-
 drivers/md/md-bitmap.c |  47 +++++++++----------
 drivers/md/md.c        | 100 ++++++++++++++++++++---------------------
 drivers/md/md.h        |   4 +-
 drivers/md/raid1.c     |   3 +-
 drivers/md/raid10.c    |   3 --
 drivers/md/raid5.c     |   3 --
 7 files changed, 78 insertions(+), 89 deletions(-)

-- 
2.39.2

