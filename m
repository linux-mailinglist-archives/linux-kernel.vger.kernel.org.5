Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF77DB6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjJ3JzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjJ3Jyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:54:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6A7D59;
        Mon, 30 Oct 2023 02:53:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B39DC433C8;
        Mon, 30 Oct 2023 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698659617;
        bh=Ow413Gt1+hkdiL1Zt/+V0ffiq6AHrwB002YRhc+9a+E=;
        h=From:To:Cc:Subject:Date:From;
        b=ZYicV++WR+i+pgSeXIy91MWahUAI7Hiyc5aon4FQgrCH6QYxFhgi3Rx4EVRO3XPxT
         bpje5Ds2H1TI6uCETZgO2ltNVRbs/dp2kgilPsSsDq7lfHOmJFaKtaAHIFt21doftz
         5d4mA9+bGjYIU9UCynYc2mKB/38JFLphqx2GkOaPmiCimSMrOe54tNFh5gxfj4NIyD
         JMmLkXZ2prj5w2UZpcr8hPAOqmmzU5R/zD3y1oR9yD3q9FbWG2gIeO1xs2jfwqU+9n
         VzKHQUMyUPqV4hD/uEaVP8oZUcvtDwP7OkUuh8a/1ql84vF0QAKqMM67HH1N+O8DaE
         KfzzzVC2WNVhw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     suleiman@google.com, briannorris@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4.1] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date:   Mon, 30 Oct 2023 18:53:32 +0900
Message-ID:  <169865961255.107850.9724026775256278587.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Expose last succeeded resumed timestamp as last_success_resume_time
attribute of suspend_stats in sysfs.

There are some printk()s for printing the similar resume timing to
dmesg, but those are recorded with local_clock(), and user can not
compare it with current time. We also have tracing events but it
requires CAP_SYS_ADMIN to use it.

This suspend_stats attribute is easy to access and only expose the
timestamp in CLOCK_MONOTONIC. So user can find the actual resumed
time and measure the elapsed time from the time when the kernel
finished the resume to the user-space action (e.g. display the UI).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
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
 kernel/power/suspend.c                |    1 +
 4 files changed, 28 insertions(+)

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
index fa3bf161d13f..33334565d5a6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -622,6 +622,7 @@ int pm_suspend(suspend_state_t state)
 		dpm_save_failed_errno(error);
 	} else {
 		suspend_stats.success++;
+		ktime_get_ts64(&suspend_stats.last_success_resume_time);
 	}
 	pr_info("suspend exit\n");
 	return error;

