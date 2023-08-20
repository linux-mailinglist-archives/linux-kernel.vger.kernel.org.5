Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5145E782016
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjHTVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjHTVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:08:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591BE49C9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:08:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fee87dd374so9080965e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692565686; x=1693170486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvS6i5MmlM83okIt3hu6QZE/yTaGAFd1OJzWlOJdeII=;
        b=eUJdEfU+wCh7GbOSrOcgXSU+omBihmSIkylrFWG+wpsvLidpTcilplQelHH1voLoO7
         3fypW+Xof0JkFMUwbwJPZBcBbhasRAZIHXFoD6eHqTREGlT9HPDtVEpIG1XzUrJR07gA
         KqrDzd/ZhelmjWYKeYPF7d7FYr9JD8kkaOQIFd3+2GxGt2kfaso/vGEWk0lwMNpI/Fgy
         XIHKOBXpGWXDg6wU6AEqLvkTabTxbnjl5nTTAZbABRiR432mhjRpryHfra/Z6OcU76cF
         6CyjNjBHbzzDcjjSIZC2Vn1Jlqrz7nf6Ry6HPF1rgcBbx/hB0s4Q/9pe2x8wfOIIT25N
         YYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565686; x=1693170486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvS6i5MmlM83okIt3hu6QZE/yTaGAFd1OJzWlOJdeII=;
        b=S0t/oLEZprUVKegCt0EFaeYF/sGAmIJwD4IpMu8ANOd3gWXlNNWZo2qu7fK4YwS9Yj
         7rf+Bn/GSVtqfWMIjPWCcMmSsDZIsvrFUqbCGL9RXSDRlC+vXUwqZ6fw3+IqqXNLqTcl
         xIJTLR1m8yxpwnR+RPvvwvqH7o35xQUJcWqz74FStj1/nMuZgubZt+yEpCSAJ9wEdxz5
         xQILIPAY2QCQ1kA9WcY+QKq96cOxssAvO+AEcwYVaCvNQKqPh0cTh1By//19aJe/0RDJ
         ihh13TdpuHyzd44aDD1PqCJYZc1R8tt3BpDMcAvB5RALt+d6Cah+aq8paGvA69IdeIlQ
         ZHWA==
X-Gm-Message-State: AOJu0Yw5xJ5CvQYw40V98KgPV8MyR6Y1lnbO+J/IQ2zZIG/3cqFySvUZ
        09cb9Fjw5Ur0CWeSy6+yXjckgQ==
X-Google-Smtp-Source: AGHT+IEjvAnle4Qh/tgCe9Abtc/2UPfgazY/8no6cp5UNC4rcPBG4Ofv/HaNWmre2NOn8zi6Sbi0Kg==
X-Received: by 2002:adf:cf02:0:b0:317:6b0d:1b1 with SMTP id o2-20020adfcf02000000b003176b0d01b1mr3791525wrj.4.1692565685830;
        Sun, 20 Aug 2023 14:08:05 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id j6-20020adfea46000000b003197a4b0f68sm10336800wrn.7.2023.08.20.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:08:05 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 3/4] sched: cpufreq: Move apply_dvfs_headroom() to sched.h
Date:   Sun, 20 Aug 2023 22:06:39 +0100
Message-Id: <20230820210640.585311-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820210640.585311-1-qyousef@layalina.io>
References: <20230820210640.585311-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function relies on updating util signal appropriately to give
a headroom to grow. This is more of a scheduler functionality than
cpufreq. Move it to sched.h where all the other util handling code
belongs.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h | 30 ------------------------------
 kernel/sched/sched.h          | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index f0069b354ac8..d01755d3142f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -28,36 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
 {
 	return freq * util / cap;
 }
-
-/*
- * DVFS decision are made at discrete points. If CPU stays busy, the util will
- * continue to grow, which means it could need to run at a higher frequency
- * before the next decision point was reached. IOW, we can't follow the util as
- * it grows immediately, but there's a delay before we issue a request to go to
- * higher frequency. The headroom caters for this delay so the system continues
- * to run at adequate performance point.
- *
- * This function provides enough headroom to provide adequate performance
- * assuming the CPU continues to be busy.
- *
- * At the moment it is a constant multiplication with 1.25.
- *
- * TODO: The headroom should be a function of the delay. 25% is too high
- * especially on powerful systems. For example, if the delay is 500us, it makes
- * more sense to give a small headroom as the next decision point is not far
- * away and will follow the util if it continues to rise. On the other hand if
- * the delay is 10ms, then we need a bigger headroom so the CPU won't struggle
- * at a lower frequency if it never goes to idle until then.
- */
-static inline unsigned long apply_dvfs_headroom(unsigned long util)
-{
-	return util + (util >> 2);
-}
-#else
-static inline unsigned long apply_dvfs_headroom(unsigned long util)
-{
-	return util;
-}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a01b7a2bf66..56eeb5b05b50 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2997,6 +2997,30 @@ enum cpu_util_type {
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 enum cpu_util_type type,
 				 struct task_struct *p);
+/*
+ * DVFS decision are made at discrete points. If CPU stays busy, the util will
+ * continue to grow, which means it could need to run at a higher frequency
+ * before the next decision point was reached. IOW, we can't follow the util as
+ * it grows immediately, but there's a delay before we issue a request to go to
+ * higher frequency. The headroom caters for this delay so the system continues
+ * to run at adequate performance point.
+ *
+ * This function provides enough headroom to provide adequate performance
+ * assuming the CPU continues to be busy.
+ *
+ * At the moment it is a constant multiplication with 1.25.
+ *
+ * TODO: The headroom should be a function of the delay. 25% is too high
+ * especially on powerful systems. For example, if the delay is 500us, it makes
+ * more sense to give a small headroom as the next decision point is not far
+ * away and will follow the util if it continues to rise. On the other hand if
+ * the delay is 10ms, then we need a bigger headroom so the CPU won't struggle
+ * at a lower frequency if it never goes to idle until then.
+ */
+static inline unsigned long apply_dvfs_headroom(unsigned long util)
+{
+	return util + (util >> 2);
+}
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1

