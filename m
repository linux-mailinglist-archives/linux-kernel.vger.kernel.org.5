Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653A9809721
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444219AbjLHAYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444166AbjLHAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:24:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9CD5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so18063345e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995047; x=1702599847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hmu4GR1Tf24zDfNQg/5SjNdB/QFzSeUZxk8HyYC52U=;
        b=x+BhzZ6VtGPBQFltDUsIdkVfWUh1AG8Qdn8SLD2E/8UQ7ee58SP79CSpA/Pv4BVVh5
         rpZvTDUQo5GjiQ2GTc9lJx5hTiIOHuK9D7VjixxgTDFBNdLi3vNzmVXD4f1Yjng5mE98
         Q4POqOxubMOO8smHCX2dGZYTCZVz3qi3AUBvrkjFygVZFpIkVbgaQ92gJHXHVZpx6uyA
         xPAzbfpgOK6aXQaVxbd1hIqL4mYXL9wMiNjA2zLTq/60dthzOj+qTlsE3lHGaX2zTyCI
         hzHYUM7TqpGUCctXCu5IdF+ugivfruAgOEwQgOIQrFrSIGxQ5yeGWEaFDvMHqwVML1sW
         GjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995047; x=1702599847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hmu4GR1Tf24zDfNQg/5SjNdB/QFzSeUZxk8HyYC52U=;
        b=IK78Mh3hW4zy/AKZcb8Xz8usga3DD7M9fwsy6BvMIWllUq+20/10yhfyqLitgf+F+F
         z6yjza1w3q7Gcsw1SSPEj1IHBMJ+no2rIOJoF0IvUeP7Rl2IFhdavbtcUwuSPGNlcZJ5
         WB7mvZn28l4NlvnuQdTbyZWzSMYVvxtql3PIdUSkp4bdzglcIjOrVHEW8HH0K1PEYVNE
         92dl39V4bKDkgrhjaMGIYg+P/B53IRORgCtP8o5SrEGekWgMh5Q/atrIGvSu79OeYpm0
         P7AUV1GVU+JvpXPcUZfwq0Q508o95Yv2gEglTv1kN5lwdgiQmCcw/bnHXCT3ca0MSIoL
         z34w==
X-Gm-Message-State: AOJu0YzbVSEMwXG85uU0yyVDOyBs1YMtdll9Cgt4ZZrx5B16uGgPZ8z7
        0XfmQJPOvCC/A//K1B6eUQrAAg==
X-Google-Smtp-Source: AGHT+IEDkE6xFmQ45NVfGlGxefY7HBAhSTWDgMehJ17Ql0RmMpqkVzJDaZNH0S70STgK37Gtbrc9Yg==
X-Received: by 2002:a05:600c:a388:b0:40c:2c51:d78b with SMTP id hn8-20020a05600ca38800b0040c2c51d78bmr522596wmb.209.1701995047752;
        Thu, 07 Dec 2023 16:24:07 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:07 -0800 (PST)
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
Subject: [PATCH v2 3/8] sched/pelt: Add a new function to approximate the future util_avg value
Date:   Fri,  8 Dec 2023 00:23:37 +0000
Message-Id: <20231208002342.367117-4-qyousef@layalina.io>
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

Given a util_avg value, the new function will return the future one
given a runtime delta.

This will be useful in later patches to help replace some magic margins
with more deterministic behavior.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 22 +++++++++++++++++++++-
 kernel/sched/sched.h |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 63b6cf898220..81555a8288be 100644
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
+	accumulate_sum(delta, &sa, 1, 0, 1);
+	___update_load_avg(&sa, 0);
+
+	return sa.util_avg;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0da3425200b1..7e5a86a376f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3002,6 +3002,8 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max);
 
+unsigned long approximate_util_avg(unsigned long util, u64 delta);
+
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
  * continue to grow, which means it could need to run at a higher frequency
-- 
2.34.1

