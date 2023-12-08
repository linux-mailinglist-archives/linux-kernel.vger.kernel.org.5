Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530008098D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572963AbjLHBxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjLHBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:53:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77E172D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:53:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-332c46d5988so1688702f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702000383; x=1702605183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31uCcMHZPgEoDhCw1uvDKEltQSe+mPpn7IW2GIItino=;
        b=vOrvHqgDi0qxb5BdwhAL0mk6P007jCigtoK2GZFaibOEAN8gtKZYPTvoBKP8m3LYik
         fV0yEIAlCCGzrSrVzgaHrZpKgcXt6B+vCIqmhPQhdoa3T/S1bTAARxT8IQpr/nIGkNMV
         skAkL+jzNEkThS0zaOZFpQXiYqqz2y/WyKkDdAM3wHs5lpIDFyy+ymbIJXsLTFNhRFuc
         jM23QQWJwbMtEw41S7mZu/MHrtHVoe8hpu+DdJOQwVpsVALRG6rxGXqJ+hZ3jVhiUHNb
         ZhhkvX+yaFHdlQsxE0OGLFs15p3+tSdg9lAbK+W9s7tauTvDe6bZF/J6lWZXaLzJZDUh
         BuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000383; x=1702605183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31uCcMHZPgEoDhCw1uvDKEltQSe+mPpn7IW2GIItino=;
        b=mzjESjxzF7exJH3iZSzk+f4MAXjvvwzzexA4HwV95PxnSmvTKg/pcJn4DnLKg6Lwct
         hesfki13xOHS2l7GUp5/p0cBrxA9zN87/4WhSRqnHr/ZtYYe18HN5Cb7l9qjIL3yQQtl
         rAyrJ50Vj8E7vt/7lepLALEN5NUlq2xJU4WXctivlWQ9OSUG27T8+5coWUxRhN9kCDwT
         cGWQKePkHZxoQiSza7lC9mpIRB0jqHz8HYUuaI1dhTy+yY8qePJatOCP0i600usQyqeF
         tGxPlsHXChKY+Nvxuv4oxUBLgNC9mlrIOsKvcFtI2Uf0A34JQSRBDDoQQbL+U57tpCUx
         6SDg==
X-Gm-Message-State: AOJu0Yzt0FOkTANFfIGxhBB6qyHzgZw8MNkRcDz5rgYd9c5ALAx9O51A
        8Vdfju/k0MQKgAGzsHWwsy3SBQ==
X-Google-Smtp-Source: AGHT+IG4IUsa7DV15wnNOlcuAvDlFGhKyQFMusK/if39EeqD0F8ohN6cpsYvBkwY1HdsAijqH552LQ==
X-Received: by 2002:adf:e952:0:b0:333:2fd2:5d3d with SMTP id m18-20020adfe952000000b003332fd25d3dmr1899176wrn.111.1702000383066;
        Thu, 07 Dec 2023 17:53:03 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm902521wrb.81.2023.12.07.17.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:53:02 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 4/4] sched/documentation: Remove reference to max aggregation
Date:   Fri,  8 Dec 2023 01:52:42 +0000
Message-Id: <20231208015242.385103-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015242.385103-1-qyousef@layalina.io>
References: <20231208015242.385103-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that max aggregation complexity was removed, update the doc to
reflect the new working design.

And since we fixed one of the limitation, remove it as well.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 Documentation/scheduler/sched-util-clamp.rst | 239 ++++---------------
 1 file changed, 45 insertions(+), 194 deletions(-)

diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
index 74d5b7c6431d..642e5f386f8e 100644
--- a/Documentation/scheduler/sched-util-clamp.rst
+++ b/Documentation/scheduler/sched-util-clamp.rst
@@ -129,172 +129,50 @@ and the scheduler needs to select a suitable CPU for it to run on.
 
 Since the goal of util clamp is to allow requesting a minimum and maximum
 performance point for a task to run on, it must be able to influence the
