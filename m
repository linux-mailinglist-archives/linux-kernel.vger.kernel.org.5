Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7BF7AC79A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjIXKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjIXKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:39:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD5103;
        Sun, 24 Sep 2023 03:39:31 -0700 (PDT)
Date:   Sun, 24 Sep 2023 10:39:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695551969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iby/f6knc8Llp2MPydntv2sbevQFn926+/F0Sda8m1Q=;
        b=Ozdq1/cJ2kfFwdGuIEqvE+EyoBmvc3BT5jLZM5Y6GH5o/72a/BYcOMqYvQ253WL0vHq6hb
        eM5DrvbwLLaSNRLwRdAFgYS/RQxka4FkFRt1BrYnKS46IAqJx/blgd1CxQi1cu5fFDi8xH
        UkRLLrAznXfJn/TEZHoBWVJjDlQbM7V4NXYM+U0wX8EvFqaCikK+AMg4pvHdG7KfH2gSsO
        XQ4UwbSFK0d50htezJp6A14LfPNllFsoSs9gSmuaFHTHJJyUnne7t7Jd7V3+8kHPPI2ZaJ
        xYVo0Fr1cQzE0Ia2U65jRJFnRokqiROcC7jf/OaPj/CZz69V97qBHpTVWoGXYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695551969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iby/f6knc8Llp2MPydntv2sbevQFn926+/F0Sda8m1Q=;
        b=lU7s/0/QSNIk8bB+Wp9BHKeAPQHKhXRoG8C+HOK7uYcjEk3gPw/wixVRiWl08TmzafB9yy
        VhHN2Kjx5ZIqGHCw==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make cfs_rq->throttled_csd_list
 available on !SMP
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922230535.296350-1-joshdon@google.com>
References: <20230922230535.296350-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <169555196901.27769.4146483684793646610.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     30797bce8ef0c73f0c388148ffac92458533b10e
Gitweb:        https://git.kernel.org/tip/30797bce8ef0c73f0c388148ffac92458533b10e
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Fri, 22 Sep 2023 16:05:34 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 12:08:28 +02:00

sched/fair: Make cfs_rq->throttled_csd_list available on !SMP

This makes the following patch cleaner by avoiding extra CONFIG_SMP
conditionals on the availability of rq->throttled_csd_list.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230922230535.296350-1-joshdon@google.com
---
 kernel/sched/fair.c  | 4 ----
 kernel/sched/sched.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7572000..41c960e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5763,11 +5763,9 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
-#ifdef CONFIG_SMP
 		/* Already queued for async unthrottle */
 		if (!list_empty(&cfs_rq->throttled_csd_list))
 			goto next;
-#endif
 
 		/* By the above checks, this should never be true */
 		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
@@ -6134,9 +6132,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
-#ifdef CONFIG_SMP
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
-#endif
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9260120..96f8ab7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -634,9 +634,7 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
-#ifdef CONFIG_SMP
 	struct list_head	throttled_csd_list;
-#endif
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
