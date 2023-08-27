Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8078A371
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjH0XcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjH0XcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:32:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE2B5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so2287168f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179136; x=1693783936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUiAZLE25UP5PNu+kEwnlg+iVrOjDSgPGFYS2eQl6Qk=;
        b=1lYLM9jj8BcntjwJapi8Vs1a7DRwDl9/ZkXfaYc8TeBsAomajDtHaHsi80//pkWlgV
         3qwsTBk+/7iTUhe2/tsHwUSW1gKFeYCekkOEXRaM/KHZGUVrj79GYKHYlgviAfRdAaSe
         zPPHu8x0CfqtcSnYpK1+rTe4V8sTjR/euYZ3/LLQC9A4LLpazdkeltIjC//VPTPe3cz/
         rTdZa+olX7nbsUA+zKk+/JbLOtyb/rm117t3wQqjMZCcMPaFtxrLUvisruFhsGOwNojS
         Kh2leDDoykJ33nPt1HZkRi/NhKsZjfhOToQ4UWZZ6XLNjdFuflEtIJjQs48C1k0cJ4Xl
         03Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179136; x=1693783936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUiAZLE25UP5PNu+kEwnlg+iVrOjDSgPGFYS2eQl6Qk=;
        b=DbcIi4rVYVWX20xCdXqcc2HYprB5rVudVK5reRRm8XAWoRCUk1ERzr2kRDNsBtZHRf
         14rFhFGPugR5FoF8Ef8SZPcfrguheCvwihAIk7ljio8zwV8EApTgSHSBxUjlfdHhqijp
         ghwW9UlK2gReQ6iOYiUifepaN0De68/TCL52bYaDLEVALZsT6taTkmbBuEhaIXdM+MfB
         0Q0dN+OQRRqvyZlwDFOpZOM21VwVVHMdgMOMdLcC1kJL85ApcS6ZlpcHq9/PH6tlAtX6
         99TrjyN7V6xIiJ7te/9/NmUGfrl9OujDW1/N6amF57mGLPSgcz2LBwisDOgneDrO2+Zz
         Je6w==
X-Gm-Message-State: AOJu0YzxgiH8LsEeMDM2FkEr90AF628NZXVxxxGbryKrU2ovt93ovR49
        hQ+RHMZ1kJQ8CXdMubE2X8J5fw==
X-Google-Smtp-Source: AGHT+IGgPBy9e8n3XpdI/QU8N5OZg9NT4gK9vR0sAWjDjSmuMs1dflKI1vrkQPwpTbVkx8My7SAbQg==
X-Received: by 2002:adf:f54a:0:b0:317:597f:3aa6 with SMTP id j10-20020adff54a000000b00317597f3aa6mr20505805wrp.18.1693179135312;
        Sun, 27 Aug 2023 16:32:15 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:14 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 1/7] sched/pelt: Add a new function to approximate the future util_avg value
Date:   Mon, 28 Aug 2023 00:31:57 +0100
Message-Id: <20230827233203.1315953-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given a util_avg value, the new function will return the future one
given a runtime delta.

This will be useful in later patches to help replace some magic margins
with more deterministic behavior.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 22 +++++++++++++++++++++-
 kernel/sched/sched.h |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f310768260c..50322005a0ae 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -466,4 +466,24 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 
 	return ret;
 }
-#endif
+#endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
+
+/*
+ * Approximate the new util_avg value assuming an entity has continued to run
+ * for @delta us.
+ */
+unsigned long approximate_util_avg(unsigned long util, u64 delta)
+{
+	struct sched_avg sa = {
+		.util_sum = util * PELT_MIN_DIVIDER,
+		.util_avg = util,
+	};
+
+	if (unlikely(!delta))
+		return util;
+
+	accumulate_sum(delta, &sa, 0, 0, 1);
+	___update_load_avg(&sa, 0);
+
+	return sa.util_avg;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56eeb5b05b50..5f76b8a75a9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2997,6 +2997,9 @@ enum cpu_util_type {
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 enum cpu_util_type type,
 				 struct task_struct *p);
+
+unsigned long approximate_util_avg(unsigned long util, u64 delta);
+
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
  * continue to grow, which means it could need to run at a higher frequency
-- 
2.34.1

