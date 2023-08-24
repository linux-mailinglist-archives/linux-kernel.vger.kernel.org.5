Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEC787211
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbjHXOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbjHXOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:45:08 -0400
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBD81BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:45:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692888302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S9+qnTir0RgMRooesWbZgHu9XmCpC66Spzkbub/tPAs=;
        b=Tv8yFGBlN3FnIqVaaR7vwYZENCXOSfMeywy9FLLHKGN4V/I1K3NO4AGXmsqjBLwkZsePsK
        qSlHpRlehWg/95fHe+r+CqJD0fD2Vdw14UGWbcPrY8OBPNnuALnS7XmidBNRluc0RGHvyM
        E8ClSDm0xeJgUrF8n7jHGwVyD6GcdJo=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 0/6] blk-mq: optimize the queue_rqs() support
Date:   Thu, 24 Aug 2023 22:43:57 +0800
Message-ID: <20230824144403.2135739-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The current queue_rqs() support has limitation that it can't work on
shared tags queue, which is resolved by patch 1-3. We move the account
of active requests to where we really allocate the driver tag.

This is clearer and matched with the unaccount side which now happen
when we put the driver tag. And we can remove RQF_MQ_INFLIGHT, which
was used to avoid double account problem of flush request.

Another problem is that the driver that support queue_rqs() has to
set inflight request table by itself, which is resolved in patch 4.

The patch 5 fixes a potential race problem which may cause false
timeout because of the reorder of rq->state and rq->deadline.

The patch 6 add support queue_rqs() for null_blk, which showed a
3.6% IOPS improvement in fio/t/io_uring benchmark on my test VM.
And we also use it for testing queue_rqs() on shared tags queue.

Thanks for review!

Chengming Zhou (6):
  blk-mq: account active requests when get driver tag
  blk-mq: remove RQF_MQ_INFLIGHT
  blk-mq: support batched queue_rqs() on shared tags queue
  blk-mq: update driver tags request table when start request
  blk-mq: fix potential reorder of request state and deadline
  block/null_blk: add queue_rqs() support

 block/blk-flush.c             | 11 ++-----
 block/blk-mq-debugfs.c        |  1 -
 block/blk-mq.c                | 53 ++++++++++++++------------------
 block/blk-mq.h                | 57 ++++++++++++++++++++++++-----------
 drivers/block/null_blk/main.c | 20 ++++++++++++
 drivers/block/virtio_blk.c    |  2 --
 drivers/nvme/host/pci.c       |  1 -
 include/linux/blk-mq.h        |  2 --
 8 files changed, 84 insertions(+), 63 deletions(-)

-- 
2.41.0

