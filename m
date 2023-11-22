Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCCE7F486E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbjKVOBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbjKVOB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:01:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D744BD4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:01:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso529128f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700661683; x=1701266483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hD1zFhwekBASv0LVRn3WfLSmlJjau+U8Wq2CF3q/Fo0=;
        b=lAaxW2LirPJu+NuMjl0SIZYxsdaE1a/F9i0gFTWs75ufBnqG6UREbNDyMKyHTW9UW8
         5dG0VgHDCFwxbXAyHFmP9eDnxp8KoBXSVOdtWtRt6d2Pd/n4TmlJuLUBiOY0ue60x3K1
         0ROWmoaQqH3IDsXjBfWxsuXBAquZt2e1eJDFHgoXrzYnm59Gm8qjtN4lbF3TqGyqJJTu
         ScYQmGj6o9zABwz7P+DH5jlPmeV6cRPANC9AzDRj/Mnmj1uInaPCsiHyqKAcmyUA/HnG
         VZ+GsnHoiSuAaOGO4zSqMTinTTKhPIyPrR2OjnXGxaq2eWAjccJYRs2kFUGJ+GGg2kDD
         PqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661683; x=1701266483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD1zFhwekBASv0LVRn3WfLSmlJjau+U8Wq2CF3q/Fo0=;
        b=Ft4zVfHMxEuvNBLBQTypkKeNVpNmoc1XJwGzQF1Fx2ST7zadVHvSfJg/WDNWJZrja7
         c2310FowneTvxOeBAWo36rCXix6p/FbabtoKTCfxNc0/K0TqXVTTfRkbfVR9axyEwCD/
         4fUfMj5kzTu8YTmmc422DAZPpYpHN+GT1FlKWn0pQA0k+0YlHyB/mId5HHCjqq3JQhZx
         snGJ57DFtnqQdRjD98ghvEfl3Y+vlW/75CZq4tN7Jg/RPCNMBHMFK5Xnx1HlplhZSibh
         gBKF9SG6qWY5Z9qUlUEwxPUTk3hk6hg5KeZI9OGhSGFP19ESKdVR6upEu2wIjnhjg8AW
         9r/Q==
X-Gm-Message-State: AOJu0Yz4sjIiOWXyTaptp2n7Zop07H5bSez+rrwrQ0D9IR893ukEySnb
        2doOYmMppXm0gUnavXaWGaALJg==
X-Google-Smtp-Source: AGHT+IF1WdpNgUZP3fGLF0q/5JfKa+9xX/YJ7NdWshlU73MgaUNxlnFDUGTXxuNTIlZgO67jFa8hHw==
X-Received: by 2002:a05:6000:1aca:b0:32d:d4c5:272b with SMTP id i10-20020a0560001aca00b0032dd4c5272bmr2461824wry.26.1700661683074;
        Wed, 22 Nov 2023 06:01:23 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:3a2e:a7f5:93e6:508b])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b003317796e0e3sm13283423wrr.65.2023.11.22.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:01:22 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: avoid underestimate of task utilization
Date:   Wed, 22 Nov 2023 15:01:19 +0100
Message-Id: <20231122140119.472110-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported that thread's util_est can significantly decrease as
a result of sharing the CPU with other threads. The use case can be easily
reproduced with a periodic task TA that runs 1ms and sleeps 100us.
When the task is alone on the CPU, its max utilization and its util_est is
around 888. If another similar task starts to run on the same CPU, TA will
have to share the CPU runtime and its maximum utilization will decrease
around half the CPU capacity (512) then TA's util_est will follow this new
maximum trend which is only the result of sharing the CPU with others
tasks. Such situation can be detected with runnable_avg wich is close or
equal to util_avg when TA is alone but increases above util_avg when TA
shares the CPU with other threads and wait on the runqueue.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

This patch implements what I mentioned in [1]. I have been able to
reproduce such pattern with rt-app.

[1] https://lore.kernel.org/lkml/CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com/#t

 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07f555857698..eeb505d28905 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4774,6 +4774,11 @@ static inline unsigned long task_util(struct task_struct *p)
 	return READ_ONCE(p->se.avg.util_avg);
 }
 
+static inline unsigned long task_runnable(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.runnable_avg);
+}
+
 static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
@@ -4892,6 +4897,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
 		return;
 
+	/*
+	 * To avoid underestimate of task utilization, skip updates of ewma if
+	 * we cannot grant that thread got all CPU time it wanted.
+	 */
+	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
+		goto done;
+
+
 	/*
 	 * Update Task's estimated utilization
 	 *
-- 
2.34.1

