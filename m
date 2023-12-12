Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916380E04D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbjLLAb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjLLAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:51 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D0C6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:53 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35d72b72ff7so20438225ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341112; x=1702945912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr94+IMx6s1+HpyvMH2m+IvjCEwFJoJsIekdJu7+PcE=;
        b=KJvrgAQAi75cmYFJuFPDnQFYdA8P3E2F4AtJmeFLQuIY4PopEGiyEtf/t4fZj5GKFv
         asgO6U4R6Rwv00c11RHaHDONfAXMhoNEmBEii6XeWoFpNpIeE6nsVtNwXyN8Y84tYLrA
         HwCzh9Qb8UhpLWd1bTP+Dk/+KXrDcHU8yRnk02nJCwf5X8Xq8Vqkhiqii4njSmPzMwg6
         ZJoE3okwkLoZHIqUncs0P6ptr45UsfaOw/NiNqdtQkNcDR1mb8qoDQ7zhZKDsbciYye+
         nc9bKkMMRzkjeZuJSo090NCrFv860qI5EZ3y9fQVF+etrWOa//KwWoKjDAK1x3eA0HCx
         REqQ==
X-Gm-Message-State: AOJu0YzvV2cvmu6t3l6uuZzOvoLwTTuyGks4EK63mzQtDV5YEb4aZCU4
        A46Ypu4hB4OEvGUleKAdXgFlCFOMFhgIH9c3
X-Google-Smtp-Source: AGHT+IGdl7UlQ2qhNtgqnYoecAjUWZxZu4zlGcyAKjosWCjMc2gZDN7TVosapaaE0nmZ3x4bCr1JTw==
X-Received: by 2002:a05:6e02:164f:b0:35d:59a2:6453 with SMTP id v15-20020a056e02164f00b0035d59a26453mr7227927ilu.38.1702341111922;
        Mon, 11 Dec 2023 16:31:51 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id s2-20020a92cb02000000b0035f54df2401sm672851ilo.72.2023.12.11.16.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:51 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 2/8] sched: Move is_cpu_allowed() into sched.h
Date:   Mon, 11 Dec 2023 18:31:35 -0600
Message-ID: <20231212003141.216236-3-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index fb6f505d5792..9ad7f0255e14 100644
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
@@ -2469,36 +2468,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
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
index 5afdbd7e2381..53fe2294eec7 100644
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
@@ -1206,6 +1207,36 @@ static inline bool is_migration_disabled(struct task_struct *p)
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
2.42.1

