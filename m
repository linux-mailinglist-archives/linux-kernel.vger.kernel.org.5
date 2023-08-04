Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584E76F7E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHDCdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjHDCdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76711A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691116350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8jnmrIEx4SJ3sEJwf12nMDN4JK4gDtMO8+W4VI3+2Rk=;
        b=Nf7f50ZLKnkt+YocHhE4j/Ab9IxYPZKeAhO+JKyZjrmLdI6zZpygJmKi1wkyizx2caera0
        LWAAOmdNCQuFsa3cqON39aAeqyNWk6fR3qIwHHbRx5faT75X1cffcwuTrD7nob+x+sQevz
        CXg/6tDgUU+I493DGtriR3FO6kvfZVo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-wvWgjmUlOzKF-e2PP22GFA-1; Thu, 03 Aug 2023 22:32:29 -0400
X-MC-Unique: wvWgjmUlOzKF-e2PP22GFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DECDE380391D;
        Fri,  4 Aug 2023 02:32:28 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09CC4C5796B;
        Fri,  4 Aug 2023 02:32:27 +0000 (UTC)
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
Subject: [PATCH v3] sched/core: Use empty mask to reset cpumasks in sched_setaffinity()
Date:   Thu,  3 Aug 2023 22:32:18 -0400
Message-Id: <20230804023218.75544-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
will always return an -EINVAL error. With this patch, an alternative
error of -ENODEV will be returned returned if sched_setaffinity(2)
has been called before to set up user_cpus_ptr. In this case, the
user_cpus_ptr that stores the user provided affinity will be cleared and
the task's CPU affinity will be reset to that of the current cpuset. This
alternative error code of -ENODEV signals that the no CPU is specified
and, at the same time, a side effect of resetting cpu affinity to the
cpuset default.

If sched_setaffinity(2) has not been called previously, an EINVAL error
will be returned with an empty cpumask just like before.  Tests or
tools that rely on the behavior that an empty cpumask will return an
error code will not be affected.

We will have to update the sched_setaffinity(2) manpage to document
this possible side effect of passing in an empty cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..3ef7397f2a61 100644
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
@@ -8423,6 +8440,13 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	retval = __sched_setaffinity(p, &ac);
 	kfree(ac.user_mask);
 
+	/*
+	 * Force an error return (-ENODEV), if no error yet, for the empty
+	 * cpumask case to avoid breaking existing tests.
+	 */
+	if (reset_cpumasks && !retval)
+		retval = -ENODEV;
+
 out_put_task:
 	put_task_struct(p);
 	return retval;
-- 
2.31.1

