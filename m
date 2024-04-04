Return-Path: <linux-kernel+bounces-132004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17338898E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380031C27741
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA01332A5;
	Thu,  4 Apr 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HRB8vm4"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFE1D6A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257344; cv=none; b=tTUg6JRxk8HGxiO5si624HjKOrburhn3gdR2j+AQwwll9NEwUC3tdHK/bwN+ApeS1d9Ujwr6yPCm4VutWagPEp+/pa0opddqlLOm0ww10LyHkCca9Iou2TuRcmUswp1XEpYkA3A1FDE8z6x28EAWBXW9F87IYNW1hpW4xC2axIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257344; c=relaxed/simple;
	bh=rKaK1Zc9SOGEDlcWnUTiSrWXe1T2ioiZmgOH6AaQzJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g02HWXH6XGTFSeKClrUAUrVBr3XjPIL5q4N9As5feXUK1zSmCFeBNc1r1Yi56SIX9w56BRVyDix4oW5yUU060Q8m+CPuMXUP6zLLGrGY5tZhigDpGCF55LvpiCsoWkGsuF8uBTWYY4JhLmluxLhGc5+wf4Kk2KiDMoyrFYKyY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HRB8vm4; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56e090236acso806271a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712257340; x=1712862140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fjeFoOMiQMg1H5xaHZjQQm5ismA9U/Cf/wjYUQ8Jbl4=;
        b=2HRB8vm4ZztxJ0XTvt/m4i+Fxz0eFrEWaBEljTKZp1o0Sct1oBHm+OKNYeMl3muteo
         W1NSZJ7q+U3QNmbt1QLhluQIvcYxiT2BEUyKseaiw/Ejc8GxDnyqaZe3kuxGJ2Y4CJMD
         /bNG7UOHPQGAlvbN8fvA1N046DpBxWn6CyQxJg079tHo+hZ9+Dbw5AQeUmm4Ij3JCfJ0
         F88lMl4NRiZpIqBnVy0KXo6nJzU1sgXCgtqgkNi/IKzipI095bxyp4nM2xn0aW74636/
         bGrRrouImIM2H3dMSpmwc1jGkqr9K7afoNc/j6LZ+OaPGhmLI/yYJaeF+DB+ApAwBnc5
         mjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257340; x=1712862140;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjeFoOMiQMg1H5xaHZjQQm5ismA9U/Cf/wjYUQ8Jbl4=;
        b=OKpHUwSNLhIk8gBQH1SYkeVywFx7HMB0cQMbuNSyandtFz6CKnaYBuF5M3vUhF/HXI
         MFWoWQLvXjbyr5So7ihhg04Kb88YIu1uADPKptTnT2wx7CdZjvD3TwbLfTkuazbxUvb+
         L6ivpKAXKa+JvXrCQwJOLUf12JZv1K953zu43/jlPi+8gl4szT+cx/Dy8bXfLZ7dfyKy
         4soNJ1tGdbOae7W2WvS8euYMzIbD7MHTPpHlVQ8bfXWt6IwbgG16L39AOLTdeCHFl33L
         /thYwRzTbj5sGsbi3swMP1A/HVc9UjU/Aqtc6Nn5C9jCr2oxk57V+Sdt5U6cmWfaPDDb
         c6sg==
X-Forwarded-Encrypted: i=1; AJvYcCWxAbPsLzO3BKDRaLJnZuumHsHYw94VNuhUnZ+/dhEAJ1TSmeD/OUYScZDIC+jwjdLHKtNFBRquD+Po3KtgGBWvD998cwzhgangqMPY
X-Gm-Message-State: AOJu0Yx+/XiIKKAmdp7GPugbh7/8/tkNUdKqxd0dG+fumMpAYwr4yALE
	GXbUJu1f2HQCwx7JJVO1gTLyKPHKrXrfhW56DnGjkGYzf0f38Zalf22cJ25eKQqZ3nbS3bsqBw=
	=
X-Google-Smtp-Source: AGHT+IHhNXlRuqsdejfQye9ej9C5xDI1Y5f94yZMQvaRMkJ+dAHRN9ha9FTmTybWvMEvEzHNBF4qDeym8A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:2ac:e52b:98d7:eb1e])
 (user=elver job=sendgmr) by 2002:a05:6402:2482:b0:56e:1348:c9b8 with SMTP id
 q2-20020a056402248200b0056e1348c9b8mr1688eda.0.1712257339434; Thu, 04 Apr
 2024 12:02:19 -0700 (PDT)
