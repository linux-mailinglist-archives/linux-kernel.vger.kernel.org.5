Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED8754D11
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 03:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjGPBmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 21:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGPBmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:42:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C426B6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 18:42:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so49536251fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689471748; x=1692063748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8lHu+9aTKEHsLqATnFWjg+0GsO2SOZlCCuELJGI+s=;
        b=AJcDIt4BpVuvCKPiOHKI2v9J53LnqJTBBaBorsrPes+1X96Os+TGgWVyO/OEa5F7rp
         dJ4PRX6YqlJ9JHvBVAnSzLB5dnfvWS61qFhUTQBbPmAI5V+3mCf7w0MbzbOtIC+41SAW
         kGetuWg4F4lMmgmK6O9I/GN1BHeFhXECYC5Ih/uR2mAT/F7h+IX741Qd/ubmVOUso7gT
         znDGCdpzLAA9aKAzdyEkpNowXQ4tFk7zHi+Hpb9w1oyglJD1eShFUVX9cGaYe1oE9Jrb
         ukxMWXOD7dDxSD2v1DlkfgfZmPT23pCBnfcxOpk+Mwtg3ZuRYgBnPFdgcDk7EX2MglID
         Jfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689471748; x=1692063748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vy8lHu+9aTKEHsLqATnFWjg+0GsO2SOZlCCuELJGI+s=;
        b=GK3vs6CEuOCqTXEfccO0qi81OgeYB6BrLiWa0mBSq3GrGbd5JGaHFtvZ50ScFcSLFJ
         U+v4zBAm6tsxjLw8MGBnjwy1gogG2yBtgcj7QAWj2bceYXfjqiZWvl1xLIEn+c8wqQx3
         M0w3w9pHngcrVOUU79MY24tVMIFsTTFnR0rYtM5j7KWnTKzcrgN9R/bwnIFfq9jG7lXq
         Gr42SUv416HOCkhFXwHSdABFk8a8MxOMHBjjEumtP1UaMsFMOFwUC9p5fcKs4U5c9f4B
         UOybSqOtskfe1z+oJtSuXl5ajma+Xti+romXoa9PblACs0HB/5FfdVF+P3S0vRHn+W6w
         +3ow==
X-Gm-Message-State: ABy/qLYiO0V3Hn9q5aS67H0PCc8szq5HDP4tN077tYiuUHRxG8Ny4/o9
        aodjVzT7NLTYKa0qIR8UuSyGNA==
X-Google-Smtp-Source: APBJJlEL5lB9/VY3sgL1r1fT/jKXqhC3SV7cNe0+T3IvdhZw9pXqBaAPuFyegIy/GMLBPVZKTbQoUA==
X-Received: by 2002:a2e:8753:0:b0:2b8:3ac9:e201 with SMTP id q19-20020a2e8753000000b002b83ac9e201mr4107846ljj.40.1689471747923;
        Sat, 15 Jul 2023 18:42:27 -0700 (PDT)
Received: from localhost.localdomain (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c214900b003fbc9371193sm4751856wml.13.2023.07.15.18.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 18:42:27 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in load balance
Date:   Sun, 16 Jul 2023 02:41:25 +0100
Message-Id: <20230716014125.139577-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen cases while running geekbench that an idle little core never
pulls a task from a bigger overloaded cluster for 100s of ms and
sometimes over a second.

It turned out that the load balance identifies this as a migrate_util
type since the local group (little cluster) has a spare capacity and
will try to pull a task. But the little cluster capacity is very small
nowadays (around 200 or less) and if two busy tasks are stuck on a mid
core which has a capacity of over 700, this means the util of each tasks
will be around 350+ range. Which is always bigger than the spare
capacity of the little group with a single idle core.

When trying to detach_tasks() we bail out then because of the comparison
of:

	if (util > env->imbalance)
		goto next;

In calculate_imbalance() we convert a migrate_util into migrate_task
type if the CPU trying to do the pull is idle. But we only do this if
env->imbalance is 0; which I can't understand. AFAICT env->imbalance
contains the local group's spare capacity. If it is 0, this means it's
fully busy.

Removing this condition fixes the problem, but since I can't fully
understand why it checks for 0, sending this as RFC. It could be a typo
and meant to check for

	env->imbalance != 0

instead?

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..682d9d6a8691 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10288,7 +10288,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * waiting task in this overloaded busiest group. Let's
 			 * try to pull it.
 			 */
-			if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
+			if (env->idle != CPU_NOT_IDLE) {
 				env->migration_type = migrate_task;
 				env->imbalance = 1;
 			}
-- 
2.25.1

