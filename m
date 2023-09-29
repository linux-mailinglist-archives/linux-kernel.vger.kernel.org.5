Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051987B363A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjI2PCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjI2PCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:02:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0DD6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:02:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4ABC433C8;
        Fri, 29 Sep 2023 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695999772;
        bh=y43geovcEZogQgO3GND3tejuh+vJKIDuqHW03nP9LR8=;
        h=From:To:Cc:Subject:Date:From;
        b=KYYa0vJdYom7lvX5FI0PvtM4Fse8v1qA0JKlubv5MZvelCbUQQ5C5qR+qgPUd1NY5
         vjYAQ66mRBHlNcImuOrpSXc/OTCoxyFcueSVBFF17G2mxQUcJQ9mPXPFMpfCiOfhSv
         wnRSoQPUNXycc67Ti+3ZyQQwn922JqSVWxXI3D1LWc0YHbd/IQ0czBAKHNltnpYeyi
         p2/cH4+A8ktm5yNmaKZPujT543Ut3o7Dj7pbA2INE++VDInigXLYqa+zexd8j+NX0O
         SN4yWfIYwHiVTUCDORTjc0az9GMRXJUnbDwPBuC7TdAOYDsTA3vxja4FwSa5p0r3+U
         TPfSEIS9WxLaA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] tracing/timerlat: Hotplug support for the user-space interface
Date:   Fri, 29 Sep 2023 17:02:46 +0200
Message-Id: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The osnoise/per_cpu/CPU$/timerlat_fd is create for each possible
CPU, but it might create confusion if the CPU is not online.

Create the file only for online CPUs, also follow hotplug by
creating and deleting as CPUs come and go.

Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---

Changes from V2:
  - Better split the code into the generic (per_cpu/cpu$)
    and timerlat (/timerlat_fd) specific function (Daniel)
  - Fixed a cpus_read_lock/unlock() usage (kbuild test)
  Link: https://lore.kernel.org/lkml/6b9a5f306e488bc77bf8521faeade420a0adf3e4.1695224204.git.bristot@kernel.org/

Changes from V1:
  - Fix compilation issue when !HOTPLUG
  - Fix init interface | hotplug race
  Link: https://lore.kernel.org/lkml/b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot@kernel.org/

 kernel/trace/trace_osnoise.c | 149 ++++++++++++++++++++++++++++-------
 1 file changed, 121 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..f375fb1e721d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -229,6 +229,19 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 }
 
 #ifdef CONFIG_TIMERLAT_TRACER
+
+/*
+ * osnoise/per_cpu dir
+ */
+static struct dentry		*osnoise_per_cpu_fd;
+
+struct osnoise_per_cpu_dir {
+	struct dentry *root;
+	struct dentry *timerlat_fd;
+};
+
+static DEFINE_PER_CPU(struct osnoise_per_cpu_dir, osnoise_per_cpu_dir);
+
 /*
  * Runtime information for the timer mode.
  */
@@ -2000,6 +2013,9 @@ static int start_kthread(unsigned int cpu)
 	char comm[24];
 
 	if (timerlat_enabled()) {
+		if (!test_bit(OSN_WORKLOAD, &osnoise_options))
+			return 0;
+
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
@@ -2065,19 +2081,99 @@ static int start_per_cpu_kthreads(void)
 	return retval;
 }
 
+#ifdef CONFIG_TIMERLAT_TRACER
+static struct dentry *osnoise_get_per_cpu_dir(long cpu)
+{
+	struct dentry *cpu_dir_entry = per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root;
+	char cpu_str[30]; /* see trace.c: tracing_init_tracefs_percpu() */
+
+	if (cpu_dir_entry)
+		return cpu_dir_entry;
+
+	if (!osnoise_per_cpu_fd)
+		return NULL;
+
+	snprintf(cpu_str, 30, "cpu%ld", cpu);
+	cpu_dir_entry = tracefs_create_dir(cpu_str, osnoise_per_cpu_fd);
+	if (!cpu_dir_entry)
+		return NULL;
+
+	per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root = cpu_dir_entry;
+
+	return cpu_dir_entry;
+}
+
+static void osnoise_put_per_cpu_dir(long cpu)
+{
+	struct dentry *cpu_dir_entry = per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root;
+
+	if (!cpu_dir_entry)
+		return;
+
+	tracefs_remove(cpu_dir_entry);
+
+	per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root = NULL;
+}
+
+static const struct file_operations timerlat_fd_fops;
+
+static int timerlat_add_per_cpu_interface(long cpu)
+{
+	struct dentry *cpu_dir_entry = osnoise_get_per_cpu_dir(cpu);
+	struct dentry *timerlat_fd;
+
+	lockdep_assert_cpus_held();
+
+	if (!cpu_dir_entry)
+		return -ENOMEM;
+
+	timerlat_fd = trace_create_file("timerlat_fd", TRACE_MODE_READ, cpu_dir_entry, NULL,
+					&timerlat_fd_fops);
+	if (!timerlat_fd)
+		goto out_put;
+
+	per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->timerlat_fd = timerlat_fd;
+
+	/* Record the CPU */
+	d_inode(timerlat_fd)->i_cdev = (void *)(cpu);
+
+	return 0;
+
+out_put:
+	osnoise_put_per_cpu_dir(cpu);
+	return -ENOMEM;
+}
+
+static void timerlat_rm_per_cpu_interface(long cpu)
+{
+	struct dentry *timerlat_fd = per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->timerlat_fd;
+
+	if (timerlat_fd) {
+		tracefs_remove(timerlat_fd);
+		per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->timerlat_fd = NULL;
+	}
+
+	osnoise_put_per_cpu_dir(cpu);
+}
+#elif defined(CONFIG_HOTPLUG_CPU)
+static int timerlat_add_per_cpu_interface(long cpu) { return 0; };
+static void timerlat_rm_per_cpu_interface(long cpu) {};
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
 	unsigned int cpu = smp_processor_id();
 
 	mutex_lock(&trace_types_lock);
