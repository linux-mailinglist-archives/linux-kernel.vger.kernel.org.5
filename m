Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5277A329E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjIPVeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIPVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 17:33:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129EC1A5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 14:33:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313e742a787so2075369f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694899998; x=1695504798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xrrt2suSJ6gjUVAnhNjeD14TylLZKxWwTvYr5KCOAJ8=;
        b=X3ci8nxNygDRqRLKnKYrt55/S2vs+pscizKqpqfCe9vZLXXIJUSHc7zB/BwFYbtoiU
         kdph2gzze7Qj9NNkfqt8amw6UnXIHYiJD9Wj6CK4Pxv9Tr905bWCGrZgiL3ck2ybk4JA
         QrKprP0zipqnw9Qep8pYNlVwqjq1KKS5F2IXpjTO/AC8N/R82iAEo1P3eIDHbh29g4SX
         PL/oJIsW7UiP5aHVWx6sxJ3gDiixXKAvyvuk9sn4P/lbcQ5dWnJI+7xVf8+rcP9PlbY/
         cdJWPPv5jaLJsGubXdk97HHREimTYBCRFQNIf1Jq8+5hC+u5KqmvWODYiceiGQfEdEsC
         M7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694899998; x=1695504798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xrrt2suSJ6gjUVAnhNjeD14TylLZKxWwTvYr5KCOAJ8=;
        b=YucyTn+lz55etRXZc/C2NjabVIhhvZDuPtLDXzPmcHuMn9MssDPGhrWom1TcOY6Ojc
         wpV0T2GTLNhIETFIf6yJ05IyGITnZXTFBu3HelMGsvYz9f00MvRm7xfexGp2YQroE2gX
         QIo04SnyATRZFe0Kxs2/rTBah+Xgqs+pXQXwNJGDkfF8ZyVdcl9zx5P8lTWIFj8e7j56
         8nzBDAt5tu5r/wBs3kkCTu/nYiWo1Fi3I+YfdWrRIIeWQNpZ3PX9PWI0LWrbe3O9nYZ/
         8UxWtwivEmFJ9f1b5CjPwUxIRfeH+gZlvVaalhlc7ef5hEOIJeArrwIRLpzYDwFG75Hc
         ++yQ==
X-Gm-Message-State: AOJu0Yyp+GSHTIS0GmHG83w5tg1fhy2ytZimqKpQ19a9E2Vxm2at97ed
        z8NRSaaTGJokgVIbjzierLXU+A==
X-Google-Smtp-Source: AGHT+IFYfccGoJvIVNhXPq+pu5GEv/o7bwuSFp4x7XpyEXJn/kGU542MufeSyvLlCdm126f6lF7ApQ==
X-Received: by 2002:a05:6000:a14:b0:314:1096:6437 with SMTP id co20-20020a0560000a1400b0031410966437mr2254734wrb.19.1694899998392;
        Sat, 16 Sep 2023 14:33:18 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6184000000b003176c6e87b1sm8132440wru.81.2023.09.16.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 14:33:17 -0700 (PDT)
Date:   Sat, 16 Sep 2023 22:33:16 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        daniel.m.jordan@oracle.com
Subject: Re: [PATCH 0/2] sched/eevdf: sched_attr::sched_runtime slice hint
Message-ID: <20230916213316.p36nhgnibsidoggt@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915124354.416936110@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/23 14:43, peterz@infradead.org wrote:
> Hi,
> 
> As promised a while ago, here is a new version of the variable slice length
> hint stuff.  Back when I asked for comments on the latency-nice vs slice length
> thing, there was very limited feedback on-list, a number of people have
> expressed interrest in the slice length hint.

I did try to give feedback then, but I don't see my email on lore and not sure
if it arrived.

As it stands having any interface to help describe latency sensitive tasks is
much desired! So I am desperate enough to take whatever.

But at the same time, I do see that we will not stop here. And we get a lot of
conflicting requirements from different workloads that I think we need
a framework to help provide sensible way to allow us describe those needs to
help the scheduler manage resources better.

I wasn't sure if you're still planning to send an interface or not, so was
working on this potential way (patch below) to provide a generic framework for
sched-qos. It's only a shell as I didn't get a chance yet to implement the
WAKEUP_LATENCY hint yet.

