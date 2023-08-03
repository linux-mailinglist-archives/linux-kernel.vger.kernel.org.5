Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950476EA38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjHCN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjHCN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:31 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F2810EA;
        Thu,  3 Aug 2023 06:27:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqQQ33txz4f44xV;
        Thu,  3 Aug 2023 21:27:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S4;
        Thu, 03 Aug 2023 21:27:24 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 00/13] md: make rdev addition and removal independent from daemon thread
Date:   Thu,  3 Aug 2023 21:24:13 +0800
Message-Id: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4fWw48uFW5Ww18Wr1kAFb_yoW8Zw1rpr
        y3tF13Ww4UAFsrGF9xXayUWa45Kw4fGrW7GF9rW395u3W5uryv9w1xJF48uF90ya4ak3y0
        qr1Utr1kCa4vyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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

patch 1-11 are cleanup and refactor patches, I think they make related
code much easier to read;

More patchset on the way!

[1] https://lore.kernel.org/all/20230621165110.1498313-1-yukuai1@huaweicloud.com/
[2] https://lore.kernel.org/all/20230628012931.88911-2-yukuai1@huaweicloud.com/

Yu Kuai (13):
  md: remove rdev flag 'RemoveSynchronized'
  md: factor out a helper rdev_removeable() from remove_and_add_spares()
  md: factor out a helper rdev_is_spare() from remove_and_add_spares()
  md: factor out a helper rdev_addable() from remove_and_add_spares()
  md: factor out a helper hot_remove_rdev() from remove_and_add_spares()
  md: factor out a helper hot_add_rdev() from remove_and_add_spares()
  md: factor out a helper remove_rdev() from state_store()
  md: convert to use hot_remove_rdev() to hot remove one rdev
  md: convert to use hot_add_rdev() to hot add one rdev
  md: cleanup remove_and_add_spares()
  md: use separate work_struct for md_start_sync()
  md: delay choosing sync direction to md_start_sync()
  md: delay remove_and_add_spares() for read only array to
    md_start_sync()

 drivers/md/md-multipath.c |  15 +-
 drivers/md/md.c           | 413 +++++++++++++++++++++-----------------
 drivers/md/md.h           |  10 +-
 drivers/md/raid1.c        |  15 +-
 drivers/md/raid10.c       |  15 +-
 drivers/md/raid5.c        |  15 +-
 6 files changed, 262 insertions(+), 221 deletions(-)

-- 
2.39.2

