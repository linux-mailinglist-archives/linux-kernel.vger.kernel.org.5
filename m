Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42989787218
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbjHXOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbjHXOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:45:29 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [IPv6:2001:41d0:203:375::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737FF1BC6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:45:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692888325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfeZa4Y5jAeM+nwkiT/BS1yQ2iWyllMXdsEwns8FPns=;
        b=EKJiNVsaft0sHEc9R6T7LMrjABFaeKezxlh5EL18TMxj99tnCeqaL+HKir1bIpvCuj88ql
        EY91OcF5k/gn2ZYgQx4kYxBZlbVBiM2Fkf2WohB8Bm5XFJx8QrjNdOd0fjIhiStcyFyShC
        HARTCWpXJhX4r/dYItsWnFfXEba9XnE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 5/6] blk-mq: fix potential reorder of request state and deadline
Date:   Thu, 24 Aug 2023 22:44:02 +0800
Message-ID: <20230824144403.2135739-6-chengming.zhou@linux.dev>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

CPU0				CPU1
blk_mq_start_request()		blk_mq_req_expired()
  WRITE_ONCE(rq->deadline)
  WRITE_ONCE(rq->state)
				  if (READ_ONCE(rq->state) != IN_FLIGHT)
				    return
				  deadline = READ_ONCE(rq->deadline)

If CPU1 speculately reorder rq->deadline LOAD before rq->state, the
deadline will be the initial value 0.

CPU0				CPU1
blk_mq_start_request()		blk_mq_req_expired()
				  deadline = READ_ONCE(rq->deadline)
  WRITE_ONCE(rq->deadline)
  WRITE_ONCE(rq->state)
				  if (READ_ONCE(rq->state) != IN_FLIGHT)
				    return

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ff1b0f3ab3a8..49cbf826b100 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1258,6 +1258,8 @@ void blk_mq_start_request(struct request *rq)
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
 	blk_add_timer(rq);
+	/* Pair with smp_rmb in blk_mq_req_expired(). */
+	smp_wmb();
 	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
 	rq->mq_hctx->tags->rqs[rq->tag] = rq;
 
@@ -1568,6 +1570,12 @@ static bool blk_mq_req_expired(struct request *rq, struct blk_expired_data *expi
 	if (rq->rq_flags & RQF_TIMED_OUT)
 		return false;
 
+	/*
+	 * Order LOADs of rq->state and rq->deadline, pair with
+	 * smp_wmb in blk_mq_start_request().
+	 */
+	smp_rmb();
+
 	deadline = READ_ONCE(rq->deadline);
 	if (time_after_eq(expired->timeout_start, deadline))
 		return true;
-- 
2.41.0

