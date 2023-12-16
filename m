Return-Path: <linux-kernel+bounces-2000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361568156D6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98101F21CBA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E5107B6;
	Sat, 16 Dec 2023 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MFvpTzAH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD48101F5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocPDVHoS7vEhw6tr2I6a+vqz6+CvzqYlQOZuWmaACjs=;
	b=MFvpTzAHZrRy1GsWJgEbV5sUn3JBdOzPITqjc+x2YXTYOyRxMDxGyb0QcQlfWXCByyKVKk
	G0ZLeiQmLO2bKrCM457BFrpTL8dvQbBS8Dszx5Keykadem6YhSAfF3z/4a52vJrcMYILTh
	b/dEnYVIXWAmR5h3vpZWXvEStueaZm0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Subject: [PATCH 22/50] pid: Split out pid_types.h
Date: Fri, 15 Dec 2023 22:29:28 -0500
Message-ID: <20231216032957.3553313-1-kent.overstreet@linux.dev>
In-Reply-To: <20231216024834.3510073-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Trimming down sched.h dependencies: we dont't want to include more than
the base types.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 drivers/target/target_core_xcopy.c |  1 +
 include/linux/pid.h                | 15 ++-------------
 include/linux/pid_types.h          | 16 ++++++++++++++++
 include/linux/sched.h              |  2 +-
 include/linux/seccomp.h            |  2 ++
 5 files changed, 22 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/pid_types.h

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 91ed015b588c..4128631c9dfd 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/rculist.h>
 #include <linux/configfs.h>
 #include <linux/ratelimit.h>
 #include <scsi/scsi_proto.h>
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 653a527574c4..f254c3a45b9b 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,18 +2,10 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/pid_types.h>
 #include <linux/rculist.h>
-#include <linux/wait.h>
 #include <linux/refcount.h>
-
-enum pid_type
-{
-	PIDTYPE_PID,
-	PIDTYPE_TGID,
-	PIDTYPE_PGID,
-	PIDTYPE_SID,
-	PIDTYPE_MAX,
-};
+#include <linux/wait.h>
 
 /*
  * What is struct pid?
@@ -110,9 +102,6 @@ extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
-struct pid_namespace;
-extern struct pid_namespace init_pid_ns;
-
 extern int pid_max;
 extern int pid_max_min, pid_max_max;
 
diff --git a/include/linux/pid_types.h b/include/linux/pid_types.h
new file mode 100644
index 000000000000..c2aee1d91dcf
--- /dev/null
+++ b/include/linux/pid_types.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PID_TYPES_H
+#define _LINUX_PID_TYPES_H
+
+enum pid_type {
+	PIDTYPE_PID,
+	PIDTYPE_TGID,
+	PIDTYPE_PGID,
+	PIDTYPE_SID,
+	PIDTYPE_MAX,
+};
+
+struct pid_namespace;
+extern struct pid_namespace init_pid_ns;
+
+#endif /* _LINUX_PID_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 436f7ce1450a..37cc9d257073 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -11,7 +11,7 @@
 
 #include <asm/current.h>
 
-#include <linux/pid.h>
+#include <linux/pid_types.h>
 #include <linux/sem.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 175079552f68..1ec0d8dc4b69 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -126,6 +126,8 @@ static inline long seccomp_get_metadata(struct task_struct *task,
 
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 struct seq_file;
+struct pid_namespace;
+struct pid;
 
 int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
 			   struct pid *pid, struct task_struct *task);
-- 
2.43.0