-
-	if (!osnoise_has_registered_instances())
-		goto out_unlock_trace;
-
 	mutex_lock(&interface_lock);
 	cpus_read_lock();
 
+	timerlat_add_per_cpu_interface(cpu);
+
+	if (!osnoise_has_registered_instances())
+		goto out_unlock;
+
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		goto out_unlock;
 
@@ -2086,7 +2182,6 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 out_unlock:
 	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
-out_unlock_trace:
 	mutex_unlock(&trace_types_lock);
 }
 
@@ -2106,6 +2201,7 @@ static int osnoise_cpu_init(unsigned int cpu)
  */
 static int osnoise_cpu_die(unsigned int cpu)
 {
+	timerlat_rm_per_cpu_interface(cpu);
 	stop_kthread(cpu);
 	return 0;
 }
@@ -2708,10 +2804,7 @@ static int init_timerlat_stack_tracefs(struct dentry *top_dir)
 
 static int osnoise_create_cpu_timerlat_fd(struct dentry *top_dir)
 {
-	struct dentry *timerlat_fd;
-	struct dentry *per_cpu;
-	struct dentry *cpu_dir;
-	char cpu_str[30]; /* see trace.c: tracing_init_tracefs_percpu() */
+	int retval;
 	long cpu;
 
 	/*
@@ -2720,29 +2813,28 @@ static int osnoise_create_cpu_timerlat_fd(struct dentry *top_dir)
 	 * Because osnoise/timerlat have a single workload, having
 	 * multiple files like these are wast of memory.
 	 */
-	per_cpu = tracefs_create_dir("per_cpu", top_dir);
-	if (!per_cpu)
+	osnoise_per_cpu_fd = tracefs_create_dir("per_cpu", top_dir);
+	if (!osnoise_per_cpu_fd)
 		return -ENOMEM;
 
-	for_each_possible_cpu(cpu) {
-		snprintf(cpu_str, 30, "cpu%ld", cpu);
-		cpu_dir = tracefs_create_dir(cpu_str, per_cpu);
-		if (!cpu_dir)
-			goto out_clean;
-
-		timerlat_fd = trace_create_file("timerlat_fd", TRACE_MODE_READ,
-						cpu_dir, NULL, &timerlat_fd_fops);
-		if (!timerlat_fd)
-			goto out_clean;
-
-		/* Record the CPU */
-		d_inode(timerlat_fd)->i_cdev = (void *)(cpu);
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		retval = timerlat_add_per_cpu_interface(cpu);
+		if (retval)
+			goto out_rm_cpus_locked;
 	}
+	cpus_read_unlock();
 
 	return 0;
 
-out_clean:
-	tracefs_remove(per_cpu);
+out_rm_cpus_locked:
+	for_each_online_cpu(cpu)
+		timerlat_rm_per_cpu_interface(cpu);
+	cpus_read_lock();
+
+	tracefs_remove(osnoise_per_cpu_fd);
+	/* tracefs_remove() recursively deletes all the other files */
+	osnoise_per_cpu_fd = NULL;
 	return -ENOMEM;
 }
 
@@ -3122,11 +3214,12 @@ __init static int init_osnoise_tracer(void)
 		return ret;
 	}
 
-	osnoise_init_hotplug_support();
-
 	INIT_LIST_HEAD_RCU(&osnoise_instances);
 
+	mutex_lock(&trace_types_lock);
 	init_tracefs();
+	osnoise_init_hotplug_support();
+	mutex_unlock(&trace_types_lock);
 
 	return 0;
 }
-- 
2.38.1