-frequency selection as well as task placement to be most effective. Both of
-which have implications on the utilization value at CPU runqueue (rq for short)
-level, which brings us to the main design challenge.
-
-When a task wakes up on an rq, the utilization signal of the rq will be
-affected by the uclamp settings of all the tasks enqueued on it. For example if
-a task requests to run at UTIL_MIN = 512, then the util signal of the rq needs
-to respect to this request as well as all other requests from all of the
-enqueued tasks.
-
-To be able to aggregate the util clamp value of all the tasks attached to the
-rq, uclamp must do some housekeeping at every enqueue/dequeue, which is the
-scheduler hot path. Hence care must be taken since any slow down will have
-significant impact on a lot of use cases and could hinder its usability in
-practice.
-
-The way this is handled is by dividing the utilization range into buckets
-(struct uclamp_bucket) which allows us to reduce the search space from every
-task on the rq to only a subset of tasks on the top-most bucket.
-
-When a task is enqueued, the counter in the matching bucket is incremented,
-and on dequeue it is decremented. This makes keeping track of the effective
-uclamp value at rq level a lot easier.
-
-As tasks are enqueued and dequeued, we keep track of the current effective
-uclamp value of the rq. See :ref:`section 2.1 <uclamp-buckets>` for details on
-how this works.
-
-Later at any path that wants to identify the effective uclamp value of the rq,
-it will simply need to read this effective uclamp value of the rq at that exact
-moment of time it needs to take a decision.
+frequency selection as well as task placement to be most effective.
 
 For task placement case, only Energy Aware and Capacity Aware Scheduling
 (EAS/CAS) make use of uclamp for now, which implies that it is applied on
-heterogeneous systems only.
-When a task wakes up, the scheduler will look at the current effective uclamp
-value of every rq and compare it with the potential new value if the task were
-to be enqueued there. Favoring the rq that will end up with the most energy
-efficient combination.
+heterogeneous systems only. When a task wakes up, the scheduler will look at
+the effective uclamp values of the woken task to check if it will fit the
+capacity of the CPU. Favouring the most energy efficient CPU that fits the
+performant request hints. Enabling it to favour a bigger CPU if uclamp_min is
+high even if the utilization of the task is low. Or enable it to run on
+a smaller CPU if UCLAMP_MAX is low, even if the utilization of the task is
+high.
 
 Similarly in schedutil, when it needs to make a frequency update it will look
-at the current effective uclamp value of the rq which is influenced by the set
-of tasks currently enqueued there and select the appropriate frequency that
-will satisfy constraints from requests.
+at the effective uclamp values of the current running task on the rq and select
+the appropriate frequency that will satisfy the performance request hints of
+the task, taking into account the current utilization of the rq.
 
 Other paths like setting overutilization state (which effectively disables EAS)
 make use of uclamp as well. Such cases are considered necessary housekeeping to
 allow the 2 main use cases above and will not be covered in detail here as they
 could change with implementation details.
 
-.. _uclamp-buckets:
+2.1. Frequency hints are applied at context switch
+--------------------------------------------------
 
-2.1. Buckets
-------------
+At context switch, we tell schedutil of the new uclamp values (or min/max perf
+requirments) of the newly RUNNING task. It is up to the governor to try its
+best to honour these requests.
 
