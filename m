Return-Path: <linux-kernel+bounces-32951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555B5836269
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A91F28D13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196B3B795;
	Mon, 22 Jan 2024 11:44:33 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508753A8C6;
	Mon, 22 Jan 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923872; cv=none; b=pZI+zcX3LtZMM6VWwYWXrSmUADUCbly8VjSVDSlotA+02GM7dsIf1qREtaI25iuondIir2EGGOmikrjlCJZEdE91w4lHl5lkkl/xFhaTNDgXBJmAKG2Xo8CbQUgpXT7aMsbEe6TWGt9Y9xBgzgio8lWHh68XuqAlILq9+pnHjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923872; c=relaxed/simple;
	bh=C/KXr/lcTZWCiZDT+UIkSX2uZE5rIBwzwiKbDIbMQwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMjiah9i4QHnJKlNvwI6DMWTjFgj3S+pHJ4BjvQ8ZI/DaE/S3sfwyjXWkB2rzWhh/4AEHV8SXKFfsJgwXS41orzB/VuQEGk+1sKB3DvcELhQw2tDVcNp1e+4ZQ0eJ4DGkkpJxCfDxxRUURYRrBCGISJdo22pZBjmbLoivtY7HWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 0a2be78f0dfab9bd; Mon, 22 Jan 2024 12:44:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DC004669540;
	Mon, 22 Jan 2024 12:44:26 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 04/12] PM: sleep: stats: Use an array of step failure counters
Date: Mon, 22 Jan 2024 12:27:21 +0100
Message-ID: <2932420.e9J7NaK4W3@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using a set of individual struct suspend_stats fields
representing suspend step failure counters, use an array of counters
indexed by enum suspend_stat_step for this purpose, which allows
dpm_save_failed_step() to increment the appropriate counter
automatically, so that its callers don't need to do that directly.

It also allows suspend_stats_show() to carry out a loop over the
counters array to print their values.

Because the counters cannot become negative, use unsigned int for
representing them.

