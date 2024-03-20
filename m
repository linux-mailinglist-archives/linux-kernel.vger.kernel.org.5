Return-Path: <linux-kernel+bounces-109346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47F8817E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A0D1C22D08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB098594A;
	Wed, 20 Mar 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAGCUQzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AA85643;
	Wed, 20 Mar 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963085; cv=none; b=EhwbUKVvkMOylBjClzwCQlW9U1TF7m+hKi1CaVI16slp2+DMg3GsPRHqV4iJdLGlIW1r2VGr4bwO8rT5QqcN1Xo2Gxk8E2lxuzLQBD2ZWnoTYF33FABVCE5NAsJKbx99PWgcs8y/PuiFpl/rC/Y2EgLL8D8b5gHO2dkLvrKdUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963085; c=relaxed/simple;
	bh=iXBI8axSfSxPB883iJMXJriHVLTLFGmqnye7926e4pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bz4H+2h8QybhPRz5UjsmZpXlMtFVeRAu76mWZpFYL/3WjdwmlrTFmbOpprBhP/F+gtJgqLWazhSdDdn/LexmoO2j9ee3BWyJtsl1Q5KidLq5E03lymIBrd8/eTs8b+TUgHkkH2NG9CW7SdCiOAZOjqY8F17Oaq14rr/Akj6QXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAGCUQzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C853DC433F1;
	Wed, 20 Mar 2024 19:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963085;
	bh=iXBI8axSfSxPB883iJMXJriHVLTLFGmqnye7926e4pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAGCUQzBooEtImPsjB4MtPo2n99Qi03BIZOM6KneFO7U0sVFssCPKLnmnRiJPTzDU
	 FU8fSA1URCVg7o1aSlgByCJLxJzg6tmIyHREVY7pReDsTVpdN5LgU5P1lEeiw0b3TB
	 7EvKQW/qUN2TiXxST8ROYp9+wjPUEknCj5hEhmlym5XB/08RwJ9OIKAuAXpOCuLSEr
	 LH8ixs08VWkQPsCSQm2KJCoZOC5Ivlpy2mOUZ6T9OpxwMSWQ8PqulCh/IYmLQvjlpA
	 HKymTSu67goTN9YHFBXKUzcJvewBGAB/usMqeWoX9THuKrFLNCQLYrz/1HAppwHGgk
	 SdeILDIzHKnzA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument
Date: Wed, 20 Mar 2024 16:31:12 -0300
Message-ID: <20240320193115.811899-3-acme@kernel.org>
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
for a binary flag, one that used the system's stat.h and preprocessor
tricks that had to be updated everytime a new flag was introduced.

Use the more recent scrape script + strarray +
strarray__scnprintf_flags() combo.

  $ tools/perf/trace/beauty/statx_mask.sh
  static const char *statx_mask[] = {
  	[ilog2(0x00000001) + 1] = "TYPE",
  	[ilog2(0x00000002) + 1] = "MODE",
  	[ilog2(0x00000004) + 1] = "NLINK",
  	[ilog2(0x00000008) + 1] = "UID",
  	[ilog2(0x00000010) + 1] = "GID",
  	[ilog2(0x00000020) + 1] = "ATIME",
  	[ilog2(0x00000040) + 1] = "MTIME",
  	[ilog2(0x00000080) + 1] = "CTIME",
  	[ilog2(0x00000100) + 1] = "INO",
  	[ilog2(0x00000200) + 1] = "SIZE",
  	[ilog2(0x00000400) + 1] = "BLOCKS",
  	[ilog2(0x00000800) + 1] = "BTIME",
  	[ilog2(0x00001000) + 1] = "MNT_ID",
  	[ilog2(0x00002000) + 1] = "DIOALIGN",
  	[ilog2(0x00004000) + 1] = "MNT_ID_UNIQUE",
  };
  $

Now we need a copy of uapi/linux/stat.h from tools/include/ in the
scrape only directory tools/perf/trace/beauty/include.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                      |   7 +
 tools/perf/check-headers.sh                   |   1 +
 .../trace/beauty/include/uapi/linux/stat.h    | 195 ++++++++++++++++++
 tools/perf/trace/beauty/statx.c               |  50 +----
 tools/perf/trace/beauty/statx_mask.sh         |  23 +++
 5 files changed, 235 insertions(+), 41 deletions(-)
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/stat.h
 create mode 100755 tools/perf/trace/beauty/statx_mask.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 73d5603450b0a547..0d2dbdfc44df3019 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -673,6 +673,12 @@ arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 $(arch_errno_name_array): $(arch_errno_tbl)
 	$(Q)$(SHELL) '$(arch_errno_tbl)' '$(patsubst -%,,$(CC))' $(arch_errno_hdr_dir) > $@
 
