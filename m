Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154157816FF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbjHSDNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbjHSDNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:13:05 -0400
Received: from out-6.mta1.migadu.com (out-6.mta1.migadu.com [IPv6:2001:41d0:203:375::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BB4216
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:13:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692414781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z+fBmSvZuIQpbseYhEh9Xt9nxn/9KuEbFVAwNjKXsAI=;
        b=u628zJ4cG9HuzAFStSu6alV8eRCbTDKJTXaRYCEFfOPG62wLW5niBBZxoRHXU94DmPv6mR
        ppXD6VP3kUuDZ/ezCOIhBV4pGUawIqZcDsD2tUv9lZejBDQZ42TuAb2zJ12p4ZB8MDZnk9
        2XCBNHz8AkHfKTiu3l0UQEilI5lh92E=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, chuck.lever@oracle.com, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] blk-mq: fix mismatch between IO scheduler insert and finish
Date:   Sat, 19 Aug 2023 11:12:06 +0800
Message-ID: <20230819031206.2744005-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

IO scheduler has requirement that one request which has been inserted
must call finish_request() only once.

Now we have three special cases to consider:
1. rq has not insert, has complete: e.g. empty preflush
2. rq has insert, has not complete: e.g. merged requests will be freed
3. rq has insert, has twice complete: e.g. postflushes

Note case 1 which existed before, has been no problem since all the
schedulers will check in their finish_request() if the rq has been
inserted or not, like checking "rq->elv.priv[0]".

Then case 2 and case 3 are the introduced regression, we moved the
scheduler finish_request() from free phase to complete phase to solve
a deadlock problem. But it caused no finish_request() for request in
case 2, and double finish_request() for request in case 3.

So we still need finish_request() in blk_mq_free_request() to cover
case 2. And clear RQF_USE_SCHED flag to avoid double finish_request().
It should be fine since we're freeing the request now anyway.

Of course, we can also make all schedulers' finish_request() to clear
"rq->elv.priv[0]" to avoid double finish. Or clear it in blk-mq, make
the rq like not inserted as case 1.

FYI it's easy to reproduce warning in mq-deadline using this:
```
DEV=sdb
echo mq-deadline > /sys/block/$DEV/queue/scheduler
mkfs.ext4 /dev/$DEV
mount /dev/$DEV /mnt
cd /mnt
stress-ng --symlink 4 --timeout 60
echo none > /sys/block/$DEV/queue/scheduler
```

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308172100.8ce4b853-oliver.sang@intel.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a6d59320e034..953f08354c8c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -685,8 +685,15 @@ static void blk_mq_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	if (rq->rq_flags & RQF_USE_SCHED)
+	if (rq->rq_flags & RQF_USE_SCHED) {
 		q->elevator->type->ops.finish_request(rq);
+		/*
+		 * For postflush request that may need to be
+		 * completed twice, we should clear this flag
+		 * to avoid double finish_request() on the rq.
+		 */
+		rq->rq_flags &= ~RQF_USE_SCHED;
+	}
 }
 
 static void __blk_mq_free_request(struct request *rq)
@@ -715,6 +722,8 @@ void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
+	blk_mq_finish_request(rq);
+
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
-- 
2.41.0

