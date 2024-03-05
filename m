Return-Path: <linux-kernel+bounces-91721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F38715AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549ACB23239
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A477E567;
	Tue,  5 Mar 2024 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="KBNU+FN9"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60017B3CA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618936; cv=none; b=VS/7Q66g9yK/ph4E7hMV64vyDJ70PxJLiwtuzCSzDGg3S4ou0FWWu5wMf+kPvc8rVwuuSkqMitLizmJuRTya8Wg0IN0roFhpdfUAJE3z9YnHWsb91UvpcKssH5hXtR6xFF6nqVzUbc37FlKPXNmFib3sJIdX1KOAuv33RcZjYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618936; c=relaxed/simple;
	bh=TRqOC8Vk0vbbiZ0MlxLenaXd116F99mVCwhGyj/rLiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfImN5KQK+oA5NAygG2xaYXcmGHWf1g6dgT4lcVMrFdb2DKzqObkulZZ5nrPt8Yd2qq2a2T5RfGM7yUzJZ+lWz7lR6CjLP+mcyO3vuDfrMZKDERinPDKUB/vks+pfanHus16UbrU/EdH13+l5rdeMSJfBg/DzjgyC4L4U6uqH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=KBNU+FN9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcafff3c50so44928595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1709618934; x=1710223734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv8kG9m16/eb8RbFxYy706uGwjYMM+2HEkRfZeEGPKE=;
        b=KBNU+FN932xmy7i8s5p5mWfkUYIMZ/OzgIHF6cR4Qle97SiDkuCmt8yG+HjXqNx/g3
         j0yos5sP2oeWaUAf6dc5HM38rHM27WDpJ454APFGvzi/d9+5EceFXPEnlAyWr8m8DqYI
         EQznuQAYF/YfzqpzjznAdhMOxZpj9lRHv6N7di4YFmluq5M2L+opduEAMnmOBM4OoidY
         iIqme499nMqG3TH65rNhR5u28lDJai7IL1Ca7n3tBSxcpsaESuMPDdlqwDX5HR49+96F
         dVEATUVBqrN/muBTfmnL3p+6o+H3XyvpaPyfmxELDDmR88AVoApeEHWcKMaBezBLpmB3
         q+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709618934; x=1710223734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv8kG9m16/eb8RbFxYy706uGwjYMM+2HEkRfZeEGPKE=;
        b=hKcVWz9AVbuNUpXxpeobdp+8ogazF4/igfzVlLz3tldPyO953PJ2n5AI05mVrxu4Cq
         JEaXwsPeumLy4UG94aCfbvMe3CeuedgDmLiz6RkUPQjqEW6NST89Pic2u/4wm71mcB5o
         LI3S/uwz9Kgdktc4x9pF7dtwSwN4iV9m+dmkXkeWS7919iI5Zbx4HPBkwF7GYw252a4a
         exwwebgzEVcPK37+vssf4XQ28rJcX8JNpkMPrjs6Vd3ZM5WsoAYfvid+mVmnleiHzTUk
         lRoxgBazIfVqUFxPG4ijVQcsAuXBRJELWm0VfSIKCYyH75e8koDvhT2liJMFi9bC5jUc
         5+4w==
X-Forwarded-Encrypted: i=1; AJvYcCXhiSQPkwzvE5UgBB7dUvdXzveKTI4TSaHPotVtioA+y3ibgsDgVMtyaCjF1bWEWiSZqJbPyedqRHYKaCU+DzBJ7Q2SqcZqY8OvA8U2
X-Gm-Message-State: AOJu0Yx+/f4IrZp175F7NmlY0qzdGG0TOraCFjG6mJk2hEdqw5w5+Kvy
	6D4P4Rf2WduJMYarNtdpVO3UHnx95pur9eK7VJoysy8Z26mchFn9Cy9mQ0bfkA==
X-Google-Smtp-Source: AGHT+IGlgK4Rtn4cvuBC98qhH71KisMG0IPfh/WW29bpbvkAf1QLkp1hxti+KhU0vBULp/PtBI5DcQ==
X-Received: by 2002:a17:902:7207:b0:1dd:2e6:b951 with SMTP id ba7-20020a170902720700b001dd02e6b951mr1199829plb.12.1709618933858;
        Mon, 04 Mar 2024 22:08:53 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001d7057c2fbasm9601708plg.100.2024.03.04.22.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 22:08:53 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	linux-kernel@vger.kernel.org,
	Ian Rodgers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/perf_events: Test FASYNC with watermark wakeups.
Date: Mon,  4 Mar 2024 22:08:43 -0800
Message-Id: <20240305060844.9499-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305060844.9499-1-khuey@kylehuey.com>
References: <20240305060844.9499-1-khuey@kylehuey.com>
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