-::
-
-                           [struct rq]
-
-  (bottom)                                                    (top)
-
-    0                                                          1024
-    |                                                           |
-    +-----------+-----------+-----------+----   ----+-----------+
-    |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
-    +-----------+-----------+-----------+----   ----+-----------+
-       :           :                                   :
-       +- p0       +- p3                               +- p4
-       :                                               :
-       +- p1                                           +- p5
-       :
-       +- p2
-
-
-.. note::
-  The diagram above is an illustration rather than a true depiction of the
-  internal data structure.
-
-To reduce the search space when trying to decide the effective uclamp value of
-an rq as tasks are enqueued/dequeued, the whole utilization range is divided
-into N buckets where N is configured at compile time by setting
-CONFIG_UCLAMP_BUCKETS_COUNT. By default it is set to 5.
-
-The rq has a bucket for each uclamp_id tunables: [UCLAMP_MIN, UCLAMP_MAX].
-
-The range of each bucket is 1024/N. For example, for the default value of
-5 there will be 5 buckets, each of which will cover the following range:
-
-::
-
-        DELTA = round_closest(1024/5) = 204.8 = 205
-
-        Bucket 0: [0:204]
-        Bucket 1: [205:409]
-        Bucket 2: [410:614]
-        Bucket 3: [615:819]
-        Bucket 4: [820:1024]
-
-When a task p with following tunable parameters
-
-::
-
-        p->uclamp[UCLAMP_MIN] = 300
-        p->uclamp[UCLAMP_MAX] = 1024
-
-is enqueued into the rq, bucket 1 will be incremented for UCLAMP_MIN and bucket
-4 will be incremented for UCLAMP_MAX to reflect the fact the rq has a task in
-this range.
-
-The rq then keeps track of its current effective uclamp value for each
-uclamp_id.
-
-When a task p is enqueued, the rq value changes to:
-
-::
-
-        // update bucket logic goes here
-        rq->uclamp[UCLAMP_MIN] = max(rq->uclamp[UCLAMP_MIN], p->uclamp[UCLAMP_MIN])
-        // repeat for UCLAMP_MAX
+For uclamp to be effective, it is desired to have a hardware with reasonably
+fast DVFS hardware (rate_limit_us is short).
 
-Similarly, when p is dequeued the rq value changes to:
-
-::
-
-        // update bucket logic goes here
-        rq->uclamp[UCLAMP_MIN] = search_top_bucket_for_highest_value()
-        // repeat for UCLAMP_MAX
-
-When all buckets are empty, the rq uclamp values are reset to system defaults.
-See :ref:`section 3.4 <uclamp-default-values>` for details on default values.
+It is believed that most modern hardware (including lower rend ones) has
+rate_limit_us <= 2ms which should be good enough. Having 500us or below would
+be ideal so the hardware can reasonably catch up with each task's performance
+constraints.
 
+Schedutil might ignore the task's performance request if its historical runtime
+has been shorter than the rate_limit_us.
 
-2.2. Max aggregation
---------------------
+See :ref:`Section 5.2 <schedutil-response-time-issues>` for more details on
+schedutil related limitations.
 
-Util clamp is tuned to honour the request for the task that requires the
-highest performance point.
-
-When multiple tasks are attached to the same rq, then util clamp must make sure
-the task that needs the highest performance point gets it even if there's
-another task that doesn't need it or is disallowed from reaching this point.
-
-For example, if there are multiple tasks attached to an rq with the following
-values:
-
-::
-
-        p0->uclamp[UCLAMP_MIN] = 300
-        p0->uclamp[UCLAMP_MAX] = 900
-
-        p1->uclamp[UCLAMP_MIN] = 500
-        p1->uclamp[UCLAMP_MAX] = 500
-
-then assuming both p0 and p1 are enqueued to the same rq, both UCLAMP_MIN
-and UCLAMP_MAX become:
-
-::
-
-        rq->uclamp[UCLAMP_MIN] = max(300, 500) = 500
-        rq->uclamp[UCLAMP_MAX] = max(900, 500) = 900
-
-As we shall see in :ref:`section 5.1 <uclamp-capping-fail>`, this max
-aggregation is the cause of one of limitations when using util clamp, in
-particular for UCLAMP_MAX hint when user space would like to save power.
-
-2.3. Hierarchical aggregation
+2.2. Hierarchical aggregation
 -----------------------------
 
 As stated earlier, util clamp is a property of every task in the system. But
