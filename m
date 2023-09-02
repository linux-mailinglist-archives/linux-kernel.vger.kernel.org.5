Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156737908A8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjIBQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjIBQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:17:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7ECE;
        Sat,  2 Sep 2023 09:17:29 -0700 (PDT)
Date:   Sat, 02 Sep 2023 16:17:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693671446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bofz02cguqv8bwGl788sARA0ynb85E5Y7l5AZw5pEQw=;
        b=KXrPt0YoJNchanJ/yWL5wvCCo97lpTmOC1lElmVxR16K7uQl97Y8gC+sD2EgkML0cK9jTN
        Z5yp7B79o+e6mvTrcL4aIjM3jzSj8WxslKqZjv37b8oQ30cbNTF9v/PZeJWPlEgqAVWUxj
        DfWkbqg95+xLH5QWBTgLaNJL7Z153DKy97HTBqILJxcGTXZatprEm/ed8fjElQx3Enw/YN
        HYWdWIiAWfKAHGOFAYk4n1Cvk9Az06NN6eykG5i63RBAitr80aNqIefTB5QH0VXchG7iCa
        O4acII/RuIg4KEn7O/9Uy6+qPaUwig8UARESbqSjSx2MKvL1kRS3x4WT9PFfeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693671446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bofz02cguqv8bwGl788sARA0ynb85E5Y7l5AZw5pEQw=;
        b=HniD+waXmrr1JijMl1bOWh+wpDigkS41SUcezj8GOJjnpOrVOFYSRuHpBJC6zzhHNvq7Hz
        JbvVdaSKeZMlirBQ==
From:   "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Optimize should_we_balance() for
 large SMT systems
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
References: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <169367144573.27769.15387724635981961527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f8858d96061f5942216c6abb0194c3ea7b78e1e8
Gitweb:        https://git.kernel.org/tip/f8858d96061f5942216c6abb0194c3ea7b7=
8e1e8
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Sat, 02 Sep 2023 13:42:04 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 02 Sep 2023 12:56:04 +02:00

sched/fair: Optimize should_we_balance() for large SMT systems

should_we_balance() is called in load_balance() to find out if the CPU that
is trying to do the load balance is the right one or not.

