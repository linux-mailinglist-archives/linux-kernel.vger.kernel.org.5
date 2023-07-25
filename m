Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D376199E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGYNTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGYNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:00 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E310F6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:18:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690291134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o1A965Rmyit4V/K6hD1sBav9uLDra+3bpcOqxUt5eIs=;
        b=dPQBmSow5zQ4A2h2IYNoiNHUFfJmLfcnSv2nvtsExxlV4Q65g4JsN5MjLbRrK4f7Lt9qcI
        jwZUEhIvQq1paurJo4WxrU2RJFmxmdOjfv78KRNXDJliXJ5WmWjidD283EKIHlbKA9oJNm
        pUaFguEEtnzYC5DAAeoQIrxTrTbgfB4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 0/4] blk-flush: optimize non-postflush requests
Date:   Tue, 25 Jul 2023 21:00:58 +0800
Message-ID: <20230725130102.3030032-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This series optimize flush handling for non-postflush requests. Now we
unconditionally replace rq->end_io to make rq return twice back to the
flush state machine for post-flush.

Obviously, non-postflush requests don't need it, they don't need to
end request twice, so they don't need to replace rq->end_io callback.
And the same for requests with the FUA bit on hardware with FUA support.

The previous approach [1] we take is to move blk_rq_init_flush() to
REQ_FSEQ_DATA stage and only replace rq->end_io if it needs post-flush.

But this way add more magic to the already way too magic flush sequence.
Christoph suggested that we can kill the flush sequence entirely, and
just split the flush_queue into a preflush and a postflush queue.

So this series implement the suggested approach that use two queues:
preflush and postflush requests have separate pending list and running
list, so we know what to do for each request in flush_end_io(), and
we don't need the flush sequence entirely.

Thanks for comments!

[1] https://lore.kernel.org/lkml/20230710133308.GB23157@lst.de/

Chengming Zhou (4):
  blk-flush: flush_rq should inherit first_rq's cmd_flags
  blk-flush: split queues for preflush and postflush requests
  blk-flush: kill the flush state machine
  blk-flush: don't need to end rq twice for non postflush

 block/blk-flush.c      | 181 +++++++++++++++++++++--------------------
 block/blk.h            |   3 +-
 include/linux/blk-mq.h |   1 -
 3 files changed, 96 insertions(+), 89 deletions(-)

-- 
2.41.0