Date: Thu,  4 Apr 2024 21:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404190146.1898103-1-elver@google.com>
Subject: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With all the known caveats, tracing BPF programs may directly write to
user-space memory with the bpf_probe_write_user() helper. Memory safety
is an obvious problem when using this helper, since it is too easy to
overwrite memory across all running processes that user space did not
expect to be touched (neither the verifier nor the kernel knows what may
be touched). While it is possible to come up with mechanisms to safely
communicate to the BPF program which memory region may be written to,
there are no built-in guarantees of safety. For this reason, the helper
produces a warning in the kernel log, and in newer kernels it is
possible to disallow use of the helper since 51e1bb9eeaf7 ("bpf: Add
lockdown check for probe_write_user helper").

Nevertheless, direct user-space memory writes from BPF programs can be
useful to efficiently manipulate and communicate with cooperating user
space processes.

For example, one of our use cases are for events that happen relatively
frequently in the kernel (e.g. specific scheduler events), but a set of
user space threads want to check for such events in very hot code paths
to make more optimal decisions (the cost of such a check can be no more
than a load and compare). The types of events and heuristics used may
change based on system environment and application, and a BPF program
provides the best trade-offs in terms of performance and deployment.

To achieve better safety, introduce tagged user writable regions, that
must explicitly be registered before tracing BPF programs may use them:

 1. The prctl() option PR_BPF_REGISTER_WRITABLE allows any user space
    process (that is allowed to use prctl()) to register tagged writable
    memory regions for the current thread.

 2. Conversely, the prctl() option PR_BPF_UNREGISTER_WRITABLE allows a
    user space process to unregister a writable memory region that was
    previously registered from the current thread. This must be done
    before freeing memory if the thread that registered a region is
    still running.

 3. Tracing BPF programs may write to any registered region in the
    current thread with bpf_probe_write_user_registered(). If the memory
    region has been tagged with a non-zero value, the BPF program must
    provide a matching tag.

Admin capabilities are still required to attach BPF programs that use
the new bpf_probe_write_user_registered() helper.

With this interface, user space threads are guaranteed that no writes
happen to regions that they did not explicitly register. Tagging can be
used to associate additional semantics with the memory region.

A note on tag allocation: Since such programs can only be installed by
the local system administrator, tag allocation may be done by the system
administrator. For example, by providing headers with tag definitions,
or a central service to distribute tags to the BPF program loader and to
user applications.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/bpf/bpf_design_QA.rst |   3 +-
 fs/exec.c                           |   2 +
 include/linux/sched.h               |   5 +
 include/linux/trace_events.h        |  19 +++
 include/uapi/linux/bpf.h            |  16 ++
 include/uapi/linux/capability.h     |   3 +-
 include/uapi/linux/prctl.h          |   5 +
 kernel/fork.c                       |   6 +
 kernel/sys.c                        |   7 +
 kernel/trace/bpf_trace.c            | 220 +++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h      |  16 ++
 tools/include/uapi/linux/prctl.h    |   5 +
 12 files changed, 303 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index eb19c945f4d5..5f081d254a44 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -254,7 +254,8 @@ A: Sort-of.
 Tracing BPF programs can overwrite the user memory
 of the current task with bpf_probe_write_user(). Every time such
 program is loaded the kernel will print warning message, so
-this helper is only useful for experiments and prototypes.
+this helper is only useful for experiments and prototypes. A safer,
+but more limited, alternative is bpf_probe_write_user_registered().
 Tracing BPF programs are root only.
 
 Q: New functionality via kernel modules?
diff --git a/fs/exec.c b/fs/exec.c
index cf1df7f16e55..38bf71cbdf5e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
 #include <linux/time_namespace.h>
+#include <linux/trace_events.h>
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 
@@ -1881,6 +1882,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 	user_events_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
+	bpf_user_writable_free(current);
 	return retval;
 
 out:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..81ab3b5df430 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -53,6 +53,7 @@ struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
 struct bpf_run_ctx;
+struct bpf_user_writable;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
@@ -1501,6 +1502,10 @@ struct task_struct {
 	struct bpf_local_storage __rcu	*bpf_storage;
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
+#ifdef CONFIG_BPF_EVENTS
+	/* Used for bpf_probe_write_user_registered() */
+	struct bpf_user_writable	*bpf_user_writable;
+#endif
 #endif
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 6f9bdfb09d1d..658c1bfc9048 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -775,6 +775,10 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_user_writable_register(void __user *start, size_t size, u32 tag);
+int bpf_user_writable_unregister(void __user *start, size_t size);
+int bpf_user_writable_copy(struct task_struct *t, u64 clone_flags);
+void bpf_user_writable_free(struct task_struct *t);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -826,6 +830,21 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_user_writable_register(void __user *start, size_t size, u32 tag)
+{
+	return -EOPNOTSUPP;
+}
+static inline int bpf_user_writable_unregister(void __user *start, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+static inline int bpf_user_writable_copy(struct task_struct *t, u64 clone_flags)
+{
+	return 0;
+}
+static inline void bpf_user_writable_free(struct task_struct *t)
+{
+}
 #endif
 
 enum {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c42b9f1bada..f5b86792b99d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5782,6 +5782,21 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_probe_write_user_registered(void *dst, const void *src, u32 len, u32 tag)
+ *	Description
+ *		Attempt in a safe way to write *len* bytes from the buffer *src*
+ *		to *dst* in memory. Writes are permitted for threads that have
+ *		registered the target memory region as writable via the prctl()
+ *		PR_BPF_REGISTER_WRITABLE. If the region was registered with a
+ *		non-zero tag, a matching *tag* must be provided.
+ *
+ *		This helper should not be used to implement any kind of
+ *		security mechanism because of TOC-TOU attacks, but rather to
+ *		debug, divert, and manipulate execution of cooperative
+ *		processes.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5996,6 +6011,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(probe_write_user_registered, 212, ##ctx)	\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 5bb906098697..144db9d2bea9 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -401,7 +401,8 @@ struct vfs_ns_cap_data {
  * - bpf_probe_read to read arbitrary kernel memory is allowed
  * - bpf_trace_printk to print kernel memory is allowed
  *
- * CAP_SYS_ADMIN is required to use bpf_probe_write_user.
+ * CAP_SYS_ADMIN is required to use bpf_probe_write_user and
+ * bpf_probe_write_user_registered.
  *
  * CAP_SYS_ADMIN is required to iterate system wide loaded
  * programs, maps, links, BTFs and convert their IDs to file descriptors.
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..4a9372e675ae 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,9 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+/* Register tagged writable memory region for the current task. */
+#define PR_BPF_REGISTER_WRITABLE		71
+/* Unregister tagged writable memory region for the current task. */
+#define PR_BPF_UNREGISTER_WRITABLE		72
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 39a5046c2f0b..3ea87b1e5806 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -98,6 +98,7 @@
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
 #include <linux/stackprotector.h>
+#include <linux/trace_events.h>
 #include <linux/user_events.h>
 #include <linux/iommu.h>
 #include <linux/rseq.h>
@@ -606,6 +607,7 @@ void free_task(struct task_struct *tsk)
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
 	bpf_task_storage_free(tsk);
+	bpf_user_writable_free(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -2353,6 +2355,9 @@ __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_BPF_SYSCALL
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx = NULL;
+	retval = bpf_user_writable_copy(p, clone_flags);
+	if (retval)
+		goto bad_fork_cleanup_policy;
 #endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
@@ -2664,6 +2669,7 @@ __latent_entropy struct task_struct *copy_process(
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
 bad_fork_cleanup_policy:
+	bpf_user_writable_free(p);
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
 	mpol_put(p->mempolicy);
diff --git a/kernel/sys.c b/kernel/sys.c
index 8bb106a56b3a..c317e462600b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/mount.h>
 #include <linux/gfp.h>
 #include <linux/syscore_ops.h>
+#include <linux/trace_events.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/syscall_user_dispatch.h>
@@ -2760,6 +2761,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_BPF_REGISTER_WRITABLE:
+		error = bpf_user_writable_register((void __user *)arg2, arg3, arg4);
+		break;
+	case PR_BPF_UNREGISTER_WRITABLE:
+		error = bpf_user_writable_unregister((void __user *)arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a5c4efc73c3..643454c398a2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -82,6 +82,181 @@ static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
 }
 #endif /* CONFIG_MODULES */
 
+/* Memory region writable with bpf_probe_write_user_registered(). */
+struct bpf_user_writable_entry {
+	void __user *start;
+	size_t size;
+	u32 tag;
+};
+
+struct bpf_user_writable {
+	u32 capacity;
+	u32 size;
+	struct bpf_user_writable_entry entries[];
+};
+
+static inline int bpf_user_writable_entry_cmp(const void *_key, const void *_ent)
+{
+	const struct bpf_user_writable_entry *key = (const struct bpf_user_writable_entry *)_key;
+	const struct bpf_user_writable_entry *ent = (const struct bpf_user_writable_entry *)_ent;
+	void __user *key_end = key->start + key->size - 1;
+	void __user *ent_end = ent->start + ent->size - 1;
+
+	if (ent->start <= key->start && key_end <= ent_end)
+		return 0; /* key memory range contained in entry */
+
+	return key->start < ent->start ? -1 : 1;
+}
+
+/*
+ * Returns true if the memory region from @ptr with size @size is a subset of
+ * any registered region of the current task.
+ */
+static const struct bpf_user_writable_entry *bpf_user_writable_find(void __user *ptr, size_t size)
+{
+	const struct bpf_user_writable_entry key = {.start = ptr, .size = size};
+	const struct bpf_user_writable *uw = current->bpf_user_writable;
+
+	if (!uw)
+		return NULL;
+
+	/*
+	 * We want bpf_probe_write_user_registered() to be as fast as the
+	 * non-registered version (for small uw->size): regular bsearch() does
+	 * too many calls, esp. because bpf_user_writable_entry_cmp() needs to
+	 * be outlined. Use the inline version instead, which also gives the
+	 * compiler a chance to inline bpf_user_writable_entry_cmp().
+	 */
+	return __inline_bsearch(&key, uw->entries, uw->size, sizeof(key), bpf_user_writable_entry_cmp);
+}
+
+int bpf_user_writable_register(void __user *start, size_t size, u32 tag)
+{
+	const struct bpf_user_writable_entry *exist;
+	struct bpf_user_writable_entry *ent;
+	struct bpf_user_writable *uw;
+
+	/*
+	 * Sanity check the user didn't try to register inaccessible memory.
+	 */
+	if (!start || !size || !access_ok(start, size))
+		return -EFAULT;
+
+	/*
+	 * Trying to add a range with the same address as already added is most
+	 * likely a bug - ensure the range was unregistered before re-adding.
+	 *
+	 * This also ensures that we always retain the property that no two
+	 * entries have the same start and we can sort them based on the start
+	 * address alone.
+	 */
+	exist = bpf_user_writable_find(start, 1);
+	if (exist && exist->start == start)
+		return -EEXIST;
+
+	if (current->bpf_user_writable) {
+		uw = current->bpf_user_writable;
+	} else { /* initial alloc */
+		uw = kmalloc(struct_size(uw, entries, 1), GFP_KERNEL);
+		if (!uw)
+			return -ENOMEM;
+		uw->capacity = 1;
+		uw->size = 0;
+		current->bpf_user_writable = uw;
+	}
+
+	if (uw->size == uw->capacity) { /* grow exponentially */
+		const u32 ncap = uw->capacity * 2;
+		struct bpf_user_writable *new_uw;
+
+		/* Upper bound of 2^31 entries - should be more than enough. */
+		if (uw->capacity > S32_MAX)
+			return -ENOMEM;
+
+		new_uw = krealloc(uw, struct_size(uw, entries, ncap), GFP_KERNEL);
+		if (!new_uw)
+			return -ENOMEM;
+
+		current->bpf_user_writable = uw = new_uw;
+		uw->capacity = ncap;
+	}
+
+	/* Insert new entry and sort. */
+	ent = &uw->entries[uw->size++];
+	ent->start = start;
+	ent->size = size;
+	ent->tag = tag;
+
+	sort(uw->entries, uw->size, sizeof(*ent), bpf_user_writable_entry_cmp, NULL);
+
+	return 0;
+}
+
+int bpf_user_writable_unregister(void __user *start, size_t size)
+{
+	const struct bpf_user_writable_entry *ent = bpf_user_writable_find(start, size);
+	struct bpf_user_writable *uw = current->bpf_user_writable;
+	size_t del_idx;
+
+	if (!ent)
+		return -ENOENT;
+
+	/* To unregister, require the precise range as used on registration. */
+	if (ent->start != start || ent->size != size)
+		return -ENOENT;
+
+	/*
+	 * Shift all entries after the to-be-deleted one left by one. The array
+	 * remains sorted.
+	 */
+	del_idx = ent - uw->entries;
+	for (size_t i = del_idx + 1; i < uw->size; ++i)
+		uw->entries[i - 1] = uw->entries[i];
+	uw->size--;
+
+	return 0;
+}
+
+int bpf_user_writable_copy(struct task_struct *t, u64 clone_flags)
+{
+	const struct bpf_user_writable *src;
+	struct bpf_user_writable *dst;
+
+	if (WARN_ON_ONCE(t == current))
+		return 0;
+
+	t->bpf_user_writable = NULL;
+
+	src = current->bpf_user_writable;
+	if (!src || (clone_flags & CLONE_VM)) {
+		/*
+		 * Shared VM: this thread gets its own user writable regions.
+		 */
+		return 0;
+	}
+
+	/*
+	 * A fork()'ed task (with separate VM) should behave as closely to the
+	 * original task as possible, and we will copy the writable regions.
+	 */
+	dst = kmalloc(struct_size(dst, entries, src->capacity), GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+	memcpy(dst, src, struct_size(dst, entries, src->size));
+	t->bpf_user_writable = dst;
+
+	return 0;
+}
+
+void bpf_user_writable_free(struct task_struct *t)
+{
+	if (!t->bpf_user_writable)
+		return;
+
+	kfree(t->bpf_user_writable);
+	t->bpf_user_writable = NULL;
+}
+
 u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
@@ -324,8 +499,8 @@ static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
 };
 #endif /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
 
-BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
-	   u32, size)
+static __always_inline int
+bpf_probe_write_user_common(void __user *unsafe_ptr, const void *src, u32 size)
 {
 	/*
 	 * Ensure we're in user context which is safe for the helper to
@@ -349,6 +524,12 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
 	return copy_to_user_nofault(unsafe_ptr, src, size);
 }
 
+BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
+	   u32, size)
+{
+	return bpf_probe_write_user_common(unsafe_ptr, src, size);
+}
+
 static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.func		= bpf_probe_write_user,
 	.gpl_only	= true,
@@ -369,6 +550,39 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
+BPF_CALL_4(bpf_probe_write_user_registered, void __user *, unsafe_ptr, const void *, src,
+	   u32, size, u32, tag)
+{
+	const struct bpf_user_writable_entry *ent = bpf_user_writable_find(unsafe_ptr, size);
+
+	if (!ent)
+		return -EPERM;
+
+	/* A region with tag 0 matches any tag. */
+	if (ent->tag && ent->tag != tag)
+		return -EPERM;
+
+	return bpf_probe_write_user_common(unsafe_ptr, src, size);
+}
+
+static const struct bpf_func_proto bpf_probe_write_user_registered_proto = {
+	.func		= bpf_probe_write_user_registered,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type      = ARG_ANYTHING,
+};
+
+static const struct bpf_func_proto *bpf_get_probe_write_registered_proto(void)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return NULL;
+
+	return &bpf_probe_write_user_registered_proto;
+}
+
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -1552,6 +1766,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_probe_write_user:
 		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
 		       NULL : bpf_get_probe_write_proto();
+	case BPF_FUNC_probe_write_user_registered:
+		return bpf_get_probe_write_registered_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c42b9f1bada..f5b86792b99d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5782,6 +5782,21 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_probe_write_user_registered(void *dst, const void *src, u32 len, u32 tag)
+ *	Description
+ *		Attempt in a safe way to write *len* bytes from the buffer *src*
+ *		to *dst* in memory. Writes are permitted for threads that have
+ *		registered the target memory region as writable via the prctl()
+ *		PR_BPF_REGISTER_WRITABLE. If the region was registered with a
+ *		non-zero tag, a matching *tag* must be provided.
+ *
+ *		This helper should not be used to implement any kind of
+ *		security mechanism because of TOC-TOU attacks, but rather to
+ *		debug, divert, and manipulate execution of cooperative
+ *		processes.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5996,6 +6011,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(probe_write_user_registered, 212, ##ctx)	\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 370ed14b1ae0..4a9372e675ae 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -306,4 +306,9 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+/* Register tagged writable memory region for the current task. */
+#define PR_BPF_REGISTER_WRITABLE		71
+/* Unregister tagged writable memory region for the current task. */
+#define PR_BPF_UNREGISTER_WRITABLE		72
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.44.0.478.gd926399ef9-goog


