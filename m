Return-Path: <linux-kernel+bounces-102508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2587B312
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBC6B22688
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F25537E3;
	Wed, 13 Mar 2024 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="h8ap6ih3"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABB46426
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363392; cv=none; b=E7+8a3v0Cf9a4ugeMl0LLV1IzRqRW1yWO3auo4E+WsYKy0RguTIb0hrh2/n2eVWAcVQYqUBWakUB/O9gFHlQd2BBa3gTa3LxQ5RczNnkiqNB35X2AytNC2Bij+BQARXVh/9/hU+BO9szfDLSBlW8DJFb0OCuFRHGfyHVwWus2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363392; c=relaxed/simple;
	bh=+ixMxXZbF6tGR37dXYECixFdSQH03q9xUO4uAaRdoAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7Q+OdvzU1GqFBHtrzA9USxEwKNYFIyjj6jJg3RFQwdutc9MdnA2dkHEk6Cm5Ew7CRoi6MwvH/JcjNzzQbegf1kRg0ftpBlQa0nNhdVlt7csiJ7hkGwGEgzrmtf+Ii3PX4MN2zwfnIX8rV29BgtzWHGKjEuoBbNLzkC98D6iDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=h8ap6ih3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710363382;
	bh=+ixMxXZbF6tGR37dXYECixFdSQH03q9xUO4uAaRdoAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8ap6ih3xBUsxnyYYi2b8eTZen8AaEjN4adRfAkADQ7es97F0zDhaN2R8oM0OP7vW
	 TcJUuzNrFBZ6K8XJpiqZbyWsnQR5Zcsl2/YScJqaaz/10m4OM2Q+opD5E8/cJTQrys
	 tfTmvOTxYO+ascIdZVZvouk1LI+tnz9V0W2DvIT/k1JJP1fDynLijUC5i3R7M8fM2F
	 0eQ3x3++GNK3dN/sJzkaPk+kUu9XA85KLeNsYuUUVasDKSMATC8TK12FZ8XG6xovkX
	 Oxz+Z3F1oXA7o9lOzF2NISu+8VxsNHTb6TJP3VVOs99J0tabPSHEpobFFzE8X+sj+f
	 3lg9u0TyHIyKg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tw2qT5jdKzjnp;
	Wed, 13 Mar 2024 16:56:21 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Oskolkov <posk@google.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Hunter <ahh@google.com>,
	Maged Michael <maged.michael@gmail.com>,
	gromer@google.com,
	Avi Kivity <avi@scylladb.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [RFC PATCH 1/2] smp: Implement serialized smp_call_function APIs
Date: Wed, 13 Mar 2024 16:56:21 -0400
Message-Id: <20240313205622.2179659-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
References: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce serialized smp_call_function APIs to limit the number of
concurrent smp_call_function IPIs which can be sent to a given CPU to a
maximum of two: one broadcast and one specifically targeting the CPU.

- smp_call_function_single_serialize holds a per-target-cpu
  mutex while sending the IPI,
- smp_call_function_many_serialize, on_each_cpu_cond_mask_serialize,
  on_each_cpu_mask_serialize call smp_call_function_single_serialize
  if there is only one cpu in the mask, else grab the
  serialize_ipi_broadcast_lock mutex to use the broadcast IPIs.

Motivations for this new API:

- Prevent CPU-IPI-hammering from various IPI sources (other than
  membarrier) that rely on smp_call_function APIs to send IPIs.
