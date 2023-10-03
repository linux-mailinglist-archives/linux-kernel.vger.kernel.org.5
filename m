Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775987B72F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjJCU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjJCU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFEAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696366681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R0J7KehNMsr0jjrLYehZsVAtwRuvkbKBMf/ZqDdCVXY=;
        b=Y7Hk8Nk4dB5Ylx63syWvmPcxLaZmot4iE0e7yR5zuKtVrmZAZPdfxpI4MbMOuCG5gz3OFv
        gcoj8pp/xvBmStKw7C+zKAJI/U7C19UsRYUV0mR/j72Vxf59F3qYoVu/dbaw7XyIHzydho
        LOqeoIi9S8XR0GT4aE5ZNFPx23wndlI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-_IGW9c5dOaOKfgZ-fURqaw-1; Tue, 03 Oct 2023 16:57:46 -0400
X-MC-Unique: _IGW9c5dOaOKfgZ-fURqaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8536F3806706;
        Tue,  3 Oct 2023 20:57:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3CA40C6EA8;
        Tue,  3 Oct 2023 20:57:44 +0000 (UTC)
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
Subject: [PATCH v4] sched/core: Use zero length to reset cpumasks in sched_setaffinity()
Date:   Tue,  3 Oct 2023 16:57:35 -0400
Message-Id: <20231003205735.2921964-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

One way to solve this problem is to provide a way to back off from that
user provided CPU affinity.  This patch implements such a scheme by
using an input cpumask length of 0 to signal a reset of the cpumasks
to the default as allowed by the current cpuset.  A non-NULL cpumask
should still be provided to avoid problem with older kernel.

If sched_setaffinity(2) has been called previously to set a user
supplied cpumask, a value of 0 will be returned to indicate success.
Otherwise, an error value of -EINVAL will be returned.

We may have to update the sched_setaffinity(2) manpage to document
this new side effect of passing in an input length of 0.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..a10d507a05df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8315,7 +8315,12 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
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
@@ -8401,15 +8406,29 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		goto out_put_task;
 
 	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
+	 * If a NULL cpumask is passed in and user_cpus_ptr is set,
+	 * clear user_cpus_ptr and reset the current cpu affinity to the
+	 * default for the current cpuset. If user_cpus_ptr isn't set,
+	 * -EINVAL will be returned.
 	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
-	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+	if (!in_mask) {
+		if (!p->user_cpus_ptr) {
+			retval = -EINVAL;
+			goto out_put_task;
+		}
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
@@ -8451,6 +8470,12 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
 	cpumask_var_t new_mask;
 	int retval;
 
+	/*
+	 * A len of 0 will reset a previously set user cpumask.
+	 */
+	if (!len)
+		return sched_setaffinity(pid, NULL);
+
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-- 
2.39.3

