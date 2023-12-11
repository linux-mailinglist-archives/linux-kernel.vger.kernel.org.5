Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C480DAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjLKTay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:30:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE23C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:30:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5df5d595287so15038507b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702323054; x=1702927854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SN2AMMflKSHYDUJpSUv+zVSo3moMo5WS+hI11zyslyY=;
        b=kraNx8MNGD4dohv+a6mGHzY36NileyWpm4NBXrVvHWCHkF30MSwKt/TcEchsh8kuIQ
         QywqId/xj94MT0taRwmWu1PZeeBqAWMUBR0RQy87N0ugamn3M6vIV3sgghojqQbCQ4Ot
         hrjw/kLXbLIp4OseMGhm8g3Nsdchlm+x6wZrOgBRkwD6JCqP7j0TX2k+zwvXS7qrZyYA
         Tt8PYp7RhzpWuShrKzk8COGNhGlQ/Amz84nTBD5lBUkKPH9KwtIgNOCZ5WfJNtn2WduO
         TfvGyL3BqGJ9MMwoUm7GstxCZOpSkFyAC34QNQmyL870MNEvL+evIws6Y54VhQn12hFM
         kVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323054; x=1702927854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN2AMMflKSHYDUJpSUv+zVSo3moMo5WS+hI11zyslyY=;
        b=vcTsfmm3+kqMuEu8bgikeXaom+x9e71oCUFmpz16BXh2Vi17LSyI+FMYDQUxd2y0Af
         G5CAxoP3cuWEfclcuUwe9rX6rI6sCloMl3dhwjvnBiUVcMhwMJ6B7V2t7JeMkZwitRVc
         T+y+P2Swycbhi/w142AigPLRXl7sSaUeHAe+NBpMmioJTV8ahhyatj17e8lolkoqLyag
         dBtNFNmZfjY7rYygPwAcvli6dS5Th+45sge5eoKgGKt2BGnTn4qYFs8lcMTww4cMbLAi
         TIjDQg1qbr/4Yx4lIhVQBO5idydABhHsjUbSp4G8x+ILKeVJ8NTWRtZpU6GdHnyuvf4q
         jNgQ==
X-Gm-Message-State: AOJu0Yx5jsfMLMUUmukAvaleN2g8qumsGZhMu2Y2YH57imepb47QQ9we
        Mdppn0lSD2uemHsEpL+rJjlDR1/bLUM=
X-Google-Smtp-Source: AGHT+IHyQCLI5pFjoBBbtYR/KWAHTsVjMRkb5uv8rPKP3Jo7zIXsk5mFsA5w6hVMg+R4+UHy1RdobI4TBFY=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:dc8d:a8c5:498f:a21c])
 (user=avagin job=sendgmr) by 2002:a81:af19:0:b0:5e1:a451:99bf with SMTP id
 n25-20020a81af19000000b005e1a45199bfmr9607ywh.1.1702323053733; Mon, 11 Dec
 2023 11:30:53 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:30:48 -0800
In-Reply-To: <20231211193048.580691-1-avagin@google.com>
Mime-Version: 1.0
References: <20231211193048.580691-1-avagin@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211193048.580691-2-avagin@google.com>
Subject: [PATCH 2/2] selftests/overlayfs: verify device and inode numbers in /proc/pid/maps
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mapping a file on overlayfs, the file stored in ->vm_file is a
backing file whose f_inode is on the underlying filesystem. We need to
verify that /proc/pid/maps contains numbers of the overlayfs file, but
not its backing file.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../filesystems/overlayfs/.gitignore          |   2 +
 .../selftests/filesystems/overlayfs/Makefile  |   7 +
 .../filesystems/overlayfs/dev_in_maps.c       | 182 ++++++++++++++++++
 .../selftests/filesystems/overlayfs/log.h     |  26 +++
 5 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/log.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..0939a40abb28 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -26,6 +26,7 @@ TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