@@ -324,7 +202,7 @@ In other words, this aggregation will not cause an error when a task changes
 its uclamp values, but rather the system may not be able to satisfy requests
 based on those factors.
 
-2.4. Range
+2.3. Range
 ----------
 
 Uclamp performance request has the range of 0 to 1024 inclusive.
@@ -332,6 +210,14 @@ Uclamp performance request has the range of 0 to 1024 inclusive.
 For cgroup interface percentage is used (that is 0 to 100 inclusive).
 Just like other cgroup interfaces, you can use 'max' instead of 100.
 
+2.4. Older design
+-----------------
+
+Older design was behaving differently due what was called max-aggregation rule
+which was adding high complexity and had some limitations. Please consult the
+docs corresponding to your kernel version as part of this doc might reflect how
+it works on your kernel.
+
 .. _uclamp-interfaces:
 
 3. Interfaces
@@ -594,39 +480,7 @@ possible.
 5. Limitations
 ==============
 
-.. _uclamp-capping-fail:
-
-5.1. Capping frequency with uclamp_max fails under certain conditions
----------------------------------------------------------------------
-
-If task p0 is capped to run at 512:
-
-::
-
-        p0->uclamp[UCLAMP_MAX] = 512
-
-and it shares the rq with p1 which is free to run at any performance point:
-
-::
-
-        p1->uclamp[UCLAMP_MAX] = 1024
-
-then due to max aggregation the rq will be allowed to reach max performance
-point:
-
-::
-
-        rq->uclamp[UCLAMP_MAX] = max(512, 1024) = 1024
-
-Assuming both p0 and p1 have UCLAMP_MIN = 0, then the frequency selection for
-the rq will depend on the actual utilization value of the tasks.
-
-If p1 is a small task but p0 is a CPU intensive task, then due to the fact that
-both are running at the same rq, p1 will cause the frequency capping to be left
-from the rq although p1, which is allowed to run at any performance point,
-doesn't actually need to run at that frequency.
-
-5.2. UCLAMP_MAX can break PELT (util_avg) signal
+5.1. UCLAMP_MAX can break PELT (util_avg) signal
 ------------------------------------------------
 
 PELT assumes that frequency will always increase as the signals grow to ensure
@@ -650,10 +504,6 @@ CPU is capable of. The max CPU frequency (Fmax) matters here as well,
 since it designates the shortest computational time to finish the task's
 work on this CPU.
 
-::
-
-        rq->uclamp[UCLAMP_MAX] = 0
-
 If the ratio of Fmax/Fmin is 3, then maximum value will be:
 
 ::
@@ -689,9 +539,8 @@ If task p1 wakes up on this CPU, which have:
         p1->util_avg = 200
         p1->uclamp[UCLAMP_MAX] = 1024
 
-then the effective UCLAMP_MAX for the CPU will be 1024 according to max
-aggregation rule. But since the capped p0 task was running and throttled
-severely, then the rq->util_avg will be:
+Since the capped p0 task was running and throttled severely, then the
+rq->util_avg will be:
 
 ::
 
@@ -699,9 +548,9 @@ severely, then the rq->util_avg will be:
         p1->util_avg = 200
 
         rq->util_avg = 1024
-        rq->uclamp[UCLAMP_MAX] = 1024
 
-Hence lead to a frequency spike since if p0 wasn't throttled we should get:
+Hence lead to a frequency spike when p1 is running. If p0 wasn't throttled we
+should get:
 
 ::
 
@@ -710,9 +559,11 @@ Hence lead to a frequency spike since if p0 wasn't throttled we should get:
 
         rq->util_avg = 500
 
-and run somewhere near mid performance point of that CPU, not the Fmax we get.
+and run somewhere near mid performance point of that CPU, not the Fmax p1 gets.
+
+.. _schedutil_response_time_issues:
 
-5.3. Schedutil response time issues
+5.2. Schedutil response time issues
 -----------------------------------
 
 schedutil has three limitations:
-- 
2.34.1

