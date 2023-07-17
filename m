Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671CB755A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGQEB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGQEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:01:45 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D4EE41
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:01:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689566498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=26hmSG3cG2qMCZKRMNmjIWTmveuGKUdShNQ0HXNAgXQ=;
        b=KT4Rcz6CdcyuiL90HQra1ibRCSc7FHSuWb9BOasmWz3ts1PocJEODxPlSJyVe+qCmWHfDj
        QPzUrxCYjH1fO34VkW1lk6xW4cEmZBwoDRji8kvBLKE6RQhe0xNQ9eD1aKITbnAEAiR8bL
        B4XWxTNnO9MShteo3pKdWZnSotdyXSU=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v4 0/4] blk-mq: optimize flush and request size
Date:   Mon, 17 Jul 2023 12:00:54 +0800
Message-ID: <20230717040058.3993930-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

v4:
 - Rebase on the updated block/master branch, which include a flush bugfix
   from Christoph. Please help to check patch 04. Thanks!
 - Add a bugfix patch 02 for post-flush requests, put before other flush optimizations.
 - Collect Reviewed-by tags from Ming and Christoph. Thanks!
 - [v3] https://lore.kernel.org/lkml/20230707093722.1338589-1-chengming.zhou@linux.dev/

v3:
 - Collect Reviewed-by tags from Ming and Christoph. Thanks!
 - Remove the list and csd variables which are only used once.
 - Fix a bug report of blktests nvme/012 by re-initialization of
   rq->queuelist, which maybe corrupted by rq->rq_next reuse.
 - [v2] https://lore.kernel.org/all/20230629110359.1111832-1-chengming.zhou@linux.dev/

v2:
 - Change to use call_single_data_t, which use __aligned() to avoid
   to use 2 cache lines for 1 csd. Thanks Ming Lei.
 - [v1] https://lore.kernel.org/all/20230627120854.971475-1-chengming.zhou@linux.dev/

Hello,

After the commit be4c427809b0 ("blk-mq: use the I/O scheduler for
writes from the flush state machine"), rq->flush can't reuse rq->elv
anymore, since flush_data requests can go into io scheduler now.

That increased the size of struct request by 24 bytes, but this
patchset can decrease the size by 40 bytes, which is good I think.

patch 1 use percpu csd to do remote complete instead of per-rq csd,
decrease the size by 24 bytes.

patch 2 fixes a bug in blk-flush for post-flush requests.

patch 3-4 reuse rq->queuelist in flush state machine pending list,
and maintain unsigned long counter of inflight flush_data requests,
decrease the size by 16 bytes.

Thanks for comments!

Chengming Zhou (4):
  blk-mq: use percpu csd to remote complete instead of per-rq csd
  blk-flush: fix rq->flush.seq for post-flush requests
  blk-flush: count inflight flush_data requests
  blk-flush: reuse rq queuelist in flush state machine

 block/blk-flush.c      | 26 +++++++++++++++-----------
 block/blk-mq.c         | 12 ++++++------
 block/blk.h            |  5 ++---
 include/linux/blk-mq.h |  6 +-----
 4 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.41.0

