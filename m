Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9877ABCED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 03:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIWBOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 21:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIWBOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 21:14:21 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA2CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 18:14:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34f6ce577a4so9508375ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1695431654; x=1696036454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3p2Xpy6OB/r139HgDed1FfmEjYksRL9s1sjY3anozVM=;
        b=Zx9vHbvf85ZewJI63aHShFKxCduNHcBkaJOTiTDvUVrKbXoG4a7FzYS14YXt08iGhH
         jriK2XJhlQ/DvcHETiTHNYPc2uuQ7dvyrdf3dpIERCBCcQxomMYDxGtb1mOBdiN4TCM1
         bkqedjmWj5YejyMQK5QULykOjkdSvvlR+66Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695431654; x=1696036454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3p2Xpy6OB/r139HgDed1FfmEjYksRL9s1sjY3anozVM=;
        b=KcCoNJtlm/Fe6dSs4GnrT1wMDI02ee+Sa4I7Sfge6Xbv9pcHg/A2qzWHvbbQQY8OOU
         f4+rBJXYIY4uL3fPtizoV9Ugfd6GkmlvBH6z/ywmH7PHrBaIJ45f2qBFW6wz4sI9lxZz
         dgcordaxRZ28BhpIomuzXKvuH/iTogXx+T3FaRT7FxL5y0hmRUNkcXYGPagOidkIszQl
         mFEmxdqRqvqSyXVvoCYmFNhdRa7VhClA7yU3d20D+LWNsbTWuv6ZbdJAxvPYHtvUuQdr
         oDVgnlx4mCWBv6ZnBRucDNLVtdB6z8bSpubOQHLvKyjHyNeA3WKm040KDMz9cbsit60u
         YSww==
X-Gm-Message-State: AOJu0YwZ/iEND0VwKnRUje2/Z3pVu5j2Ume1vkXabrBbt8ZxmPbU/oNk
        Yb4sSiPok09N6POlfJPcAcCmhZSLp8vz2VuDXds=
X-Google-Smtp-Source: AGHT+IGtZ1mnco63mTfTx8AkpKukDkGuoE1ogUJ28T7vde7TtYncQr/SW/Ad3AcaWIF2YbV09QHyyw==
X-Received: by 2002:a05:6e02:2189:b0:34f:1e9c:45df with SMTP id j9-20020a056e02218900b0034f1e9c45dfmr1454696ila.4.1695431654589;
        Fri, 22 Sep 2023 18:14:14 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id cg11-20020a0566381bcb00b0042b3dcb1106sm1330089jab.47.2023.09.22.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 18:14:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] sched/rt: Fix live lock between select_fallback_rq() and RT push
Date:   Sat, 23 Sep 2023 01:14:08 +0000
Message-ID: <20230923011409.3522762-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During RCU-boost testing with the TREE03 rcutorture config, I found that
after a few hours, the machine locks up.

On tracing, I found that there is a live lock happening between 2 CPUs.
One CPU has an RT task running, while another CPU is being offlined
which also has an RT task running.  During this offlining, all threads
are migrated. The migration thread is repeatedly scheduled to migrate
actively running tasks on the CPU being offlined. This results in a live
lock because select_fallback_rq() keeps picking the CPU that an RT task
is already running on only to get pushed back to the CPU being offlined.

It is anyway pointless to pick CPUs for pushing tasks to if they are
being offlined only to get migrated away to somewhere else. This could
also add unwanted latency to this task.

Fix these issues by not selecting CPUs in RT if they are not 'active'
for scheduling, using the cpu_active_mask. Other parts in core.c already
use cpu_active_mask to prevent tasks from being put on CPUs going
offline.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpupri.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a286e726eb4b..42c40cfdf836 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
-- 
2.42.0.515.g380fc7ccd1-goog