+statx_mask_array := $(beauty_outdir)/statx_mask_array.c
+statx_mask_tbl := $(srctree)/tools/perf/trace/beauty/statx_mask.sh
+
+$(statx_mask_array): $(beauty_uapi_linux_dir)/stat.h $(statx_mask_tbl)
+	$(Q)$(SHELL) '$(statx_mask_tbl)' $(beauty_uapi_linux_dir) > $@
+
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
 
@@ -807,6 +813,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array) \
+	$(statx_mask_array) \
 	$(sync_file_range_arrays) \
 	$(LIBAPI) \
 	$(LIBPERF) \
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index d23a84fdf3efef78..76726a5a7c789273 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -94,6 +94,7 @@ BEAUTY_FILES=(
   "include/uapi/linux/mount.h"
   "include/uapi/linux/prctl.h"
   "include/uapi/linux/sched.h"
+  "include/uapi/linux/stat.h"
   "include/uapi/linux/usbdevice_fs.h"
   "include/uapi/sound/asound.h"
 )
diff --git a/tools/perf/trace/beauty/include/uapi/linux/stat.h b/tools/perf/trace/beauty/include/uapi/linux/stat.h
new file mode 100644
index 0000000000000000..2f2ee82d55175d05
--- /dev/null
+++ b/tools/perf/trace/beauty/include/uapi/linux/stat.h
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_STAT_H
+#define _UAPI_LINUX_STAT_H
+
+#include <linux/types.h>
+
+#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+
+#define S_IFMT  00170000
+#define S_IFSOCK 0140000
+#define S_IFLNK	 0120000
+#define S_IFREG  0100000
+#define S_IFBLK  0060000
+#define S_IFDIR  0040000
+#define S_IFCHR  0020000
+#define S_IFIFO  0010000
+#define S_ISUID  0004000
+#define S_ISGID  0002000
+#define S_ISVTX  0001000
+
+#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
+#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
+#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
+#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
+#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
+#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
+#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
+
+#define S_IRWXU 00700
+#define S_IRUSR 00400
+#define S_IWUSR 00200
+#define S_IXUSR 00100
+
+#define S_IRWXG 00070
+#define S_IRGRP 00040
+#define S_IWGRP 00020
+#define S_IXGRP 00010
+
+#define S_IRWXO 00007
+#define S_IROTH 00004
+#define S_IWOTH 00002
+#define S_IXOTH 00001
+
+#endif
+
+/*
+ * Timestamp structure for the timestamps in struct statx.
+ *
+ * tv_sec holds the number of seconds before (negative) or after (positive)
+ * 00:00:00 1st January 1970 UTC.
+ *
+ * tv_nsec holds a number of nanoseconds (0..999,999,999) after the tv_sec time.
+ *
+ * __reserved is held in case we need a yet finer resolution.
+ */
+struct statx_timestamp {
+	__s64	tv_sec;
+	__u32	tv_nsec;
+	__s32	__reserved;
+};
+
+/*
+ * Structures for the extended file attribute retrieval system call
+ * (statx()).
+ *
+ * The caller passes a mask of what they're specifically interested in as a
+ * parameter to statx().  What statx() actually got will be indicated in
+ * st_mask upon return.
+ *
+ * For each bit in the mask argument:
+ *
+ * - if the datum is not supported:
+ *
+ *   - the bit will be cleared, and
+ *
+ *   - the datum will be set to an appropriate fabricated value if one is
+ *     available (eg. CIFS can take a default uid and gid), otherwise
+ *
+ *   - the field will be cleared;
+ *
+ * - otherwise, if explicitly requested:
+ *
+ *   - the datum will be synchronised to the server if AT_STATX_FORCE_SYNC is
+ *     set or if the datum is considered out of date, and
+ *
+ *   - the field will be filled in and the bit will be set;
+ *
+ * - otherwise, if not requested, but available in approximate form without any
+ *   effort, it will be filled in anyway, and the bit will be set upon return
+ *   (it might not be up to date, however, and no attempt will be made to
+ *   synchronise the internal state first);
+ *
+ * - otherwise the field and the bit will be cleared before returning.
+ *
+ * Items in STATX_BASIC_STATS may be marked unavailable on return, but they
+ * will have values installed for compatibility purposes so that stat() and
+ * co. can be emulated in userspace.
+ */
+struct statx {
+	/* 0x00 */
+	__u32	stx_mask;	/* What results were written [uncond] */
+	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
+	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* 0x10 */
+	__u32	stx_nlink;	/* Number of hard links */
+	__u32	stx_uid;	/* User ID of owner */
+	__u32	stx_gid;	/* Group ID of owner */
+	__u16	stx_mode;	/* File mode */
+	__u16	__spare0[1];
+	/* 0x20 */
+	__u64	stx_ino;	/* Inode number */
+	__u64	stx_size;	/* File size */
+	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
+	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* 0x40 */
+	struct statx_timestamp	stx_atime;	/* Last access time */
+	struct statx_timestamp	stx_btime;	/* File creation time */
+	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
+	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* 0x80 */
+	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_minor;
+	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+	__u32	stx_dev_minor;
+	/* 0x90 */
+	__u64	stx_mnt_id;
+	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	/* 0xa0 */
+	__u64	__spare3[12];	/* Spare space for future expansion */
+	/* 0x100 */
+};
+
+/*
+ * Flags to be stx_mask
+ *
+ * Query request/result mask for statx() and struct statx::stx_mask.
+ *
+ * These bits should be set in the mask argument of statx() to request
+ * particular items when calling statx().
+ */
+#define STATX_TYPE		0x00000001U	/* Want/got stx_mode & S_IFMT */
+#define STATX_MODE		0x00000002U	/* Want/got stx_mode & ~S_IFMT */
+#define STATX_NLINK		0x00000004U	/* Want/got stx_nlink */
+#define STATX_UID		0x00000008U	/* Want/got stx_uid */
+#define STATX_GID		0x00000010U	/* Want/got stx_gid */
+#define STATX_ATIME		0x00000020U	/* Want/got stx_atime */
+#define STATX_MTIME		0x00000040U	/* Want/got stx_mtime */
+#define STATX_CTIME		0x00000080U	/* Want/got stx_ctime */
+#define STATX_INO		0x00000100U	/* Want/got stx_ino */
+#define STATX_SIZE		0x00000200U	/* Want/got stx_size */
+#define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
+#define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
+#define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+
+#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
+
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
+/*
+ * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
+ *
+ * These give information about the features or the state of a file that might
+ * be of use to ordinary userspace programs such as GUIs or ls rather than
+ * specialised tools.
+ *
+ * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
+ * semantically.  Where possible, the numerical value is picked to correspond
+ * also.  Note that the DAX attribute indicates that the file is in the CPU
+ * direct access state.  It does not correspond to the per-inode flag that
+ * some filesystems support.
+ *
+ */
+#define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
+#define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
+#define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
+#define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
+#define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
+#define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
+#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
+#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+
+
+#endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index 4e0059fd02118f9c..24843e614b935f3a 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -6,52 +6,20 @@
  */
 
 #include "trace/beauty/beauty.h"
