Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B4880112F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378394AbjLAQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378341AbjLAQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:16:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B171724
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:17:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332ddd8e0bdso2238415f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701447421; x=1702052221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSKzabyf617fM1KjEqCfZfHlIw32BDDg2adJnGl6QJ8=;
        b=DQ3YFnHounWAqRoT31a5f8sVryNO0uLYEC2wE8ZUzQOYOPszbJfX/sqHsyoEhw4tOp
         pl/JcCzJZfhLx8yy0SQKRx3bKjmPYFW7gUr9skm+xEMYbAeUTp9fQo5ViDq64Ga1kVaT
         mLx9kY/PWRB/IoPUQZV16xa9OYNbsT9XGakS2jxDpNJ7991GKHlcRfjLG00N7inK3O6k
         RL8Z4zxOMljn++e1LEnOPkbCTOQRK1PrD/xtWIeKb+L6irEEDz/6B+Ya9MiQ800fRQSQ
         LqlTDpFk8n+bUCj6djNyiUzE+Na5dHYVIuO6I5lk7d0RNPso5C9QODkdIcCSmS5TLPMk
         Mb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447421; x=1702052221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSKzabyf617fM1KjEqCfZfHlIw32BDDg2adJnGl6QJ8=;
        b=uCBdc89554O/tXN3R8PjkRSSIo7znpKtJNFA+RCkzkM9mrtx6nXc8Gg/cT4x6+ZZdy
         FLMQ/+vOUBfbQrGmAMOaMIG5cA6lLtEONFmRGum0vnpPnhYDQjgH2DHLAywLYNvEGQ+n
         5HREKZA+aB1Y20BsXiXiBoffY64bLbkeyvE8nzpDapIOOr6o8EVwDkzyG6Fq5S+Kgqwm
         kzbq+WdL02UvlKvEaj2wN4sQCUnotQXjg+zjI8+6clyjzLxqLbsg4rbZD4KPgNikYDJ4
         UrfZgGd9Abou3EBiieDdUchu/GgmNYbMFmRFH8wGB+nGUFFd4cpnR3miJ6tQUjGF9C9d
         4nVQ==
X-Gm-Message-State: AOJu0YxbmQaV9cLkfJt9TEWmreYTW3v/6HtaMJ7mRn7RUg1B9737XWkE
        pz0R/ceYeLP61zxmGM/ynFZ/wg==
X-Google-Smtp-Source: AGHT+IHjqFYkByXc9Gb3pcb1OogPS3f1+e4xDX/ps+5Ye1VAGcstpN9qt433fzLCKLTPnd9WoPHO1g==
X-Received: by 2002:a05:600c:1615:b0:40b:5e56:7b5c with SMTP id m21-20020a05600c161500b0040b5e567b5cmr764423wmn.165.1701447420729;
        Fri, 01 Dec 2023 08:17:00 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:6db5:f04:fbd5:88e1])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003feae747ff2sm9591398wms.35.2023.12.01.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:16:58 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com, yizhou.tang@shopee.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/2] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
Date:   Fri,  1 Dec 2023 17:16:51 +0100
Message-Id: <20231201161652.1241695-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201161652.1241695-1-vincent.guittot@linaro.org>
References: <20231201161652.1241695-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_feat(UTIL_EST_FASTUP) has been added to easily disable the feature
in order to check for possibly related regressions. After 3 years, it has
never been used and no regression has been reported. Let remove it
and make fast increase a permanent behavior.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/scheduler/schedutil.rst                    | 7 +++----
 Documentation/translations/zh_CN/scheduler/schedutil.rst | 7 +++----
 kernel/sched/fair.c                                      | 8 +++-----
 kernel/sched/features.h                                  | 1 -
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/Documentation/scheduler/schedutil.rst b/Documentation/scheduler/schedutil.rst
index 32c7d69fc86c..803fba8fc714 100644
--- a/Documentation/scheduler/schedutil.rst
+++ b/Documentation/scheduler/schedutil.rst
@@ -90,8 +90,8 @@ For more detail see:
  - Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"
 
 
-UTIL_EST / UTIL_EST_FASTUP
-==========================
+UTIL_EST
+========
 
 Because periodic tasks have their averages decayed while they sleep, even
 though when running their expected utilization will be the same, they suffer a
@@ -99,8 +99,7 @@ though when running their expected utilization will be the same, they suffer a
 
 To alleviate this (a default enabled option) UTIL_EST drives an Infinite
 Impulse Response (IIR) EWMA with the 'running' value on dequeue -- when it is
-highest. A further default enabled option UTIL_EST_FASTUP modifies the IIR
-filter to instantly increase and only decay on decrease.
+highest. UTIL_EST filters to instantly increase and only decay on decrease.
 
 A further runqueue wide sum (of runnable tasks) is maintained of:
 
diff --git a/Documentation/translations/zh_CN/scheduler/schedutil.rst b/Documentation/translations/zh_CN/scheduler/schedutil.rst
index d1ea68007520..7c8d87f21c42 100644
--- a/Documentation/translations/zh_CN/scheduler/schedutil.rst
+++ b/Documentation/translations/zh_CN/scheduler/schedutil.rst
@@ -89,16 +89,15 @@ r_cpu被定义为当前CPU的最高性能水平与系统中任何其它CPU的最
  - Documentation/translations/zh_CN/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"
 
 
-UTIL_EST / UTIL_EST_FASTUP
-==========================
+UTIL_EST
+========
 
 由于周期性任务的平均数在睡眠时会衰减，而在运行时其预期利用率会和睡眠前相同，
 因此它们在再次运行后会面临（DVFS）的上涨。
 
 为了缓解这个问题，（一个默认使能的编译选项）UTIL_EST驱动一个无限脉冲响应
 （Infinite Impulse Response，IIR）的EWMA，“运行”值在出队时是最高的。
-另一个默认使能的编译选项UTIL_EST_FASTUP修改了IIR滤波器，使其允许立即增加，
-仅在利用率下降时衰减。
+UTIL_EST滤波使其在遇到更高值时立刻增加，而遇到低值时会缓慢衰减。
 
 进一步，运行队列的（可运行任务的）利用率之和由下式计算：
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..e94d65da8d66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4870,11 +4870,9 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * to smooth utilization decreases.
 	 */
 	ue.enqueued = task_util(p);
-	if (sched_feat(UTIL_EST_FASTUP)) {
-		if (ue.ewma < ue.enqueued) {
-			ue.ewma = ue.enqueued;
-			goto done;
-		}
+	if (ue.ewma < ue.enqueued) {
+		ue.ewma = ue.enqueued;
+		goto done;
 	}
 
 	/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3ddf84de430..143f55df890b 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,7 +83,6 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
-SCHED_FEAT(UTIL_EST_FASTUP, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
 
-- 
2.34.1

