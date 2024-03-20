Return-Path: <linux-kernel+bounces-109345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8378817E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D331C22EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D285935;
	Wed, 20 Mar 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmfKJzAU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B598565E;
	Wed, 20 Mar 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963083; cv=none; b=LfWOBcIDp0OqT/fNudlnez2a/wpMBHsPsfIHTRFhE1steReDahVrF98sGVdNQzT6fWms25PwpqKtWFxF7HVCxIJUM/iwsrNoBakEk/rMYmgi1y4l0HE44HHhZcJET8vXn7DKLqLj5Wtu5mxADUxKWLrPIpa2OoNRwpWNuZJ6vLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963083; c=relaxed/simple;
	bh=DtY8CRGRg4fNqQryb5oUz+nbtnFjPoe5JRp5LBzURWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfZCv11otY2WZGL3mwmjUoUGkTxjtP1DIkOAQ63f0OGxMaMOwYZmE4ErjaUtIsa+iK6nFl/PSViHsF8LzYPVox74s8Bv48JdPwhULiuRnLbS6bCBeE85E5Z5fqeqhLus5p93N1rq4B4QvD+f6nODpqdN6JtC5e1hcl2A6gCaHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmfKJzAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B7C43390;
	Wed, 20 Mar 2024 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963083;
	bh=DtY8CRGRg4fNqQryb5oUz+nbtnFjPoe5JRp5LBzURWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmfKJzAUmVTSrCVhRpOqNd24zxCTMO02s7yAwmC5Dl4J8A2eV/VOSFV/+37w0BhqY
	 Lz6+y9N/jCcDr28DuvpJL6drBUMSsC/Fxr5lSGblscQ4lMENlSdjdZzMRyvYRSREGG
	 F6aKhFLVsgy6+qgVVdHw9Pn3B8OetTNTcYc+17aCZaQ/6nVzMHvPEdSRQM/dZpfJhN
	 VDjL2thf1G0y+/strfHlzjzM5xuYVPtzHOiIrlfijTurVOkBFqCwp7SzqdoqjtjSdM
	 WVtcTCaQ/jUoC2ZZPxfLAOub0/sjECWE22Jtb2/EpDO9buIFAZU0P+tnz3eTpRznEe
	 fkJqxvHfOrpIw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/5] perf beauty: Introduce scrape script for various fs syscalls 'flags' arguments
Date: Wed, 20 Mar 2024 16:31:11 -0300
Message-ID: <20240320193115.811899-2-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320193115.811899-1-acme@kernel.org>
References: <20240320193115.811899-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was using the first variation on producing a string representation
for a binary flag, one that used the system's fcntl.h and preprocessor
tricks that had to be updated everytime a new flag was introduced.

Use the more recent scrape script + strarray + strarray__scnprintf_flags() combo.

  $ tools/perf/trace/beauty/fs_at_flags.sh
  static const char *fs_at_flags[] = {
  	[ilog2(0x100) + 1] = "SYMLINK_NOFOLLOW",
  	[ilog2(0x200) + 1] = "REMOVEDIR",
  	[ilog2(0x400) + 1] = "SYMLINK_FOLLOW",
  	[ilog2(0x800) + 1] = "NO_AUTOMOUNT",
  	[ilog2(0x1000) + 1] = "EMPTY_PATH",
  	[ilog2(0x0000) + 1] = "STATX_SYNC_AS_STAT",
  	[ilog2(0x2000) + 1] = "STATX_FORCE_SYNC",
  	[ilog2(0x4000) + 1] = "STATX_DONT_SYNC",
  	[ilog2(0x8000) + 1] = "RECURSIVE",
  	[ilog2(0x80000000) + 1] = "GETATTR_NOSEC",
  };
  $

Now we need a copy of uapi/linux/fcntl.h from tools/include/ in the
scrape only directory tools/perf/trace/beauty/include and will use that
fs_at_flags array for other fs syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                      |   7 +
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/trace/beauty/Build                 |   1 +
 tools/perf/trace/beauty/beauty.h              |   4 +-
 tools/perf/trace/beauty/fs_at_flags.c         |  26 ++++
 tools/perf/trace/beauty/fs_at_flags.sh        |  21 +++
 .../trace/beauty/include/uapi/linux/fcntl.h   | 123 ++++++++++++++++++
 tools/perf/trace/beauty/statx.c               |  31 -----
 9 files changed, 182 insertions(+), 34 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fs_at_flags.c
 create mode 100755 tools/perf/trace/beauty/fs_at_flags.sh
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/fcntl.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ccd2dcbc64f720d2..73d5603450b0a547 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -489,6 +489,12 @@ beauty_ioctl_outdir := $(beauty_outdir)/ioctl
 # Create output directory if not already present
 $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
 