-#include <linux/kernel.h>
 #include <sys/types.h>
-#include <linux/stat.h>
+#include <linux/log2.h>
 
-#ifndef STATX_MNT_ID
-#define STATX_MNT_ID		0x00001000U
-#endif
-#ifndef STATX_DIOALIGN
-#define STATX_DIOALIGN		0x00002000U
-#endif
-#ifndef STATX_MNT_ID_UNIQUE
-#define STATX_MNT_ID_UNIQUE	0x00004000U
-#endif
+static size_t statx__scnprintf_mask(unsigned long mask, char *bf, size_t size, bool show_prefix)
+{
+	#include "trace/beauty/generated/statx_mask_array.c"
+	static DEFINE_STRARRAY(statx_mask, "STATX_");
+	return strarray__scnprintf_flags(&strarray__statx_mask, bf, size, show_prefix, mask);
+}
 
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "STATX_";
-	int printed = 0, flags = arg->val;
-
-#define	P_FLAG(n) \
-	if (flags & STATX_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
-		flags &= ~STATX_##n; \
-	}
-
-	P_FLAG(TYPE);
-	P_FLAG(MODE);
-	P_FLAG(NLINK);
-	P_FLAG(UID);
-	P_FLAG(GID);
-	P_FLAG(ATIME);
-	P_FLAG(MTIME);
-	P_FLAG(CTIME);
-	P_FLAG(INO);
-	P_FLAG(SIZE);
-	P_FLAG(BLOCKS);
-	P_FLAG(BTIME);
-	P_FLAG(MNT_ID);
-	P_FLAG(DIOALIGN);
-	P_FLAG(MNT_ID_UNIQUE);
-
-#undef P_FLAG
-
-	if (flags)
-		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
+	int mask = arg->val;
 
-	return printed;
+	return statx__scnprintf_mask(mask, bf, size, show_prefix);
 }
diff --git a/tools/perf/trace/beauty/statx_mask.sh b/tools/perf/trace/beauty/statx_mask.sh
new file mode 100755
index 0000000000000000..18c802ed0c71578f
--- /dev/null
+++ b/tools/perf/trace/beauty/statx_mask.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
+else
+	beauty_uapi_linux_dir=$1
+fi
+
+linux_stat=${beauty_uapi_linux_dir}/stat.h
+
+printf "static const char *statx_mask[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+STATX_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+# STATX_BASIC_STATS its a bitmask formed by the mask in the normal stat struct
+# STATX_ALL is another bitmask and deprecated
+# STATX_ATTR_*: Attributes to be found in stx_attributes and masked in stx_attributes_mask
+grep -E $regex ${linux_stat} | \
+	grep -v STATX_ALL | \
+	grep -v STATX_BASIC_STATS | \
+	grep -v '\<STATX_ATTR_' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.44.0


