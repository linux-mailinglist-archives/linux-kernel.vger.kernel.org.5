Return-Path: <linux-kernel+bounces-76857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F885FDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2C11F26EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265F150988;
	Thu, 22 Feb 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="r7GgaSkz"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC214F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618180; cv=none; b=YBhr1BEDSZTORsY2rOm0NjS0VFgBlSPK4Eu4Z/VpBBH6cnVwtXjQk8hbGDJRRp+nbfgFYdH4VoRacCCN0tekZAJ43byvW7LEURKNq5/2sRHHCFCptKWdfvQWWDVS1OEFH/nTC0IvHg1oAtK7LWFEcjsaCqPaoZwVN1MpDtOQJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618180; c=relaxed/simple;
	bh=LlrMgz48LDI+YMP2FNELcvlVdRB5L4XoxBzEdaHcEuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUO3JoWHgsUZmPNdbsuecUQqkScipQxWdyFGSE+pxC/UPvMa3e1eONDLOS5/ZPQGlnoNcizH4d6WmaIZJJCugu3DX5OgNVfEpYHkgkOk5s0+9UHaTEpibnrhHyqF3QFxNpitvmqr6ae5J5M0zE8mvaC4YMKQ8NxDAk4g7mlxvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=r7GgaSkz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A3EA940FDB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708618175;
	bh=BI5FcmQTFFPXfMYvca+sidINehPeDaY7JnQmjl0Up0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=r7GgaSkz5RulKicH5lM41hFUWpjEWYXZoCzz8nAsHSYBorjQu3tlKl/sc2TJpYJ/K
	 XCYZDaImCGcRPPP847U5gAOLs8F65B6Jg2jujo2nqQlMUsTAUtZpgzwqSvwi6kEZVq
	 LqLPpYbCdm633zzd5N5tRGKXRGalCV/kZyz7Oe81vfoOeNOyONczqrpjbcNSLWx4RL
	 mdDQYoR+Zr/b8uqqXIBYYoIQJ391ELlLxeBWEWKahDJkYbIwggviR8kJAkgwwF9Xre
	 y124VEzEj/jtcdv83bz4P7B7c6cDJhcKUu9u32wW4c2MUiFT6+Y0f5YmcvVGczMCpE
	 1fF9grxM3Q/AQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-559555e38b0so1973821a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618175; x=1709222975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI5FcmQTFFPXfMYvca+sidINehPeDaY7JnQmjl0Up0k=;
        b=VWppBZgqzrYJFIzTw1BY+Y6h7FSOQMDM0Zu5w+g2i7qakdhr38UKujvkm+QURZkGW3
         y3/5tQz4X+gbGy6yZzdHR1nZvsoOHzfo0xBupTlSANx/J+FkzCqnMowJlLluEPJwrYOn
         lQMZs8v3CwpDDgeTQngO65pNhECCkUXX6m9JkcfKucP2JcPSjBrnzDQPfun9WWW/NCpU
         rGu2keDhCBonCObbs8wq1yv9Vey4wiResKr8QF5bVBDcM42HgXis4P298cGxddzZvfj2
         SINkhFdrMxtJ2lNFDxFpK6tTdPRnJBZYmfs4n7T9BqjUSUmFNkgEyW8//vvbPolbIbsk
         +R+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0X2uSzZFE9u/VXhxlWQzm4i5Op2t9T6tMcs8/YkB/bKMX+9L340herPY53XP18+uHmwpNvbNbtKFR0gyuWV3+9qXaVfSUszTuqjfz
X-Gm-Message-State: AOJu0Yxk4QkMyhTkXbSfcg98lCI5S71LbBe/4g0UnXj9m864l7wCPu2Z
	z2fjK80rc7GEY55JobQ0cIbIoKHUqpz4KD8xT7ZNv9FgVJGrmn1f6LjnsRBBq6cGwS6hkJyXgqS
	ggMq5bMm70T+wGoTMBW0ThXsSnuD/pfmiJ6gJGyCZVUQ1oUZ0bdrF4pBlNqG7vnd3G8AEnnB7fK
	HOKw==
X-Received: by 2002:aa7:d148:0:b0:563:c54e:f7 with SMTP id r8-20020aa7d148000000b00563c54e00f7mr14116711edo.17.1708618174979;
        Thu, 22 Feb 2024 08:09:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDe6pCjXOiwPVyUnH22k67Ne16V2DJCJtIzKneFKYNJaVmcfNIRLHxr9eeFJBMt5mz9C3+gw==
X-Received: by 2002:aa7:d148:0:b0:563:c54e:f7 with SMTP id r8-20020aa7d148000000b00563c54e00f7mr14116694edo.17.1708618174617;
        Thu, 22 Feb 2024 08:09:34 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id er25-20020a056402449900b00563f8233ba8sm5675001edb.7.2024.02.22.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:09:33 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: stgraber@stgraber.org,
	tycho@tycho.pizza,
	cyphar@cyphar.com,
	linux-kernel@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Date: Thu, 22 Feb 2024 17:09:15 +0100
Message-Id: <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <christian.brauner@ubuntu.com>

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 .../selftests/pid_namespace/.gitignore        |   1 +
 .../testing/selftests/pid_namespace/Makefile  |   2 +-
 .../testing/selftests/pid_namespace/pid_max.c | 358 ++++++++++++++++++
 3 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/pid_namespace/pid_max.c

diff --git a/tools/testing/selftests/pid_namespace/.gitignore b/tools/testing/selftests/pid_namespace/.gitignore
index 93ab9d7e5b7e..5118f0f3edf4 100644
--- a/tools/testing/selftests/pid_namespace/.gitignore
+++ b/tools/testing/selftests/pid_namespace/.gitignore
@@ -1 +1,2 @@
+pid_max
 regression_enomem
diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
index 9286a1d22cd3..b972f55d07ae 100644
--- a/tools/testing/selftests/pid_namespace/Makefile
+++ b/tools/testing/selftests/pid_namespace/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS = regression_enomem
+TEST_GEN_PROGS = regression_enomem pid_max
 
 LOCAL_HDRS += $(selfdir)/pidfd/pidfd.h
 
diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
new file mode 100644
index 000000000000..51c414faabb0
--- /dev/null
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -0,0 +1,358 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+
+#include "../kselftest_harness.h"
+#include "../pidfd/pidfd.h"
+
+#define __STACK_SIZE (8 * 1024 * 1024)
+static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	char *stack;
+	pid_t ret;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	ret = __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg);
+#else
+	ret = clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg);
+#endif
+	free(stack);
+	return ret;
+}
+
+static int pid_max_cb(void *data)
+{
+	int fd, ret;
+	pid_t pid;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return -1;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return -1;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return -1;
+	}
+
+	ret = write(fd, "500", sizeof("500") - 1);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return -1;
+	}
+
+	for (int i = 0; i < 501; i++) {
+		pid = fork();
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+		wait_for_pid(pid);
+		if (pid > 500) {
+			fprintf(stderr, "Managed to create pid number beyond limit\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int pid_max_nested_inner(void *data)
+{
+	int fret = -1;
+	pid_t pids[2];
+	int fd, i, ret;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return fret;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return fret;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return fret;
+	}
+
+	ret = write(fd, "500", sizeof("500") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return fret;
+	}
+
+	pids[0] = fork();
+	if (pids[0] < 0) {
+		fprintf(stderr, "Failed to create first new process\n");
+		return fret;
+	}
+
+	if (pids[0] == 0)
+		exit(EXIT_SUCCESS);
+
+	pids[1] = fork();
+	wait_for_pid(pids[0]);
+	if (pids[1] >= 0) {
+		if (pids[1] == 0)
+			exit(EXIT_SUCCESS);
+		wait_for_pid(pids[1]);
+
+		fprintf(stderr, "Managed to create process even though ancestor pid namespace had a limit\n");
+		return fret;
+	}
+
+	/* Now make sure that we wrap pids at 400. */
+	for (i = 0; i < 510; i++) {
+		pid_t pid;
+
+		pid = fork();
+		if (pid < 0)
+			return fret;
+
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+
+		wait_for_pid(pid);
+		if (pid >= 500) {
+			fprintf(stderr, "Managed to create process with pid %d beyond configured limit\n", pid);
+			return fret;
+		}
+	}
+
+	return 0;
+}
+
+static int pid_max_nested_outer(void *data)
+{
+	int fret = -1, nr_procs = 400;
+	pid_t pids[1000];
+	int fd, i, ret;
+	pid_t pid;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return fret;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return fret;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return fret;
+	}
+
+	ret = write(fd, "400", sizeof("400") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return fret;
+	}
+
+	/*
+	 * Create 397 processes. This leaves room for do_clone() (398) and
+	 * one more 399. So creating another process needs to fail.
+	 */
+	for (nr_procs = 0; nr_procs < 396; nr_procs++) {
+		pid = fork();
+		if (pid < 0)
+			goto reap;
+
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+
+		pids[nr_procs] = pid;
+	}
+
+	pid = do_clone(pid_max_nested_inner, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (pid < 0) {
+		fprintf(stderr, "%m - Failed to clone nested pidns\n");
+		goto reap;
+	}
+
+	if (wait_for_pid(pid)) {
+		fprintf(stderr, "%m - Nested pid_max failed\n");
+		goto reap;
+	}
+
+	fret = 0;
+
+reap:
+	for (int i = 0; i < nr_procs; i++)
+		wait_for_pid(pids[i]);
+
+	return fret;
+}
+
+static int pid_max_nested_limit_inner(void *data)
+{
+	int fret = -1, nr_procs = 400;
+	int fd, ret;
+	pid_t pid;
+	pid_t pids[1000];
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return fret;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return fret;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return fret;
+	}
+
+	ret = write(fd, "500", sizeof("500") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return fret;
+	}
+
+	for (nr_procs = 0; nr_procs < 500; nr_procs++) {
+		pid = fork();
+		if (pid < 0)
+			break;
+
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+
+		pids[nr_procs] = pid;
+	}
+
+	if (nr_procs >= 400) {
+		fprintf(stderr, "Managed to create processes beyond the configured outer limit\n");
+		goto reap;
+	}
+
+	fret = 0;
+
+reap:
+	for (int i = 0; i < nr_procs; i++)
+		wait_for_pid(pids[i]);
+
+	return fret;
+}
+
+static int pid_max_nested_limit_outer(void *data)
+{
+	int fd, ret;
+	pid_t pid;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return -1;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return -1;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return -1;
+	}
+
+	ret = write(fd, "400", sizeof("400") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return -1;
+	}
+
+	pid = do_clone(pid_max_nested_limit_inner, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (pid < 0) {
+		fprintf(stderr, "%m - Failed to clone nested pidns\n");
+		return -1;
+	}
+
+	if (wait_for_pid(pid)) {
+		fprintf(stderr, "%m - Nested pid_max failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+TEST(pid_max_simple)
+{
+	pid_t pid;
+
+
+	pid = do_clone(pid_max_cb, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(0, wait_for_pid(pid));
+}
+
+TEST(pid_max_nested_limit)
+{
+	pid_t pid;
+
+	pid = do_clone(pid_max_nested_limit_outer, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(0, wait_for_pid(pid));
+}
+
+TEST(pid_max_nested)
+{
+	pid_t pid;
+
+	pid = do_clone(pid_max_nested_outer, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(0, wait_for_pid(pid));
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


