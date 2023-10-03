Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212807B669D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjJCKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjJCKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C870D3;
        Tue,  3 Oct 2023 03:42:39 -0700 (PDT)
Date:   Tue, 03 Oct 2023 10:42:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696329758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WxE0dPjXVRoqzOKIikXrexpeB8LT3+xgtw9e0GJ98CA=;
        b=PI1VAnl5vXp/p41cdckqyCLKsAZHnORC58uYnD/1x4DUn5TRUYk0BwSTPGajCrS6KDKzHq
        mjr3pegcPsyhfiKvHCIAvs784DsGofxTwXimlxj6vpDkGCc8UEFNJTeea8wTqA8rsw6hGV
        tT/Oa1LxqGQdIu9EInYqnGQngdppKcmq4r8Rik8x8F1lO/DKEBR/7uBxMFfHRo80Rnm88y
        t3Tld6roh+bzaz2gali/D3hv0Pr3H0JZcN3tbEXOzyOBMrtohx4Isj7jW+diwfwHzRDO4j
        65HYUUSfFTwxhNBLGMfjIHcnJiP8aFHtl1ahxcfBvSgWWDnTheJ28jWbh8CVyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696329758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WxE0dPjXVRoqzOKIikXrexpeB8LT3+xgtw9e0GJ98CA=;
        b=DbCMkLaBbmLuSH6+/uwvUGZk0OE1J0UpZ+F8cNEN8OSloOHYbAK2CE/mGWh8PHUCfZRo5Z
        YzzQ2SpGkc71wjBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Fix avg_vruntime()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169632975777.3135.1926466016577986434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     650cad561cce04b62a8c8e0446b685ef171bc3bb
Gitweb:        https://git.kernel.org/tip/650cad561cce04b62a8c8e0446b685ef171bc3bb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Sep 2023 14:29:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Oct 2023 12:32:29 +02:00

sched/eevdf: Fix avg_vruntime()

The expectation is that placing a task at avg_vruntime() makes it
eligible. Turns out there is a corner case where this is not the case.

Specifically, avg_vruntime() relies on the fact that integer division
is a flooring function (eg. it discards the remainder). By this
property the value returned is slightly left of the true average.

However! when the average is a negative (relative to min_vruntime) the
effect is flipped and it becomes a ceil, with the result that the
returned value is just right of the average and thus not eligible.

Fixes: af4cf40470c2 ("sched/fair: Add cfs_rq::avg_vruntime")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d73652..ef7490c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -664,6 +664,10 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
 	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
 }
 
+/*
+ * Specifically: avg_runtime() + 0 must result in entity_eligible() := true
+ * For this to be so, the result of this function must have a left bias.
+ */
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -677,8 +681,12 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		load += weight;
 	}
 
-	if (load)
+	if (load) {
+		/* sign flips effective floor / ceil */
+		if (avg < 0)
+			avg -= (load - 1);
 		avg = div_s64(avg, load);
+	}
 
 	return cfs_rq->min_vruntime + avg;
 }
