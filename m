Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625A0756B37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjGQSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGQSDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462468E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689616977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UhX9Je5Vdw3sFh8XOSMjosjqPg2QpevXAW0ylqLCyFw=;
        b=N+622LaMVfX5H0MB1wV6mhAqV+GNpbGpZiGzM3DzmMCx9bw+1Ham142yqCzCnGpl3AbsXt
        hu7Ynot25gpwTjrlddK+fxEm3309ECMOE5uiOZlj8/xp3S2hKFFCP4AdYibVPbZjX6lL2J
        5D0RO/6wI4Uljw/JdXclxVraqoIj2mE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-qjqdx2_6Op29tfhYxCFvww-1; Mon, 17 Jul 2023 14:02:50 -0400
X-MC-Unique: qjqdx2_6Op29tfhYxCFvww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDC95185A792;
        Mon, 17 Jul 2023 18:02:49 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B33B40C6F4F;
        Mon, 17 Jul 2023 18:02:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] sched/core: Use empty mask to reset cpumasks in sched_setaffinity()
Date:   Mon, 17 Jul 2023 14:02:43 -0400
Message-Id: <20230717180243.3607603-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), user provided CPU affinity via sched_setaffinity(2) is
perserved even if the task is being moved to a different cpuset. However,
that affinity is also being inherited by any subsequently created child
processes which may not want or be aware of that affinity.

One way to solve this problem is to provide a way to back off from
that user provided CPU affinity.  This patch implements such a scheme
by using an empty cpumask to signal a reset of the cpumasks to the
default as allowed by the current cpuset.

Before this patch, passing in an empty cpumask to sched_setaffinity(2)
will always return an EINVAL error. With this patch, an error will no
longer be returned if sched_setaffinity(2) has been called before to
set up user_cpus_ptr. Instead, the user_cpus_ptr that stores the user
provided affinity will be cleared and the task's CPU affinity will be
reset to that of the current cpuset. No error will be returned in this
case to signal that a reset has happened.

If sched_setaffinity(2) has not been called previously, an EINVAL error
will be returned with an empty cpumask just like before. As a result,
tests or tools that rely on this behavior will not be affected unless
they have somehow called sched_setaffinity(2) before.

We will have to update the sched_setaffinity(2) manpage to document
this possible side effect of passing in an empty cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..9c4c27d4d4a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8317,7 +8317,12 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 	}
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+
+	/* Default to cpus_allowed with NULL new_mask */
+	if (ctx->new_mask)
+		cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+	else
+		cpumask_copy(new_mask, cpus_allowed);
 
 	ctx->new_mask = new_mask;
 	ctx->flags |= SCA_CHECK;
@@ -8366,6 +8371,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	bool reset_cpumasks = cpumask_empty(in_mask);
 	struct affinity_context ac;
 	struct cpumask *user_mask;
 	struct task_struct *p;
@@ -8403,15 +8409,26 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		goto out_put_task;
 
 	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
+	 * If an empty cpumask is passed in and user_cpus_ptr is set,
+	 * clear user_cpus_ptr and reset the current cpu affinity to the
+	 * default for the current cpuset. If user_cpus_ptr isn't set,
+	 * -EINVAL will be returned as before.
 	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
-	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+	if (reset_cpumasks && p->user_cpus_ptr) {
+		in_mask = NULL;	/* To be updated in __sched_setaffinity */
+		user_mask = NULL;
+	} else {
+		/*
+		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used
+		 * and alloc_user_cpus_ptr() returns NULL.
+		 */
+		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+		if (user_mask) {
+			cpumask_copy(user_mask, in_mask);
+		} else if (IS_ENABLED(CONFIG_SMP)) {
+			retval = -ENOMEM;
+			goto out_put_task;
+		}
 	}
 
 	ac = (struct affinity_context){
-- 
2.31.1

