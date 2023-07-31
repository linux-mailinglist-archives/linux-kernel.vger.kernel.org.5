Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5537D7692FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjGaKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjGaKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:20:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C063173D;
        Mon, 31 Jul 2023 03:19:49 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsRNsjRfTmn24aGFtC3YGXjM0MgO+nfS6Z39o8zwtlQ=;
        b=M5VNR6GDdDVgNHgIHq2nRSCW9cH/hoap5+ZT7X4r04coB3h9E8A5JYt7RpsDVJ/AfUYh8i
        WuJRV4o8bkR4wjWW+kscSs2mwKPiGEVqrVe2VohkDlYf5hF3wPHr5GJ/3gDW2s2cob3Pkz
        8ZfXIo4pst1KNKagJkxHkY1QefVo5YISwO/i1Rupcq4g6HE2tIBe6XliC7Pm8nGBfBvfcK
        iCdcR1kfCPwJDjEDYo/j9BjU2Nm21w2KTOhx7KT9ZOrKF2i7jzLwsSQrgDlzZZm3zn2YQ/
        m8SkBYeRIHmqFvscFUqAIKRnhLqmp8IPuQVflSEALbE9Ih0kt6SqssHdvJwMdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsRNsjRfTmn24aGFtC3YGXjM0MgO+nfS6Z39o8zwtlQ=;
        b=oFzMs+pAY8xrvxelmyhz3LapbJAozYWn+qv3NgbzKdRdvE8jvxYjXYLP4TPYxQpO1y9FI4
        3MROx4jyMpyewWBg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: remove util_est boosting
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230706135144.324311-1-vincent.guittot@linaro.org>
References: <20230706135144.324311-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <169079878708.28540.11161051369114712527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c2e164ac33f75e0acb93004960c73bd9166d3d35
Gitweb:        https://git.kernel.org/tip/c2e164ac33f75e0acb93004960c73bd9166d3d35
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 06 Jul 2023 15:51:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:50 +02:00

sched/fair: remove util_est boosting

There is no need to use runnable_avg when estimating util_est and that
even generates wrong behavior because one includes blocked tasks whereas
the other one doesn't. This can lead to accounting twice the waking task p,
once with the blocked runnable_avg and another one when adding its
util_est.

cpu's runnable_avg is already used when computing util_avg which is then
compared with util_est.

In some situation, feec will not select prev_cpu but another one on the
same performance domain because of higher max_util

Fixes: 7d0583cf9ec7 ("sched/fair, cpufreq: Introduce 'runnable boosting'")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20230706135144.324311-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3df5b1..f55b0a7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7320,9 +7320,6 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
 
-		if (boost)
-			util_est = max(util_est, runnable);
-
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
 		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
