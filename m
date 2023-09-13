Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855EB79E88A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjIMNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjIMNDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:03:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B219B4;
        Wed, 13 Sep 2023 06:03:18 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wb/APhQFGyMx84W31Q0gHe7XzN1/IU592+NvQ04bgvc=;
        b=y7dmEXWosAyV7xjx3joVAf9V6runeYiSYi2tPb/eBo4vKzddf9f7FGqetmeigmICpg0ot+
        y9ZUqIveLeDmwfl0gwmVCMscUZKRCTyZDyVDydQyB74VkQKqJ9X3LT3bJaaroCm6QU/aqc
        +nKkBFL6HD4QlQeBGJbtYrGXP/+uXJnSwIb4feO2JzDZtBidzYmx2SZRg7vcODoiTSHcNA
        y0S1i544AVdPSfSV9Vhnq2Bxz5AvUeTjILLd8gjf9gDSXc+n8urfU2XVaWhMBDzVkkLCym
        j/Xm9fW/ROgWPNtCf+FkvWQfREQX0GM7MDcrLgYzJAqMZFit5eLMfZT+TBxJFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wb/APhQFGyMx84W31Q0gHe7XzN1/IU592+NvQ04bgvc=;
        b=8iRoC1+g4tG8Hcvydy6eIXefTUelbBF56lzhfHxgQoEJVmQjMzai9GVCRXJ7cPTMNaCfC7
        dXcdkOXV7B/IewBQ==
From:   "tip-bot2 for Leonardo Bras" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Change function signatures to use call_single_data_t
Cc:     Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230831063129.335425-1-leobras@redhat.com>
References: <20230831063129.335425-1-leobras@redhat.com>
MIME-Version: 1.0
Message-ID: <169461019515.27769.14088820979826570090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     d090ec0df81e56556af3a2bf04a7e89347ae5784
Gitweb:        https://git.kernel.org/tip/d090ec0df81e56556af3a2bf04a7e89347ae5784
Author:        Leonardo Bras <leobras@redhat.com>
AuthorDate:    Thu, 31 Aug 2023 03:31:28 -03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 14:59:24 +02:00

smp: Change function signatures to use call_single_data_t

call_single_data_t is a size-aligned typedef of struct __call_single_data.

This alignment is desirable in order to have smp_call_function*() avoid
bouncing an extra cacheline in case of an unaligned csd, given this
would hurt performance.

Since the removal of struct request->csd in commit 660e802c76c8
("blk-mq: use percpu csd to remote complete instead of per-rq csd") there
are no current users of smp_call_function*() with unaligned csd.

Change every 'struct __call_single_data' function parameter to
'call_single_data_t', so we have warnings if any new code tries to
introduce an smp_call_function*() call with unaligned csd.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230831063129.335425-1-leobras@redhat.com
---
 include/linux/smp.h        |  2 +-
 include/trace/events/csd.h |  8 ++++----
 kernel/smp.c               | 26 +++++++++++++-------------
 kernel/up.c                |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 91ea4a6..e87520d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
index 67e9d01..58cc83b 100644
--- a/include/trace/events/csd.h
+++ b/include/trace/events/csd.h
@@ -12,7 +12,7 @@ TRACE_EVENT(csd_queue_cpu,
 	TP_PROTO(const unsigned int cpu,
 		unsigned long callsite,
 		smp_call_func_t func,
-		struct __call_single_data *csd),
+		call_single_data_t *csd),
 
 	TP_ARGS(cpu, callsite, func, csd),
 
@@ -39,7 +39,7 @@ TRACE_EVENT(csd_queue_cpu,
  */
 DECLARE_EVENT_CLASS(csd_function,
 
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 
 	TP_ARGS(func, csd),
 
@@ -57,12 +57,12 @@ DECLARE_EVENT_CLASS(csd_function,
 );
 
 DEFINE_EVENT(csd_function, csd_function_entry,
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 	TP_ARGS(func, csd)
 );
 
 DEFINE_EVENT(csd_function, csd_function_exit,
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 	TP_ARGS(func, csd)
 );
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 385179d..822fabb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -125,7 +125,7 @@ send_call_function_ipi_mask(struct cpumask *mask)
 }
 
 static __always_inline void
-csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
+csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
 {
 	trace_csd_function_entry(func, csd);
 	func(info);
@@ -172,7 +172,7 @@ module_param(csd_lock_timeout, ulong, 0444);
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void __csd_lock_record(struct __call_single_data *csd)
+static void __csd_lock_record(call_single_data_t *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -187,13 +187,13 @@ static void __csd_lock_record(struct __call_single_data *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline void csd_lock_record(struct __call_single_data *csd)
+static __always_inline void csd_lock_record(call_single_data_t *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled))
 		__csd_lock_record(csd);
 }
 
-static int csd_lock_wait_getcpu(struct __call_single_data *csd)
+static int csd_lock_wait_getcpu(call_single_data_t *csd)
 {
 	unsigned int csd_type;
 
@@ -208,7 +208,7 @@ static int csd_lock_wait_getcpu(struct __call_single_data *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -272,7 +272,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static void __csd_lock_wait(struct __call_single_data *csd)
+static void __csd_lock_wait(call_single_data_t *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -286,7 +286,7 @@ static void __csd_lock_wait(struct __call_single_data *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
-static __always_inline void csd_lock_wait(struct __call_single_data *csd)
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
@@ -296,17 +296,17 @@ static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #else
-static void csd_lock_record(struct __call_single_data *csd)
+static void csd_lock_record(call_single_data_t *csd)
 {
 }
 
-static __always_inline void csd_lock_wait(struct __call_single_data *csd)
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
-static __always_inline void csd_lock(struct __call_single_data *csd)
+static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
 	csd->node.u_flags |= CSD_FLAG_LOCK;
@@ -319,7 +319,7 @@ static __always_inline void csd_lock(struct __call_single_data *csd)
 	smp_wmb();
 }
 
-static __always_inline void csd_unlock(struct __call_single_data *csd)
+static __always_inline void csd_unlock(call_single_data_t *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
@@ -372,7 +372,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -658,7 +658,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * Return: %0 on success or negative errno value on error
  */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index a38b8b0..df50828 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	unsigned long flags;
 
