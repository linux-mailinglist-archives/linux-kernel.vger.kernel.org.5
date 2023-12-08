Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23094809724
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjLHAYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444197AbjLHAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:24:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB3C1980
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso15920595e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995053; x=1702599853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRq0Syt1SvsKafd3cs6Wfp7cr+i7CiNOFmpcV8u9otI=;
        b=usHAvpdI+8BCDpXTPlDZj94N2uiO7C6T7X3m780XxcxIEBe7thVy3r/tY18K2eIBkw
         0kLzajxwNDRDUV60iOQP6QsW3my9+elNyPbzebQ+5CdPZ7QBhfUjs7nP2gXL2fmvtXQS
         kGQkNIYhbAk4/9MGQBcNUZ6MLVQw0oryFjW9rR/d+7SSgaKa5mND9+zaOmAkGIHMTx84
         vzBHY+nAMRBq6k1whTJtua0IYtj7ogL9hcOU/ERm55T+L3TZ1bjgqxKJGeQW0ej/eAcr
         p/KVXJ867hybCpZr8NZ80qJuam2T68rf6wUCktNVFSvYG09KfcLPJtSMhkgzhlgT9kIT
         Qnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995053; x=1702599853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRq0Syt1SvsKafd3cs6Wfp7cr+i7CiNOFmpcV8u9otI=;
        b=JvEX1eqiSXDh7JF7vRFFIERJoBQxqLLtKSERsp7Ak/tP2wDhwm0zfOYV9MeByK5HN1
         HBFr/886qcGSb9WKU5DzSvSuCi8hYuqmsaWZGyNvOtlvQwqB18RjyraAJmETB4KTb24d
         Sy/gUGd7S2F6VsxcaVerbmTrWezM3Si2KsPyCjnqVYsdMRtqeGp8npKGqq+UXcHfeZdq
         9+xMwFLyEgtx5B4yjUJYz9JMBhE6qBhhJFihSWkPHPFxB/a1SVeFwXfAefTXni+QN2+a
         me/IYtZuMVhGTGUx+geYfIpEyzYDY3Q+wZhhbhKuV/pnPXRbq+EssS5hiXmgNTvKHuNc
         MxJQ==
X-Gm-Message-State: AOJu0YwOcBX35jucje5723QzZl3UKNIuu4DKLs7d5MxeuSDdd02aRTYw
        3bH6kRMmjv+N7C7OH9jBr3+ASg==
X-Google-Smtp-Source: AGHT+IGzt9IqJG3ZpXpJIZHhOEc8F+mqRgQdm8BQLp3/peB0eQhUaZSO2ows8w6zmPv1lRO1zF36+g==
X-Received: by 2002:a05:600c:45d2:b0:40b:32fa:d8a3 with SMTP id s18-20020a05600c45d200b0040b32fad8a3mr2019599wmo.18.1701995053212;
        Thu, 07 Dec 2023 16:24:13 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:12 -0800 (PST)
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
Subject: [PATCH v2 5/8] sched/fair: Remove magic hardcoded margin in fits_capacity()
Date:   Fri,  8 Dec 2023 00:23:39 +0000
Message-Id: <20231208002342.367117-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
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

Replace hardcoded margin value in fits_capacity() with better dynamic
logic.

80% margin is a magic value that has served its purpose for now, but it
no longer fits the variety of systems exist today. If a system is over
powered specifically, this 80% will mean we leave a lot of capacity
unused before we decide to upmigrate on HMP system.

On some systems the little core are under powered and ability to migrate
faster away from them is desired.

The upmigration behavior should rely on the fact that a bad decision
made will need load balance to kick in to perform misfit migration. And
I think this is an adequate definition for what to consider as enough
headroom to consider whether a util fits capacity or not.

Use the new approximate_util_avg() function to predict the util if the
task continues to run for TICK_US. If the value is not strictly less
than the capacity, then it must not be placed there, ie considered
misfit.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..b83448be3f79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -101,16 +101,31 @@ int __weak arch_asym_cpu_priority(int cpu)
 }
 
 /*
- * The margin used when comparing utilization with CPU capacity.
+ * The util will fit the capacity if it has enough headroom to grow within the
+ * next tick - which is when any load balancing activity happens to do the
+ * correction.
  *
- * (default: ~20%)
+ * If util stays within the capacity before tick has elapsed, then it should be
+ * fine. If not, then a correction action must happen shortly after it starts
+ * running, hence we treat it as !fit.
+ *
+ * TODO: TICK is not actually accurate enough. balance_interval is the correct
+ * one to use as the next load balance doesn't not happen religiously at tick.
+ * Accessing balance_interval might be tricky and will require some refactoring
+ * first.
  */
-#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+static inline bool fits_capacity(unsigned long util, unsigned long capacity)
+{
+	return approximate_util_avg(util, TICK_USEC) < capacity;
+}
 
 /*
  * The margin used when comparing CPU capacities.
  * is 'cap1' noticeably greater than 'cap2'
  *
+ * TODO: use approximate_util_avg() to give something more quantifiable based
+ * on time? Like 1ms?
+ *
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
-- 
2.34.1

