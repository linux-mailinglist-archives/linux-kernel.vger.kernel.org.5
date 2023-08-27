Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C778A376
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjH0Xc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjH0XcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:32:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED0123
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401c9525276so4720055e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179137; x=1693783937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5bbOUNHimZNEIeEbsqR6Op3Ym6DwMUs69DrKTMvK38=;
        b=gDEUL0lSGmBoaPWfsdt3TIy8RSGSnjDc+yuy6jOtCoQs3riTpFg5BcpAg/47t5ETzA
         uBEBzkWGVCP4rmYz+AG5I7SjwiA9c/DKIO8ce/UbRfn8vZWGo0wWUr4yDFlQvTKut4eg
         lP3wAziUEizy9Jxu8vPPufPekOxYHt2oTwnTa/b4Qo5f7Jk+D7DjlE3YDfTCSoo5AXdC
         /bPBxjmM79oD0K37l4OWKzrkMmOb4hud30gdwALN7Mz3swQDfSm/SHint0Ps+6zGXIwu
         bB3ulNvSk/RkB9hOlHnfkdZO3HOppjPSxbrjVi4S7stzgZwp2uuE35P3TZj46EaAIfNo
         LAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179137; x=1693783937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5bbOUNHimZNEIeEbsqR6Op3Ym6DwMUs69DrKTMvK38=;
        b=dpp/XwQMmh8Mtb3liDkWhOqujmegO1fKo+D9Upv7vOIU9oX54B5bUlQSGMveuYCItE
         iGGVDX8vE1rRZLnPjiB3RV+4KBfXAiZWGpCmnn0HQ4J5g0PGyRsFAM0Q5SkfqNOVUHOd
         MsrPkd1NBbK2MbD763rBdo3d+X27K4ods5DgU5U2zB+KlkUJ1XOBajVbn2dtm83JB1yo
         BgHq8SK3A3WAYl9nZeEZ66X2cSf/YYLJsMgWm71iDWPuNggmntGyVNoNUhjOWxYGBZUe
         RUZUQvTHVkh5TwBqeEZl3VlM2XuInImtDaUq/qaKGdT3l6l9prsHub1vi/QB1zQzqm3t
         htLQ==
X-Gm-Message-State: AOJu0Yz/dpfN+pLNiSxwWLqjxWCC4zMItToPPG75pOSA7X0WZxVRBy3O
        K+eQ1finjDGNvl0/qQFkySXT6w==
X-Google-Smtp-Source: AGHT+IHYSiwQ3pMeW83Szi6hCgZxKzkWheiaQklAzkUroyHg+F/5J5GvycGMIWaS2P3qj3to1YJnLQ==
X-Received: by 2002:a7b:ce11:0:b0:401:c636:8f4c with SMTP id m17-20020a7bce11000000b00401c6368f4cmr2111090wmc.3.1693179136997;
        Sun, 27 Aug 2023 16:32:16 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:16 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 3/7] sched/fair: Remove magic margin in fits_capacity()
Date:   Mon, 28 Aug 2023 00:31:59 +0100
Message-Id: <20230827233203.1315953-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

80% margin is a magic value that has served its purpose for now, but it
no longer fits the variety of systems exist today. If a system is over
powered specifically, this 80% will mean we leave a lot of capacity
unused before we decide to upmigrate on HMP system.

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
index 0b7445cd5af9..facbf3eb7141 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -109,16 +109,31 @@ int __weak arch_asym_cpu_priority(int cpu)
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

