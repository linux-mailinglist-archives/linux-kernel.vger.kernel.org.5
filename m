Return-Path: <linux-kernel+bounces-164180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73498B7A43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A1D1C20D49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32529175541;
	Tue, 30 Apr 2024 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="OhrF2fGR"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A515278D;
	Tue, 30 Apr 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487986; cv=none; b=DOzZka4vNUMFsu1AaWadmBbEOwhra7CL25lD3hUkWkqTt+jgC8l6SbgTYq/lqN4L6njVQIkmYYvgd1DjrEOhbFkz1p5fwv94DA5ZRbjkY84/yLLtxfOIgGP8SnJzqWfaxd+WHI0XP/Y82b43uo3vQtAWMKIOW5cv+Q7Fs8Nq0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487986; c=relaxed/simple;
	bh=yh4UkJROZof3Z5/tahwibAl9NwXtP0Y8lX/fWlHGJ04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jFyYSVx3oC4a8eseAWZP7qSYxIYAZdnLOXpC1NfJ/T/tmjqfiOfriW4WvMYlR2IWsrMTRswUSiU2QI2bI51Kf1ueLR+UshvLGn2AzZcX87DSwghDjrAp7exS9un16bkZk03svmpqzfAWvyY5LbSfmFlusLWyImZKc7Kk5XdEqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=OhrF2fGR; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1714487985; x=1746023985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KIdLEbVLveYoeF+FdTwiVoHwWZgCy+AkAm1QB2Ti9Cw=;
  b=OhrF2fGRtTOEQ10PAUnG2NS8anrhyDOThV+QVgmvj4x4++ZMCEeyQyNn
   la4pjjgTdnqvkpGgGlUKoLr/Xc+FVbuUFRD7OAI1sY1ovZz/cu1V8Royr
   Ak3r30yOEpkaSqbv++rb26PuRjkZd/LN4Jvv+J1sz5aFEmP9Wso3sBRnc
   I=;
X-IronPort-AV: E=Sophos;i="6.07,242,1708387200"; 
   d="scan'208";a="292831472"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:39:42 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:10847]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.3.184:2525] with esmtp (Farcaster)
 id fbf8882e-3755-4985-9d0c-837b264f1e8d; Tue, 30 Apr 2024 14:39:40 +0000 (UTC)
X-Farcaster-Flow-ID: fbf8882e-3755-4985-9d0c-837b264f1e8d
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 14:39:39 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 14:39:40 +0000
Received: from dev-dsk-faresx-1b-27755bf1.eu-west-1.amazon.com (10.253.79.181)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Tue, 30 Apr 2024 14:39:37 +0000
From: Fares Mehanna <faresx@amazon.de>
To: 
CC: <rkagan@amazon.de>, Fares Mehanna <faresx@amazon.de>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: fail to start a governor if limits weren't updated correctly
Date: Tue, 30 Apr 2024 14:39:22 +0000
Message-ID: <20240430143923.40431-1-faresx@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Current cpufreq governors are using `__cpufreq_driver_target()` in their
`.limits()` functions to update the frequency. `__cpufreq_driver_target()`
will eventually call `.target()` or `.target_index()` in the cpufreq driver
to update the frequency.

`.target()`, `.target_index()` and `__cpufreq_driver_target()` may fail and
all do return an error code, this error code is dropped by the governor and
not propagated to the core.

This have the downside of accepting a new CPU governor even if it fails to
set the wanted limits. This is misleading to the sysfs user, as setting the
governor will be accepted but the governor itself is not functioning as
expected. Especially with `performance` and `powersave` where they only
target specific frequency during starting of the governor and stays the
same during their lifetime.

This change will cause a failure to start the new governor if `.limits()`
failed, propagating back to userspace if the change is driven by sysfs.

Signed-off-by: Fares Mehanna <faresx@amazon.de>
---
 drivers/cpufreq/cpufreq.c             |  7 +++++--
 drivers/cpufreq/cpufreq_governor.c    |  6 ++++--
 drivers/cpufreq/cpufreq_governor.h    |  2 +-
 drivers/cpufreq/cpufreq_performance.c |  4 ++--
 drivers/cpufreq/cpufreq_powersave.c   |  4 ++--
 drivers/cpufreq/cpufreq_userspace.c   | 16 +++++++++-------
 include/linux/cpufreq.h               | 13 +++++++------
 kernel/sched/cpufreq_schedutil.c      |  6 ++++--
 8 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a19d76a..5ac44a44d319 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2474,8 +2474,11 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 			return ret;
 	}
 