+fs_at_flags_array := $(beauty_outdir)/fs_at_flags_array.c
+fs_at_flags_tbl := $(srctree)/tools/perf/trace/beauty/fs_at_flags.sh
+
+$(fs_at_flags_array): $(beauty_uapi_linux_dir)/fcntl.h $(fs_at_flags_tbl)
+	$(Q)$(SHELL) '$(fs_at_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
 clone_flags_array := $(beauty_outdir)/clone_flags_array.c
 clone_flags_tbl := $(srctree)/tools/perf/trace/beauty/clone.sh
 
@@ -772,6 +778,7 @@ build-dir   = $(or $(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
 	arm64-sysreg-defs \
+	$(fs_at_flags_array) \
 	$(clone_flags_array) \
 	$(drm_ioctl_array) \
 	$(fadvise_advice_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8fb032caeaf53288..8417387aafa8295d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1144,7 +1144,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "stat", .alias = "newstat", },
 	{ .name	    = "statx",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	 /* fdat */ },
-		   [2] = { .scnprintf = SCA_STATX_FLAGS, /* flags */ } ,
+		   [2] = { .scnprintf = SCA_FS_AT_FLAGS, /* flags */ } ,
 		   [3] = { .scnprintf = SCA_STATX_MASK,	 /* mask */ }, }, },
 	{ .name	    = "swapoff",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 413c9b747216020f..d23a84fdf3efef78 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -89,6 +89,7 @@ BEAUTY_FILES=(
   "arch/x86/include/asm/irq_vectors.h"
   "arch/x86/include/uapi/asm/prctl.h"
   "include/linux/socket.h"
+  "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
   "include/uapi/linux/prctl.h"
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index d11ce256f5114034..d8ce1b6989832134 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,6 +1,7 @@
 perf-y += clone.o
 perf-y += fcntl.o
 perf-y += flock.o
+perf-y += fs_at_flags.o
 perf-y += fsmount.o
 perf-y += fspick.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 9feb794f5c6e15f4..c94ae8701bc65a2f 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -234,8 +234,8 @@ size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct sysc
 size_t syscall_arg__scnprintf_socket_level(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_SK_LEVEL syscall_arg__scnprintf_socket_level
 
-size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
-#define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
+size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FS_AT_FLAGS syscall_arg__scnprintf_fs_at_flags
 
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
new file mode 100644
index 0000000000000000..2a099953d9935782
--- /dev/null
+++ b/tools/perf/trace/beauty/fs_at_flags.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/fs_at_flags.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <sys/types.h>
+#include <linux/log2.h>
+
+#include "trace/beauty/generated/fs_at_flags_array.c"
+static DEFINE_STRARRAY(fs_at_flags, "AT_");
+
+static size_t fs_at__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+	return strarray__scnprintf_flags(&strarray__fs_at_flags, bf, size, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	bool show_prefix = arg->show_string_prefix;
+	int flags = arg->val;
+
+	return fs_at__scnprintf_flags(flags, bf, size, show_prefix);
+}
diff --git a/tools/perf/trace/beauty/fs_at_flags.sh b/tools/perf/trace/beauty/fs_at_flags.sh
new file mode 100755
index 0000000000000000..456f59addf741062
--- /dev/null
+++ b/tools/perf/trace/beauty/fs_at_flags.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
+else
+	beauty_uapi_linux_dir=$1
+fi
+
+linux_fcntl=${beauty_uapi_linux_dir}/fcntl.h
+
+printf "static const char *fs_at_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+AT_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+# AT_EACCESS is only meaningful to faccessat, so we will special case it there...
+# AT_STATX_SYNC_TYPE is not a bit, its a mask of AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC and AT_STATX_DONT_SYNC
+grep -E $regex ${linux_fcntl} | \
+	grep -v AT_EACCESS | \
+	grep -v AT_STATX_SYNC_TYPE | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
new file mode 100644
index 0000000000000000..282e90aeb163c028
--- /dev/null
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_FCNTL_H
+#define _UAPI_LINUX_FCNTL_H
+
+#include <asm/fcntl.h>
+#include <linux/openat2.h>
+
+#define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
+#define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
+
+/*
+ * Cancel a blocking posix lock; internal use only until we expose an
+ * asynchronous lock api to userspace:
+ */
+#define F_CANCELLK	(F_LINUX_SPECIFIC_BASE + 5)
+
+/* Create a file descriptor with FD_CLOEXEC set. */
+#define F_DUPFD_CLOEXEC	(F_LINUX_SPECIFIC_BASE + 6)
+
+/*
+ * Request nofications on a directory.
+ * See below for events that may be notified.
+ */
+#define F_NOTIFY	(F_LINUX_SPECIFIC_BASE+2)
+
+/*
+ * Set and get of pipe page size array
+ */
+#define F_SETPIPE_SZ	(F_LINUX_SPECIFIC_BASE + 7)
+#define F_GETPIPE_SZ	(F_LINUX_SPECIFIC_BASE + 8)
+
+/*
+ * Set/Get seals
+ */
+#define F_ADD_SEALS	(F_LINUX_SPECIFIC_BASE + 9)
+#define F_GET_SEALS	(F_LINUX_SPECIFIC_BASE + 10)
+
+/*
+ * Types of seals
+ */
+#define F_SEAL_SEAL	0x0001	/* prevent further seals from being set */
+#define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
+#define F_SEAL_GROW	0x0004	/* prevent file from growing */
+#define F_SEAL_WRITE	0x0008	/* prevent writes */
+#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
+/* (1U << 31) is reserved for signed error codes */
+
+/*
+ * Set/Get write life time hints. {GET,SET}_RW_HINT operate on the
+ * underlying inode, while {GET,SET}_FILE_RW_HINT operate only on
+ * the specific file.
+ */
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
+#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
+
+/*
+ * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
+ * used to clear any hints previously set.
+ */
+#define RWH_WRITE_LIFE_NOT_SET	0
+#define RWH_WRITE_LIFE_NONE	1
+#define RWH_WRITE_LIFE_SHORT	2
+#define RWH_WRITE_LIFE_MEDIUM	3
+#define RWH_WRITE_LIFE_LONG	4
+#define RWH_WRITE_LIFE_EXTREME	5
+
+/*
+ * The originally introduced spelling is remained from the first
+ * versions of the patch set that introduced the feature, see commit
+ * v4.13-rc1~212^2~51.
+ */
+#define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
+
+/*
+ * Types of directory notifications that may be requested.
+ */
+#define DN_ACCESS	0x00000001	/* File accessed */
+#define DN_MODIFY	0x00000002	/* File modified */
+#define DN_CREATE	0x00000004	/* File created */
+#define DN_DELETE	0x00000008	/* File removed */
+#define DN_RENAME	0x00000010	/* File renamed */
+#define DN_ATTRIB	0x00000020	/* File changed attibutes */
+#define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
+
+/*
+ * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
+ * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
+ * unlinkat.  The two functions do completely different things and therefore,
+ * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
+ * faccessat would be undefined behavior and thus treating it equivalent to
+ * AT_EACCESS is valid undefined behavior.
+ */
+#define AT_FDCWD		-100    /* Special value used to indicate
+                                           openat should use the current
+                                           working directory. */
+#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+#define AT_EACCESS		0x200	/* Test access permitted for
+                                           effective IDs, not real IDs.  */
+#define AT_REMOVEDIR		0x200   /* Remove directory instead of
+                                           unlinking file.  */
+#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
+#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
+#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
+
+#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
+#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
+#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
+#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
+
+#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+
+/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
+#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
+					compare object identity and may not
+					be usable to open_by_handle_at(2) */
+#if defined(__KERNEL__)
+#define AT_GETATTR_NOSEC	0x80000000
+#endif
+
+#endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index 1f7e34ed4e02be86..4e0059fd02118f9c 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -8,7 +8,6 @@
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
 #include <sys/types.h>
-#include <linux/fcntl.h>
 #include <linux/stat.h>
 
 #ifndef STATX_MNT_ID
@@ -21,36 +20,6 @@
 #define STATX_MNT_ID_UNIQUE	0x00004000U
 #endif
 
-size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg)
-{
-	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "AT_";
-	int printed = 0, flags = arg->val;
-
-	if (flags == 0)
-		return scnprintf(bf, size, "%s%s", show_prefix ? "AT_STATX_" : "", "SYNC_AS_STAT");
-#define	P_FLAG(n) \
-	if (flags & AT_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
-		flags &= ~AT_##n; \
-	}
-
-	P_FLAG(SYMLINK_NOFOLLOW);
-	P_FLAG(REMOVEDIR);
-	P_FLAG(SYMLINK_FOLLOW);
-	P_FLAG(NO_AUTOMOUNT);
-	P_FLAG(EMPTY_PATH);
-	P_FLAG(STATX_FORCE_SYNC);
-	P_FLAG(STATX_DONT_SYNC);
-
-#undef P_FLAG
-
-	if (flags)
-		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
-
-	return printed;
-}
-
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-- 
2.44.0


