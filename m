Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9A809723
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444185AbjLHAYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444198AbjLHAYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:24:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B4172A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso15484285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995051; x=1702599851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFcvWyGzy7I7g+xwi5n944IlgZ7CY3p5798f0wmNhcc=;
        b=cdX5NWyWCBwXaoh8OWBzi6gu+rNuV2bBH/2eVclyphUVCJIi3HYqdO3+95cxomldmM
         S0Ly4YLHh5kVQSxqv7ZXyy7X/NurSo4a/NGpcPwKNB6xvFOM/8v5IoA7TUsiw7Uo4/bt
         NFjNhGzQl28Aa2NZ7ZDmfynSzxWVTeBnN7GRIvNF0gHY1Jc/uM1jQzd5fNmqkltJ3NRc
         OS/5OwLvc+0dExB8HOUUkeQ4XHRofF2IOBCUvyqO8DGvztAYpK5ssac1mMHRohib93Fy
         7eVDJSYd4XabZkagv2hicmktQDoHYZ488qhIAHYmSlIfSmiWTVUYNLQZC0RH8S+I2zQP
         tAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995051; x=1702599851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFcvWyGzy7I7g+xwi5n944IlgZ7CY3p5798f0wmNhcc=;
        b=B78kfLfYYToQlyJWqf6x/jKLXLpRJISwE2VfeV5Gt4RD8HamsNC+3NdnaDY6/Kp9xA
         HMTpb1hStLQQgbxTq3TpMzTn1cNnBfp2XoweM7YpwfU4RXnzhfr7oW1fKcWDl7GFGhRJ
         CTtR9TiaZzvm2tpQnJVxks0B/YSI1iiXUjQz1tdoBH4K8zo7EnQqBi8/5jlFHtRBhM8n
         MyEhb58U5Bho1X+Rys7x5ISaDw8ZZefhAjibrpyFwv67UdXqP7pk0neAf6Ze6tiPf0pV
         CBojqolTSLHirUuMy0C9eAhMAuSfdhAxoHVL23aD7TvpCFrVAuVnA7PpRqYj65kFSDLW
         1xjQ==
X-Gm-Message-State: AOJu0YyY3QHEc8Tx1LjOqKSECe9VgjQeb6jlOsVh/hhNeFkLauhSglL2
        88dShau1IMyG8w6sP5/Zp4Gufw==
X-Google-Smtp-Source: AGHT+IFNv/bJ3z7++RWJr3sps726MqohP1NGWMmNXo4tcWhp9NOoexZrvOdWJYl26EZFZZEDpZZ4qw==
X-Received: by 2002:a05:600c:3c86:b0:40c:7ef:2d2 with SMTP id bg6-20020a05600c3c8600b0040c07ef02d2mr2224939wmb.8.1701995051136;
        Thu, 07 Dec 2023 16:24:11 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:10 -0800 (PST)
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
Subject: [PATCH v2 4/8] sched/pelt: Add a new function to approximate runtime to reach given util
Date:   Fri,  8 Dec 2023 00:23:38 +0000
Message-Id: <20231208002342.367117-5-qyousef@layalina.io>
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

It is basically the ramp-up time from 0 to a given value. Will be used
later to implement new tunable to control response time  for schedutil.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 81555a8288be..00a1b9c1bf16 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 1, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e5a86a376f8..2de64f59853c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3003,6 +3003,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
-- 
2.34.1