I did add the concept of grouping the hint to be meaningful for a group of
tasks sharing a cookie. Borrowing the concept from core scheduling. I've seen
many times how priorities (or nice) was used incorrectly with the assumption
that it applies to the apps tasks only. Which might be the case with autogroup
on some systems. But it struck a chord then that there's a perception/desire
not to apply it globally but only relative to a group of tasks they care about.
So I catered to allow describing such cases.

I was still trying to wrap my head around implementing WAKEUP_LATENCY hint, but
the idea I had is to represent WAKEUP_LATENCY in us time and somehow translate
this into lag. Which what I thought is our admission control. Based on your
patch it seems it might be simpler than this.

Was still thinking this through to be honest. But it seems it's either speak
now or forever hold, so here you go :)


Cheers

--
Qais Yousef

--->8---

From d6c83e05a81ac4ca34e99cb1f56d1acdacc63362 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qyousef@layalina.io>
Date: Sat, 26 Aug 2023 17:39:31 +0100
Subject: [PATCH] sched: Add a new sched-qos interface

The need to describe the conflicting demand of various workloads hasn't
been higher. Both hardware and software has moved rapidly in the past
decade and system usage is more diverse and the number of workloads
expected to run on the same machine whether on Mobile or Server markets
has created a big dilemma on how to better manage those requirements.

The problem is that we lack mechanisms to allow these workloads to
describe what they need, and then allow kernel to do best efforts to
manage those demands based on the hardware it is running on
transparently and current system state.

Example of conflicting requirements that come across frequently:

	1. Improve wake up latency without for SCHED_OTHER. Many tasks
	   end up using SCHED_FIFO/SCHED_RR to compensate for this
	   shortcoming. RT tasks lack power management and fairness and
	   can be hard and error prone to use correctly and portably.

	2. Prefer spreading vs prefer packing on wake up for a group of
	   tasks. Geekbench-like workloads would benefit from
	   parallelising on different CPUs. hackbench type of workloads
	   can benefit from waking on up same CPUs or a CPU that is
	   closer in the cache hierarchy.

	3. Nice values for SCHED_OTHER are system wide and require
	   privileges. Many workloads would like a way to set relative
	   nice value so they can preempt each others, but not be
	   impact or be impacted by other tasks belong to different
	   workloads on the system.

	4. Provide a way to tag some tasks as 'background' to keep them
	   out of the way. SCHED_IDLE is too strong for some of these
	   tasks but yet they can be computationally heavy. Example
	   tasks are garbage collectors. Their work is both important
	   and not important.

Whether any of these use cases warrants an additional QoS hint is
something to be discussed individually. But the main point is to
introduce an interface that can be extendable to cater for potentially
those requirements and more. Wake up latency is the major driving use
case that has brewing already for years and it is the first QoS hint to
be introduced in later patches.

It is desired to have apps (and benchmarks!) directly use this interface
for optimal perf/watt. But in the absence of such support, it should be
possible to write a userspace daemon to monitor workloads and apply
these QoS hints on apps behalf based on analysis done by anyone
interested in improving the performance of those workloads.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 Documentation/scheduler/index.rst     |  1 +
 Documentation/scheduler/sched-qos.rst | 44 +++++++++++++++++++++++++
 include/uapi/linux/sched.h            |  4 +++
 include/uapi/linux/sched/types.h      | 46 +++++++++++++++++++++++++++
 kernel/sched/core.c                   |  3 ++
 tools/include/uapi/linux/sched.h      |  4 +++
 6 files changed, 102 insertions(+)
 create mode 100644 Documentation/scheduler/sched-qos.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 3170747226f6..fef59d7cd8e2 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -20,6 +20,7 @@ Scheduler
     sched-rt-group
     sched-stats
     sched-debug
+    sched-qos
 
     text_files
 
diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
new file mode 100644
index 000000000000..0911261cb124
--- /dev/null
+++ b/Documentation/scheduler/sched-qos.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Scheduler QoS
+=============
+
+1. Introduction
+===============
+
+Different workloads have different scheduling requirements to operate
+optimally. The same applies to tasks within the same workload.
+
+To enable smarter usage of system resources and to cater for the conflicting
+demands of various tasks, Scheduler QoS provides a mechanism to provide more
+information about those demands so that scheduler can do best-effort to
+honour them.
+
+  @sched_qos_type	what QoS hint to apply
+  @sched_qos_value	value of the QoS hint
+  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
+			applies. If 0, the hint will apply globally system
+			wide. If not 0, the hint will be relative to tasks that
+			has the same cookie value only.
+
+QoS hints are set once and not inherited by children by design. The
+rationale is that each task has its individual characteristics and it is
+encouraged to describe each of these separately. Also since system resources
+are finite, there's a limit to what can be done to honour these requests
+before reaching a tipping point where there are too many requests for
+a particular QoS that is impossible to service for all of them at once and
+some will start to lose out. For example if 10 tasks require better wake
+up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
+4 can perceive the hint honoured and the rest will have to wait. Inheritance
+can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
+hint will lose its meaning and effectiveness rapidly. The chances of 10
+tasks waking up at the same time is lower than a 100 and lower than a 1000.
+
+To set multiple QoS hints, a syscall is required for each. This is a
+trade-off to reduce the churn on extending the interface as the hope for
+this to evolve as workloads and hardware get more sophisticated and the
+need for extension will arise; and when this happen the task should be
+simpler to add the kernel extension and allow userspace to use readily by
+setting the newly added flag without having to update the whole of
+sched_attr.
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..67ef99f64ddc 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -102,6 +102,9 @@ struct clone_args {
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
 };
+
+enum sched_qos_type {
+};
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
@@ -132,6 +135,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_QOS			0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index f2c4589d4dbf..8c2658ffe4bd 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -98,6 +98,48 @@ struct sched_param {
  * scheduled on a CPU with no more capacity than the specified value.
  *
  * A task utilization boundary can be reset by setting the attribute to -1.
+ *
+ * Scheduler QoS
+ * =============
+ *
+ * Different workloads have different scheduling requirements to operate
+ * optimally. The same applies to tasks within the same workload.
+ *
+ * To enable smarter usage of system resources and to cater for the conflicting
+ * demands of various tasks, Scheduler QoS provides a mechanism to provide more
+ * information about those demands so that scheduler can do best-effort to
+ * honour them.
+ *
+ *  @sched_qos_type	what QoS hint to apply
+ *  @sched_qos_value	value of the QoS hint
+ *  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
+ *			applies. If 0, the hint will apply globally system
+ *			wide. If not 0, the hint will be relative to tasks that
+ *			has the same cookie value only.
+ *
+ * QoS hints are set once and not inherited by children by design. The
+ * rationale is that each task has its individual characteristics and it is
+ * encouraged to describe each of these separately. Also since system resources
+ * are finite, there's a limit to what can be done to honour these requests
+ * before reaching a tipping point where there are too many requests for
+ * a particular QoS that is impossible to service for all of them at once and
+ * some will start to lose out. For example if 10 tasks require better wake
+ * up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
+ * 4 can perceive the hint honoured and the rest will have to wait. Inheritance
+ * can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
+ * hint will lose its meaning and effectiveness rapidly. The chances of 10
+ * tasks waking up at the same time is lower than a 100 and lower than a 1000.
+ *
+ * To set multiple QoS hints, a syscall is required for each. This is a
+ * trade-off to reduce the churn on extending the interface as the hope for
+ * this to evolve as workloads and hardware get more sophisticated and the
+ * need for extension will arise; and when this happen the task should be
+ * simpler to add the kernel extension and allow userspace to use readily by
+ * setting the newly added flag without having to update the whole of
+ * sched_attr.
+ *
+ * Details about the available QoS hints can be found in:
+ * Documentation/scheduler/sched-qos.rst
  */
 struct sched_attr {
 	__u32 size;
@@ -120,6 +162,10 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	__u32 sched_qos_type;
+	__s64 sched_qos_value;
+	__u32 sched_qos_cookie;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848978a0..efc658f0f6e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7680,6 +7680,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_QOS)
+		return -ENOSYS;
+
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
 	 * information.
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 3bac0a8ceab2..67ef99f64ddc 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -102,6 +102,9 @@ struct clone_args {
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
 };
+
+enum sched_qos_type {
+};
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
@@ -132,6 +135,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_QOS			0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
-- 
2.34.1

