Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4F79E715
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbjIMLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjIMLrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:47:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F108319AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:47:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30694C433CA;
        Wed, 13 Sep 2023 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694605620;
        bh=BZf+zZM9sVwxroHem+Yy/Zphx5LTLZy6/U7KJ8tSUJM=;
        h=Date:From:To:Cc:Subject:From;
        b=C0S14i4ZI4B6TWqoTdN16n3YJAJQKVAIfTJKUqs2kAcKQ0i2GND4tG3VJZvRCmwnU
         DMx0DhDoSKQ9pgDUVhRaSYn1cFq2FB0XhsgvJaPp5KnD9uwunV3dWMQLpdMRBvcu3a
         gfRhfcI7zh+D0sEPLLa4SpZn14JRTf3+RDmXr/dSKWwCwx3m15vh68dpdeUJcKT3YJ
         scoYhR7q8zD7yQMEiEOpG/AdvEZrcp94hg5CswduQdFzDoAh26xDLp+lGmsmbhxDJ4
         JklTC7zyOW7dfYnO0RFKjdozfEzm7vDwrRpGbRMCHcLM0SnQQPhOjfU1ov8dEYMfeM
         86pGQUh4mKKPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 18096403F4; Wed, 13 Sep 2023 08:46:57 -0300 (-03)
Date:   Wed, 13 Sep 2023 08:46:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     Kees Kook <keescook@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2 fyi] tools headers UAPI: Copy seccomp.h to be able to
 build 'perf bench' in older systems
Message-ID: <ZQGhMXtwX7RvV3ya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

The new 'perf bench' for sched-seccomp-notify uses defines and types not
available in older systems where we want to have perf available, so grab
a copy of this UAPI from the kernel sources to allow that.

This will be checked in the future for drift from the original when we
build the perf tool, that will warn when that happens like:

  make: Entering directory '/var/home/acme/git/perf-tools/tools/perf'
    BUILD:   Doing 'make -j32' parallel build
  Warning: Kernel ABI header differences:

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrei Vagin <avagin@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kees Kook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/seccomp.h | 157 +++++++++++++++++++++++++++++
 tools/perf/check-headers.sh        |   1 +
 2 files changed, 158 insertions(+)
 create mode 100644 tools/include/uapi/linux/seccomp.h

diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linux/seccomp.h
new file mode 100644
index 0000000000000000..dbfc9b37fcaee47e
--- /dev/null
+++ b/tools/include/uapi/linux/seccomp.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SECCOMP_H
+#define _UAPI_LINUX_SECCOMP_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+
+/* Valid values for seccomp.mode and prctl(PR_SET_SECCOMP, <mode>) */
+#define SECCOMP_MODE_DISABLED	0 /* seccomp is not in use. */
+#define SECCOMP_MODE_STRICT	1 /* uses hard-coded filter. */
+#define SECCOMP_MODE_FILTER	2 /* uses user-supplied filter. */
+
+/* Valid operations for seccomp syscall. */
+#define SECCOMP_SET_MODE_STRICT		0
+#define SECCOMP_SET_MODE_FILTER		1
+#define SECCOMP_GET_ACTION_AVAIL	2
+#define SECCOMP_GET_NOTIF_SIZES		3
+
+/* Valid flags for SECCOMP_SET_MODE_FILTER */
+#define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
+#define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
+#define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
+#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
+/* Received notifications wait in killable state (only respond to fatal signals) */
+#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+
+/*
+ * All BPF programs must return a 32-bit value.
+ * The bottom 16-bits are for optional return data.
+ * The upper 16-bits are ordered from least permissive values to most,
+ * as a signed value (so 0x8000000 is negative).
+ *
+ * The ordering ensures that a min_t() over composed return values always
+ * selects the least permissive choice.
+ */
+#define SECCOMP_RET_KILL_PROCESS 0x80000000U /* kill the process */
+#define SECCOMP_RET_KILL_THREAD	 0x00000000U /* kill the thread */
+#define SECCOMP_RET_KILL	 SECCOMP_RET_KILL_THREAD
+#define SECCOMP_RET_TRAP	 0x00030000U /* disallow and force a SIGSYS */
+#define SECCOMP_RET_ERRNO	 0x00050000U /* returns an errno */
+#define SECCOMP_RET_USER_NOTIF	 0x7fc00000U /* notifies userspace */
+#define SECCOMP_RET_TRACE	 0x7ff00000U /* pass to a tracer or disallow */
+#define SECCOMP_RET_LOG		 0x7ffc0000U /* allow after logging */
+#define SECCOMP_RET_ALLOW	 0x7fff0000U /* allow */
+
+/* Masks for the return value sections. */
+#define SECCOMP_RET_ACTION_FULL	0xffff0000U
+#define SECCOMP_RET_ACTION	0x7fff0000U
+#define SECCOMP_RET_DATA	0x0000ffffU
+
+/**
+ * struct seccomp_data - the format the BPF program executes over.
+ * @nr: the system call number
+ * @arch: indicates system call convention as an AUDIT_ARCH_* value
+ *        as defined in <linux/audit.h>.
+ * @instruction_pointer: at the time of the system call.
+ * @args: up to 6 system call arguments always stored as 64-bit values
+ *        regardless of the architecture.
+ */
+struct seccomp_data {
+	int nr;
+	__u32 arch;
+	__u64 instruction_pointer;
+	__u64 args[6];
+};
+
+struct seccomp_notif_sizes {
+	__u16 seccomp_notif;
+	__u16 seccomp_notif_resp;
+	__u16 seccomp_data;
+};
+
+struct seccomp_notif {
+	__u64 id;
+	__u32 pid;
+	__u32 flags;
+	struct seccomp_data data;
+};
+
+/*
+ * Valid flags for struct seccomp_notif_resp
+ *
+ * Note, the SECCOMP_USER_NOTIF_FLAG_CONTINUE flag must be used with caution!
+ * If set by the process supervising the syscalls of another process the
+ * syscall will continue. This is problematic because of an inherent TOCTOU.
+ * An attacker can exploit the time while the supervised process is waiting on
+ * a response from the supervising process to rewrite syscall arguments which
+ * are passed as pointers of the intercepted syscall.
+ * It should be absolutely clear that this means that the seccomp notifier
+ * _cannot_ be used to implement a security policy! It should only ever be used
+ * in scenarios where a more privileged process supervises the syscalls of a
+ * lesser privileged process to get around kernel-enforced security
+ * restrictions when the privileged process deems this safe. In other words,
+ * in order to continue a syscall the supervising process should be sure that
+ * another security mechanism or the kernel itself will sufficiently block
+ * syscalls if arguments are rewritten to something unsafe.
+ *
+ * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
+ * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
+ * same syscall, the most recently added filter takes precedence. This means
+ * that the new SECCOMP_RET_USER_NOTIF filter can override any
+ * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
+ * such filtered syscalls to be executed by sending the response
+ * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
+ * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
+ */
+#define SECCOMP_USER_NOTIF_FLAG_CONTINUE (1UL << 0)
+
+struct seccomp_notif_resp {
+	__u64 id;
+	__s64 val;
+	__s32 error;
+	__u32 flags;
+};
+
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+
+/* valid flags for seccomp_notif_addfd */
+#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+#define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
+
+/**
+ * struct seccomp_notif_addfd
+ * @id: The ID of the seccomp notification
+ * @flags: SECCOMP_ADDFD_FLAG_*
+ * @srcfd: The local fd number
+ * @newfd: Optional remote FD number if SETFD option is set, otherwise 0.
+ * @newfd_flags: The O_* flags the remote FD should have applied
+ */
+struct seccomp_notif_addfd {
+	__u64 id;
+	__u32 flags;
+	__u32 srcfd;
+	__u32 newfd;
+	__u32 newfd_flags;
+};
+
+#define SECCOMP_IOC_MAGIC		'!'
+#define SECCOMP_IO(nr)			_IO(SECCOMP_IOC_MAGIC, nr)
+#define SECCOMP_IOR(nr, type)		_IOR(SECCOMP_IOC_MAGIC, nr, type)
+#define SECCOMP_IOW(nr, type)		_IOW(SECCOMP_IOC_MAGIC, nr, type)
+#define SECCOMP_IOWR(nr, type)		_IOWR(SECCOMP_IOC_MAGIC, nr, type)
+
+/* Flags for seccomp notification fd ioctl. */
+#define SECCOMP_IOCTL_NOTIF_RECV	SECCOMP_IOWR(0, struct seccomp_notif)
+#define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
+						struct seccomp_notif_resp)
+#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOW(2, __u64)
+/* On success, the return value is the remote process's added fd number */
+#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
+						struct seccomp_notif_addfd)
+
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS	SECCOMP_IOW(4, __u64)
+
+#endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 4314c91978509a49..e21caadda7c11566 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -21,6 +21,7 @@ FILES=(
   "include/uapi/linux/perf_event.h"
   "include/uapi/linux/prctl.h"
   "include/uapi/linux/sched.h"
+  "include/uapi/linux/seccomp.h"
   "include/uapi/linux/stat.h"
   "include/uapi/linux/usbdevice_fs.h"
   "include/uapi/linux/vhost.h"
-- 
2.37.1

