Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD00E787E73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjHYDU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHYDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:20:38 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC35D3;
        Thu, 24 Aug 2023 20:20:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RX4vz1QLnz4f3tDS;
        Fri, 25 Aug 2023 11:20:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqUBHuhkPT4XBg--.14533S4;
        Fri, 25 Aug 2023 11:20:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 0/7] md: make rdev addition and removal independent from daemon thread
Date:   Fri, 25 Aug 2023 11:16:15 +0800
Message-Id: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqUBHuhkPT4XBg--.14533S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kJrW8ZFykCry5Wr13CFg_yoW8AFy3pr
        yaqF1agw4UZFZrGF9xJ3W7W34Fgw4fXrZrJFy3Ww18Cw15WrW0vryxJa1DZrWYy34akry7
        uF4jqF95C3WkAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
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

Changes in v4:
 - add some review tag;
 - add comments to make code more readadble for patch 4,6;
 - rework patch 7 a litter;

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

Yu Kuai (7):
  md: use separate work_struct for md_start_sync()
  md: factor out a helper to choose sync action from md_check_recovery()
  md: delay choosing sync action to md_start_sync()
  md: factor out a helper rdev_removeable() from remove_and_add_spares()
  md: factor out a helper rdev_is_spare() from remove_and_add_spares()
  md: factor out a helper rdev_addable() from remove_and_add_spares()
  md: delay remove_and_add_spares() for read only array to
    md_start_sync()

 drivers/md/md.c | 308 +++++++++++++++++++++++++++++++++---------------
 drivers/md/md.h |   5 +-
 2 files changed, 218 insertions(+), 95 deletions(-)

-- 
2.39.2

