Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660AD80B159
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjLIBS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjLIBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:18:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E76E9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:18:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so24509015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702084710; x=1702689510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFYWeAhDfJi/WLTdfBCo6f4JMRv5USdHJApJmzB/s9w=;
        b=HdPEvMxsYgCXB/zOsMf4AulmTu6cBYeDTdEqYVAfjTmdJIbxkmVM5wfTTNT5K1ns7X
         XhaBo+z3JbnZRy9iLaSEduyAbIMjE7NQLBUoyI4zWv39Rr/obJiAzTEnk5JwDx/gYAGK
         yma5kgIObYyc/E4Wrx7xkfiSUs61F3DCrJsDcDHvQ4ObjXifR97+XpncQllQSAKGZ6qA
         yJQNvitEWqLr0e4k60+ZIch3ye7x9YYg5+bIQf+xqlJESJco9Fbw4dCYRD78U2JwmDcG
         sa+6hSmZDxBpHLeODgkm2qjpYnRfT/MMU00/f2PZcltHNQpMxN9rg4i+dB0SGa31g8Qw
         M1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702084710; x=1702689510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFYWeAhDfJi/WLTdfBCo6f4JMRv5USdHJApJmzB/s9w=;
        b=go/ZUaaHIJzFTBleO1CDJAP3kijqQstsMHjNRCHn3NbnEhlITE2WxBRUrZtybcIa95
         HrdHwNWhvOdqkIxXh3zFFYpzGd75EolsO+GRj4JGocIYV3cMTHD9Dq7abjIq5sahC64J
         nbYNcz++nR3FomoPGtsE8OvHuGLKAoKSoD10atyy0VQfnDefRfgEeyWmC16mZ9nU6sMF
         u8KQzlgvdmvRTdKv5bU5sOXftQjIR6HihKNo2K/wkvoHSWeP0DnY0IDdIvPUUFG6BLGG
         pUGm3QU/2Kgdl+/TMgpEDrFwQzMuTYbMSXxipijf3gngr7wnWKs5DRf7ghYLRGuOihYw
         eHBA==
X-Gm-Message-State: AOJu0YwW7QPRVjfvr8T9DpVj07GPZX6W6MgRFQWaYCBMHhNPIV/oaIuk
        Wc6DSG37M/U9uNXL8XYBLLOlAQ==
X-Google-Smtp-Source: AGHT+IH+bn2jCLPEznmo/Nt/CVTLs6ohZAGpX1bmZKh9FQu4htGMZnuTpDNe4HBwLVSOgK+VRvU8hQ==
X-Received: by 2002:a05:600c:1913:b0:40b:5e21:cc37 with SMTP id j19-20020a05600c191300b0040b5e21cc37mr430703wmq.98.1702084710323;
        Fri, 08 Dec 2023 17:18:30 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm4772125wmq.43.2023.12.08.17.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 17:18:29 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 1/3] sched/fair: Add is_misfit_task() function
Date:   Sat,  9 Dec 2023 01:17:57 +0000
Message-Id: <20231209011759.398021-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209011759.398021-1-qyousef@layalina.io>
References: <20231209011759.398021-1-qyousef@layalina.io>
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

Split it from update_misfit_status(). Use it in detach_tasks() and
update_sg_lb_wakeup_stats().

This should help us generalize misfit lb to handle more than
upmigration.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..eb9e891182cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5063,17 +5063,23 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 }
 
+static inline int is_misfit_task(struct task_struct *p, struct rq *rq)
+{
+	if (!p || p->nr_cpus_allowed == 1)
+		return 0;
+
+	if (task_fits_cpu(p, cpu_of(rq)))
+		return 0;
+
+	return 1;
+}
+
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!p || p->nr_cpus_allowed == 1) {
-		rq->misfit_task_load = 0;
-		return;
-	}
-
-	if (task_fits_cpu(p, cpu_of(rq))) {
+	if (!is_misfit_task(p, rq)) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -9105,7 +9111,7 @@ static int detach_tasks(struct lb_env *env)
 
 		case migrate_misfit:
 			/* This is not a misfit task */
-			if (task_fits_cpu(p, env->src_cpu))
+			if (!is_misfit_task(p, cpu_rq(env->src_cpu)))
 				goto next;
 
 			env->imbalance = 0;
@@ -10207,7 +10213,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		/* Check if task fits in the CPU */
 		if (sd->flags & SD_ASYM_CPUCAPACITY &&
 		    sgs->group_misfit_task_load &&
-		    task_fits_cpu(p, i))
+		    !is_misfit_task(p, rq))
 			sgs->group_misfit_task_load = 0;
 
 	}
-- 
2.34.1

