Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0976E688
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjHCLOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjHCLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:14:46 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77E9B;
        Thu,  3 Aug 2023 04:14:43 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 373BEBdF048295;
        Thu, 3 Aug 2023 19:14:11 +0800 (+08)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RGmQf3WpJz2Nwpsg;
        Thu,  3 Aug 2023 19:12:26 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 3 Aug 2023 19:14:09 +0800
From:   Zhiguo Niu <zhiguo.niu@unisoc.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>,
        <hongyu.jin@unisoc.com>, <yunlong.xing@unisoc.com>
Subject: [PATCH] block/mq-deadline: use correct way to throttling write requests
Date:   Thu, 3 Aug 2023 19:12:42 +0800
Message-ID: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 373BEBdF048295
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original formula was inaccurate:
dd->async_depth = max(1UL, 3 * q->nr_requests / 4);

For write requests, when we assign a tags from sched_tags,
data->shallow_depth will be passed to sbitmap_find_bit,
see the following code:

nr = sbitmap_find_bit_in_word(&sb->map[index],
			min_t (unsigned int,
			__map_depth(sb, index),
			depth),
			alloc_hint, wrap);

The smaller of data->shallow_depth and __map_depth(sb, index)
will be used as the maximum range when allocating bits.

For a mmc device (one hw queue, deadline I/O scheduler):
q->nr_requests = sched_tags = 128, so according to the previous
calculation method, dd->async_depth = data->shallow_depth = 96,
and the platform is 64bits with 8 cpus, sched_tags.bitmap_tags.sb.shift=5,
sb.maps[]=32/32/32/32, 32 is smaller than 96, whether it is a read or
a write I/O, tags can be allocated to the maximum range each time,
which has not throttling effect.

In addition, refer to the methods of bfg/kyber I/O scheduler,
limit ratiois are calculated base on sched_tags.bitmap_tags.sb.shift.

This patch can throttle write requests really.

Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

---
 block/mq-deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5839a027e0f0..7e043d4a78f8 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -620,8 +620,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
+	unsigned int shift = tags->bitmap_tags.sb.shift;
 
-	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
+	dd->async_depth = max(1U, 3 * (1U << shift)  / 4);
 
 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
 }
-- 
2.37.3

