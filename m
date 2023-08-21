Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E17835EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjHUWpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjHUWpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:45:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981511C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so10843785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692657935; x=1693262735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTRbCBxMRaYij2kRTYuGmwmVEHPH52LS7r5bTY/h3bA=;
        b=UY+K+BD7c6+P2yUeQVE2TWrcWb/V3Kdcl675gl3k6bqT7wUr0Mkb2/MfvW/yFtQW9i
         tk7nG+P4Vjf5EM7Y+ltswVvjANHzqQ791OcknjDLaTbPzPS1Hbe94aTTFZp8cc8Lo7dy
         sr0crZmJ2xiu+D5Cn4PFgT+dqjy1Lqpcr5tJUWpD+G7fNhAwdeQpJR6U/vwSPwkRJKd0
         QfwJY9P/QrJ5S7Tbe+4Mr5ZKZ9JZPpnKbq3q9xdDwbECfQ8B0G0/2j8mnvbS2vsX+SRt
         n4ZhCilaMZkRFD+TSRagKvDpPkg5LXBm6x6y23w1Fmu/dOgdBoczeRkYYN73B8vlQ06o
         Et2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657935; x=1693262735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTRbCBxMRaYij2kRTYuGmwmVEHPH52LS7r5bTY/h3bA=;
        b=VTXNQy+zQBHKZ0Rg7UfeWyVQZeBlicC9kODSfxisqQuP6emeD9eI9Z65TAq8pGlKTh
         COD5VAU49kStpPemkJZUyVs2AJmUEwzbkvzxipfF68VWJuGn+Rv8ceAScryInvYhPghO
         rYbONagFnMPPlaYC48PB27ux6Qyvl8oJv7zCjQnSj+Ze+8woF5nP6HWc23Oz5+k0GODq
         agtToIQEw9apEEklfafE+HVA2TxfCBQXn8ZwKlHI9f9pjVOgywqAKC2wGE31vRBf/41N
         Q+ERDenrx4OvEqiRvDbipVmwLFIpGU0jQJs3eRvUpbHvEvOU7vBx6aIyzN/ye7E8Q/9v
         DjlQ==
X-Gm-Message-State: AOJu0YwVCzqHsSNK2GN3E4jFkSHWOf6jL+cOX4aifkaEI8jS2hg2cseX
        SbCFYXL6YYLTdh0W71pTa2WJ7A==
X-Google-Smtp-Source: AGHT+IFGmg4UpofLbuyziHiz8PVxC78shmZ9+U/EcscObJzorr4RfANcKioe7Unt4Yi909ii9GwpZg==
X-Received: by 2002:a1c:750a:0:b0:3fe:d1b9:7ea9 with SMTP id o10-20020a1c750a000000b003fed1b97ea9mr6151072wmc.36.1692657935141;
        Mon, 21 Aug 2023 15:45:35 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000100100b0031981c500aasm13820788wrx.25.2023.08.21.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:45:34 -0700 (PDT)
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
Subject: [PATCH v4 3/3] sched/tp: Add new tracepoint to track compute energy computation
Date:   Mon, 21 Aug 2023 23:45:04 +0100
Message-Id: <20230821224504.710576-4-qyousef@layalina.io>
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

It was useful to track feec() placement decision and debug the spare
capacity and optimization issues vs uclamp_max.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/trace/events/sched.h | 5 +++++
 kernel/sched/core.c          | 1 +
 kernel/sched/fair.c          | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..a13d5d06be9d 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -735,6 +735,11 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_compute_energy_tp,
+	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy,
+		 unsigned long max_util, unsigned long busy_time),
+	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848978a0..36c60ad9966a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e19a36e7b433..779c285203e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7604,11 +7604,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 {
 	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
 	unsigned long busy_time = eenv->pd_busy_time;
+	unsigned long energy;
 
 	if (dst_cpu >= 0)
 		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
 
-	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+
+	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
+
+	return energy;
 }
 
 /*
-- 
2.34.1

