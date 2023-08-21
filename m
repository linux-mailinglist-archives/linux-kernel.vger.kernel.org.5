Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AE7826A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjHUJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjHUJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:57:53 -0400
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [IPv6:2001:41d0:203:375::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41874EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:57:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692611867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9OilRxGI20nC45Qzhn26jvVe/s07+OS9kKShML1tRI=;
        b=wW9g+0zD8xkhGCgoG44/Kl2S/T4TCRmzJH8wWm1V8Qucsr1OCG9BiPrdc9QzC9rynMpVKN
        BCARgSaSRDgqWrSviRVOh/rOUG0Wxw7IwbBclL7zCuleeQclKQowEG3AK7B/73aK3LM3WI
        bxpBOg6GNl1OqPQVGtzvuVR2ww5dxyM=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 2/3] blk-mq: delete redundant tagset map update when fallback
Date:   Mon, 21 Aug 2023 17:56:01 +0800
Message-ID: <20230821095602.70742-2-chengming.zhou@linux.dev>
In-Reply-To: <20230821095602.70742-1-chengming.zhou@linux.dev>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
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

When we increase nr_hw_queues fail, the fallback path will use
blk_mq_update_queue_map() to clear and update all maps.
Obviously, this line of update of HCTX_TYPE_DEFAULT only is not
needed, so delete it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8af29a3b1400..8d02bafff331 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4737,7 +4737,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 				__blk_mq_free_map_and_rqs(set, i);
 
 			set->nr_hw_queues = prev_nr_hw_queues;
-			blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 			goto fallback;
 		}
 		blk_mq_map_swqueue(q);
-- 
2.41.0

