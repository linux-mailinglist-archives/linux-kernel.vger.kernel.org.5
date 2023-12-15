Return-Path: <linux-kernel+bounces-1072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E02B8149F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7390B1C226DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3783035B;
	Fri, 15 Dec 2023 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gpXoOR8A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997C2F847
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:42a6:0:640:15f4:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id A497060EE3;
	Fri, 15 Dec 2023 17:01:31 +0300 (MSK)
Received: from davydov-max-nux.yandex.net (unknown [2a02:6b8:0:419:ed5e:f8e6:ca7f:c00d])
	by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id D1mgmB0GfOs0-kI8EEad7;
	Fri, 15 Dec 2023 17:01:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1702648890;
	bh=hBgvleu0cfg4lHgVjkdztt7M4UQsQ0LacEUkFkN556Q=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=gpXoOR8ApfZx9SQ6kydNVgLY8E/gEEWnNhUcHg1HP6UhKkSn4CZGEfJO8ePqkuJEq
	 mJrKy0xqcT5JCWbhBJEJZtxjZd7JyC1z3PW7R4jbQg7rEXvsJEL6rx/e4w/NC3YAdu
	 i8R0v/JwvPyB/96zhJ8AYjDXMFW/KHQxfpAlqm6w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: davydov-max@yandex-team.ru,
	den-plotnikov@yandex-team.ru,
	tony.luck@intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH] x86/split_lock: add split lock counter
Date: Fri, 15 Dec 2023 17:01:13 +0300
Message-Id: <20231215140113.57173-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provides per task split locks counter to monitor split locks rate
in the system. It can be helpful in split locks monitoring to get a clear
sense of which process causing split locks and how many of them have
happened by the moment. For instance, it might be used by cloud providers
who can't control guest executable code and want to make decisions based
on the rate value like ratelimiting or notifing the split lock origins.

To implement this functionality the per-task flag have been transformed
into the counter. But procfs interface is used to provide the counter
in machine-readable format.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/include/asm/cpu.h  | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/intel.c | 35 +++++++++++++++++++++++++++++++++--
 fs/proc/base.c              |  7 +++++++
 include/linux/sched.h       |  6 +++---
 kernel/fork.c               |  2 +-
 5 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index fecc4fe1d68a..1470124e1d63 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,12 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
 u8 get_this_hybrid_cpu_type(void);
+extern int proc_pid_split_locks_show(struct seq_file *s,
+		struct pid_namespace *ns, struct pid *pid,
+		struct task_struct *tsk);
+extern int proc_tgid_split_locks_show(struct seq_file *s,
+		struct pid_namespace *ns, struct pid *pid,
+		struct task_struct *tsk);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -62,6 +68,18 @@ static inline u8 get_this_hybrid_cpu_type(void)
 {
 	return 0;
 }
+static inline int proc_pid_split_locks_show(struct seq_file *s,
+		struct pid_namespace *ns, struct pid *pid,
+		struct task_struct *tsk)
+{
+	return 0;
+}
+static inline int proc_tgid_split_locks_show(struct seq_file *s,
+		struct pid_namespace *ns, struct pid *pid,
+		struct task_struct *tsk)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8fc9624..20640a4b9eac 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1160,10 +1160,10 @@ static void split_lock_warn(unsigned long ip)
 	struct delayed_work *work;
 	int cpu;
 
-	if (!current->reported_split_lock)
+	if (!current->detected_split_locks)
 		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, ip);
-	current->reported_split_lock = 1;
+	current->detected_split_locks++;
 
 	if (sysctl_sld_mitigate) {
 		/*
@@ -1191,6 +1191,37 @@ static void split_lock_warn(unsigned long ip)
 	put_cpu();
 }
 
+static int split_locks_show(struct seq_file *s, struct task_struct *tsk,
+			    int whole)
+{
+	u64 detected_split_locks = tsk->detected_split_locks;
+
+	if (whole) {
+		struct task_struct *t = tsk;
+
+		while_each_thread(tsk, t) {
+			detected_split_locks += t->detected_split_locks;
+		}
+	}
+
+	seq_put_decimal_ull(s, "", detected_split_locks);
+	seq_putc(s, '\n');
+
+	return 0;
+}
+
+int proc_pid_split_locks_show(struct seq_file *s, struct pid_namespace *ns,
+			      struct pid *pid, struct task_struct *tsk)
+{
+	return split_locks_show(s, tsk, 0);
+}
+
+int proc_tgid_split_locks_show(struct seq_file *s, struct pid_namespace *ns,
+			       struct pid *pid, struct task_struct *tsk)
+{
+	return split_locks_show(s, tsk, 1);
+}
+
 bool handle_guest_split_lock(unsigned long ip)
 {
 	if (sld_state == sld_warn) {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index dd31e3b6bf77..3c533312dbbc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -98,6 +98,7 @@
 #include <linux/cn_proc.h>
 #include <linux/ksm.h>
 #include <trace/events/oom.h>
+#include <asm/cpu.h>
 #include "internal.h"
 #include "fd.h"
 
@@ -3360,6 +3361,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_CPU_SUP_INTEL
+	ONE("split_locks", S_IRUGO, proc_tgid_split_locks_show),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3699,6 +3703,9 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_CPU_SUP_INTEL
+	ONE("split_locks", S_IRUGO, proc_pid_split_locks_show),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..5b9cd4524405 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -957,9 +957,6 @@ struct task_struct {
 #ifdef CONFIG_IOMMU_SVA
 	unsigned			pasid_activated:1;
 #endif
-#ifdef	CONFIG_CPU_SUP_INTEL
-	unsigned			reported_split_lock:1;
-#endif
 #ifdef CONFIG_TASK_DELAY_ACCT
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
@@ -1027,6 +1024,9 @@ struct task_struct {
 	u64				stimescaled;
 #endif
 	u64				gtime;
+#ifdef	CONFIG_CPU_SUP_INTEL
+	u64				detected_split_locks;
+#endif
 	struct prev_cputime		prev_cputime;
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 	struct vtime			vtime;
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..5a0318010dd5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1188,7 +1188,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 
 #ifdef CONFIG_CPU_SUP_INTEL
-	tsk->reported_split_lock = 0;
+	tsk->detected_split_locks = 0;
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
-- 
2.34.1


