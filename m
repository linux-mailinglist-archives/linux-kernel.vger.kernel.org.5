Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E5756F34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGQV5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGQV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:57:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFBFE4C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so31609945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689631056; x=1692223056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnEU7IyPXcZt92+8oUCYiT+upo6fdJ63NnSG75EIHJo=;
        b=sWpR9vlwo4Vjsmd/o4NAYCuZ967dRZ9yiQRE4cVUO5bp1VMmgBmDoND0iXLoyvJJqX
         UqHtLfK7LFDtJ7VR/WiXySJOKb+Kl4E1ruINwrQwG6sOPQBgUhyOeDYaOLcT0kNJ8KFB
         h6xdjA37+r+hydQ9KqUZJ0bbC6amDSVqb9uycdYc+jRzhVB+pclfa8t/pHVdTbDQFCs/
         CfDfU466bd009AdWslJtR5pVUVjk5UBir55HIqXmYCAfwG+/ygvgv9M0dzoP/4lMxkcH
         Mmz/btk64wkHp3WCWhwmXa18R261N7pFw/oJypM/cfG4pFFWUkr4qmWdULlwgiBQbGCx
         giVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689631056; x=1692223056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnEU7IyPXcZt92+8oUCYiT+upo6fdJ63NnSG75EIHJo=;
        b=QWPqHsWHUtwNUKFCagr9WxR0GGWeg3b7ChfAKnTm9RNOy9uL6OWLHb1nxUm0asokxg
         SJ+0DX2YmQd0lx+3qd1zJl2UjfziOvnUzeZismcvjiZmXyxfUxWV/rLN1nZcesfVfgY2
         uU606XPcGKobchxWXus5mv6e1P9zQ/FyLFt5+bovJ2LE+m/LiNJtYpzYHl7RB7TJdnyR
         B+QzIe/tGK5MDL4qllBX43rAOUm4UJfWm+ja1sx2LsxqV/hnlMs9xyrx+ZxYaishYDkj
         ccKr8AHjUkTbzM7XnYslTPkE6bUA7MhAGGL8Op9K+/0HD5xi500xkO/cEo+McYeYTOFN
         LGmA==
X-Gm-Message-State: ABy/qLYAgsm+W3FHXJFn0bUwdEHKKGo9sA4Ch2qucdTxQhTFmYdSIE5I
        pUkXQynaZyL3Fvr4rwYwmuWqSg==
X-Google-Smtp-Source: APBJJlHlEKhbOU+MWBX8IaREz4d9Dl4JzeGAI5jS1ox5TLtlX382zFGNHBX7vBeqO53d4ZTVw6QQXA==
X-Received: by 2002:a05:600c:54c3:b0:3f9:68f:9c1a with SMTP id iw3-20020a05600c54c300b003f9068f9c1amr359377wmb.15.1689631056310;
        Mon, 17 Jul 2023 14:57:36 -0700 (PDT)
Received: from localhost.localdomain (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fbaa2903f4sm671285wmc.19.2023.07.17.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:57:36 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 2/3] sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
Date:   Mon, 17 Jul 2023 22:57:16 +0100
Message-Id: <20230717215717.309174-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717215717.309174-1-qyousef@layalina.io>
References: <20230717215717.309174-1-qyousef@layalina.io>
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

find_energy_efficient_cpu() bails out early if effective util of the
task is 0 as the delta at this point will be zero and there's nothing
for EAS to do. When uclamp is being used, this could lead to wrong
decisions when uclamp_max is set to 0. In this case the task is capped
to performance point 0, but it is actually running and consuming energy
and we can benefit from EAS energy calculations.

Rework the condition so that it bails out for when util is actually 0 or
uclamp_min is requesting a higher performance point.

We can do that without needing to use uclamp_task_util(); remove it.

Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d489eece5a0d..c701f490ca4c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4348,22 +4348,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
-#ifdef CONFIG_UCLAMP_TASK
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return clamp(task_util_est(p), uclamp_min, uclamp_max);
-}
-#else
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return task_util_est(p);
-}
-#endif
-
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -7588,7 +7572,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p) && p_util_min == 0)
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
-- 
2.25.1

