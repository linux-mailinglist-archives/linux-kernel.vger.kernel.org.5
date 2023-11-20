Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9B7F0CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjKTHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:38:56 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3EB4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:38:51 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3AK7cQLe038238;
        Mon, 20 Nov 2023 15:38:26 +0800 (+08)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SYfPK4SPKz2K7tXg;
        Mon, 20 Nov 2023 15:33:09 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 20 Nov 2023 15:38:24 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [PATCH] sched/eevdf: Avoid NULL in pick_eevdf
Date:   Mon, 20 Nov 2023 15:38:21 +0800
Message-ID: <20231120073821.1304-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.73]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 3AK7cQLe038238
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now in pick_eevdf function, add the pick_first_entity to prevent
picking null when using eevdf, however, the leftmost may be null.
As a result, it would cause oops because the se is NULL.

Fix this by compare the curr and left, if the left is null, set
the se be curr.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..10916f6778ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -951,12 +951,28 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
 	return NULL;
 }
 
+/* Just simply choose the se with the smallest vruntime */
+static struct sched_entity *__pick_cfs(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *left = __pick_first_entity(cfs_rq);
+
+	/*
+	 * If curr is set we have to see if its left of the leftmost entity
+	 * still in the tree, provided there was anything in the tree at all.
+	 */
+	if (!left || (curr && entity_before(curr, left)))
+		left = curr;
+
+	return left;
+}
+
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *se = __pick_eevdf(cfs_rq);
 
 	if (!se) {
-		struct sched_entity *left = __pick_first_entity(cfs_rq);
+		struct sched_entity *left = __pick_cfs(cfs_rq);
 		if (left) {
 			pr_err("EEVDF scheduling fail, picking leftmost\n");
 			return left;
-- 
2.25.1

