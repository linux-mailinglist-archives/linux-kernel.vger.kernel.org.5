Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC40A7AEE35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjIZNi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:38:57 -0400
X-Greylist: delayed 87 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 06:38:49 PDT
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C6F3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:38:49 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 26 Sep 2023 13:37:14 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 1/1] tools/nolibc: Add workarounds for centos-7
Date:   Tue, 26 Sep 2023 15:36:47 +0200
Message-Id: <20230926133647.467179-2-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
References: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centos-7 doesn't include statx on its linux/stat.h file. So, let's just
define it if the include doesn't define STATX_BASIC_STATS.

This makes nolibc work on centos-7 just fine, before this patch it
failed with:

	nolibc/sys.h:987:78: warning: ‘struct statx’ declared inside parameter list [enabled by default]
	 int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)

Please note that while on types.h we can still include linux/stat.h
and it won't cause any issues, it seems simpler if we just always
include "statx.h" instead of that file and be safe. That is why I
changed types.h too.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 tools/include/nolibc/statx.h | 218 +++++++++++++++++++++++++++++++++++
 tools/include/nolibc/sys.h   |   2 +-
 tools/include/nolibc/types.h |   2 +-
 3 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/nolibc/statx.h

diff --git tools/include/nolibc/statx.h tools/include/nolibc/statx.h
new file mode 100644
index 000000000000..d05528754154
--- /dev/null
+++ tools/include/nolibc/statx.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Compatibility header to allow using statx() on old distros.
+ * Copyright (C) 2023 Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>
+ */
+
+#ifndef _NOLIBC_STATX_H
+#define _NOLIBC_STATX_H
+
+/* We should always include this file instead of linux/stat.h, so nolibc works
+ * in old distros too.
+ *
+ * The problem is centos-7, that doesn't have statx() defined in linux/stat.h.
+ * We can't include sys/stat.h because it creates conflicts, so let's just
+ * define it here.
+ * No other distros seem affected by this, so we can remove this file when it
+ * hits EOL (06/2024).
+ */
+#include <linux/stat.h>  /* for statx() */
+
+#ifndef STATX_BASIC_STATS
+
+/* This is just a c&p from tools/include/uapi/linux/stat.h as it is in
+ * Linux 6.6-rc3.
+ * We don't need it all, but it's easier to just copy it all in case in the
+ * future we start using more of it, as we won't have CI running on centos-7.
+ */
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
+#endif // STATX_BASIC_STATS
+
+#endif // _NOLIBC_STATX_H
diff --git tools/include/nolibc/sys.h tools/include/nolibc/sys.h
index fdb6bd6c0e2f..d3e45793682a 100644
--- tools/include/nolibc/sys.h
+++ tools/include/nolibc/sys.h
@@ -20,9 +20,9 @@
 #include <linux/time.h>
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
-#include <linux/stat.h>  /* for statx() */
 #include <linux/prctl.h>
 
+#include "statx.h"       /* for statx() */
 #include "arch.h"
 #include "errno.h"
 #include "types.h"
diff --git tools/include/nolibc/types.h tools/include/nolibc/types.h
index 8cfc4c860fa4..ccef87e9044c 100644
--- tools/include/nolibc/types.h
+++ tools/include/nolibc/types.h
@@ -10,9 +10,9 @@
 #include "std.h"
 #include <linux/mman.h>
 #include <linux/reboot.h> /* for LINUX_REBOOT_* */
-#include <linux/stat.h>
 #include <linux/time.h>
 
+#include "statx.h"
 
 /* Only the generic macros and types may be defined here. The arch-specific
  * ones such as the O_RDONLY and related macros used by fcntl() and open()
-- 
2.40.1

