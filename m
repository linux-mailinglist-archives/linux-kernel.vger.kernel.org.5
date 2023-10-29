Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48C7DAE9C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjJ2Vdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjJ2Vdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:33:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576B97
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:33:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698615208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mUY6ElB5v1dxSX48fosPPZCjVphm65D1oI+XbUs9zGU=;
        b=TaonmGZzn51T/7oEbgYghujsK6fyi7EN+WBQWBe6v0fmktqYRJI5JTf8NdVBFCh1Dyr/vl
        /M5f6L0UfieoJaSqYdXhAv+na8RtKNn/5Zg2a8dvzNZGtMo7ISRSPqz90uG+oxRz984W/F
        X9WgjIFDWA/tFDfMmePP5bRVfWqxckfocvhSc22p6tIpsLvLUXPQeIuo+2gxiEJedoNw3W
        yg0xbnWhnjTwKg1KvoHLKHO69JT3DxYQTEdeRG5wF27yRHnOqt+KAv0kXAop5VocG+7E+u
        S3MbI64LTZ/68p/hMD0RsGuPWvP2gFCT68h3fPSgl3qwNEFlGYpda9oADhtPmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698615208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mUY6ElB5v1dxSX48fosPPZCjVphm65D1oI+XbUs9zGU=;
        b=UmIr9cbgA6aSFUobm/S1oYwuFwZDNObjBv1sjCf5MGx3pPtKSTzDaN3C5c7D0R8wvz/JaL
        ztrqHS++j9t5SMDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.7-rc1
References: <169861500709.181063.7816209662289132093.tglx@xen13>
Message-ID: <169861501025.181063.9297786167357798627.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 22:33:27 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-10=
-29-v2

up to:  38685e2a0476: cpu/hotplug: Don't offline the last non-isolated CPU

Updates for SMP and CPU hotplug:

  - Switch the smp_call_function*() @csd argument to call_single_data_t
    type, which is a cache-line aligned typedef of the underlying struct
    __call_single_data.

    This ensures that the call data is not crossing a cacheline which
    avoids bouncing an extra cache-line for the SMP function call

  - Prevent offlining of the last housekeeping CPU when CPU isolation is
    active.

    Offlining the last housekeeping CPU makes no sense in general, but also
    caused the scheduler to panic due to the empty CPU mask when rebuilding
    the scheduler domains.

  - Remove an unused CPU hotplug state


Thanks,

	tglx

------------------>
Leonardo Bras (1):
      smp: Change function signatures to use call_single_data_t

Olaf Hering (1):
      cpu/hotplug: Remove unused cpuhp_state CPUHP_AP_X86_VDSO_VMA_ONLINE

Ran Xiaokai (1):
      cpu/hotplug: Don't offline the last non-isolated CPU


 include/linux/cpuhotplug.h |  1 -
 include/linux/smp.h        |  2 +-
 include/trace/events/csd.h |  8 ++++----
 kernel/cpu.c               | 11 +++++++----
 kernel/smp.c               | 26 +++++++++++++-------------
 kernel/up.c                |  2 +-
 6 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 068f7738be22..d246d325918a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -204,7 +204,6 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ONLINE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
-	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
 	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 91ea4a67f8ca..e87520dc2959 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t fun=
c, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
=20
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
=20
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
index 67e9d01f80c2..58cc83b99c34 100644
--- a/include/trace/events/csd.h
+++ b/include/trace/events/csd.h
@@ -12,7 +12,7 @@ TRACE_EVENT(csd_queue_cpu,
 	TP_PROTO(const unsigned int cpu,
 		unsigned long callsite,
 		smp_call_func_t func,
-		struct __call_single_data *csd),
+		call_single_data_t *csd),
=20
 	TP_ARGS(cpu, callsite, func, csd),
