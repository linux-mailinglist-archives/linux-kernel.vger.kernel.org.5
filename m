Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071017835ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHUWpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHUWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:45:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90150127
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317f1c480eeso3494515f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692657934; x=1693262734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xo2rDYUn6cFsvHWOIxIDUTC2tCLPno1dd5/kaYQheQ=;
        b=hpORAIsqxPqUvsJDPgUUOgqOOsPITw5aBADc4lzUUA6cBvuQ1KnJZSpigi6sxCz1/E
         RqNgD7q7MM4ub1RwGERZQTkIKt5Haoomb11NxCM0EehP8nPHvZXwHvmGIjPuZqTCp9v2
         HuuzNtMn6JNx3tibw/OKkefawHq13sYcL593U4c/wgWxGBemiCzNG5MksEssYeMSqbez
         fvACtFvQxFVAvLVf5EFejyb+CuaSKFRikv5MSyRDZWDHTvLJTe0UWwC8wNJfEf3/7+5j
         n0Mbg2CSgnO9IBnL8a6+EJovPPOJfxUR5lCFlnRynywifecXONZVV91Z1thS1+IjkB3x
         J97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657934; x=1693262734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xo2rDYUn6cFsvHWOIxIDUTC2tCLPno1dd5/kaYQheQ=;
        b=e3s6xaS1McXgTuQbzULWf7LEKiI1BrlWO+Dq+fXUcDKIaDgCN9JE49gJrbSEQKLet4
         nLHmR4lngNDywE0ZxHvY7PCjM/QGakU0PXp7E9YCRCdNWDLSoc9K9CR2jcnkT5kxoJqC
         nOqrMdtoODnxgf5ot4T0oanGY45yxTxHjkitmTFS+fI2TWS90Lceol3XUtqsmu3NIv4X
         jyUqx9471CVPtfI+LkntanYEvK7lk7AIrjcyKmi6xZMHiwePU+NCO2Qwti2UW06HDPbz
         zdZGDK5PGiS9inyyNKirf6cWR2Da7rQtNv4SrvPft3s0k9BcaFzbfc4A/4ou7lKwXf0i
         dowA==
X-Gm-Message-State: AOJu0Yz5hyA7ITCOi2xiTOWIypQ3E7aZO+kCKw/94iWqqSeiB03/Jsie
        na30vsdjEXHD/HHOcCp06nxoIwDh48koRLqA7Xs=
X-Google-Smtp-Source: AGHT+IFiADB+DiMkzWKI/AzaBSuLw1jBHwy5dMPIUbHPNwTPAd+TEdtZpRSSgEpoh3n8MTMak2gjMQ==
X-Received: by 2002:a05:6000:108f:b0:31a:e728:867d with SMTP id y15-20020a056000108f00b0031ae728867dmr5435065wrw.46.1692657934205;
        Mon, 21 Aug 2023 15:45:34 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000100100b0031981c500aasm13820788wrx.25.2023.08.21.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:45:33 -0700 (PDT)
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
Subject: [PATCH v4 2/3] sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
Date:   Mon, 21 Aug 2023 23:45:03 +0100
Message-Id: <20230821224504.710576-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821224504.710576-1-qyousef@layalina.io>
References: <20230821224504.710576-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5da6538ed220..e19a36e7b433 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4571,22 +4571,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
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
@@ -7699,7 +7683,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p) && p_util_min == 0)
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
-- 
2.34.1