With commit:

  b1bfeab9b002("sched/fair: Consider the idle state of the whole core for loa=
d balance")

the code tries to find an idle core to do the load balancing
and falls back on an idle sibling CPU if there is no idle core.

However, on larger SMT systems, it could be needlessly iterating to find a
idle by scanning all the CPUs in an non-idle core. If the core is not idle,
and first SMT sibling which is idle has been found, then its not needed to
check other SMT siblings for idleness

Lets say in SMT4, Core0 has 0,2,4,6 and CPU0 is BUSY and rest are IDLE.
balancing domain is MC/DIE. CPU2 will be set as the first idle_smt and
same process would be repeated for CPU4 and CPU6 but this is unnecessary.
Since calling is_core_idle loops through all CPU's in the SMT mask, effect
is multiplied by weight of smt_mask. For example,when say 1 CPU is busy,
we would skip loop for 2 CPU's and skip iterating over 8CPU's. That
effect would be more in DIE/NUMA domain where there are more cores.

Testing and performance evaluation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The test has been done on this system which has 12 cores, i.e 24 small
cores with SMT=3D4:

  lscpu
  Architecture:            ppc64le
    Byte Order:            Little Endian
  CPU(s):                  96
    On-line CPU(s) list:   0-95
  Model name:              POWER10 (architected), altivec supported
    Thread(s) per core:    8

Used funclatency bcc tool to evaluate the time taken by should_we_balance(). =
For
base tip/sched/core the time taken is collected by making the
should_we_balance() noinline. time is in nanoseconds. The values are
collected by running the funclatency tracer for 60 seconds. values are
average of 3 such runs. This represents the expected reduced time with
patch.

tip/sched/core was at commit:

  2f88c8e802c8 ("sched/eevdf/doc: Modify the documented knob to base_slice_ns=
 as well")

Results:

	----------------------------------------------------------------------------=
--
	workload			   tip/sched/core	with_patch(%gain)
	----------------------------------------------------------------------------=
--
	idle system				 809.3		 695.0(16.45)
	stress ng =E2=80=93 12 threads -l 100		1013.5		 893.1(13.49)
	stress ng =E2=80=93 24 threads -l 100		1073.5		 980.0(9.54)
	stress ng =E2=80=93 48 threads -l 100		 683.0		 641.0(6.55)
	stress ng =E2=80=93 96 threads -l 100		2421.0		2300(5.26)
	stress ng =E2=80=93 96 threads -l 15		 375.5		 377.5(-0.53)
	stress ng =E2=80=93 96 threads -l 25		 635.5		 637.5(-0.31)
	stress ng =E2=80=93 96 threads -l 35		 934.0		 891.0(4.83)

Ran schbench(old), hackbench and stress_ng  to evaluate the workload
performance between tip/sched/core and with patch.
No modification to tip/sched/core

TL;DR:

Good improvement is seen with schbench. when hackbench and stress_ng
runs for longer good improvement is seen.

	----------------------------------------------------------------------------=
--
	schbench(old)		            tip		+patch(%gain)
	10 iterations			sched/core
	----------------------------------------------------------------------------=
--
	1 Threads
	50.0th:		      		    8.00       9.00(-12.50)
	75.0th:   			    9.60       9.00(6.25)
	90.0th:   			   11.80      10.20(13.56)
	95.0th:   			   12.60      10.40(17.46)
	99.0th:   			   13.60      11.90(12.50)
	99.5th:   			   14.10      12.60(10.64)
	99.9th:   			   15.90      14.60(8.18)
	2 Threads
	50.0th:   			    9.90       9.20(7.07)
	75.0th:   			   12.60      10.10(19.84)
	90.0th:   			   15.50      12.00(22.58)
	95.0th:   			   17.70      14.00(20.90)
	99.0th:   			   21.20      16.90(20.28)
	99.5th:   			   22.60      17.50(22.57)
	99.9th:   			   30.40      19.40(36.18)
	4 Threads
	50.0th:   			   12.50      10.60(15.20)
	75.0th:   			   15.30      12.00(21.57)
	90.0th:   			   18.60      14.10(24.19)
	95.0th:   			   21.30      16.20(23.94)
	99.0th:   			   26.00      20.70(20.38)
	99.5th:   			   27.60      22.50(18.48)
	99.9th:   			   33.90      31.40(7.37)
	8 Threads
	50.0th:   			   16.30      14.30(12.27)
	75.0th:   			   20.20      17.40(13.86)
	90.0th:   			   24.50      21.90(10.61)
	95.0th:   			   27.30      24.70(9.52)
	99.0th:   			   35.00      31.20(10.86)
	99.5th:   			   46.40      33.30(28.23)
	99.9th:   			   89.30      57.50(35.61)
	16 Threads
	50.0th:   			   22.70      20.70(8.81)
	75.0th:   			   30.10      27.40(8.97)
	90.0th:   			   36.00      32.80(8.89)
	95.0th:   			   39.60      36.40(8.08)
	99.0th:   			   49.20      44.10(10.37)
	99.5th:   			   64.90      50.50(22.19)
	99.9th:   			  143.50     100.60(29.90)
	32 Threads
	50.0th:   			   34.60      35.50(-2.60)
	75.0th:   			   48.20      50.50(-4.77)
	90.0th:   			   59.20      62.40(-5.41)
	95.0th:   			   65.20      69.00(-5.83)
	99.0th:   			   80.40      83.80(-4.23)
	99.5th:   			  102.10      98.90(3.13)
	99.9th:   			  727.10     506.80(30.30)

schbench does improve in general. There is some run to run variation with
schbench. Did a validation run to confirm that trend is similar.

	----------------------------------------------------------------------------=
--
	hackbench				tip	   +patch(%gain)
	20 iterations, 50000 loops	     sched/core
	----------------------------------------------------------------------------=
--
	Process 10 groups                :      11.74      11.70(0.34)
	Process 20 groups                :      22.73      22.69(0.18)
	Process 30 groups                :      33.39      33.40(-0.03)
	Process 40 groups                :      43.73      43.61(0.27)
	Process 50 groups                :      53.82      54.35(-0.98)
	Process 60 groups                :      64.16      65.29(-1.76)
	thread 10 Time                   :      12.81      12.79(0.16)
	thread 20 Time                   :      24.63      24.47(0.65)
	Process(Pipe) 10 Time            :       6.40       6.34(0.94)
	Process(Pipe) 20 Time            :      10.62      10.63(-0.09)
	Process(Pipe) 30 Time            :      15.09      14.84(1.66)
	Process(Pipe) 40 Time            :      19.42      19.01(2.11)
	Process(Pipe) 50 Time            :      24.04      23.34(2.91)
	Process(Pipe) 60 Time            :      28.94      27.51(4.94)
	thread(Pipe) 10 Time             :       6.96       6.87(1.29)
	thread(Pipe) 20 Time             :      11.74      11.73(0.09)

hackbench shows slight improvement with pipe. Slight degradation in process.

	----------------------------------------------------------------------------=
--
	stress_ng				tip        +patch(%gain)
	10 iterations 100000 cpu_ops	     sched/core
	----------------------------------------------------------------------------=
--

	--cpu=3D96 -util=3D100 Time taken  	 :       5.30,       5.01(5.47)
	--cpu=3D48 -util=3D100 Time taken    :       7.94,       6.73(15.24)
	--cpu=3D24 -util=3D100 Time taken    :      11.67,       8.75(25.02)
	--cpu=3D12 -util=3D100 Time taken    :      15.71,      15.02(4.39)
	--cpu=3D96 -util=3D10 Time taken     :      22.71,      22.19(2.29)
	--cpu=3D96 -util=3D20 Time taken     :      12.14,      12.37(-1.89)
	--cpu=3D96 -util=3D30 Time taken     :       8.76,       8.86(-1.14)
	--cpu=3D96 -util=3D40 Time taken     :       7.13,       7.14(-0.14)
	--cpu=3D96 -util=3D50 Time taken     :       6.10,       6.13(-0.49)
	--cpu=3D96 -util=3D60 Time taken     :       5.42,       5.41(0.18)
	--cpu=3D96 -util=3D70 Time taken     :       4.94,       4.94(0.00)
	--cpu=3D96 -util=3D80 Time taken     :       4.56,       4.53(0.66)
	--cpu=3D96 -util=3D90 Time taken     :       4.27,       4.26(0.23)

Good improvement seen with 24 CPUs. In this case only one CPU is busy,
and no core is idle. Decent improvement with 100% utilization case. no
difference in other utilization.

Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core f=
or load balance")
Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230902081204.232218-1-sshegde@linux.vnet.ib=
m.com
---
 kernel/sched/fair.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dbff6e..33a2b6b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6619,6 +6619,7 @@ dequeue_throttle:
 /* Working cpumask for: load_balance, load_balance_newidle. */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
+static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
=20
 #ifdef CONFIG_NO_HZ_COMMON
=20
@@ -10917,6 +10918,7 @@ static int active_load_balance_cpu_stop(void *data);
=20
 static int should_we_balance(struct lb_env *env)
 {
+	struct cpumask *swb_cpus =3D this_cpu_cpumask_var_ptr(should_we_balance_tmp=
mask);
 	struct sched_group *sg =3D env->sd->groups;
 	int cpu, idle_smt =3D -1;
=20
@@ -10940,8 +10942,9 @@ static int should_we_balance(struct lb_env *env)
 		return 1;
 	}
=20
+	cpumask_copy(swb_cpus, group_balance_mask(sg));
 	/* Try to find first idle CPU */
-	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
+	for_each_cpu_and(cpu, swb_cpus, env->cpus) {
 		if (!idle_cpu(cpu))
 			continue;
=20
@@ -10953,6 +10956,14 @@ static int should_we_balance(struct lb_env *env)
 		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
 			if (idle_smt =3D=3D -1)
 				idle_smt =3D cpu;
+			/*
+			 * If the core is not idle, and first SMT sibling which is
+			 * idle has been found, then its not needed to check other
+			 * SMT siblings for idleness:
+			 */
+#ifdef CONFIG_SCHED_SMT
+			cpumask_andnot(swb_cpus, swb_cpus, cpu_smt_mask(cpu));
+#endif
 			continue;
 		}
=20
@@ -12918,6 +12929,8 @@ __init void init_sched_fair_class(void)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to=
_node(i));
 		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cpu_to=
_node(i));
+		zalloc_cpumask_var_node(&per_cpu(should_we_balance_tmpmask, i),
+					GFP_KERNEL, cpu_to_node(i));
=20
 #ifdef CONFIG_CFS_BANDWIDTH
 		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