+TARGETS += filesystems/overlayfs
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/tools/testing/selftests/filesystems/overlayfs/.gitignore
new file mode 100644
index 000000000000..52ae618fdd98
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dev_in_maps
diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
new file mode 100644
index 000000000000..56b2b48a765b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := dev_in_maps
+
+CFLAGS := -Wall -Werror
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
new file mode 100644
index 000000000000..08497c2e10a3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <inttypes.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <linux/unistd.h>
+#include <linux/types.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sched.h>
+#include <fcntl.h>
+
+#include "../../kselftest.h"
+#include "log.h"
+
+static int sys_fsopen(const char *fsname, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static int sys_fsconfig(int fd, unsigned int cmd, const char *key, const char *value, int aux)
+{
+	return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
+}
+
+static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_flags)
+{
+	return syscall(__NR_fsmount, fd, flags, attr_flags);
+}
+
+static int sys_move_mount(int from_dfd, const char *from_pathname,
+			  int to_dfd, const char *to_pathname,
+			  unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
+}
+
+static long get_file_dev_and_inode(void *addr, struct statx *stx)
+{
+	char buf[4096];
+	FILE *mapf;
+
+	mapf = fopen("/proc/self/maps", "r");
+	if (mapf == NULL)
+		return pr_perror("fopen(/proc/self/maps)");
+
+	while (fgets(buf, sizeof(buf), mapf)) {
+		unsigned long start, end;
+		uint32_t maj, min;
+		__u64 ino;
+
+		if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llx",
+				&start, &end, &maj, &min, &ino) != 5)
+			return pr_perror("unable to parse: %s", buf);
+		if (start == (unsigned long)addr) {
+			stx->stx_dev_major = maj;
+			stx->stx_dev_minor = min;
+			stx->stx_ino = ino;
+			return 0;
+		}
+	}
+
+	return pr_err("unable to find the mapping");
+}
+
+static int ovl_mount(void)
+{
+	int tmpfs, fsfd, ovl;
+
+	fsfd = sys_fsopen("tmpfs", 0);
+	if (fsfd == -1)
+		return pr_perror("fsopen(tmpfs)");
+
+	if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == -1)
+		return pr_perror("FSCONFIG_CMD_CREATE");
+
+	tmpfs = sys_fsmount(fsfd, 0, 0);
+	if (tmpfs == -1)
+		return pr_perror("fsmount");
+
+	close(fsfd);
+
+	/* overlayfs can't be constructed on top of a detached mount. */
+	if (sys_move_mount(tmpfs, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH))
+		return pr_perror("move_mount");
+	close(tmpfs);
+
+	if (mkdir("/tmp/w", 0755) == -1 ||
+	    mkdir("/tmp/u", 0755) == -1 ||
+	    mkdir("/tmp/l", 0755) == -1)
+		return pr_perror("mkdir");
+
+	fsfd = sys_fsopen("overlay", 0);
+	if (fsfd == -1)
+		return pr_perror("fsopen(overlay)");
+	if (sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0) == -1 ||
+	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir", "/tmp/l", 0) == -1 ||
+	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "upperdir", "/tmp/u", 0) == -1 ||
+	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "workdir", "/tmp/w", 0) == -1)
+		return pr_perror("fsconfig");
+	if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == -1)
+		return pr_perror("fsconfig");
+	ovl = sys_fsmount(fsfd, 0, 0);
+	if (ovl == -1)
+		return pr_perror("fsmount");
+
+	return ovl;
+}
+
+/*
+ * Check that the file device and inode shown in /proc/pid/maps match values
+ * returned by stat(2).
+ */
+static int test(void)
+{
+	struct statx stx, mstx;
+	int ovl, fd;
+	void *addr;
+
+	ovl = ovl_mount();
+	if (ovl == -1)
+		return -1;
+
+	fd = openat(ovl, "test", O_RDWR | O_CREAT, 0644);
+	if (fd == -1)
+		return pr_perror("openat");
+
+	addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED)
+		return pr_perror("mmap");
+
+	if (get_file_dev_and_inode(addr, &mstx))
+		return -1;
+	if (statx(fd, "", AT_EMPTY_PATH | AT_STATX_SYNC_AS_STAT, STATX_INO, &stx))
+		return pr_perror("statx");
+
+	if (stx.stx_dev_major != mstx.stx_dev_major ||
+	    stx.stx_dev_minor != mstx.stx_dev_minor ||
+	    stx.stx_ino != mstx.stx_ino)
+		return pr_fail("unmatched dev:ino %x:%x:%llx (expected %x:%x:%llx)\n",
+			mstx.stx_dev_major, mstx.stx_dev_minor, mstx.stx_ino,
+			stx.stx_dev_major, stx.stx_dev_minor, stx.stx_ino);
+
+	ksft_test_result_pass("devices are matched\n");
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int fsfd;
+
+	fsfd = sys_fsopen("overlay", 0);
+	if (fsfd == -1) {
+		ksft_test_result_skip("unable to create overlay mount\n");
+		return 1;
+	}
+	close(fsfd);
+
+	/* Create a new mount namespace to not care about cleaning test mounts. */
+	if (unshare(CLONE_NEWNS) == -1) {
+		ksft_test_result_skip("unable to create a new mount namespace\n");
+		return 1;
+	}
+
+	if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
+		pr_perror("mount");
+		return 1;
+	}
+
+	ksft_set_plan(1);
+
+	if (test())
+		return 1;
+
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/filesystems/overlayfs/log.h b/tools/testing/selftests/filesystems/overlayfs/log.h
new file mode 100644
index 000000000000..db64df2a8483
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/log.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_TIMENS_LOG_H__
+#define __SELFTEST_TIMENS_LOG_H__
+
+#define pr_msg(fmt, lvl, ...)						\
+	ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",			\
+			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+#endif
-- 
2.43.0.472.g3155946c3a-goog

