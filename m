Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817876FAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjHDHGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjHDHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:06:47 -0400
Received: from out-90.mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD621724;
        Fri,  4 Aug 2023 00:06:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691132804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N+PDNOldMLpWe69wkWNroeRQ0YSGNugCwYgD/y+ooro=;
        b=wWYdynmWr8j2Zpj7xMyOAs3ezXwF7tkwWlomyVRAePrtrisQ9F1QoabhoFgJiY2j1udwyP
        YjkEZ127YkooBA7JmZZVq+cy9rtCJLeEdG5gnmzrq/dxIwl+TGD24r+BppOHvGctzkLEnC
        S3lZWg0en8KKb6y+Rr3NBbobqsJqMWQ=
From:   chengming.zhou@linux.dev
To:     tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-iocost: fix queue stats accounting
Date:   Fri,  4 Aug 2023 15:06:09 +0800
Message-ID: <20230804070609.31623-1-chengming.zhou@linux.dev>
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

The q->stats->accounting is not only used by iocost, but iocost only
increase this counter, never decrease it. So queue stats accounting
will always enabled after using iocost once.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index dd64e2066f01..089fcb9cfce3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3301,11 +3301,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (qos[QOS_MIN] > qos[QOS_MAX])
 		goto einval;
 
-	if (enable) {
+	if (enable && !ioc->enabled) {
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
-	} else {
+	} else if (!enable && ioc->enabled) {
+		blk_stat_disable_accounting(disk->queue);
 		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
 	}
-- 
2.41.0

