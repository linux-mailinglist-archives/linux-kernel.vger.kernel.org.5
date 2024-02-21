Return-Path: <linux-kernel+bounces-75229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC785E4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ACA1C23A15
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F184FDC;
	Wed, 21 Feb 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="bhT4zPJ1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F384052
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537936; cv=none; b=VIKD0hP9jvh0Bgt6aXXRITkkIDsqEER+8yZ7tGk5QAE51njUCxa7Engly8TxCNQ4F783z6To6mE34/bAug78O15FMYWnuNRYClymmclqTi/YhfWRHRiMlnnJk638ULmrNDWQrny1iCCpkisjCo3yK8kTDkfbqUrWlDos1JjTd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537936; c=relaxed/simple;
	bh=tZ7ZR1nkA/EFD6K9KNCEcHnkRImuMCfdTQ5YwENITDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrDhAkr6gBi6UUm6iVk7wQU+3zuf+VHEdBNQD14ryp8cWl86VmReNf3sCNp5NN6wtSa7ClUSh5yt/6Xc4oFj/sPWjeVgEuDzZdbV8My7eT3Bc/GfbQ0URMQ1+ziMoCjwX8sZ+lvKQmw1ZemZb2gfbU+o6qWzFTwvjNv3nEdOQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=bhT4zPJ1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d932f6ccfaso58227545ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1708537934; x=1709142734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+DfUwTrji+JiliVaosYGzYtaY7yoOzYOgDQgUlYBFM=;
        b=bhT4zPJ1KFUJzAlSHukomfjbC+A4tFZLm0WucBPFXI8g90T5L5ygrojSJFuKyIoqqn
         6Z7AiYfFfnSgkqAnBEZf+NM4S/VJQFoF4kYGhEXXI2/vDSK+97OEjc1bJTGgS8d4m5C3
         LMeMTQxLhRLS6wmfU1PHtu5ssuiZK79ry82hMRaAVUeZd2txLiIIfTpBJJCd/zbYa0bz
         JF03aUHrCe4RvT1gYpKB04Juj1WKE9dGXW1Wo3QwhWIJysbOwuV8hVWcEkEmNtLuWTE2
         m/09lswBxDRTCX8EMWs8wm5olDvSs/eOzCAV7ZQEslXJpC3uZqaQihhDeXEN4KeJ4gk/
         0eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537934; x=1709142734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+DfUwTrji+JiliVaosYGzYtaY7yoOzYOgDQgUlYBFM=;
        b=wzhH+7NCWK7gv7WRXRiFp2smGn4atbCyoY9HRNHEEzPpcsiJrsZYpzSEKGnWKHxWuD
         zpmyyMvVxq/xEvcpkBV7CFKwAV8/XeC8WC6W2P5SJK2R7UvXBXsehX7k8iV8c/cebefA
         K8FR4VgRwtBcPKo7zeTb2QXiWk+Ef41bp355RD2mLeT7Ijazn2eldwRnDofONCNlPwyh
         NPVh6COEQ4nUqw6KcoHBj6WHuXwTlXEZd6fe0ntjSrEXOGBO1vD0P793oA7yJXFLVkqs
         TGq9QjVXFZSU86/yBWHaqIKMtjipCzqEAJxv5s0ZMA4ltoQowFaIfVXlfd9SoCKI0vMV
         6sig==
X-Forwarded-Encrypted: i=1; AJvYcCW9I/93xdFnrPhteUe1Mmcea6Ie089SQ62AMINSb+r6NV5taNsNpQzHHpKMQ5pn/MS70LMr6aYeT0hhSI4JKyU0kXOfgIVmH+bz81Fk
X-Gm-Message-State: AOJu0YxwrX+jIFWG7LphoytD/VMGexYKhPBIww9VnXn3UkoEIPwJeC0f
	RI/blqyOnTmG242Ea3hRVuKp3e2KLOgVxXkEUtvJAy7KmwMuujk5rWFZFUT5qg==