-	if (policy->governor->limits)
-		policy->governor->limits(policy);
+	if (policy->governor->limits) {
+		ret = policy->governor->limits(policy);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index af44ee6a6430..d4e5d433cf68 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -560,9 +560,10 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
 
-void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
+int cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs;
+	int rc = 0;
 
 	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
 	mutex_lock(&gov_dbs_data_mutex);
@@ -571,11 +572,12 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 		goto out;
 
 	mutex_lock(&policy_dbs->update_mutex);
-	cpufreq_policy_apply_limits(policy);
+	rc = cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
 	mutex_unlock(&policy_dbs->update_mutex);
 
 out:
 	mutex_unlock(&gov_dbs_data_mutex);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 168c23fd7fca..551c8e7f1df9 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,7 +150,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy);
-void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy);
+int cpufreq_dbs_governor_limits(struct cpufreq_policy *policy);
 
 #define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)			\
 	{								\
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index addd93f2a420..3e02896a155b 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -11,10 +11,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-static void cpufreq_gov_performance_limits(struct cpufreq_policy *policy)
+static int cpufreq_gov_performance_limits(struct cpufreq_policy *policy)
 {
 	pr_debug("setting to %u kHz\n", policy->max);
-	__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+	return __cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
 }
 
 static struct cpufreq_governor cpufreq_gov_performance = {
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index 8d830d860e91..68eebfcae742 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -11,10 +11,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-static void cpufreq_gov_powersave_limits(struct cpufreq_policy *policy)
+static int cpufreq_gov_powersave_limits(struct cpufreq_policy *policy)
 {
 	pr_debug("setting to %u kHz\n", policy->min);
-	__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+	return __cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
 }
 
 static struct cpufreq_governor cpufreq_gov_powersave = {
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 2c42fee76daa..fb6a9d955189 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -102,8 +102,9 @@ static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
 	mutex_unlock(&userspace->mutex);
 }
 
-static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
+static int cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
 {
+	int rc;
 	struct userspace_policy *userspace = policy->governor_data;
 
 	mutex_lock(&userspace->mutex);
@@ -112,16 +113,17 @@ static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
 		 policy->cpu, policy->min, policy->max, policy->cur, userspace->setspeed);
 
 	if (policy->max < userspace->setspeed)
-		__cpufreq_driver_target(policy, policy->max,
-					CPUFREQ_RELATION_H);
+		rc = __cpufreq_driver_target(policy, policy->max,
+					     CPUFREQ_RELATION_H);
 	else if (policy->min > userspace->setspeed)
-		__cpufreq_driver_target(policy, policy->min,
-					CPUFREQ_RELATION_L);
+		rc = __cpufreq_driver_target(policy, policy->min,
+					     CPUFREQ_RELATION_L);
 	else
-		__cpufreq_driver_target(policy, userspace->setspeed,
-					CPUFREQ_RELATION_L);
+		rc = __cpufreq_driver_target(policy, userspace->setspeed,
+					     CPUFREQ_RELATION_L);
 
 	mutex_unlock(&userspace->mutex);
+	return rc;
 }
 
 static struct cpufreq_governor cpufreq_gov_userspace = {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9956afb9acc2..f5c2bf659701 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -579,7 +579,7 @@ struct cpufreq_governor {
 	void	(*exit)(struct cpufreq_policy *policy);
 	int	(*start)(struct cpufreq_policy *policy);
 	void	(*stop)(struct cpufreq_policy *policy);
-	void	(*limits)(struct cpufreq_policy *policy);
+	int	(*limits)(struct cpufreq_policy *policy);
 	ssize_t	(*show_setspeed)	(struct cpufreq_policy *policy,
 					 char *buf);
 	int	(*store_setspeed)	(struct cpufreq_policy *policy,
@@ -637,14 +637,15 @@ module_exit(__governor##_exit)
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
-static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
+static inline int cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 {
 	if (policy->max < policy->cur)
-		__cpufreq_driver_target(policy, policy->max,
-					CPUFREQ_RELATION_HE);
+		return __cpufreq_driver_target(policy, policy->max,
+					       CPUFREQ_RELATION_HE);
 	else if (policy->min > policy->cur)
-		__cpufreq_driver_target(policy, policy->min,
-					CPUFREQ_RELATION_LE);
+		return __cpufreq_driver_target(policy, policy->min,
+					       CPUFREQ_RELATION_LE);
+	return 0;
 }
 
 /* Governor attribute set */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..9c1e3dbe9657 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -871,17 +871,19 @@ static void sugov_stop(struct cpufreq_policy *policy)
 	}
 }
 
-static void sugov_limits(struct cpufreq_policy *policy)
+static int sugov_limits(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
+	int rc = 0;
 
 	if (!policy->fast_switch_enabled) {
 		mutex_lock(&sg_policy->work_lock);
-		cpufreq_policy_apply_limits(policy);
+		rc = cpufreq_policy_apply_limits(policy);
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
 	sg_policy->limits_changed = true;
+	return rc;
 }
 
 struct cpufreq_governor schedutil_gov = {
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




