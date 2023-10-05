Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282057BA216
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjJEPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjJEPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:12:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9C9194;
        Thu,  5 Oct 2023 06:48:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DA30168F;
        Thu,  5 Oct 2023 06:42:06 -0700 (PDT)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.100.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6CBD3F641;
        Thu,  5 Oct 2023 06:41:25 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: Rebuild sched-domains when removing cpufreq driver
Date:   Thu,  5 Oct 2023 15:41:20 +0200
Message-Id: <20231005134120.1217829-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Aware Scheduler (EAS) relies on the schedutil governor.
When moving to/from the schedutil governor, sched domains must be
rebuilt to allow re-evaluating the enablement conditions of EAS.
This is done through sched_cpufreq_governor_change().

Having a cpufreq governor assumes a cpufreq driver is running.
Inserting/removing a cpufreq driver should trigger a re-evaluation
of EAS enablement conditions, avoiding to see EAS enabled when
removing a running cpufreq driver.

Rebuild the sched domains in schedutil's sugov_init()/sugov_exit(),
allowing to check EAS's enablement condition whenever schedutil
governor is initialized/exited from.
Move relevant code up in schedutil.c to avoid a split and conditional
function declaration.
Rename sched_cpufreq_governor_change() to sugov_eas_rebuild_sd().

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c        |  3 +-
 include/linux/cpufreq.h          |  8 -----
 kernel/sched/cpufreq_schedutil.c | 55 +++++++++++++++++---------------
 3 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 60ed89000e82..4bc15634d49c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1544,7 +1544,7 @@ static int cpufreq_online(unsigned int cpu)
 
 		/*
 		 * Register with the energy model before
-		 * sched_cpufreq_governor_change() is called, which will result
+		 * sugov_eas_rebuild_sd() is called, which will result
 		 * in rebuilding of the sched domains, which should only be done
 		 * once the energy model is properly initialized for the policy
 		 * first.
@@ -2652,7 +2652,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
 			pr_debug("governor change\n");
-			sched_cpufreq_governor_change(policy, old_gov);
 			return 0;
 		}
 		cpufreq_exit_governor(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 71d186d6933a..1c5ca92a0555 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1193,14 +1193,6 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 }
 #endif
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
-			struct cpufreq_governor *old_gov);
-#else
-static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
-			struct cpufreq_governor *old_gov) { }
-#endif
-
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
 #ifndef arch_set_freq_scale
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..901cada51ba7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -555,6 +555,31 @@ static const struct kobj_type sugov_tunables_ktype = {
 
 /********************** cpufreq governor interface *********************/
 
+#ifdef CONFIG_ENERGY_MODEL
+static void rebuild_sd_workfn(struct work_struct *work)
+{
+	rebuild_sched_domains_energy();
+}
+
+static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
+
+/*
+ * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
+ * on governor changes to make sure the scheduler knows about it.
+ */
+static void sugov_eas_rebuild_sd(void)
+{
+	/*
+	 * When called from the cpufreq_register_driver() path, the
+	 * cpu_hotplug_lock is already held, so use a work item to
+	 * avoid nested locking in rebuild_sched_domains().
+	 */
+	schedule_work(&rebuild_sd_work);
+}
+#else
+static inline void sugov_eas_rebuild_sd(void) { };
+#endif
+
 struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
@@ -709,6 +734,8 @@ static int sugov_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto fail;
 
+	sugov_eas_rebuild_sd();
+
 out:
 	mutex_unlock(&global_tunables_lock);
 	return 0;
@@ -750,6 +777,8 @@ static void sugov_exit(struct cpufreq_policy *policy)
 	sugov_kthread_stop(sg_policy);
 	sugov_policy_free(sg_policy);
 	cpufreq_disable_fast_switch(policy);
+
+	sugov_eas_rebuild_sd();
 }
 
 static int sugov_start(struct cpufreq_policy *policy)
@@ -838,29 +867,3 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 #endif
 
 cpufreq_governor_init(schedutil_gov);
-
-#ifdef CONFIG_ENERGY_MODEL
-static void rebuild_sd_workfn(struct work_struct *work)
-{
-	rebuild_sched_domains_energy();
-}
-static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
-
-/*
- * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
- * on governor changes to make sure the scheduler knows about it.
- */
-void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
-				  struct cpufreq_governor *old_gov)
-{
-	if (old_gov == &schedutil_gov || policy->governor == &schedutil_gov) {
-		/*
-		 * When called from the cpufreq_register_driver() path, the
-		 * cpu_hotplug_lock is already held, so use a work item to
-		 * avoid nested locking in rebuild_sched_domains().
-		 */
-		schedule_work(&rebuild_sd_work);
-	}
-
-}
-#endif
-- 
2.25.1

