Return-Path: <linux-kernel+bounces-32950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E99836267
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A2B1F28A50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF103B18D;
	Mon, 22 Jan 2024 11:44:32 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67A3C68A;
	Mon, 22 Jan 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923871; cv=none; b=EQ/QnpwlpWlAZA1tMvU3B+bog4WJoOuy2xQ3hy9VmxHHsq9SmPV/xzNVhqEpIt3mOkrviKMVX+Uhf3eltrdAG8SZRhQGG9YHnjNQzcnTfOBDIOxFX1xq3tsl1M9KA/6uz+Gh0LP2YGIUm8WbrirDSx+H0WfTm69+lRJ0GdDS5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923871; c=relaxed/simple;
	bh=k6I8vIqOm9FPnO/xt7Fix3r2rFtBxf84ZbLyTz5y5kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOLCXurH4yG1+Gwyh/qmBR3HbLbYnBTDCj/73SpK98aaJsyWpM8oHN1W1D6A8/Ij/36TEngKjUfvg5u4azO8mGhv+SeBWQcflYbmxoenc14Pzfs6cI6Oo0Ak+PInlnlCkrIpJaN9DLZ+VcxmrhzfJtQxv/ZI88kRhiIt4Wf9bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 7d18eee11acd6026; Mon, 22 Jan 2024 12:44:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 71EAE669541;
	Mon, 22 Jan 2024 12:44:25 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 06/12] PM: sleep: stats: Define suspend_stats next to the code using it
Date: Mon, 22 Jan 2024 12:31:20 +0100
Message-ID: <2266871.iZASKD2KPV@kreacher>
In-Reply-To: <5760158.DvuYhMxLoT@kreacher>
References: <5760158.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to define struct suspend_stats in a header file and the
suspend_stats variable in the core device system-wide PM code.  They both
can be defined in kernel/power/main.c, next to the sysfs and debugfs code
accessing suspend_stats, which can be static.

Modify the code in question in accordance with the above observation and
replace the static inline functions manipulating suspend_stats with
regular ones defined in kernel/power/main.c.

While at it, move the enum suspend_stat_step to the end of suspend.h which
is a more suitable place for it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    1 
 include/linux/suspend.h   |   70 +++++++++----------------------------------
 kernel/power/main.c       |   74 +++++++++++++++++++++++++++++++++++++---------
 kernel/power/power.h      |    2 +
 kernel/power/suspend.c    |    7 ----
 5 files changed, 80 insertions(+), 74 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -40,60 +40,6 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MIN		PM_SUSPEND_TO_IDLE
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
-enum suspend_stat_step {
-	SUSPEND_NONE = 0,
-	SUSPEND_FREEZE,
-	SUSPEND_PREPARE,
-	SUSPEND_SUSPEND,
-	SUSPEND_SUSPEND_LATE,
-	SUSPEND_SUSPEND_NOIRQ,
-	SUSPEND_RESUME_NOIRQ,
-	SUSPEND_RESUME_EARLY,
-	SUSPEND_RESUME,
-	SUSPEND_NR_STEPS
-};
-
-struct suspend_stats {
-	unsigned int step_failures[SUSPEND_NR_STEPS];
-	unsigned int fail;
-#define	REC_FAILED_NUM	2
-	int	last_failed_dev;
-	char	failed_devs[REC_FAILED_NUM][40];
-	int	last_failed_errno;
-	int	errno[REC_FAILED_NUM];
-	int	last_failed_step;
-	u64	last_hw_sleep;
-	u64	total_hw_sleep;
-	u64	max_hw_sleep;
-	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
-};
-
-extern struct suspend_stats suspend_stats;
-
-static inline void dpm_save_failed_dev(const char *name)
-{
-	strscpy(suspend_stats.failed_devs[suspend_stats.last_failed_dev],
-		name,
-		sizeof(suspend_stats.failed_devs[0]));
-	suspend_stats.last_failed_dev++;
-	suspend_stats.last_failed_dev %= REC_FAILED_NUM;
-}
-
-static inline void dpm_save_failed_errno(int err)
-{
-	suspend_stats.errno[suspend_stats.last_failed_errno] = err;
-	suspend_stats.last_failed_errno++;
-	suspend_stats.last_failed_errno %= REC_FAILED_NUM;
-}
-
-static inline void dpm_save_failed_step(enum suspend_stat_step step)
-{
-	suspend_stats.step_failures[step]++;
-	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
-	suspend_stats.last_failed_step++;
-	suspend_stats.last_failed_step %= REC_FAILED_NUM;
-}
-
 /**
  * struct platform_suspend_ops - Callbacks for managing platform dependent
  *	system sleep states.
@@ -621,4 +567,20 @@ static inline void queue_up_suspend_work
 
 #endif /* !CONFIG_PM_AUTOSLEEP */
 
