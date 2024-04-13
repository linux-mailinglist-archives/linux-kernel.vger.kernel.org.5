Return-Path: <linux-kernel+bounces-143749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A88A3CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E460B215AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95358446B2;
	Sat, 13 Apr 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="L9R+QSm4"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56090482D3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017853; cv=none; b=HV5C9nY1APHogmn0+avvgyNq+RvCCb1kZFKq1ZvDO6SO6/DBM9zA9Rc31Cy+qvG58pwjP+lTH9Jy9Nz4aj6m3yOss8zJY/ij+FgLrp5yO2bqOBIts3ZFp1MCmnmojYQPQVWa752tNv2+ntkNFBjH95a4aJGWWzPwf8IdGt/9gbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017853; c=relaxed/simple;
	bh=TRqOC8Vk0vbbiZ0MlxLenaXd116F99mVCwhGyj/rLiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLj0x/D/Ccm8p9BmH7N9EdKML8BUnqKuSBqOJI156L8JxMThY5VrENDFNeNaBpfdouBpPnRhdkET8XfU29FMnqWer5oYz71/XzIDpyut6/ompcUR6lQqCgpRQ0OULCrc2eZO1FQo4iHaXxxqqCmvcs0JqGBfxMeH7D8L0aZNPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=L9R+QSm4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso1917038276.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1713017850; x=1713622650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv8kG9m16/eb8RbFxYy706uGwjYMM+2HEkRfZeEGPKE=;
        b=L9R+QSm4s3DftkUfwzT5+StmzJ62j9crCegKBf4LWnzwKykchpyyMGEWHeugx/9EMa
         d3SalJgsDhXSqo0AgMLQu0pBjeusffCIRMvxHVLIGwk9KDAY+Mf8nWfwqhJdUNlNeTkM
         wk+EXjnARRE+ErSrPABxqRq6eKPXK1JR54a7tNfRxPVmRWPVpl63hAMai6KFEWsm4zDz
         oHE1ep8oJ4tyjhPesvFI2bsrwlIzsmNIOU1Z1LFC+n696CVjAAegZHuE9haXV4uq9LSu
         dkgxiOifRNOsgJN8GFesvcmKm3mPEDJ1ZsB4s6tqshtozhGyrovutpHKXPQn57kKkXiN
         5eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713017850; x=1713622650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv8kG9m16/eb8RbFxYy706uGwjYMM+2HEkRfZeEGPKE=;
        b=KMXlzxksq/6ocvc8g1/A88oInmL/oyabOltm9Oz6NBSeiBLNThA7NASkzI8Z3rS03i
         r269suflsw0MRETp+ZKukEFLjaeB26QDixPxh7mG9KFjiwg9oarxGSS8vz7lD1QwFHz/
         6HX57p5C4JHLKw26hFHC/kLmoejaeVPRZUZYm2+JcTGWJ25CwnTs8xdqEJ3jc+nHowQi
         uGycV34WinIpvqJrq8B+6SLFY8O7/9kFXhYCyD/wZt3h9sweE6UOKVQsNmotvW6vi+dY
         YfO5kKC/EGrsw5DCWs/+cTcM3y2+AirEuooXqlyl8mK/baQFZkycq9pEL/ExQcGHCP+a
         ImKA==
X-Forwarded-Encrypted: i=1; AJvYcCVobiWoy6KqzX9en2ZcT5IHAv8hCMLEAyLvc8H5K4iR34+95LV0jRdeD/b5aw/1Op1EELN5yQaojTcJQYBxbYVWANs3igBiOc5EsIb4
X-Gm-Message-State: AOJu0YyjVJ/8we5b+l5bSyXc4PbkYW/43whW5bjne3hIbWqPoEiGWV2D
	hbe+5/iRtchokW6llNKQzohAkKXd+bWEq5d0SngSjwvt0KMTX48qjBteTnba4Q==
X-Google-Smtp-Source: AGHT+IHdWfmUP29OS2Mnz/ZajV0Y8zieEb03Y4pOFphhcucJKssu82pq8Zz29O1npwOpQtXUYBkM/A==
X-Received: by 2002:a25:9392:0:b0:dcb:38d3:3c6a with SMTP id a18-20020a259392000000b00dcb38d33c6amr5447050ybm.46.1713017850353;
        Sat, 13 Apr 2024 07:17:30 -0700 (PDT)
