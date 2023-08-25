Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39E787E58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjHYDOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjHYDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:14:17 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC91997;
        Thu, 24 Aug 2023 20:14:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RX4mc3rh6z4f3tDH;
        Fri, 25 Aug 2023 11:14:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBah_HOhkveEWBg--.3212S4;
        Fri, 25 Aug 2023 11:14:09 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 0/7] md: initialize 'active_io' while allocating mddev
Date:   Fri, 25 Aug 2023 11:09:49 +0800
Message-Id: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBah_HOhkveEWBg--.3212S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJryktw1kGFy8Jw43tFWUArb_yoW8KFWDp3
        9aqF43Zw1UWr1rJr43X3y8Wr90qws3WrZxKr9xWr4Fkw17uwn7Jw1Sga1Fgr97AFy3A3ZI
        yr98Xw48CF18ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - rebase for md-next;
 - update commit message for patch 3;

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