- Restore scaling of membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
  targeting a specific CPU with MEMBARRIER_CMD_FLAG_CPU, which is
  serialized by a mutex by commit 944d5fe50f3f ("sched/membarrier:
  reduce the ability to hammer on sys_membarrier"). This is used in
  Google tcmalloc for cross-CPU operations.

My testing on an AMD EPYC 9654 shows that 5 IPI source CPUs are needed
to overwhelm one target CPU without commit 944d5fe50f3f. Therefore,
permitting two CPUs to concurrently IPI a given target CPU should not
allow overwhelming it. [ This should be confirmed by testing on other
hardware. ]

* nr_src=1
Runs OK
top output: %Cpu0  : 35.0 us, 65.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

* nr_src=2
Runs OK
top output: %Cpu0  : 19.1 us, 80.9 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

* nr_src=3
Runs OK
top output: %Cpu0  :  4.9 us, 94.1 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  1.0 si,  0.0 st

* nr_src=4
Runs OK, but "si" (time spent servicing software interrupts) is getting high:
top output: %Cpu0  :  0.0 us, 20.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 80.0 si,  0.0 st

* nr_src=5
"si" is now 100%. watchdog: BUG: soft lockup - CPU#0 stuck for 24s! [membarrier-hamm:5464]
%Cpu0  :  0.0 us,  0.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,100.0 si,  0.0 st

With this reproducer:

  #define _GNU_SOURCE
  #include <linux/membarrier.h> /* Definition of MEMBARRIER_* constants */
  #include <sys/syscall.h>      /* Definition of SYS_* constants */
  #include <unistd.h>
  #include <pthread.h>
  #include <sched.h>
  #include <stdlib.h>
  #include <stdio.h>

  #define NR_DEST 1
  #define NR_SRC  5

  static int
  membarrier(int cmd, unsigned int flags, int cpu_id)
  {
          return syscall(__NR_membarrier, cmd, flags, cpu_id);
  }

  void *ipi_dest(void *arg)
  {
          int ret;
          cpu_set_t mask;

          CPU_ZERO(&mask);
          CPU_SET(0, &mask);
          ret = sched_setaffinity(0, sizeof(mask), &mask);
          if (ret) {
                  perror("sched_setaffinity");
                  abort();
          }
          while (1) {
                  asm volatile ("rep; nop" : : : "memory");
          }
  }

  void *ipi_src(void *arg)
  {
          int ret;

          while (1) {
                  /* Hammer CPU 0 */
                  ret = membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
                                  MEMBARRIER_CMD_FLAG_CPU, 0);
                  if (ret) {
                          perror("membarrier");
                          abort();
                  }
          }
  }

  static
  void do_membarrier_hammer(void)
  {
          int ret, i;
          pthread_t dest_tid[NR_DEST];
          pthread_t src_tid[NR_SRC];

          for (i = 0; i < NR_DEST; i++) {
                  ret = pthread_create(&dest_tid[i], NULL,
                                  ipi_dest, NULL);
                  if (ret)
                          abort();
          }
          for (i = 0; i < NR_SRC; i++) {
                  ret = pthread_create(&src_tid[i], NULL,
                                  ipi_src, NULL);
                  if (ret)
                          abort();
          }

          for (i = 0; i < NR_DEST; i++) {
                  ret = pthread_join(dest_tid[i], NULL);
                  if (ret)
                          abort();
          }
          for (i = 0; i < NR_SRC; i++) {
                  ret = pthread_join(src_tid[i], NULL);
                  if (ret)
                          abort();
          }
  }

  int main()
  {
          int ret;

          ret = membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ, 0, 0);
          if (ret) {
                  perror("membarrier");
                  return -1;
          }
          do_membarrier_hammer();
          return 0;
  }

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: gromer@google.com
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Oskolkov <posk@google.com>
---
 include/linux/smp.h |  40 +++++++++++++++++
 kernel/smp.c        | 106 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520dc2959..cfc7df87fceb 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -160,6 +160,16 @@ void smp_call_function_many(const struct cpumask *mask,
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
 
+int smp_call_function_single_serialize(int cpuid, smp_call_func_t func,
+				       void *info, int wait);
+
+void smp_call_function_many_serialize(const struct cpumask *mask,
+				      smp_call_func_t func,
+				      void *info, bool wait);
+
+void on_each_cpu_cond_mask_serialize(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask);
+
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
 
@@ -215,6 +225,28 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 	return smp_call_function_single(0, func, info, wait);
 }
 
+static inline
+int smp_call_function_single_serialize(int cpuid, smp_call_func_t func,
+				       void *info, int wait)
+{
+	return smp_call_function_single(cpuid, func, info, wait);
+}
+
+static inline
+void smp_call_function_many_serialize(const struct cpumask *mask,
+				      smp_call_func_t func,
+				      void *info, bool wait)
+{
+	return smp_call_function_many(mask, func, info, wait);
+}
+
+static inline
+void on_each_cpu_cond_mask_serialize(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask)
+{
+	return on_each_cpu_cond_mask(cond_func, func, info, wait, mask);
+}
+
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
@@ -288,6 +320,14 @@ void smp_setup_processor_id(void);
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par,
 		    bool phys);
 
+static inline
+void on_each_cpu_mask_serialize(const struct cpumask *mask,
+				smp_call_func_t func,
+				void *info, bool wait)
+{
+	on_each_cpu_cond_mask_serialize(NULL, func, info, wait, mask);
+}
+
 /* SMP core functions */
 int smpcfd_prepare_cpu(unsigned int cpu);
 int smpcfd_dead_cpu(unsigned int cpu);
diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..4c58617a2c48 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -48,6 +48,10 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
 static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
 
