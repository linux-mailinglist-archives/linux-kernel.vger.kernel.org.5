Return-Path: <linux-kernel+bounces-104915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311287D5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72271C2301C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB654F8B;
	Fri, 15 Mar 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGSz8o9c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1854BFF;
	Fri, 15 Mar 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535734; cv=none; b=ASQUwV53FTIP6mCvYAOzq9q5K/+sol8CiF0ulx8/IK8vCRuGZaRiXv4b4V3maXsDzoQVjCuT4/nPkegHOrd1omhP/nMcYNCMDzsjsxITWIIrbxDIAz08dDTNIpENwOWBc5Uuev/ai2VXbUBdFVQyr3T6Y80/BDRGFQGYT9uwwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535734; c=relaxed/simple;
	bh=ywcmlIelcYDX8Zz223DTjUanNzh/GUTtjP+Ou34oa7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt0u38TJC34+22Ohx+BZ7yyRVCzFRa3Br0rLex2Zlr/G2PxrVfoDT6CJzrgZK/+oNf3uuo/JXX6stLgkG7bHFpeVKNHKcX8zAlp2S3JW2nzfyvWs4TwuY6hOH4/VIw3Pn2i2/QAOaOSB8YILhAM5fl+FCQicOjXS7R8xu+IHeVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGSz8o9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A2DC43399;
	Fri, 15 Mar 2024 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535734;
	bh=ywcmlIelcYDX8Zz223DTjUanNzh/GUTtjP+Ou34oa7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGSz8o9c3tTgaYOu4+ZmF55MGBhMVY3nqZVek2i8IadoYcHUpW88GP+MW1xoe/T3w
	 BnEHeEruZT8Jvy2LiNFuDDBMvAaTLqfkJFm5tTLbYTaKj9cBOJActwhQ7tXe5kOEd0
	 gKoYHj6i2GTJTV8aiguGt0nI8zuNcMJwoE5+8yg74y6rAABZ3BshFZGcU5a/KKOUt7
	 DxCWpRK7Q/q7bxkr+O7MAOaMx8UVTcYW11E8T3lO6MtWyCu4EoazF1+/26ctFlZ2UI
	 z6AcnYdI1j9Aw+/lNNZkE2HniEkbJ0A3fUoRkCqJ/2Etf0CxBjaPEylHU1RU4HxUNT
	 C8rvDKGpYSEXQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/5] tools headers: Remove almost unused copy of uapi/stat.h, add few conditional defines
Date: Fri, 15 Mar 2024 17:48:35 -0300
Message-ID: <20240315204835.748716-6-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315204835.748716-1-acme@kernel.org>
References: <20240315204835.748716-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These were used to build perf to provide defines not available in older
distros, but this was back in 2017, nowadays most the distros that are
supported and I have build containers for work using just the system
headers, so ditch them.

For the few that don't have STATX_MNT_ID{_UNIQUE}, or STATX_MNT_DIOALIGN
add them conditionally.

