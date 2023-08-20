Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646C781D15
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjHTJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjHTJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:16:28 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A149F3;
        Sun, 20 Aug 2023 02:13:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RT8zq1qhfz4f3tCm;
        Sun, 20 Aug 2023 17:13:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBahH2eFkmXibBA--.44158S4;
        Sun, 20 Aug 2023 17:13:45 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, mariusz.tkaczyk@linux.intel.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 0/7] md: make rdev addition and removal independent from daemon thread
Date:   Sun, 20 Aug 2023 17:09:42 +0800
Message-Id: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBahH2eFkmXibBA--.44158S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJryfWFyUtw15XFW5GrWrGrg_yoW8Cryfpr
        yaqF1agrWUXFnrGrZxGw17Wa4Fgw4fXrZrJFy3W34rCw15urykur97ta1UuF90yFyak347
        Wr1jqF95C3WDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - rename md_choose_sync_direction() to md_choose_sync_action() in patch 2;
 - fix an error in patch 3;
 - add flush_work(&mddev->sync_work) while change read-only array to
 read-write;

Changes in v2:
 - remove patch 1 from v1 and some related patches, those patches will
 be sent later when rcu protection for rdev is removed.
 - add patch 2.

This is the third patchset to do some preparatory work to synchronize
io with array reconfiguration.

1) The first patchset refactor 'active_io', make sure that mddev_suspend()
will wait for io to be done. [1]

2) The second patchset remove 'quiesce' callback from mddev_suspend(), so
that mddev_suspend() doesn't rely on 'quiesce' callback is registered,
and can be used for all personalites; [2]

3) This patchset make array reconfiguration independent from daemon thread,
and synchronize it with io will be much easier because io may rely on
daemon thread to be done.

More patchset on the way!

[1] https://lore.kernel.org/all/20230621165110.1498313-1-yukuai1@huaweicloud.com/
[2] https://lore.kernel.org/all/20230628012931.88911-2-yukuai1@huaweicloud.com/

Yu Kuai (7):
  md: use separate work_struct for md_start_sync()
  md: factor out a helper to choose sync action from md_check_recovery()
  md: delay choosing sync action to md_start_sync()
  md: factor out a helper rdev_removeable() from remove_and_add_spares()
  md: factor out a helper rdev_is_spare() from remove_and_add_spares()
  md: factor out a helper rdev_addable() from remove_and_add_spares()
  md: delay remove_and_add_spares() for read only array to
    md_start_sync()

 drivers/md/md.c | 268 ++++++++++++++++++++++++++++++------------------
 drivers/md/md.h |   5 +-
 2 files changed, 170 insertions(+), 103 deletions(-)

-- 
2.39.2

