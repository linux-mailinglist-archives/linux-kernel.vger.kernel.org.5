Return-Path: <linux-kernel+bounces-11515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89B81E78C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7121F21E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1B4EB40;
	Tue, 26 Dec 2023 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYeEodHt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282B4EB36;
	Tue, 26 Dec 2023 13:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD21C433C7;
	Tue, 26 Dec 2023 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703596699;
	bh=1Jvtrvq6zSXyv65vAE6f19WOYESewGkQRlVOfMtg8jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYeEodHtCkfn0EaLL/T5sWtt2WPdX0yv1kwvAhaEOsWqejJ/6Or9is3eIyKBxs/0C
	 swys2LqSSXk164TTBxwgm2ahkLJgAnF09ZBeR7vvptJAaCfxamQMZnYcaekMiKyHw8
	 BM4CanSBUIoteMy5/NDvSkbWDCDrHpBPVy60q6xwoosvVshp5TiDiNta0xaBUyNi61
	 ubD8p3fQzOZqvjKrMqrwKScgWbXEVjgWvT53FJDMdpwc3EbAYVBKSjIZJZKxfETaUW
	 BR/MABjOuqUWmvHb4cssXDYbN14h4j5tMvndI3KI3XrjBFfTMz7r8VKC7jhEGn00Zf
	 BULjLnxTsxlIg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: suleiman@google.com,
	briannorris@google.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date: Tue, 26 Dec 2023 22:18:16 +0900
Message-ID:  <170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To:  <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
References:  <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

Expose last succeeded resumed timestamp as last_success_resume_time
attribute of suspend_stats in sysfs so that user can use this time
stamp as a reference point of resuming user space.

On some system like the ChromeOS, the system suspend and resume are
controlled by a power management process. The user-space tasks will be
noticed the suspend and the resume signal from it.
To improve the suspend/resume performance and/or to find regressions,
we would like to know how long the resume processes are taken in kernel
and in user-space.
For this purpose, expose the accarate time when the kernel is finished
to resume so that we can distinguish the duration of kernel resume and
user space resume.

This suspend_stats attribute is easy to access and only expose the
timestamp in CLOCK_MONOTONIC. User can find the accarate time when the
kernel finished to resume its drivers/subsystems and start thawing, and
measure the elapsed time from the time when the kernel finished the
resume to a user-space action (e.g. displaying the UI).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Update patch description.
  - Update sysfs documentation to say the exact timing.
  - Update the comment.
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
 Documentation/ABI/testing/sysfs-power |   11 +++++++++++
 include/linux/suspend.h               |    2 ++
 kernel/power/main.c                   |   15 +++++++++++++++
 kernel/power/suspend.c                |    9 +++++++++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index a3942b1036e2..ee567e7e9d4a 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -442,6 +442,17 @@ Description:
 		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
 		This number is measured in microseconds.
 
+What:		/sys/power/suspend_stats/last_success_resume_time
+Date:		Dec 2023
+Contact:	Masami Hiramatsu <mhiramat@kernel.org>
+Description:
+		The /sys/power/suspend_stats/last_success_resume_time file
+		contains the timestamp of when the kernel successfully
+		resumed drivers/subsystems from suspend/hibernate. This is
+		just before thawing the user processes.
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
index fa3bf161d13f..2d0f46b4d0cf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -595,6 +595,15 @@ static int enter_state(suspend_state_t state)
  Finish:
 	events_check_enabled = false;
 	pm_pr_dbg("Finishing wakeup.\n");
+
+	/*
+	 * Record last succeeded resume timestamp just before thawing processes.
+	 * This is for helping users to measure user-space resume performance
+	 * for improving their programs or finding regressions.
+	 */
+	if (!error)
+		ktime_get_ts64(&suspend_stats.last_success_resume_time);
+
 	suspend_finish();
  Unlock:
 	mutex_unlock(&system_transition_mutex);