The only user-observable impact of this change is a different
ordering of entries in the suspend_stats debugfs file which is not
expected to matter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   22 ++++++++-----------
 include/linux/suspend.h   |   13 +++--------
 kernel/power/main.c       |   51 ++++++++++++++++++++++++----------------------
 kernel/power/suspend.c    |    1 
 4 files changed, 40 insertions(+), 47 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -49,20 +49,14 @@ enum suspend_stat_step {
 	SUSPEND_SUSPEND_NOIRQ,
 	SUSPEND_RESUME_NOIRQ,
 	SUSPEND_RESUME_EARLY,
-	SUSPEND_RESUME
+	SUSPEND_RESUME,
+	SUSPEND_NR_STEPS
 };
 
 struct suspend_stats {
+	unsigned int step_failures[SUSPEND_NR_STEPS];
 	int	success;
 	int	fail;
-	int	failed_freeze;
-	int	failed_prepare;
-	int	failed_suspend;
-	int	failed_suspend_late;
-	int	failed_suspend_noirq;
-	int	failed_resume;
-	int	failed_resume_early;
-	int	failed_resume_noirq;
 #define	REC_FAILED_NUM	2
 	int	last_failed_dev;
 	char	failed_devs[REC_FAILED_NUM][40];
@@ -95,6 +89,7 @@ static inline void dpm_save_failed_errno
 
 static inline void dpm_save_failed_step(enum suspend_stat_step step)
 {
+	suspend_stats.step_failures[step]++;
 	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
 	suspend_stats.last_failed_step++;
 	suspend_stats.last_failed_step %= REC_FAILED_NUM;
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -341,18 +341,28 @@ static struct kobj_attribute _name = __A
 
 suspend_attr(success, "%d\n");
 suspend_attr(fail, "%d\n");
-suspend_attr(failed_freeze, "%d\n");
-suspend_attr(failed_prepare, "%d\n");
-suspend_attr(failed_suspend, "%d\n");
-suspend_attr(failed_suspend_late, "%d\n");
-suspend_attr(failed_suspend_noirq, "%d\n");
-suspend_attr(failed_resume, "%d\n");
-suspend_attr(failed_resume_early, "%d\n");
-suspend_attr(failed_resume_noirq, "%d\n");
 suspend_attr(last_hw_sleep, "%llu\n");
 suspend_attr(total_hw_sleep, "%llu\n");
 suspend_attr(max_hw_sleep, "%llu\n");
 
+#define suspend_step_attr(_name, step)		\
+static ssize_t _name##_show(struct kobject *kobj,		\
+		struct kobj_attribute *attr, char *buf)		\
+{								\
+	return sprintf(buf, "%u\n",				\
+		       suspend_stats.step_failures[step]);	\
+}								\
+static struct kobj_attribute _name = __ATTR_RO(_name)
+
+suspend_step_attr(failed_freeze, SUSPEND_FREEZE);
+suspend_step_attr(failed_prepare, SUSPEND_PREPARE);
+suspend_step_attr(failed_suspend, SUSPEND_SUSPEND);
+suspend_step_attr(failed_suspend_late, SUSPEND_SUSPEND_LATE);
+suspend_step_attr(failed_suspend_noirq, SUSPEND_SUSPEND_NOIRQ);
+suspend_step_attr(failed_resume, SUSPEND_RESUME);
+suspend_step_attr(failed_resume_early, SUSPEND_RESUME_EARLY);
+suspend_step_attr(failed_resume_noirq, SUSPEND_RESUME_NOIRQ);
+
 static ssize_t last_failed_dev_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -439,6 +449,7 @@ static const struct attribute_group susp
 static int suspend_stats_show(struct seq_file *s, void *unused)
 {
 	int i, index, last_dev, last_errno, last_step;
+	enum suspend_stat_step step;
 
 	last_dev = suspend_stats.last_failed_dev + REC_FAILED_NUM - 1;
 	last_dev %= REC_FAILED_NUM;
@@ -446,22 +457,14 @@ static int suspend_stats_show(struct seq
 	last_errno %= REC_FAILED_NUM;
 	last_step = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
 	last_step %= REC_FAILED_NUM;
-	seq_printf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
-			"%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
-			"success", suspend_stats.success,
-			"fail", suspend_stats.fail,
-			"failed_freeze", suspend_stats.failed_freeze,
-			"failed_prepare", suspend_stats.failed_prepare,
-			"failed_suspend", suspend_stats.failed_suspend,
-			"failed_suspend_late",
-				suspend_stats.failed_suspend_late,
-			"failed_suspend_noirq",
-				suspend_stats.failed_suspend_noirq,
-			"failed_resume", suspend_stats.failed_resume,
-			"failed_resume_early",
-				suspend_stats.failed_resume_early,
-			"failed_resume_noirq",
-				suspend_stats.failed_resume_noirq);
+
+	seq_printf(s, "success: %d\nfail: %d\n",
+		   suspend_stats.success, suspend_stats.fail);
+
+	for (step = SUSPEND_FREEZE; step < SUSPEND_NR_STEPS; step++)
+		seq_printf(s, "failed_%s: %u\n", suspend_step_names[step],
+			   suspend_stats.step_failures[step]);
+
 	seq_printf(s,	"failures:\n  last_failed_dev:\t%-s\n",
 			suspend_stats.failed_devs[last_dev]);
 	for (i = 1; i < REC_FAILED_NUM; i++) {
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -367,7 +367,6 @@ static int suspend_prepare(suspend_state
 	if (!error)
 		return 0;
 
-	suspend_stats.failed_freeze++;
 	dpm_save_failed_step(SUSPEND_FREEZE);
 	pm_notifier_call_chain(PM_POST_SUSPEND);
  Restore:
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -686,7 +686,6 @@ Out:
 	TRACE_RESUME(error);
 
 	if (error) {
-		suspend_stats.failed_resume_noirq++;
 		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
@@ -817,7 +816,6 @@ Out:
 	complete_all(&dev->power.completion);
 
 	if (error) {
-		suspend_stats.failed_resume_early++;
 		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
@@ -974,7 +972,6 @@ static void device_resume(struct device
 	TRACE_RESUME(error);
 
 	if (error) {
-		suspend_stats.failed_resume++;
 		dpm_save_failed_step(SUSPEND_RESUME);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
@@ -1323,10 +1320,9 @@ static int dpm_noirq_suspend_devices(pm_
 	if (!error)
 		error = async_error;
 
-	if (error) {
-		suspend_stats.failed_suspend_noirq++;
+	if (error)
 		dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
-	}
+
 	dpm_show_time(starttime, state, error, "noirq");
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, false);
 	return error;
@@ -1509,8 +1505,8 @@ int dpm_suspend_late(pm_message_t state)
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
+
 	if (error) {
-		suspend_stats.failed_suspend_late++;
 		dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
 		dpm_resume_early(resume_event(state));
 	}
@@ -1789,10 +1785,10 @@ int dpm_suspend(pm_message_t state)
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
-	if (error) {
-		suspend_stats.failed_suspend++;
+
+	if (error)
 		dpm_save_failed_step(SUSPEND_SUSPEND);
-	}
+
 	dpm_show_time(starttime, state, error, NULL);
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, false);
 	return error;
@@ -1943,11 +1939,11 @@ int dpm_suspend_start(pm_message_t state
 	int error;
 
 	error = dpm_prepare(state);
-	if (error) {
-		suspend_stats.failed_prepare++;
+	if (error)
 		dpm_save_failed_step(SUSPEND_PREPARE);
-	} else
+	else
 		error = dpm_suspend(state);
+
 	dpm_show_time(starttime, state, error, "start");
 	return error;
 }




