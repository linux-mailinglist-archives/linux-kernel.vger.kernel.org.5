Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88937A3363
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjIPXaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 19:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjIPXaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 19:30:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211ACD3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-402d499580dso36058615e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694907011; x=1695511811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjwrFheoCHUo12B1slBH8742esS72cLDk94QJ+87wIg=;
        b=JKqcgBNEEnaF+XBWVoJMf8mIPlL7G+jVMkGzgxujVdgHdO/jsehHsNxNN8secWe1cs
         bDt7+o4/0Ar9atEk9TZcXdLzZ26qauMTXlVbZtYusOJ1iqjftmv4kjqaZsXWPUGtJcFT
         hrexe+Y3ERRf2MUfw+7UQFI1oDjGflYarO8fweO0yrYaenoqmTkpsXf/ph8+QioansRn
         1wSCJKfW5Du1jpzGzhSdlaUtWFUTW8caf7D7rE+Qdk9pbIx8ujA9tm4QbK2A5Kh5+Pj5
         YOT/BUh1D9zlZaOa2i80q7W1cLvKhHbub0zq7S1oIRhZhOtMCvqezd+BL0Qik5rsqtPh
         Zfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694907011; x=1695511811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjwrFheoCHUo12B1slBH8742esS72cLDk94QJ+87wIg=;
        b=SpRiy356ZmaMVPFq/sOzEuCQ9Wi+nPHWx3sdNfwo9CfMo9Q4dcpzbIVNED1/d6Zjt/
         Eym/NYory/v4J0KQmW7L+VhmW+v+hb1EKz7MAP6ZBnBJ4UaasMhLBzUXdlcivlj5sOMT
         QukAaOou8LFgaNhBk12PDy3RKS9nKoRicL2iSNUACIlZP3uB8+CPD+aZBQt/U5PYnKOy
         SaRBisrirbNobFaWd/K7kOCd0dPGXfBXxRQK0U1qflr0nMCt0kCfiQBopMJLkXCHyWhM
         ICnBvULf9D8OXyAecboNZ/AJRhcIX9wU87aiWyWC34vE6FX/Mfj42kWQraEwcQRubxdO
         hDyw==
X-Gm-Message-State: AOJu0YyUWWPUjfW9XaYf94O/5SAEwk6Xqf4++fV34RhnLGxdF3engYdE
        +f0Wpe4ntwT7SdVrhEDmb0Uy/g==
X-Google-Smtp-Source: AGHT+IHcvSC6ERLy719iC4PnIU38X71EJ3HBoioZJ4M+rvOghzBOC7h+3/wgDHTMGbZ50FrPzUXOyA==
X-Received: by 2002:a05:600c:2055:b0:3fb:efe2:34a2 with SMTP id p21-20020a05600c205500b003fbefe234a2mr4568815wmg.5.1694907011584;
        Sat, 16 Sep 2023 16:30:11 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm11203929wmi.18.2023.09.16.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 16:30:11 -0700 (PDT)
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
Subject: [PATCH v5 2/3] sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
Date:   Sun, 17 Sep 2023 00:29:54 +0100
Message-Id: <20230916232955.2099394-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916232955.2099394-1-qyousef@layalina.io>
References: <20230916232955.2099394-1-qyousef@layalina.io>
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

Rework the condition so that it bails out when both util and uclamp_min
are 0.

We can do that without needing to use uclamp_task_util(); remove it.

Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a0a28a0b9c7..0d0582e02409 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4560,22 +4560,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
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
@@ -7687,7 +7671,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p) && p_util_min == 0)
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
-- 
2.34.1