Received: from ip-172-31-11-157.us-east-2.compute.internal (ec2-3-145-99-109.us-east-2.compute.amazonaws.com. [3.145.99.109])
        by smtp.googlemail.com with ESMTPSA id v5-20020a254805000000b00dcdb6934617sm1193349yba.62.2024.04.13.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 07:17:30 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rodgers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/3] selftests/perf_events: Test FASYNC with watermark wakeups
Date: Sat, 13 Apr 2024 07:16:20 -0700
Message-Id: <20240413141618.4160-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413141618.4160-1-khuey@kylehuey.com>
References: <20240413141618.4160-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test uses PERF_RECORD_SWITCH records to fill the ring buffer and
trigger the watermark wakeup, which in turn should trigger an IO
signal.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 .../testing/selftests/perf_events/.gitignore  |   1 +
 tools/testing/selftests/perf_events/Makefile  |   2 +-
 .../selftests/perf_events/watermark_signal.c  | 146 ++++++++++++++++++
 3 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/perf_events/watermark_signal.c

diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
index 790c47001e77..ee93dc4969b8 100644
--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 sigtrap_threads
 remove_on_exec
+watermark_signal
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index db93c4ff081a..70e3ff211278 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads remove_on_exec
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
new file mode 100644
index 000000000000..49dc1e831174
--- /dev/null
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/perf_event.h>
+#include <stddef.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define __maybe_unused __attribute__((__unused__))
+
+static int sigio_count;
+
+static void handle_sigio(int signum __maybe_unused,
+			 siginfo_t *oh __maybe_unused,
+			 void *uc __maybe_unused)
+{
+	++sigio_count;
+}
+
+static void do_child(void)
+{
+	raise(SIGSTOP);
+
+	for (int i = 0; i < 20; ++i)
+		sleep(1);
+
+	raise(SIGSTOP);
+
+	exit(0);
+}
+
+TEST(watermark_signal)
+{
+	struct perf_event_attr attr;
+	struct perf_event_mmap_page *p = NULL;
+	struct sigaction previous_sigio, sigio = { 0 };
+	pid_t child = -1;
+	int child_status;
+	int fd = -1;
+	long page_size = sysconf(_SC_PAGE_SIZE);
+
+	sigio.sa_sigaction = handle_sigio;
+	EXPECT_EQ(sigaction(SIGIO, &sigio, &previous_sigio), 0);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_DUMMY;
+	attr.sample_period = 1;
+	attr.disabled = 1;
+	attr.watermark = 1;
+	attr.context_switch = 1;
+	attr.wakeup_watermark = 1;
+
+	child = fork();
+	EXPECT_GE(child, 0);
+	if (child == 0)
+		do_child();
+	else if (child < 0) {
+		perror("fork()");
+		goto cleanup;
+	}
+
+	if (waitpid(child, &child_status, WSTOPPED) != child ||
+	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
+		fprintf(stderr,
+			"failed to sycnhronize with child errno=%d status=%x\n",
+			errno,
+			child_status);
+		goto cleanup;
+	}
+
+	fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
+		     PERF_FLAG_FD_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "failed opening event %llx\n", attr.config);
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETFL, FASYNC)) {
+		perror("F_SETFL FASYNC");
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETOWN, getpid())) {
+		perror("F_SETOWN getpid()");
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETSIG, SIGIO)) {
+		perror("F_SETSIG SIGIO");
+		goto cleanup;
+	}
+
+	p = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (p == NULL) {
+		perror("mmap");
+		goto cleanup;
+	}
+
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
+		perror("PERF_EVENT_IOC_ENABLE");
+		goto cleanup;
+	}
+
+	if (kill(child, SIGCONT) < 0) {
+		perror("SIGCONT");
+		goto cleanup;
+	}
+
+	if (waitpid(child, &child_status, WSTOPPED) != -1 || errno != EINTR)
+		fprintf(stderr,
+			"expected SIGIO to terminate wait errno=%d status=%x\n%d",
+			errno,
+			child_status,
+			sigio_count);
+
+	EXPECT_GE(sigio_count, 1);
+
+cleanup:
+	if (p != NULL)
+		munmap(p, 2 * page_size);
+
+	if (fd >= 0)
+		close(fd);
+
+	if (child > 0) {
+		kill(child, SIGKILL);
+		waitpid(child, NULL, 0);
+	}
+
+	sigaction(SIGIO, &previous_sigio, NULL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