+enum suspend_stat_step {
+	SUSPEND_NONE = 0,
+	SUSPEND_FREEZE,
+	SUSPEND_PREPARE,
+	SUSPEND_SUSPEND,
+	SUSPEND_SUSPEND_LATE,
+	SUSPEND_SUSPEND_NOIRQ,
+	SUSPEND_RESUME_NOIRQ,
+	SUSPEND_RESUME_EARLY,
+	SUSPEND_RESUME,
+	SUSPEND_NR_STEPS
+};
+
+void dpm_save_failed_dev(const char *name);
+void dpm_save_failed_step(enum suspend_stat_step step);
+
 #endif /* _LINUX_SUSPEND_H */
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -95,19 +95,6 @@ int unregister_pm_notifier(struct notifi
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
-void pm_report_hw_sleep_time(u64 t)
-{
-	suspend_stats.last_hw_sleep = t;
-	suspend_stats.total_hw_sleep += t;
-}
-EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
-
-void pm_report_max_hw_sleep(u64 t)
-{
-	suspend_stats.max_hw_sleep = t;
-}
-EXPORT_SYMBOL_GPL(pm_report_max_hw_sleep);
-
 int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
@@ -319,6 +306,67 @@ static ssize_t pm_test_store(struct kobj
 power_attr(pm_test);
 #endif /* CONFIG_PM_SLEEP_DEBUG */
 
+#define REC_FAILED_NUM	2
+
+struct suspend_stats {
+	unsigned int step_failures[SUSPEND_NR_STEPS];
+	unsigned int fail;
+	int last_failed_dev;
+	char failed_devs[REC_FAILED_NUM][40];
+	int last_failed_errno;
+	int errno[REC_FAILED_NUM];
+	int last_failed_step;
+	u64 last_hw_sleep;
+	u64 total_hw_sleep;
+	u64 max_hw_sleep;
+	enum suspend_stat_step failed_steps[REC_FAILED_NUM];
+};
+
+static struct suspend_stats suspend_stats;
+
+void dpm_save_failed_dev(const char *name)
+{
+	strscpy(suspend_stats.failed_devs[suspend_stats.last_failed_dev],
+		name, sizeof(suspend_stats.failed_devs[0]));
+	suspend_stats.last_failed_dev++;
+	suspend_stats.last_failed_dev %= REC_FAILED_NUM;
+}
+
+void dpm_save_failed_step(enum suspend_stat_step step)
+{
+	suspend_stats.step_failures[step]++;
+	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
+	suspend_stats.last_failed_step++;
+	suspend_stats.last_failed_step %= REC_FAILED_NUM;
+}
+
+void dpm_save_errno(int err)
+{
+	if (!err) {
+		suspend_stats.step_failures[SUSPEND_NONE]++;
+		return;
+	}
+
+	suspend_stats.fail++;
+
+	suspend_stats.errno[suspend_stats.last_failed_errno] = err;
+	suspend_stats.last_failed_errno++;
+	suspend_stats.last_failed_errno %= REC_FAILED_NUM;
+}
+
+void pm_report_hw_sleep_time(u64 t)
+{
+	suspend_stats.last_hw_sleep = t;
+	suspend_stats.total_hw_sleep += t;
+}
+EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
+
+void pm_report_max_hw_sleep(u64 t)
+{
+	suspend_stats.max_hw_sleep = t;
+}
+EXPORT_SYMBOL_GPL(pm_report_max_hw_sleep);
+
 static const char * const suspend_step_names[] = {
 	[SUSPEND_NONE] = "",
 	[SUSPEND_FREEZE] = "freeze",
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -327,3 +327,5 @@ static inline void pm_sleep_enable_secon
 	suspend_enable_secondary_cpus();
 	cpuidle_resume();
 }
+
+void dpm_save_errno(int err);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -616,12 +616,7 @@ int pm_suspend(suspend_state_t state)
 
 	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
 	error = enter_state(state);
-	if (error) {
-		suspend_stats.fail++;
-		dpm_save_failed_errno(error);
-	} else {
-		suspend_stats.step_failures[SUSPEND_NONE]++;
-	}
+	dpm_save_errno(error);
 	pr_info("suspend exit\n");
 	return error;
 }
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -60,7 +60,6 @@ static LIST_HEAD(dpm_suspended_list);
 static LIST_HEAD(dpm_late_early_list);
 static LIST_HEAD(dpm_noirq_list);
 
-struct suspend_stats suspend_stats;
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
 




