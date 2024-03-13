Return-Path: <linux-kernel+bounces-102507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C294187B311
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CF0287389
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113E5339D;
	Wed, 13 Mar 2024 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HmLkOYMo"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7F225AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363392; cv=none; b=eXwlHeN/EkdYYDMPrI3zkwv6vfxsNbJfKuVIj9fAKNC/KZ1yiW3wWLF0rulDejDaYQrfTrei2dlB8iW6ixVCeRwagvKFIi0Wp/HdPfi/8HSurMezNXOQ6r47MJHNu7jhAwwEJ1GS9/oWQtAGhf0qErq8BGonPg8L26mu95wsBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363392; c=relaxed/simple;
	bh=h7MYZvQ42ZrkU+g07VqiXmidevdYRk1IO5cCImEWhZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BytAXvOJgzSOXIe1Mfd6JyIQVshMoTakRyBdCBpqkOjSb3grnOSY8Hyg535FLv/Ol5boFb03BmcP3ZoXnBPSvn/VEtlwmEcGfiln4B9dSs7k3PPF0BAznutFaO8PfsRfwhoc7xf+e+jjy2PTWeP9mASknI7amHiVLMwoKJzW/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HmLkOYMo; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710363382;
	bh=h7MYZvQ42ZrkU+g07VqiXmidevdYRk1IO5cCImEWhZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmLkOYMoEc4qLDE2XTDsTMz8UY18NWo/MBEJTqvVW3Cb/xxq0S3kPECJfD6RUsZ6R
	 IQmMfVgOKHr9iTDlu1sO6CdtwQVBT6BCEuMHz7sij/MqxVtmDD7mxdRhkN8u2CFUbB
	 ceRHdL6NLt4FLwLjPGeF0jMko57CsQwS8d1E14akCgtZCWmqIdBScECIWlnfpc+F+g
	 eHFJ81OuMiO6u2P0KG4eEQpMdvHxbbFdZAo41uc7cQ3mvPbf1EstTdGwu6DyokLoGu
	 xfng3mSXb2m5cWKYRwN5L1XGkARZsP43vqAUil3MJNSaODuGizgE5KXd8TgE8O/r/T
	 Laa5xUi0G/JPg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tw2qV0tPyzjQk;
	Wed, 13 Mar 2024 16:56:22 -0400 (EDT)
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
Subject: [RFC PATCH 2/2] sched/membarrier: Use serialized smp_call_function APIs
Date: Wed, 13 Mar 2024 16:56:22 -0400
Message-Id: <20240313205622.2179659-3-mathieu.desnoyers@efficios.com>
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

Use the serialized smp_call_function APIs to issue IPIs, thus limiting
the rate at which IPIs can be generated for each CPU.

Limiting the rate of IPIs at the smp_call_function level ensures that
various mechanisms cannot be combined to overwhelm a CPU with IPIs.

This allows removing the IPI serialization mutex introduced by commit
944d5fe50f3f ("sched/membarrier: reduce the ability to hammer on
sys_membarrier"), which restores scaling of membarrier
MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ targeting a specific CPU with
MEMBARRIER_CMD_FLAG_CPU. This is used in Google tcmalloc for cross-CPU
operations.

[ I do not have numbers justifying the benefit of moving to a per-CPU
  mutex for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ targeting a specific
  CPU. Perhaps Google folks using this have benchmarks that can provide
  those numbers ? ]

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
 kernel/sched/membarrier.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 4e715b9b278e..368afd35c1de 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -162,9 +162,6 @@
 	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK			\
 	| MEMBARRIER_CMD_GET_REGISTRATIONS)
 
-static DEFINE_MUTEX(membarrier_ipi_mutex);
-#define SERIALIZE_IPI() guard(mutex)(&membarrier_ipi_mutex)
-
 static void ipi_mb(void *info)
 {
 	smp_mb();	/* IPIs should be serializing but paranoid. */
@@ -262,7 +259,6 @@ static int membarrier_global_expedited(void)
 	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
-	SERIALIZE_IPI();
 	cpus_read_lock();
 	rcu_read_lock();
 	for_each_online_cpu(cpu) {
@@ -295,9 +291,7 @@ static int membarrier_global_expedited(void)
 	}
 	rcu_read_unlock();
 
-	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
-	preempt_enable();
+	smp_call_function_many_serialize(tmpmask, ipi_mb, NULL, 1);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
@@ -351,7 +345,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	if (cpu_id < 0 && !zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
-	SERIALIZE_IPI();
 	cpus_read_lock();
 
 	if (cpu_id >= 0) {
@@ -382,10 +375,10 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 
 	if (cpu_id >= 0) {
 		/*
-		 * smp_call_function_single() will call ipi_func() if cpu_id
-		 * is the calling CPU.
+		 * smp_call_function_single_serialize() will call
+		 * ipi_func() if cpu_id is the calling CPU.
 		 */
-		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
+		smp_call_function_single_serialize(cpu_id, ipi_func, NULL, 1);
 	} else {
 		/*
 		 * For regular membarrier, we can save a few cycles by
@@ -405,11 +398,9 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		 * rseq critical section.
 		 */
 		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
-			preempt_disable();
-			smp_call_function_many(tmpmask, ipi_func, NULL, true);
-			preempt_enable();
+			smp_call_function_many_serialize(tmpmask, ipi_func, NULL, true);
 		} else {
-			on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
+			on_each_cpu_mask_serialize(tmpmask, ipi_func, NULL, true);
 		}
 	}
 
@@ -465,7 +456,6 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	 * between threads which are users of @mm has its membarrier state
 	 * updated.
 	 */
-	SERIALIZE_IPI();
 	cpus_read_lock();
 	rcu_read_lock();
 	for_each_online_cpu(cpu) {
@@ -478,7 +468,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	}
 	rcu_read_unlock();
 
-	on_each_cpu_mask(tmpmask, ipi_sync_rq_state, mm, true);
+	on_each_cpu_mask_serialize(tmpmask, ipi_sync_rq_state, mm, true);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
-- 
2.39.2


