Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD1810BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjLMHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjLMHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:39:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404FD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:39:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2677C433C7;
        Wed, 13 Dec 2023 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702453179;
        bh=PqBqAQn/OokdemTcp+5Kw3VJfA7j+I/V4SwxQjOf9xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sm4pF2QjsQ5F1ID9ESwEEH8AhlILqQhr+e4j+kXiucFgPB/tB+7wrZNmY6v1hUrGc
         OR9rFxt4mzSY0IFN7hiYbtZ4tg0MZT1gJ8PUSv1pWTt5hi/T1ZnzCYa83gTa5r8Kfg
         DdWyDX+PZNz75bbcgV7/qVD4138JaVQ1WQTsWK6QdjhvlkKJ5HRAW9xCwovtS7aMRf
         IJznAjcp/fSNOSThQ1U3x/tBvgZ1MfbHQWcMVnkpiH8ar8WxXkGsUi/rEvpQCQAxCJ
         D0wGXkrAFQYOl+kaT8chCf/XhafPxRJ5XnA4Dt3n3qMXkonS9GlNRKiXOuLsy+vvj3
         VIhrYUJAqP0lQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     suleiman@google.com, briannorris@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v6] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date:   Wed, 13 Dec 2023 16:39:35 +0900
Message-ID:  <170245317569.651355.7858730719579399805.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To:  <170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com>
References:  <170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Expose last succeeded resumed timestamp as last_success_resume_time
attribute of suspend_stats in sysfs so that user can use this time
stamp as a reference point of resuming user space.

There are some printk()s for printing the similar resume timing to
dmesg, but those are recorded with local_clock(), and user can not
compare it with current time. We also have tracing events but it
requires CAP_SYS_ADMIN to use it.

This suspend_stats attribute is easy to access and only expose the
timestamp in CLOCK_MONOTONIC. User can find the actual resumed
time and measure the elapsed time from the time when the kernel
finished the resume to the user-space action (e.g. display the UI)
and use it as a performance metric of user process resuming time.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Fix to record resume time before thawing user processes.
 Changes in v5:
  - Just updated for v6.7-rc3.
 Changes in v4.1:
  - Fix document typo (again).
 Changes in v4:
  - Update description to add why.
  - Fix document typo.
 Changes in v3:
  - Add (unsigned long long) casting for %llu.
  - Add a line after last_success_resume_time_show().
 Changes in v2:
  - Use %llu instead of %lu for printing u64 value.
  - Remove unneeded indent spaces from the last_success_resume_time
    line in the debugfs suspend_stat file.
---
 Documentation/ABI/testing/sysfs-power |   10 ++++++++++
 include/linux/suspend.h               |    2 ++
 kernel/power/main.c                   |   15 +++++++++++++++
 kernel/power/suspend.c                |    3 +++
 4 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index a3942b1036e2..e14975859766 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -442,6 +442,16 @@ Description:
 		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
 		This number is measured in microseconds.
 
+What:		/sys/power/suspend_stats/last_success_resume_time
+Date:		Oct 2023
+Contact:	Masami Hiramatsu <mhiramat@kernel.org>
+Description:
+		The /sys/power/suspend_stats/last_success_resume_time file
+		contains the timestamp of when the kernel successfully
+		resumed from suspend/hibernate.
+		This floating point number is measured in seconds by monotonic
+		clock.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index ef503088942d..ddd789044960 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -8,6 +8,7 @@
 #include <linux/pm.h>
 #include <linux/mm.h>
 #include <linux/freezer.h>
+#include <linux/timekeeping.h>
 #include <asm/errno.h>
 
 #ifdef CONFIG_VT
@@ -71,6 +72,7 @@ struct suspend_stats {
 	u64	last_hw_sleep;
 	u64	total_hw_sleep;
 	u64	max_hw_sleep;
+	struct timespec64 last_success_resume_time;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b0..2ab23fd3daac 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -421,6 +421,17 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_success_resume_time_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu.%llu\n",
+		(unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
+		(unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
+}
+
+static struct kobj_attribute last_success_resume_time =
+			__ATTR_RO(last_success_resume_time);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -438,6 +449,7 @@ static struct attribute *suspend_attrs[] = {
 	&last_hw_sleep.attr,
 	&total_hw_sleep.attr,
 	&max_hw_sleep.attr,
+	&last_success_resume_time.attr,
 	NULL,
 };
 
@@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
 			suspend_step_name(
 				suspend_stats.failed_steps[index]));
 	}
+	seq_printf(s,	"last_success_resume_time:\t%-llu.%llu\n",
+		   (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
+		   (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
 
 	return 0;
 }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..b85889358f53 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -595,6 +595,9 @@ static int enter_state(suspend_state_t state)
  Finish:
 	events_check_enabled = false;
 	pm_pr_dbg("Finishing wakeup.\n");
+	/* Record last succeeded resume time before thawing processes. */
+	if (!error)
+		ktime_get_ts64(&suspend_stats.last_success_resume_time);
 	suspend_finish();
  Unlock:
 	mutex_unlock(&system_transition_mutex);

