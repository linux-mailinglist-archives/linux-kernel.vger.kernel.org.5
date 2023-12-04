Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ADA803FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjLDUgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjLDUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:36:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B66C2D6B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E247C433CD;
        Mon,  4 Dec 2023 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722098;
        bh=utnA4ZmxMlETtUMbXwSY4jNxpOOsInsvF7s/KcfzNhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAOMjfBKK4fws254udE6FcHWyUyRRcLqNhri20RAc5Q6CtXX3dmf/wHdplAZZ02S/
         GfTRcaRH6MhqcY5xqe0rET6cZPUgLY2tPoT85ZQVMc0oYkuzTgfTag85/Jy7/yrAJ1
         QzWqZ7hVno2t1csZQB9hwjIBUPsEQYAt8jwmeD/sKwygptESF1dqn5acJdHd3N090K
         5ea2/7cge4/2RjvA39F6GdkyVRApIeevDTh6WCOBa9HJnvCr8AvH9Bc4D1UUJaA9Ln
         sV7Ag1Y0lApYbm32qTZHrQTimU+G33HL49Tcr4sDOmI3BrtMfBFtQ7y8aZsQXNGr7H
         D9HWhHKYSztSA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        David Jeffery <djeffery@redhat.com>,
        John Pittman <jpittman@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 31/32] blk-mq: don't count completed flush data request as inflight in case of quiesce
Date:   Mon,  4 Dec 2023 15:32:51 -0500
Message-ID: <20231204203317.2092321-31-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 0e4237ae8d159e3d28f3cd83146a46f576ffb586 ]

Request queue quiesce may interrupt flush sequence, and the original request
may have been marked as COMPLETE, but can't get finished because of
queue quiesce.

This way is fine from driver viewpoint, because flush sequence is block
layer concept, and it isn't related with driver.

However, driver(such as dm-rq) can call blk_mq_queue_inflight() to count &
drain inflight requests, then the wait & drain never gets done because
the completed & not-finished flush request is counted as inflight.

Fix this issue by not counting completed flush data request as inflight in
case of quiesce.

Cc: Mike Snitzer <snitzer@kernel.org>
Cc: David Jeffery <djeffery@redhat.com>
Cc: John Pittman <jpittman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231201085605.577730-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6ab7f360ff2ac..20ecd0ab616f7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1511,14 +1511,26 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
+static bool blk_is_flush_data_rq(struct request *rq)
+{
+	return (rq->rq_flags & RQF_FLUSH_SEQ) && !is_flush_rq(rq);
+}
+
 static bool blk_mq_rq_inflight(struct request *rq, void *priv)
 {
 	/*
 	 * If we find a request that isn't idle we know the queue is busy
 	 * as it's checked in the iter.
 	 * Return false to stop the iteration.
+	 *
+	 * In case of queue quiesce, if one flush data request is completed,
+	 * don't count it as inflight given the flush sequence is suspended,
+	 * and the original flush data request is invisible to driver, just
+	 * like other pending requests because of quiesce
 	 */
-	if (blk_mq_request_started(rq)) {
+	if (blk_mq_request_started(rq) && !(blk_queue_quiesced(rq->q) &&
+				blk_is_flush_data_rq(rq) &&
+				blk_mq_request_completed(rq))) {
 		bool *busy = priv;
 
 		*busy = true;
-- 
2.42.0

