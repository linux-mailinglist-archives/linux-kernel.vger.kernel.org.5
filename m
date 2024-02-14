Return-Path: <linux-kernel+bounces-66167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AF855809
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826D6B26529
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABA145328;
	Wed, 14 Feb 2024 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQtRtd7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBA2556E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955048; cv=none; b=oBSx6OQX92lp4bRIzNdc6V31OtvwQAGDaceWIBzfZn8K6l79pvpc6KUpmERU8mqzt0APsaP/9oPjzRTI6JutEjgw5FvjNL6Y4XfYH1eeBjeWxgV5qoPTtvVBlL2W6DDHhVk5FAiRl+cnRb/qSNZEV7w+zMt5D3NMNeEAD8Bbim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955048; c=relaxed/simple;
	bh=S28Gy7X06+rDChdwBaRrBW+KGylSKI63Gb3GgRAnzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9IP7getZr4tTEGSSUpIdoHhw9oePsYDar+aYreWeKxEk0WF77RlxjSNireKSdKtKQGA3TbCmXSKnaf9pKDxY9zX263bzt7lphji52OWqAPGIP/tRooaS9R3w1YyTeNRBC+ees5shdxK3U6ULJwNMrHlyHBpB+0Pw+210e3G7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQtRtd7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241B0C43394;
	Wed, 14 Feb 2024 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955048;
	bh=S28Gy7X06+rDChdwBaRrBW+KGylSKI63Gb3GgRAnzqw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DQtRtd7thF5LxATYJbThMmxR11w3jiBa6lw9nbXOses4br86Yh/5RWDEmsGKyGWn9
	 O34r5tkzg8xofEAnleCAvFi5bpsOaw6QggzRzBH4DhnAUTa+tC+iKSVAN6yGXQBJJ0
	 UOGJJ/9PHE5XfrzeRPiyjHu2WHWyprHE4Xea5bynciT/ABNEc5vITVBhhxd2kyvaNE
	 r4flP11oE5CkGDhPXgjcFgtnuQv5/LRz7htEsNaPpC9R79IgIyedfi4ptD1PYhBv7N
	 St6Ji7usU1dmqDErqwJD2RE+QDl7oyshJHHsnRnVlqoNV5oW0wfgFmY0JMcoInKJ90
	 YCK4XftMj16Wg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B2D83CE0D11; Wed, 14 Feb 2024 15:57:27 -0800 (PST)
Date: Wed, 14 Feb 2024 15:57:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>

On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> Hi,
> 
> This series adds a new scheduling model PREEMPT_AUTO, which like
> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> on explicit preemption points for the voluntary models.
> 
> The series is based on Thomas' original proposal which he outlined
> in [1], [2] and in his PoC [3].
> 
> An earlier RFC version is at [4].

This uncovered a couple of latent bugs in RCU due to its having been
a good long time since anyone built a !SMP preemptible kernel with
non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
likely for the merge window after next, but let me know if you need
them sooner.

I am also seeing OOM conditions during rcutorture testing of callback
flooding, but I am still looking into this.  The full diff on top of
your series on top of v6.8-rc4 is shown below.  Please let me know if
I have messed up the Kconfig options.

							Thanx, Paul

[1] 6a4352fd1418 ("rcu: Update lockdep while in RCU read-side critical section")
    1b85e92eabcd ("rcu: Make TINY_RCU depend on !PREEMPT_RCU rather than !PREEMPTION")

------------------------------------------------------------------------

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0746b1b0b6639..b0b61b8598b03 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -778,9 +778,9 @@ static inline void rcu_read_unlock(void)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock() used illegally while idle");
+	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
 	__release(RCU);
 	__rcu_read_unlock();
-	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
 }
 
 /**
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index d0ecc8ef17a72..6bf969857a85b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -31,7 +31,7 @@ config PREEMPT_RCU
 
 config TINY_RCU
 	bool
-	default y if !PREEMPTION && !SMP
+	default y if !PREEMPT_RCU && !SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for UP systems from which real-time response
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
index 07f5e0a70ae70..737389417c7b3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
@@ -3,8 +3,10 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_RCU_EXPERT=n
 CONFIG_KPROBES=n
 CONFIG_FTRACE=n
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
index c70cf0405f248..c9aca21d02f8c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -10,3 +11,4 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 #CHECK#CONFIG_PREEMPT_COUNT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
index 2f9fcffff5ae3..472259f9e0a6a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
@@ -1,8 +1,10 @@
 CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TASKS_RCU=y
 CONFIG_FORCE_TASKS_RCU=y
 CONFIG_RCU_EXPERT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
index 30439f6fc20e6..df408933e7013 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -13,3 +14,4 @@ CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 85b407467454a..2f75c7349d83a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -2,6 +2,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=5
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -12,3 +13,4 @@ CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index dc4985064b3ad..9ef845d54fa41 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -2,6 +2,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
@@ -16,3 +17,4 @@ CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_EQS_DEBUG=y
 CONFIG_RCU_LAZY=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 9f48c73709ec3..31afd943d85ef 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TREE_RCU=y
@@ -18,3 +19,4 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_PROVE_RCU_LIST=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
index db27651de04b8..1180fe36a3a12 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TREE_RCU=y
@@ -17,3 +18,4 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
 CONFIG_RCU_EXPERT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index d30922d8c8832..969e852bd618b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -15,3 +16,4 @@ CONFIG_RCU_FANOUT_LEAF=2
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index a323d8948b7cf..4af22599f13ed 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=56
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -16,3 +17,4 @@ CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_OBJECTS=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=n
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
index 5d546efa68e83..7b2c9fb0cd826 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
@@ -9,3 +10,4 @@ CONFIG_NO_HZ_FULL=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
index 0fa2dc086e10c..80230745e9dc7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -14,3 +15,4 @@ CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
index 0059592c7408a..eb47f36712305 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -1,5 +1,6 @@
 CONFIG_SMP=y
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -14,3 +15,4 @@ CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index 67f9d2998afd3..cb3219cb98c78 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -1,5 +1,6 @@
 CONFIG_SMP=y
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -18,3 +19,4 @@ CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_KPROBES=n
 CONFIG_FTRACE=n
+CONFIG_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
index 6133f54ce2a7d..241f28e965e57 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
@@ -1,5 +1,6 @@
 CONFIG_SMP=y
 CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
@@ -11,3 +12,4 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 CONFIG_KPROBES=n
 CONFIG_FTRACE=n
+CONFIG_EXPERT=y

