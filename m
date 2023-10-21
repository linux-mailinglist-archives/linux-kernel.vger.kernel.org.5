Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE47D1B93
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjJUHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D31D66;
        Sat, 21 Oct 2023 00:52:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFF5wBtz4f3mHR;
        Sat, 21 Oct 2023 15:52:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S4;
        Sat, 21 Oct 2023 15:52:20 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 0/8] blk-mq: improve tag fair sharing
Date:   Sat, 21 Oct 2023 23:47:58 +0800
Message-Id: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aryxur4rAw48ArWktF48Crg_yoW8tFy8pF
        W3Ka1fGw4xtrW2qr43Z3y0qa4Fqw4kCF45Krn3X345Ar1Ykrs2q3Wvqr4rZFyxJrs3AFsr
        XF4jyr98CFWUJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjTRNgAwUUUUU
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

Current implementation:
 - a counter active_queues record how many queue/hctx is sharing tags,
 and it's updated while issue new IO, and cleared in
 blk_mq_timeout_work().
 - if active_queues is more than 1, then tags is fair shared to each
 node;

New implementation:
 - a new field 'available_tags' is added to each node, and it's
 calculate in slow path, hence fast path won't be affected, patch 5;
 - a new counter 'busy_queues' is added to blk_mq_tags, and it's updated
 while fail to get driver tag, and it's also cleared in
 blk_mq_timeout_work(), and tag sharing will based on 'busy_queues'
 instead of 'active_queues', patch 6,7;
 - a new counter 'busy_count' is added to each node to record how many
 times a node failed to get driver tag, and it's used to judge if a node
 is busy and need more tags, patch 8;
 - a new timer is added to blk_mq_tags, it will start if any node failed
 to get driver tag, and timer function will be used to borrow tags and
 return borrowed tags, patch 8;

A simple test, 32 tags with two shared node:
[global]
ioengine=libaio
iodepth=2
bs=4k
direct=1
rw=randrw
group_reporting

[sda]
numjobs=32
filename=/dev/sda

[sdb]
numjobs=1
filename=/dev/sdb

Test result(monitor new debugfs entry):

time    active          available
        sda     sdb     sda     sdb
0       0       0       32      32
1       16      2       16      16      -> start fair sharing
2       19      2       20      16
3       24      2       24      16
4       26      2       28      16      -> borrow 32/8=4 tags each round
5       28      2       28      16      -> save at lease 4 tags for sdb

Yu Kuai (8):
  blk-mq: factor out a structure from blk_mq_tags
  blk-mq: factor out a structure to store information for tag sharing
  blk-mq: add a helper to initialize shared_tag_info
  blk-mq: support to track active queues from blk_mq_tags
  blk-mq: precalculate available tags for hctx_may_queue()
  blk-mq: add new helpers blk_mq_driver_tag_busy/idle()
  blk-mq-tag: delay tag sharing until fail to get driver tag
  blk-mq-tag: allow shared queue/hctx to get more driver tags

 block/blk-core.c       |   2 -
 block/blk-mq-debugfs.c |  30 +++++-
 block/blk-mq-tag.c     | 226 +++++++++++++++++++++++++++++++++++++++--
 block/blk-mq.c         |  12 ++-
 block/blk-mq.h         |  64 +++++++-----
 include/linux/blk-mq.h |  36 +++++--
 include/linux/blkdev.h |  11 +-
 7 files changed, 328 insertions(+), 53 deletions(-)

-- 
2.39.2

