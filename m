Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10117776C02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjHIWM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjHIWMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:12:52 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED110C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:12:51 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76c93abeb83so26200185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619170; x=1692223970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5L7WYMeUuybF9PWhouTMr+CEGasjomO6XX645WEqJo=;
        b=gCNjP9t6BPHLXf2ca8GtXqhY40IobM5d353Y7DI3oNdXMzn/Mh89JEOL+fs6S/B3EL
         Tzc3+LInX51SQggamAAmUddsLTioKhYLYj7Tqvd/fDpv9eomQnwbZdTzGJooG3/2iPV9
         6Bvxc7jqUlxeQcro1idHnztpE3FMuJNrtCkEyv11e1KbG94l+75nkbputA8ld3zp7183
         94yJxtSP7js602U31Bfy0LAbVUVMOJ+i3sJNKxy67BKym0QIL9Y9uqiqKfe+noeSlPtB
         sdbc53GWzokxr31eSRwCLcgbfeASd2Eh1dhVKPJCxFy/JP6DINNe4yTaUXoeaT0GMkAd
         0F7A==
X-Gm-Message-State: AOJu0YyjPzmuBQHEHDz+5/pcyWBhHPIxBUOIk8LHu6M1dqBP5b6zBsP8
        2zTDnpBmg3maBsf9tboQ+ozsTI92dX0x7tj0
X-Google-Smtp-Source: AGHT+IG07CI5T3uhYvISE0ht1PBikgdQajxdOSf7nHHVwQJ1esEsJ3ICkwB4SFrTmbgc0GV1M5KIEg==
X-Received: by 2002:a05:620a:4690:b0:76c:d6eb:df89 with SMTP id bq16-20020a05620a469000b0076cd6ebdf89mr386609qkb.28.1691619170349;
        Wed, 09 Aug 2023 15:12:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a11a700b0076827ce13f6sm23034qkk.10.2023.08.09.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:12:49 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: [PATCH v3 2/7] sched: Move is_cpu_allowed() into sched.h
Date:   Wed,  9 Aug 2023 17:12:13 -0500
Message-ID: <20230809221218.163894-3-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_cpu_allowed() exists as a static inline function in core.c. The
functionality offered by is_cpu_allowed() is useful to scheduling
policies as well, e.g. to determine whether a runnable task can be
migrated to another core that would otherwise go idle.

Let's move it to sched.h.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  | 31 -------------------------------
 kernel/sched/sched.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 394e216b9d37..dd6412a49263 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -48,7 +48,6 @@
 #include <linux/kcov.h>
 #include <linux/kprobes.h>
 #include <linux/llist_api.h>
-#include <linux/mmu_context.h>
 #include <linux/mmzone.h>
 #include <linux/mutex_api.h>
 #include <linux/nmi.h>
@@ -2470,36 +2469,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
-/*
- * Per-CPU kthreads are allowed to run on !active && online CPUs, see
- * __set_cpus_allowed_ptr() and select_fallback_rq().
- */
-static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
-{
-	/* When not in the task's cpumask, no point in looking further. */
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-		return false;
-
-	/* migrate_disabled() must be allowed to finish. */
-	if (is_migration_disabled(p))
-		return cpu_online(cpu);
-
-	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu) && task_cpu_possible(cpu, p);
-
-	/* KTHREAD_IS_PER_CPU is always allowed. */
-	if (kthread_is_per_cpu(p))
-		return cpu_online(cpu);
-
-	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_dying(cpu))
-		return false;
-
-	/* But are allowed during online. */
-	return cpu_online(cpu);
-}
-
 /*
  * This is how migration works:
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 69b100267fd0..88cca7cc00cf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -44,6 +44,7 @@
 #include <linux/lockdep.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/module.h>
 #include <linux/mutex_api.h>
 #include <linux/plist.h>
@@ -1203,6 +1204,36 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+/*
+ * Per-CPU kthreads are allowed to run on !active && online CPUs, see
+ * __set_cpus_allowed_ptr() and select_fallback_rq().
+ */
+static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
+{
+	/* When not in the task's cpumask, no point in looking further. */
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return false;
+
+	/* migrate_disabled() must be allowed to finish. */
+	if (is_migration_disabled(p))
+		return cpu_online(cpu);
+
+	/* Non kernel threads are not allowed during either online or offline. */
+	if (!(p->flags & PF_KTHREAD))
+		return cpu_active(cpu) && task_cpu_possible(cpu, p);
+
+	/* KTHREAD_IS_PER_CPU is always allowed. */
+	if (kthread_is_per_cpu(p))
+		return cpu_online(cpu);
+
+	/* Regular kernel threads don't get to stay during offline. */
+	if (cpu_dying(cpu))
+		return false;
+
+	/* But are allowed during online. */
+	return cpu_online(cpu);
+}
+
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
-- 
2.41.0