+static DEFINE_PER_CPU(struct mutex, serialize_ipi_lock);
+
+static DEFINE_MUTEX(serialize_ipi_broadcast_lock);
+
 static void __flush_smp_call_function_queue(bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
@@ -102,9 +106,10 @@ void __init call_function_init(void)
 {
 	int i;
 
-	for_each_possible_cpu(i)
+	for_each_possible_cpu(i) {
 		init_llist_head(&per_cpu(call_single_queue, i));
-
+		mutex_init(&per_cpu(serialize_ipi_lock, i));
+	}
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
@@ -590,16 +595,9 @@ void flush_smp_call_function_queue(void)
 	local_irq_restore(flags);
 }
 
-/*
- * smp_call_function_single - Run a function on a specific CPU
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait until function has completed on other CPUs.
- *
- * Returns 0 on success, else a negative status code.
- */
-int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
-			     int wait)
+static
+int _smp_call_function_single(int cpu, smp_call_func_t func, void *info,
+			     int wait, bool serialize)
 {
 	call_single_data_t *csd;
 	call_single_data_t csd_stack = {
@@ -608,6 +606,9 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	int this_cpu;
 	int err;
 
+	if (serialize)
+		mutex_lock(&per_cpu(serialize_ipi_lock, cpu));
+
 	/*
 	 * prevent preemption and reschedule on another processor,
 	 * as well as CPU removal
@@ -651,10 +652,38 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	put_cpu();
 
+	if (serialize)
+		mutex_unlock(&per_cpu(serialize_ipi_lock, cpu));
+
 	return err;
 }
+
+/*
+ * smp_call_function_single - Run a function on a specific CPU
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait until function has completed on other CPUs.
+ *
+ * Returns 0 on success, else a negative status code.
+ */
+int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
+			     int wait)
+{
+	return _smp_call_function_single(cpu, func, info, wait, false);
+}
 EXPORT_SYMBOL(smp_call_function_single);
 
+/*
+ * Run a function on a specific CPU. Serialize the IPI to that CPU with
+ * a mutex.
+ */
+int smp_call_function_single_serialize(int cpu, smp_call_func_t func, void *info,
+			     int wait)
+{
+	return _smp_call_function_single(cpu, func, info, wait, true);
+}
+EXPORT_SYMBOL(smp_call_function_single_serialize);
+
 /**
  * smp_call_function_single_async() - Run an asynchronous function on a
  * 			         specific CPU.
@@ -880,6 +909,30 @@ void smp_call_function_many(const struct cpumask *mask,
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
+/* Call with preemption *enabled*. */
+void smp_call_function_many_serialize(const struct cpumask *mask,
+			    smp_call_func_t func, void *info, bool wait)
+{
+	unsigned int weight = cpumask_weight(mask);
+	int ret;
+
+	if (!weight)
+		return;
+
+	if (weight == 1) {
+		ret = smp_call_function_single_serialize(cpumask_first(mask), func, info, wait);
+		WARN_ON_ONCE(ret);
+		return;
+	}
+
+	mutex_lock(&serialize_ipi_broadcast_lock);
+	preempt_disable();
+	smp_call_function_many_cond(mask, func, info, wait * SCF_WAIT, NULL);
+	preempt_enable();
+	mutex_unlock(&serialize_ipi_broadcast_lock);
+}
+EXPORT_SYMBOL(smp_call_function_many_serialize);
+
 /**
  * smp_call_function(): Run a function on all other CPUs.
  * @func: The function to run. This must be fast and non-blocking.
@@ -1025,6 +1078,35 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
+/* Call with preemption enabled. */
+void on_each_cpu_cond_mask_serialize(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask)
+{
+	int cpu, ret;
+	unsigned int scf_flags = SCF_RUN_LOCAL, weight = cpumask_weight(mask);
+
+	if (!weight)
+		return;
+
+	if (weight == 1) {
+		cpu = cpumask_first(mask);
+		if (cond_func && !cond_func(cpu, info))
+			return;
+		ret = smp_call_function_single_serialize(cpu, func, info, wait);
+		WARN_ON_ONCE(ret);
+	}
+
+	if (wait)
+		scf_flags |= SCF_WAIT;
+
+	mutex_lock(&serialize_ipi_broadcast_lock);
+	preempt_disable();
+	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
+	preempt_enable();
+	mutex_unlock(&serialize_ipi_broadcast_lock);
+}
+EXPORT_SYMBOL(on_each_cpu_cond_mask_serialize);
+
 static void do_nothing(void *unused)
 {
 }
-- 
2.39.2


