Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A714812864
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjLNGos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjLNGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:44:42 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4577111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e03f0ede64so53422807b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702536287; x=1703141087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi0n1hV1ncb/RNwMZFnyh9hgwMGCToBH7DtU0L8OSxs=;
        b=Fpi9gaNfboAVvku+rZdlb6aNhnJC1QklaxRwMgYroM8zyOeRa4oVbquxJ9+D9Jd75Y
         5zkH9BQSc1Pa7nJvouWG15HZZ0bPzIfYvNQLlgppVgDr1wNqpk8JhFjN7NwD3oD7qrjq
         JTTqXpR1LYvTXl3HzychB1GMrxm7g5FosJtfWM1Y8v68G/u5a6VcMqVQ9tV3CHNm/R0/
         /SNgBosZt/tKLbF7T9Jg+ACMiP1gUM0vVttUzkvyY2WjuzBcY5Rj/SgVbgPOVG1nySli
         Z85whCyXr3Spp+eASR8pzL97psnN2ssvEv7iOnnjOrN8lGTzJzoidKHJOHd2ndAQUGCi
         46zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536287; x=1703141087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi0n1hV1ncb/RNwMZFnyh9hgwMGCToBH7DtU0L8OSxs=;
        b=un+ZOa3RdMjYG5rNwU8RI12r5PG9taGIljwS9eJKL+tqvX1a9AGJN7o+3ELhhpK/NV
         jCzHnQaO0T6+iQekm0SvvPqUQ5sIoTVQXenW55Ce9MW+3n5+sIKCFopsRKAtnLUmKfJX
         bpgwgp04xLw/vYpONx7bi1/I17hK/Y8wQGUZ1iZl+/nabSsn8A4a6AufayGY8WDegRGV
         VfUK8h6hcdiJg1OY3b6/orndEBBWcOfPMa8Opn2hvt6Y4IvoTkPiRfw8aISnvuL16EUJ
         bmh3JtmZsAWpu+dfcc3CHd1N/IQxaL0LOw9sBuw1cbijaDX1EufqVsYdiudGyZ7ZYKjy
         bH7A==
X-Gm-Message-State: AOJu0Yztt1f/MZseOOH9rntdruNUZjBZ/zfP3Zy+mtNBa7hS9mv5sq0n
        0LwwtisYqTzjEWetuK/XWS0Zv9OwVXY=
X-Google-Smtp-Source: AGHT+IFIcGL80lHU9a3QBXcN8ajJPDrjxhCqjsogxxgpG76jxiYcwGLHlmLh1XM+txh5BQ5FFFg6RJjTlQM=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:e986:a7c7:2814:c9a8])
 (user=avagin job=sendgmr) by 2002:a05:6902:343:b0:db5:f536:17d4 with SMTP id
 e3-20020a056902034300b00db5f53617d4mr76906ybs.11.1702536287106; Wed, 13 Dec
 2023 22:44:47 -0800 (PST)
Date:   Wed, 13 Dec 2023 22:44:39 -0800
In-Reply-To: <20231214064439.1023011-1-avagin@google.com>
Mime-Version: 1.0
References: <20231214064439.1023011-1-avagin@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214064439.1023011-2-avagin@google.com>
Subject: [PATCH 2/2] selftests/overlayfs: verify device and inode numbers in /proc/pid/maps
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..e19ab0e85709
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
+		if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llu",
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

