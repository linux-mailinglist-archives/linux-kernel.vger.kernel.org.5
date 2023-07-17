Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE438755A70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGQECA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGQEBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:01:52 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59BEE52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:01:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689566504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhULMMQy5GVi2OU0Ad6+wHzsWWfxFQNSA1oYnzcztlU=;
        b=lPOIEuBY1mU/WbJfF2rw4P8sXiym+C3cSXl0kNPZNRT90H6I/FvAu+UzHTynqe+69gD0KN
        cHfJK3HBQQC6Gh+LnCz5YdMsNCcw114I2TMNiaHhJD7j2R5/C0+sBirkICF2EV7/U3WbSe
        ghsduXyN6K2AawbReid6mQHSJ5U0dcM=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v4 2/4] blk-flush: fix rq->flush.seq for post-flush requests
Date:   Mon, 17 Jul 2023 12:00:56 +0800
Message-ID: <20230717040058.3993930-3-chengming.zhou@linux.dev>
In-Reply-To: <20230717040058.3993930-1-chengming.zhou@linux.dev>
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
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

If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
data sequence and post-flush sequence need to be done for this request.

The rq->flush.seq should record what sequences have been done (or don't
need to be done). So in this case, pre-flush doesn't need to be done,
we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.

Fixes: 615939a2ae73 ("blk-mq: defer to the normal submission path for post-flush requests")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 8220517c2d67..fdc489e0ea16 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -443,7 +443,7 @@ bool blk_insert_flush(struct request *rq)
 		 * the post flush, and then just pass the command on.
 		 */
 		blk_rq_init_flush(rq);
-		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
+		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
 		spin_lock_irq(&fq->mq_flush_lock);
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
 		spin_unlock_irq(&fq->mq_flush_lock);
-- 
2.41.0

