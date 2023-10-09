Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D220C7BE54F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377004AbjJIPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjJIPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:48:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A59E;
        Mon,  9 Oct 2023 08:48:07 -0700 (PDT)
Date:   Mon, 09 Oct 2023 15:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696866486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojViO7KnNPt4Z8idbh/mCwDqWaq2cGJDLdj2h5aHxeU=;
        b=aYujzAP3dEu93Yc8eVuwzpQlj7HCItimkRmvHhERbrrBe7w8M2JKk1Bf/8ADA9yKJKmA2e
        pCZCF3ZgbEptLhXMwCtgSPnuWqb/U/l9H4gJaLgwjHFnLLWJh91AOcWUSZPCKjFjRw/8Gz
        Bn7YE3WR1FsmiYdx5ZCKL5S34Sn4NfpHD6OxTvE5Im+H+BxNEdpYN1X7yTQW+t/+BwTeMQ
        6VrZOFiUViPREYHSPtDFQUZKXYwmAGrizBYpyxFOQKrReoPY9/WJVlDaw0l9ySJ3RGN3Wj
        UoXfio24sgHqE284P9mSD1L6hyAyZo3G7lKfEafZt33N7rlGBLKCJJiECx9xxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696866486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojViO7KnNPt4Z8idbh/mCwDqWaq2cGJDLdj2h5aHxeU=;
        b=bWPern//Y8NRR2ABGhnFWHT/hx4l4AWkklAHReS8udSK12Aa5mYuszHH/jN4FGMeHvKDkH
        NjveHC9JvLE3P1Ag==
From:   "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Change behaviour of the
 'sched_energy_aware' sysctl, based on the platform
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
References: <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <169686648537.3135.1153411692687641724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8f833c82cdab7b4049bcfe88311d35fa5f24e422
Gitweb:        https://git.kernel.org/tip/8f833c82cdab7b4049bcfe88311d35fa5f24e422
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Mon, 09 Oct 2023 11:30:37 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 17:24:44 +02:00

sched/topology: Change behaviour of the 'sched_energy_aware' sysctl, based on the platform

The 'sched_energy_aware' sysctl is available for the admin to disable/enable
energy aware scheduling(EAS). EAS is enabled only if few conditions are
met by the platform. They are, asymmetric CPU capacity, no SMT,
schedutil CPUfreq governor, frequency invariant load tracking etc.
A platform may boot without EAS capability, but could gain such
capability at runtime. For example, changing/registering the cpufreq
governor to schedutil.

At present, though platform doesn't support EAS, this sysctl returns 1
and it ends up calling build_perf_domains on write to 1 and
NOP when writing to 0. That is confusing and un-necessary.

Desired behavior would be to have this sysctl to enable/disable the EAS
on supported platform. On non-supported platform write to the sysctl
would return not supported error and read of the sysctl would return
empty. So sched_energy_aware returns empty - EAS is not possible at this moment
This will include EAS capable platforms which have at least one EAS
condition false during startup, e.g. not using the schedutil cpufreq governor
sched_energy_aware returns 0 - EAS is supported but disabled by admin.
sched_energy_aware returns 1 - EAS is supported and enabled.

User can find out the reason why EAS is not possible by checking
info messages. sched_is_eas_possible returns true if the platform
can do EAS at this moment.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20231009060037.170765-3-sshegde@linux.vnet.ibm.com
---
 Documentation/admin-guide/sysctl/kernel.rst |   3 +-
 kernel/sched/topology.c                     | 112 ++++++++++++-------
 2 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index cf33de5..d89ac2b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1182,7 +1182,8 @@ automatically on platforms where it can run (that is,
 platforms with asymmetric CPU topologies and having an Energy
 Model available). If your platform happens to meet the
 requirements for EAS but you do not want to use it, change
-this value to 0.
+this value to 0. On Non-EAS platforms, write operation fails and
+read doesn't return anything.
 
 task_delayacct
 ===============
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index fcda3f0..4cbbdac 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -212,6 +212,70 @@ static unsigned int sysctl_sched_energy_aware = 1;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;
 
+extern struct cpufreq_governor schedutil_gov;
+static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
+{
+	bool any_asym_capacity = false;
+	struct cpufreq_policy *policy;
+	struct cpufreq_governor *gov;
+	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	for_each_cpu(i, cpu_mask) {
+		if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, i))) {
+			any_asym_capacity = true;
+			break;
+		}
+	}
+	if (!any_asym_capacity) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS, CPUs do not have asymmetric capacities\n",
+				cpumask_pr_args(cpu_mask));
+		}
+		return false;
+	}
+
+	/* EAS definitely does *not* handle SMT */
+	if (sched_smt_active()) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS, SMT is not supported\n",
+				cpumask_pr_args(cpu_mask));
+		}
+		return false;
+	}
+
+	if (!arch_scale_freq_invariant()) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported",
+				cpumask_pr_args(cpu_mask));
+		}
+		return false;
+	}
+
+	/* Do not attempt EAS if schedutil is not being used. */
+	for_each_cpu(i, cpu_mask) {
+		policy = cpufreq_cpu_get(i);
+		if (!policy) {
+			if (sched_debug()) {
+				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
+					cpumask_pr_args(cpu_mask), i);
+			}
+			return false;
+		}
+		gov = policy->governor;
+		cpufreq_cpu_put(policy);
+		if (gov != &schedutil_gov) {
+			if (sched_debug()) {
+				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
+					cpumask_pr_args(cpu_mask));
+			}
+			return false;
+		}
+	}
+
+	return true;
+}
+
 void rebuild_sched_domains_energy(void)
 {
 	mutex_lock(&sched_energy_mutex);
@@ -230,6 +294,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!sched_is_eas_possible(cpu_active_mask)) {
+		if (write) {
+			return -EOPNOTSUPP;
+		} else {
+			*lenp = 0;
+			return 0;
+		}
+	}
+
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
@@ -351,61 +424,24 @@ static void sched_energy_set(bool has_eas)
  *    4. schedutil is driving the frequency of all CPUs of the rd;
  *    5. frequency invariance support is present;
  */
-extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i;
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
-	struct cpufreq_policy *policy;
-	struct cpufreq_governor *gov;
 
 	if (!sysctl_sched_energy_aware)
 		goto free;
 
-	/* EAS is enabled for asymmetric CPU capacity topologies. */
-	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
-		if (sched_debug()) {
-			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
-					cpumask_pr_args(cpu_map));
-		}
-		goto free;
-	}
-
-	/* EAS definitely does *not* handle SMT */
-	if (sched_smt_active()) {
-		pr_warn("rd %*pbl: Disabling EAS, SMT is not supported\n",
-			cpumask_pr_args(cpu_map));
-		goto free;
-	}
-
-	if (!arch_scale_freq_invariant()) {
-		if (sched_debug()) {
-			pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking not yet supported",
-				cpumask_pr_args(cpu_map));
-		}
+	if (!sched_is_eas_possible(cpu_map))
 		goto free;
-	}
 
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
 			continue;
 
-		/* Do not attempt EAS if schedutil is not being used. */
-		policy = cpufreq_cpu_get(i);
-		if (!policy)
-			goto free;
-		gov = policy->governor;
-		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
-			if (rd->pd)
-				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
-						cpumask_pr_args(cpu_map));
-			goto free;
-		}
-
 		/* Create the new pd and add it to the local list. */
 		tmp = pd_init(i);
 		if (!tmp)