Some of these older distros may not have things that are used in 'perf
trace', but then they also don't have libtraceevent packages, so don't
build 'perf trace'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/stat.h | 195 --------------------------------
 tools/perf/check-headers.sh     |   1 -
 tools/perf/trace/beauty/statx.c |  12 +-
 3 files changed, 11 insertions(+), 197 deletions(-)
 delete mode 100644 tools/include/uapi/linux/stat.h

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
deleted file mode 100644
index 2f2ee82d55175d05..0000000000000000
--- a/tools/include/uapi/linux/stat.h
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_STAT_H
-#define _UAPI_LINUX_STAT_H
-
-#include <linux/types.h>
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#define S_IFMT  00170000
-#define S_IFSOCK 0140000
-#define S_IFLNK	 0120000
-#define S_IFREG  0100000
-#define S_IFBLK  0060000
-#define S_IFDIR  0040000
-#define S_IFCHR  0020000
-#define S_IFIFO  0010000
-#define S_ISUID  0004000
-#define S_ISGID  0002000
-#define S_ISVTX  0001000
-
-#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
-#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
-#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
-#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
-#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
-#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
-#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
-
-#define S_IRWXU 00700
-#define S_IRUSR 00400
-#define S_IWUSR 00200
-#define S_IXUSR 00100
-
-#define S_IRWXG 00070
-#define S_IRGRP 00040
-#define S_IWGRP 00020
-#define S_IXGRP 00010
-
-#define S_IRWXO 00007
-#define S_IROTH 00004
-#define S_IWOTH 00002
-#define S_IXOTH 00001
-
-#endif
-
-/*
- * Timestamp structure for the timestamps in struct statx.
- *
- * tv_sec holds the number of seconds before (negative) or after (positive)
- * 00:00:00 1st January 1970 UTC.
- *
- * tv_nsec holds a number of nanoseconds (0..999,999,999) after the tv_sec time.
- *
- * __reserved is held in case we need a yet finer resolution.
- */
-struct statx_timestamp {
-	__s64	tv_sec;
-	__u32	tv_nsec;
-	__s32	__reserved;
-};
-
-/*
- * Structures for the extended file attribute retrieval system call
- * (statx()).
- *
- * The caller passes a mask of what they're specifically interested in as a
- * parameter to statx().  What statx() actually got will be indicated in
- * st_mask upon return.
- *
- * For each bit in the mask argument:
- *
- * - if the datum is not supported:
- *
- *   - the bit will be cleared, and
- *
- *   - the datum will be set to an appropriate fabricated value if one is
- *     available (eg. CIFS can take a default uid and gid), otherwise
- *
- *   - the field will be cleared;
- *
- * - otherwise, if explicitly requested:
- *
- *   - the datum will be synchronised to the server if AT_STATX_FORCE_SYNC is
- *     set or if the datum is considered out of date, and
- *
- *   - the field will be filled in and the bit will be set;
- *
- * - otherwise, if not requested, but available in approximate form without any
- *   effort, it will be filled in anyway, and the bit will be set upon return
- *   (it might not be up to date, however, and no attempt will be made to
- *   synchronise the internal state first);
- *
- * - otherwise the field and the bit will be cleared before returning.
- *
- * Items in STATX_BASIC_STATS may be marked unavailable on return, but they
- * will have values installed for compatibility purposes so that stat() and
- * co. can be emulated in userspace.
- */
-struct statx {
-	/* 0x00 */
-	__u32	stx_mask;	/* What results were written [uncond] */
-	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
-	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
-	/* 0x10 */
-	__u32	stx_nlink;	/* Number of hard links */
-	__u32	stx_uid;	/* User ID of owner */
-	__u32	stx_gid;	/* Group ID of owner */
-	__u16	stx_mode;	/* File mode */
-	__u16	__spare0[1];
-	/* 0x20 */
-	__u64	stx_ino;	/* Inode number */
-	__u64	stx_size;	/* File size */
-	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
-	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
-	/* 0x40 */
-	struct statx_timestamp	stx_atime;	/* Last access time */
-	struct statx_timestamp	stx_btime;	/* File creation time */
-	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
-	struct statx_timestamp	stx_mtime;	/* Last data modification time */
-	/* 0x80 */
-	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
-	__u32	stx_rdev_minor;
-	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
-	__u32	stx_dev_minor;
-	/* 0x90 */
-	__u64	stx_mnt_id;
-	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
-	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
-	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
-	/* 0x100 */
-};
-
-/*
- * Flags to be stx_mask
- *
- * Query request/result mask for statx() and struct statx::stx_mask.
- *
- * These bits should be set in the mask argument of statx() to request
- * particular items when calling statx().
- */
-#define STATX_TYPE		0x00000001U	/* Want/got stx_mode & S_IFMT */
-#define STATX_MODE		0x00000002U	/* Want/got stx_mode & ~S_IFMT */
-#define STATX_NLINK		0x00000004U	/* Want/got stx_nlink */
-#define STATX_UID		0x00000008U	/* Want/got stx_uid */
-#define STATX_GID		0x00000010U	/* Want/got stx_gid */
-#define STATX_ATIME		0x00000020U	/* Want/got stx_atime */
-#define STATX_MTIME		0x00000040U	/* Want/got stx_mtime */
-#define STATX_CTIME		0x00000080U	/* Want/got stx_ctime */
-#define STATX_INO		0x00000100U	/* Want/got stx_ino */
-#define STATX_SIZE		0x00000200U	/* Want/got stx_size */
-#define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
-#define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
-#define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
-#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
-#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
-
-#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
-
-#ifndef __KERNEL__
-/*
- * This is deprecated, and shall remain the same value in the future.  To avoid
- * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
- * instead.
- */
-#define STATX_ALL		0x00000fffU
-#endif
-
-/*
- * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
- *
- * These give information about the features or the state of a file that might
- * be of use to ordinary userspace programs such as GUIs or ls rather than
- * specialised tools.
- *
- * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
- * semantically.  Where possible, the numerical value is picked to correspond
- * also.  Note that the DAX attribute indicates that the file is in the CPU
- * direct access state.  It does not correspond to the per-inode flag that
- * some filesystems support.
- *
- */
-#define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
-#define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
-#define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
-#define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
-#define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
-#define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
-#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
-#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
-#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
-
-
-#endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 4ea674df11f8afd5..859cd6f35b0ac9b1 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -17,7 +17,6 @@ FILES=(
   "include/uapi/linux/perf_event.h"
   "include/uapi/linux/sched.h"
   "include/uapi/linux/seccomp.h"
-  "include/uapi/linux/stat.h"
   "include/uapi/linux/vhost.h"
   "include/linux/bits.h"
   "include/vdso/bits.h"
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index d1ccc93316bd9ac6..1f7e34ed4e02be86 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -9,7 +9,17 @@
 #include <linux/kernel.h>
 #include <sys/types.h>
 #include <linux/fcntl.h>
-#include <uapi/linux/stat.h>
+#include <linux/stat.h>
+
+#ifndef STATX_MNT_ID
+#define STATX_MNT_ID		0x00001000U
+#endif
+#ifndef STATX_DIOALIGN
+#define STATX_DIOALIGN		0x00002000U
+#endif
+#ifndef STATX_MNT_ID_UNIQUE
+#define STATX_MNT_ID_UNIQUE	0x00004000U
+#endif
 
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
-- 
2.43.2


