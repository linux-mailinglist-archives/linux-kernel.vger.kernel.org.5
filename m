Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4096280971D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444176AbjLHAYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjLHAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:24:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B3B171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so15625835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995045; x=1702599845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MICklUThOT75YrGOtGs5vvoxKkTP4eSHGLbFICqC1g=;
        b=kEcXB5ugh4fioltkFcR/kJAvKoJMyioY+Nr+Uga78TYQg9k6s7JKXZZt8wjGA+2l/o
         2SRx2xqrFr+dSRxVTqKSFgYVLH9wnwNezmBXLp41Qtqym7A7Ik7OuVAq4zoPpQv/s3me
         e87F/mbpldoEhv/kqCeb3mPbgqT+Mlzj+5/kL3Qw6TQ6gxLD4vgpqehYHda9fvukve+d
         E2O0X6GDWYPfQi++hNwXb/LfiFsICSyKSTpu0yqBSeS8h0zefRTOOGmUeBe8lEMz8nPB
         thWMWg03F5sRlO6h4SVWzYA3502otvgIeMchZiTjNHDEfeVL3fpKnqjZEqMWuKj1XBAn
         wZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995045; x=1702599845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MICklUThOT75YrGOtGs5vvoxKkTP4eSHGLbFICqC1g=;
        b=cOOmdzUzanQHO4S0wI1VPrnnc7UzT5WmBznYay+5S20vwKJ25hENq6HjWWMC1qIFHR
         qg67p2I92HhQTofWa917rrFB5V9KKCJ3lj/X3qyVjv0h5NoCiQ8W6jHaCsyiYQcGQQs8
         kloPx9x5WtU8sorVvsBZEsuWqsXRIVOfapp2DnH4O/5wPt1Hdmw4Nk9k+JDnGyHlAG3w
         tlivEArp9WhtIpRUjATUMqpqgEfVRsO+O7X9qPpuJ1Wsu7h02Jlf+fgXtKT96eczBxAx
         5tZqfXkY5U+//wJJSkyes88N2cs7JNlDKlVS2Vriv3P3lhxsYU/FY6L4FDpb+yEWMOn6
         9TyA==
X-Gm-Message-State: AOJu0Yw8l1owcCxvlTY0HFNp5rTjn9dmEmv95h3e/Gt64jfKsAW0g9Qr
        CWx3tiubKxjxh45tGTq1BZbodg==
X-Google-Smtp-Source: AGHT+IF6n9vGF+wKVNWmclAiRMBztZoqnbj8D/4FxMtbCN6r+z66nQHUenjbCO2tFAE1xQOoGOdHMA==
X-Received: by 2002:a05:600c:3d0b:b0:40c:314c:803e with SMTP id bh11-20020a05600c3d0b00b0040c314c803emr435922wmb.106.1701995045591;
        Thu, 07 Dec 2023 16:24:05 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:05 -0800 (PST)
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
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 2/8] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
Date:   Fri,  8 Dec 2023 00:23:36 +0000
Message-Id: <20231208002342.367117-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
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

We are providing headroom for the utilization to grow until the next
decision point to pick the next frequency. Give the function a better
name and give it some documentation. It is not really mapping anything.

Also move it to sched.h. This function relies on updating util signal
appropriately to give a headroom to grow. This is more of a scheduler
functionality than cpufreq. Move it to sched.h where all the other util
handling code belongs.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h    |  5 -----
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..d01755d3142f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
 {
 	return freq * util / cap;
 }
-
-static inline unsigned long map_util_perf(unsigned long util)
-{
-	return util + (util >> 2);
-}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4ee8ad70be99..79c3b96dc02c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -157,7 +157,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
+	actual = apply_dvfs_headroom(actual);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..0da3425200b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max);
 
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
+ */
+static inline unsigned long apply_dvfs_headroom(unsigned long util)
+{
+	return util + (util >> 2);
+}
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1