X-Google-Smtp-Source: AGHT+IEMLU7YlYaKGvZrOKY9ernOTo0nAZJnhvm6P2wOHB9H+omxxzWRQx6k/HLr6Y5NNsPFHHF+zg==
X-Received: by 2002:a17:902:eccf:b0:1db:f513:28cf with SMTP id a15-20020a170902eccf00b001dbf51328cfmr11635532plh.23.1708537934363;
        Wed, 21 Feb 2024 09:52:14 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001d706e373a9sm8312596plk.292.2024.02.21.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:52:13 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
Date: Wed, 21 Feb 2024 09:52:10 -0800
Message-Id: <20240221175210.19936-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221175210.19936-1-khuey@kylehuey.com>
References: <20240221175210.19936-1-khuey@kylehuey.com>
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
 tools/perf/tests/Build              |   1 +
 tools/perf/tests/builtin-test.c     |   1 +
 tools/perf/tests/tests.h            |   1 +
 tools/perf/tests/watermark_signal.c | 123 ++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 tools/perf/tests/watermark_signal.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 53ba9c3e20e0..de43eb60b280 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -67,6 +67,7 @@ perf-y += sigtrap.o
 perf-y += event_groups.o
 perf-y += symbols.o
 perf-y += util.o
+perf-y += watermark_signal.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4a5973f9bb9b..715c01a2172a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__event_groups,
 	&suite__symbols,
 	&suite__util,
+	&suite__watermark_signal,
 	NULL,
 };
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index dad3d7414142..7ef4e0d0a77b 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -146,6 +146,7 @@ DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
+DECLARE_SUITE(watermark_signal);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
diff --git a/tools/perf/tests/watermark_signal.c b/tools/perf/tests/watermark_signal.c
new file mode 100644
index 000000000000..ae4abedc4b7c
--- /dev/null
+++ b/tools/perf/tests/watermark_signal.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+
+#include "tests.h"
+#include "debug.h"
+#include "event.h"
+#include "../perf-sys.h"
+#include "cloexec.h"
+#include <internal/lib.h> // page_size
+
+static int sigio_count;
+
+static void handle_sigio(int sig __always_unused)
+{
+	++sigio_count;
+}
+
+static void do_child(void)
+{
+	for (int i = 0; i < 20; ++i)
+		sleep(1);
+
+	exit(0);
+}
+
+static int test__watermark_signal(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_event_attr attr;
+	struct perf_event_mmap_page *p = NULL;
+	sighandler_t previous_sigio = SIG_ERR;
+	pid_t child = -1;
+	int fd = -1;
+	int ret = TEST_FAIL;
+
+	previous_sigio = signal(SIGIO, handle_sigio);
+	if (previous_sigio == SIG_ERR) {
+		pr_debug("failed setting SIGIO handler\n");
+		goto cleanup;
+	}
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
+	if (child == 0)
+		do_child();
+	else if (child < 0) {
+		pr_debug("failed fork() %d\n", errno);
+		goto cleanup;
+	}
+
+	fd = sys_perf_event_open(&attr, child, -1, -1,
+				 perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_debug("failed opening event %llx\n", attr.config);
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETFL, FASYNC)) {
+		pr_debug("failed F_SETFL FASYNC %d\n", errno);
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETOWN, getpid())) {
+		pr_debug("failed F_SETOWN getpid() %d\n", errno);
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETSIG, SIGIO)) {
+		pr_debug("failed F_SETSIG SIGIO %d\n", errno);
+		goto cleanup;
+	}
+
+	p = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (p == NULL) {
+		pr_debug("failed to mmap\n");
+		goto cleanup;
+	}
+
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
+		pr_debug("failed PERF_EVENT_IOC_ENABLE %d\n", errno);
+		goto cleanup;
+	}
+
+	sleep(30);
+
+	ret = (sigio_count == 1) ? TEST_OK : TEST_FAIL;
+
+cleanup:
+	if (p != NULL)
+		munmap(p, 2 * page_size);
+
+	if (fd >= 0)
+		close(fd);
+
+	if (child > 0) {
+		kill(child, SIGTERM);
+		waitpid(child, NULL, 0);
+	}
+
+	if (previous_sigio != SIG_ERR)
+		signal(SIGIO, previous_sigio);
+
+	return ret;
+}
+
+DEFINE_SUITE("Watermark signal handler", watermark_signal);
-- 
2.34.1


