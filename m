Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE67B7A35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbjJDIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbjJDIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:37:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D48CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SqnhAtG+Cex2R9Nxbf73+VMJyqHMzfz2TVFjbEujz1k=; b=jsNEfL5yXv5s2sJzV3Szu6x0Jv
        y4v+RARzOWGAgi2XLRPzr7DWM9FWpBjt/qAGK36CAVY1lUylrIX7rxf4V5rqd2rBGKF0Y+FZDT9j0
        8S+JwacwegnfswJrJvSpyWegn0lyRET5tQf0oD19zqPh8z6zv3KuGvs7AZez5qf3Zdvak3hjpslAJ
        dYT7i+IiXgUfrhMpL4OElmI1lI29KRU8oFtmAkMZ0x74OQ+ZaSDF0Oe1ImE0GSR8e0kq3DGnwXOOI
        IDs5EsUnuR6Hf+2gKRHvk5me6Z6AI6r1QbraJ+uiUk6eiUPU5Acrqq72gsrnAYTWEc5Yo7MTli7Q2
        v58tFknQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnxN9-00Ad6b-0K;
        Wed, 04 Oct 2023 08:36:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36D7A300365; Wed,  4 Oct 2023 10:36:48 +0200 (CEST)
Date:   Wed, 4 Oct 2023 10:36:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Message-ID: <20231004083648.GI27267@noisy.programming.kicks-ass.net>
References: <20231003205735.2921964-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003205735.2921964-1-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:57:35PM -0400, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset. However,
> that affinity is also being inherited by any subsequently created child
> processes which may not want or be aware of that affinity.
> 
> One way to solve this problem is to provide a way to back off from that
> user provided CPU affinity.  This patch implements such a scheme by
> using an input cpumask length of 0 to signal a reset of the cpumasks
> to the default as allowed by the current cpuset.  A non-NULL cpumask
> should still be provided to avoid problem with older kernel.
> 
> If sched_setaffinity(2) has been called previously to set a user
> supplied cpumask, a value of 0 will be returned to indicate success.
> Otherwise, an error value of -EINVAL will be returned.
> 
> We may have to update the sched_setaffinity(2) manpage to document
> this new side effect of passing in an input length of 0.

Bah.. so while this is less horrible than some of the previous hacks,
but I still think an all set mask is the sanest option.

Adding FreeBSD's CPU_FILL() to glibc() isn't the hardest thing ever, but
even without that, it's a single memset() away.


Would not the below two patches, one kernel, one glibc, be all it takes?

---
Subject: sched: Allow sched_setaffinity() to re-set the usermask

When userspace provides an all-set cpumask, take that to mean 'no
explicit affinity' and drop the usermask.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 779cdc7969c8..18124bbbb17c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8368,7 +8368,15 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	 */
 	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
 	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
+		/*
+		 * All-set user cpumask resets affinity and drops the explicit
+		 * user mask.
+		 */
+		cpumask_and(user_mask, in_mask, cpu_possible_mask);
+		if (cpumask_equal(user_mask, cpu_possible_mask)) {
+			kfree(user_mask);
+			user_mask = NULL;
+		}
 	} else if (IS_ENABLED(CONFIG_SMP)) {
 		return -ENOMEM;
 	}




---
Subject: sched: Add CPU_FILL()

Add the CPU_FILL() macros to easily create an all-set cpumask.

FreeBSD also provides this macro with this semantic.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 posix/bits/cpu-set.h | 10 ++++++++++
 posix/sched.h        |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/posix/bits/cpu-set.h b/posix/bits/cpu-set.h
index 16037eae30..c65332461f 100644
--- a/posix/bits/cpu-set.h
+++ b/posix/bits/cpu-set.h
@@ -45,6 +45,8 @@ typedef struct
 #if __GNUC_PREREQ (2, 91)
 # define __CPU_ZERO_S(setsize, cpusetp) \
   do __builtin_memset (cpusetp, '\0', setsize); while (0)
+# define __CPU_FILL_S(setsize, cpusetp) \
+  do __builtin_memset (cpusetp, 0xFF, setsize); while (0)
 #else
 # define __CPU_ZERO_S(setsize, cpusetp) \
   do {									      \
@@ -54,6 +56,14 @@ typedef struct
     for (__i = 0; __i < __imax; ++__i)					      \
       __bits[__i] = 0;							      \
   } while (0)
+# define __CPU_FILL_S(setsize, cpusetp) \
+  do {									      \
+    size_t __i;								      \
+    size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+    __cpu_mask *__bits = (cpusetp)->__bits;				      \
+    for (__i = 0; __i < __imax; ++__i)					      \
+      __bits[__i] = ~0UL;						      \
+  } while (0)
 #endif
 #define __CPU_SET_S(cpu, setsize, cpusetp) \
   (__extension__							      \
diff --git a/posix/sched.h b/posix/sched.h
index 9b254ae840..a7f6638353 100644
--- a/posix/sched.h
+++ b/posix/sched.h
@@ -94,6 +94,7 @@ extern int __REDIRECT_NTH (sched_rr_get_interval,
 # define CPU_ISSET(cpu, cpusetp) __CPU_ISSET_S (cpu, sizeof (cpu_set_t), \
 						cpusetp)
 # define CPU_ZERO(cpusetp)	 __CPU_ZERO_S (sizeof (cpu_set_t), cpusetp)
+# define CPU_FILL(cpusetp)	 __CPU_FILL_S (sizeof (cpu_set_t), cpusetp)
 # define CPU_COUNT(cpusetp)	 __CPU_COUNT_S (sizeof (cpu_set_t), cpusetp)
 
 # define CPU_SET_S(cpu, setsize, cpusetp)   __CPU_SET_S (cpu, setsize, cpusetp)
@@ -101,6 +102,7 @@ extern int __REDIRECT_NTH (sched_rr_get_interval,
 # define CPU_ISSET_S(cpu, setsize, cpusetp) __CPU_ISSET_S (cpu, setsize, \
 							   cpusetp)
 # define CPU_ZERO_S(setsize, cpusetp)	    __CPU_ZERO_S (setsize, cpusetp)
+# define CPU_FILL_S(setsize, cpusetp)	    __CPU_FILL_S (setsize, cpusetp)
 # define CPU_COUNT_S(setsize, cpusetp)	    __CPU_COUNT_S (setsize, cpusetp)
 
 # define CPU_EQUAL(cpusetp1, cpusetp2) \