=20
@@ -39,7 +39,7 @@ TRACE_EVENT(csd_queue_cpu,
  */
 DECLARE_EVENT_CLASS(csd_function,
=20
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
=20
 	TP_ARGS(func, csd),
=20
@@ -57,12 +57,12 @@ DECLARE_EVENT_CLASS(csd_function,
 );
=20
 DEFINE_EVENT(csd_function, csd_function_entry,
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 	TP_ARGS(func, csd)
 );
=20
 DEFINE_EVENT(csd_function, csd_function_exit,
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 	TP_ARGS(func, csd)
 );
=20
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6bb74ee..94430ea8b4a5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1515,11 +1515,14 @@ static int cpu_down_maps_locked(unsigned int cpu, enu=
m cpuhp_state target)
 	/*
 	 * Ensure that the control task does not run on the to be offlined
 	 * CPU to prevent a deadlock against cfs_b->period_timer.
+	 * Also keep at least one housekeeping cpu onlined to avoid generating
+	 * an empty sched_domain span.
 	 */
-	cpu =3D cpumask_any_but(cpu_online_mask, cpu);
-	if (cpu >=3D nr_cpu_ids)
-		return -EBUSY;
-	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
+	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN)=
) {
+		if (cpu !=3D work.cpu)
+			return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
+	}
+	return -EBUSY;
 }
=20
 static int cpu_down(unsigned int cpu, enum cpuhp_state target)
diff --git a/kernel/smp.c b/kernel/smp.c
index 8455a53465af..8c714583786b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -127,7 +127,7 @@ send_call_function_ipi_mask(struct cpumask *mask)
 }
=20
 static __always_inline void
-csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
+csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
 {
 	trace_csd_function_entry(func, csd);
 	func(info);
@@ -174,7 +174,7 @@ module_param(csd_lock_timeout, ulong, 0444);
 static atomic_t csd_bug_count =3D ATOMIC_INIT(0);
=20
 /* Record current CSD work for current CPU, NULL to erase. */
-static void __csd_lock_record(struct __call_single_data *csd)
+static void __csd_lock_record(call_single_data_t *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -189,13 +189,13 @@ static void __csd_lock_record(struct __call_single_data=
 *csd)
 		  /* Or before unlock, as the case may be. */
 }
=20
-static __always_inline void csd_lock_record(struct __call_single_data *csd)
+static __always_inline void csd_lock_record(call_single_data_t *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled))
 		__csd_lock_record(csd);
 }
=20
-static int csd_lock_wait_getcpu(struct __call_single_data *csd)
+static int csd_lock_wait_getcpu(call_single_data_t *csd)
 {
 	unsigned int csd_type;
=20
@@ -210,7 +210,7 @@ static int csd_lock_wait_getcpu(struct __call_single_data=
 *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u=
64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1=
, int *bug_id)
 {
 	int cpu =3D -1;
 	int cpux;
@@ -276,7 +276,7 @@ static bool csd_lock_wait_toolong(struct __call_single_da=
ta *csd, u64 ts0, u64 *
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static void __csd_lock_wait(struct __call_single_data *csd)
+static void __csd_lock_wait(call_single_data_t *csd)
 {
 	int bug_id =3D 0;
 	u64 ts0, ts1;
@@ -290,7 +290,7 @@ static void __csd_lock_wait(struct __call_single_data *cs=
d)
 	smp_acquire__after_ctrl_dep();
 }
=20
-static __always_inline void csd_lock_wait(struct __call_single_data *csd)
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
@@ -300,17 +300,17 @@ static __always_inline void csd_lock_wait(struct __call=
_single_data *csd)
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #else
-static void csd_lock_record(struct __call_single_data *csd)
+static void csd_lock_record(call_single_data_t *csd)
 {
 }
=20
-static __always_inline void csd_lock_wait(struct __call_single_data *csd)
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
=20
-static __always_inline void csd_lock(struct __call_single_data *csd)
+static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
 	csd->node.u_flags |=3D CSD_FLAG_LOCK;
@@ -323,7 +323,7 @@ static __always_inline void csd_lock(struct __call_single=
_data *csd)
 	smp_wmb();
 }
=20
-static __always_inline void csd_unlock(struct __call_single_data *csd)
+static __always_inline void csd_unlock(call_single_data_t *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
=20
@@ -376,7 +376,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *=
node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu =3D=3D smp_processor_id()) {
 		smp_call_func_t func =3D csd->func;
@@ -667,7 +667,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * Return: %0 on success or negative errno value on error
  */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	int err =3D 0;
=20
diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..df50828cc2f0 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *i=
nfo), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
=20
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	unsigned long flags;
=20

