Return-Path: <linux-kernel+bounces-132005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF1898E84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9267228C275
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02CD1332A9;
	Thu,  4 Apr 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsR1JGGJ"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2F132816
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257346; cv=none; b=BOlAkNaG6ns5b7ToeeKcBo6V+F77bZPYbLKIzhrpQI/2Qa2rSG7upL/kKS1jPFUSN4yLAZoMCYNxFswam2d77V5mikeOoc3YvlF+e3UN0syAJwhjrhGaLe7XoeoglFUxgf8Xy9b9tliZbk/eyXlk4GS6INqQAbgxDwJduPwRgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257346; c=relaxed/simple;
	bh=EGDvzNbi6v6m/qOu4TJ4hzcKRgzIVliyqmolX3KdkkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ipnN2Zfk6Mhg/SKqzkYMqmNhihYR8qEwJHtowxgFX720wRXcTeYq4KsRSXzDc3H6tdU3ihGzNzj5gDSe+wLwQPYgEfFNiqktJdrJo39qvWG3yns2GPQM9C7/vItMiG4ge1aGoUhGcXSDVLwZRpktVOBvV61fOVjP7byQxV8enSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsR1JGGJ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56e1397b6d0so753424a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712257342; x=1712862142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHnDLO6+rKOAAIvx3fPfHLrwEnmmxTcJd/9Dz5qn/jI=;
        b=gsR1JGGJaAxMVzJQgDiFOAu8vIqgRS3sOg74wWOUnaLVQCdDe+bKU1ZWM1hKH+jIHv
         zJZeQ7/pIJuKPY52jP+ERhmPYBfSxk8KvCZlx1E4SH01z2KKuYPmPLjo8VXJZiHxePmR
         LQI6/8pvm4KVkXirWER4075G/v7vW2/40W8ohc8EpEdRi6S2ncLdD1Gsmz+NkdQQ3OUl
         k7xNVwhcMJJ0ToU411zhSIjp8rmhS9aFaP/hOq1PZPhTCjKVNq1Q9rXLKD/WGFbEmAI/
         W/Iqjkvq1SwNH4YfpxCK6Fw7EGk4DreyYQ9FrzCYJLexc4aVSrV1L88IAOCUC2ZzTZdh
         YwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257343; x=1712862143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHnDLO6+rKOAAIvx3fPfHLrwEnmmxTcJd/9Dz5qn/jI=;
        b=TGCXuLgyUJ+kbg3cH/gH7KRp7TFy2HN3YtTLKT52exKh49Q0pkXM81HoXBzT5HC3aS
         cEAdIAYMwhnOcckNbCIHSqKsT2N7LrIlZka3etKOTyjgbBNAv+vdflDoXU1ImEZFg+GH
         wIWbutA5hfQsUJsAJh8mAeEu0382MZNxXJCRM0MeN7opPcLB5FA6wuzgreDLd53zftK4
         aeTnGPFRG2WKg5Xwufmc9jAzVJ/AQsvV6ncSToxvuKGNBe8u5hzJFjlb0Ewpvbsa/8Rd
         yBqXNHU/NuzgPrmUA1nU1AoMbQDg+1WlemjXaZjExSuBr8LGiF21yt4I7XAH8gJN1p7N
         S21w==
X-Forwarded-Encrypted: i=1; AJvYcCWmJxhPj8X1vxg/XScm7ALbK0t1LDhDNDKoH7OT6BGosZVFVJuLJaKPCxKHh2UC7U9SaKM/54ejrlvasfGRn365+3oULukmOwm/wMXD
X-Gm-Message-State: AOJu0YwkQrTrXJqY6OjXF4VlA9FUcFDQ450eglO+RTRXWo/+ZNOnoXsk
	GOUeihbgD7wX8LmsMqjltem72nbf1zTejv93zMCJzZ+/7cHhqoP6tkYEHFxYBe1Mpjs8eWg2xQ=
	=
X-Google-Smtp-Source: AGHT+IE6NATmIrlgLd/YLW+KCHbbEuuYziGoudiOlzDgriOmlzHsBib7orQt8403zzVPjaJLUcW/YFmRJw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:2ac:e52b:98d7:eb1e])
 (user=elver job=sendgmr) by 2002:a05:6402:5024:b0:56b:9d72:55ed with SMTP id
 p36-20020a056402502400b0056b9d7255edmr1366eda.6.1712257342799; Thu, 04 Apr
 2024 12:02:22 -0700 (PDT)
Date: Thu,  4 Apr 2024 21:01:41 +0200
In-Reply-To: <20240404190146.1898103-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404190146.1898103-2-elver@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for bpf_probe_write_user_registered()
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a BPF test program and user space code to test
bpf_probe_write_user_registered().

The test program also demonstrates 2 ways a BPF program may obtain the
addresses it can write to: either by tracing prctl() or simply accessing
current->bpf_user_writable directly.

Signed-off-by: Marco Elver <elver@google.com>
---
 .../prog_tests/probe_write_user_registered.c  | 325 ++++++++++++++++++
 .../progs/test_probe_write_user_registered.c  | 219 ++++++++++++
 2 files changed, 544 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_write_user_registered.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_write_user_registered.c

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_write_user_registered.c b/tools/testing/selftests/bpf/prog_tests/probe_write_user_registered.c
new file mode 100644
index 000000000000..78ac0756d365
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/probe_write_user_registered.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023, Google LLC. */
+
+#include <malloc.h>
+#include <pthread.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <sys/prctl.h>
+#include <time.h>
+
+#include <test_progs.h>
+#include "test_probe_write_user_registered.skel.h"
+
+#define TEST_TAG 0xf23c39ab
+
+/* Encoding of the test access-type in the tv_nsec parameter. */
+enum test_access {
+	TEST_SUB_REGION,
+	TEST_EQ_REGION,
+	TEST_ONE_BY_ONE,
+	TEST_ANY_TAG,
+};
+
+/* This will be written to by the BPF program. */
+struct test_data {
+	volatile uint64_t padding_start;
+	volatile uint64_t nanosleep_arg;
+	volatile uint64_t padding_end;
+};
+
+static struct test_data test_data;
+
+static void prctl_register_writable(const volatile void *start, size_t size, uint32_t tag)
+{
+	ASSERT_OK(prctl(PR_BPF_REGISTER_WRITABLE, start, size, tag, 0), __func__);
+}
+
+static void prctl_unregister_writable(const volatile void *start, size_t size)
+{
+	ASSERT_OK(prctl(PR_BPF_UNREGISTER_WRITABLE, start, size, 0, 0), __func__);
+}
+
+/* Returns the actual tv_nsec value derived from base and test_access. */
+static uint64_t do_nanosleep(uint64_t base, enum test_access test_access)
+{
+	const uint64_t tv_nsec = base << 8 | test_access;
+	struct timespec ts = {};
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = tv_nsec;
+	syscall(__NR_nanosleep, &ts, NULL);
+
+	return tv_nsec;
+}
+
+/*
+ * Test that the basic usage works: register, write from BPF program,
+ * unregister, after which no more writes can happen.
+ */
+static void test_register_and_unregister(struct test_probe_write_user_registered *skel)
+{
+	uint64_t nsec = 1234;
+	uint64_t expect;
+
+	prctl_register_writable(&test_data, sizeof(test_data), TEST_TAG);
+
+	/* Check that we see the writes. */
+	for (int i = 0; i < 3; ++i) {
+		test_data.nanosleep_arg = 0;
+		expect = do_nanosleep(++nsec, TEST_SUB_REGION);
+		ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+		ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+	}
+
+	/* Registered the whole region, so this should also work... */
+	for (int i = 0; i < 3; ++i) {
+		test_data.nanosleep_arg = 0;
+		expect = do_nanosleep(++nsec, TEST_EQ_REGION);
+		ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+		ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+	}
+
+	prctl_unregister_writable(&test_data, sizeof(test_data));
+
+	/* No more writes after unregistration. */
+	test_data.nanosleep_arg = 0;
+	do_nanosleep(++nsec, TEST_SUB_REGION);
+	ASSERT_EQ(test_data.nanosleep_arg, 0, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 0, __func__);
+}
+
+/*
+ * Test that accesses with mismatching tags fail.
+ */
+static void test_bad_tag(struct test_probe_write_user_registered *skel)
+{
+	uint64_t expect;
+
+	prctl_register_writable(&test_data, sizeof(test_data), TEST_TAG);
+	test_data.nanosleep_arg = 0;
+	expect = do_nanosleep(1234, TEST_SUB_REGION);
+	ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+	do_nanosleep(9999, TEST_ANY_TAG); /* fails */
+	ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+	prctl_unregister_writable(&test_data, sizeof(test_data));
+}
+
+/*
+ * Test that the "any" (zero) tag works.
+ */
+static void test_any_tag(struct test_probe_write_user_registered *skel)
+{
+	uint64_t nsec = 1234;
+	uint64_t expect;
+
+	prctl_register_writable(&test_data, sizeof(test_data), 0);
+
+	for (int i = 0; i < 3; ++i) {
+		test_data.nanosleep_arg = 0;
+		expect = do_nanosleep(++nsec, TEST_ANY_TAG);
+		ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+		ASSERT_EQ(skel->data->found_user_registered, 0, __func__);
+	}
+
+	prctl_unregister_writable(&test_data, sizeof(test_data));
+
+	test_data.nanosleep_arg = 0;
+	do_nanosleep(++nsec, TEST_ANY_TAG);
+	ASSERT_EQ(test_data.nanosleep_arg, 0, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 0, __func__);
+}
+
+/*
+ * Test that invalid prctl() fail.
+ */
+static void test_invalid_prctl(struct test_probe_write_user_registered *skel)
+{
+	ASSERT_ERR(prctl(PR_BPF_REGISTER_WRITABLE, NULL, 1, 0, 0), __func__);
+	ASSERT_ERR(prctl(PR_BPF_REGISTER_WRITABLE, &test_data, 0, 0, 0), __func__);
+	prctl_register_writable(&test_data, sizeof(test_data), TEST_TAG);
+	ASSERT_ERR(prctl(PR_BPF_REGISTER_WRITABLE, &test_data, sizeof(test_data), 0, 0), __func__);
+	ASSERT_ERR(prctl(PR_BPF_REGISTER_WRITABLE, &test_data, 2, 0, 0), __func__);
+	prctl_register_writable((void *)&test_data + 1, 1, TEST_TAG);
+	prctl_register_writable((void *)&test_data - 1, 1, TEST_TAG);
+
+	ASSERT_ERR(prctl(PR_BPF_UNREGISTER_WRITABLE, &test_data, 1, 0, 0), __func__);
+	prctl_unregister_writable((void *)&test_data - 1, 1);
+	prctl_unregister_writable(&test_data, sizeof(test_data));
+	prctl_unregister_writable((void *)&test_data + 1, 1);
+	ASSERT_ERR(prctl(PR_BPF_UNREGISTER_WRITABLE, 0x123456, 1, 0, 0), __func__);
+	ASSERT_ERR(prctl(PR_BPF_UNREGISTER_WRITABLE, &test_data, sizeof(test_data), 0, 0), __func__);
+}
+
+/*
+ * Test that we can register multiple regions and they all work.
+ */
+static void test_multiple_region(struct test_probe_write_user_registered *skel)
+{
+	uint64_t expect;
+
+	prctl_register_writable(&test_data.nanosleep_arg, sizeof(uint64_t), TEST_TAG);
+	prctl_register_writable(&test_data.padding_end, sizeof(uint64_t), TEST_TAG);
+	/* First one last, so the test program knows where to start. */
+	prctl_register_writable(&test_data.padding_start, sizeof(uint64_t), TEST_TAG);
+
+	memset(&test_data, 0, sizeof(test_data));
+	do_nanosleep(0xf00d, TEST_EQ_REGION); /* fails */
+	ASSERT_EQ(test_data.nanosleep_arg, 0, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 1, __func__); /* found first */
+
+	expect = do_nanosleep(0xf33d, TEST_ONE_BY_ONE);
+	ASSERT_EQ(test_data.padding_start, expect, __func__);
+	ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+	ASSERT_EQ(test_data.padding_end, expect, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+
+	prctl_unregister_writable(&test_data.padding_start, sizeof(uint64_t));
+	prctl_unregister_writable(&test_data.nanosleep_arg, sizeof(uint64_t));
+	prctl_unregister_writable(&test_data.padding_end, sizeof(uint64_t));
+}
+
+static void *test_thread_func(void *arg)
+{
+	struct test_probe_write_user_registered *skel = arg;
+
+	/* If this fails, the thread didn't inherit the region. */
+	ASSERT_ERR(prctl(PR_BPF_UNREGISTER_WRITABLE, &test_data, sizeof(test_data), 0, 0), __func__);
+	/* So that the BPF user_writable task storage is filled. */
+	prctl_register_writable(&test_data, 1, TEST_TAG);
+	prctl_unregister_writable(&test_data, 1);
+
+	/* Test that there really is no way it'll write. */
+	test_data.nanosleep_arg = 0;
+	do_nanosleep(9999, TEST_SUB_REGION); /* fails */
+	ASSERT_EQ(test_data.nanosleep_arg, 0, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 0, __func__);
+
+	return NULL;
+}
+
+/*
+ * Test that threads (CLONE_VM) do not inherit writable regions.
+ */
+static void test_thread(struct test_probe_write_user_registered *skel)
+{
+	uint64_t expect;
+	pthread_t tid;
+
+	prctl_register_writable(&test_data, sizeof(test_data), TEST_TAG);
+
+	test_data.nanosleep_arg = 0;
+	expect = do_nanosleep(1234, TEST_SUB_REGION);
+	ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+
+	ASSERT_OK(pthread_create(&tid, NULL, test_thread_func, skel), "pthread_create");
+	ASSERT_OK(pthread_join(tid, NULL), "pthread_join");
+
+	ASSERT_EQ(test_data.nanosleep_arg, 0, __func__);
+	prctl_unregister_writable(&test_data, sizeof(test_data));
+}
+
+/*
+ * Test that fork() does inherit writable regions.
+ */
+static void test_fork(struct test_probe_write_user_registered *skel)
+{
+	uint64_t expect;
+	int pid, status;
+
+	prctl_register_writable(&test_data, sizeof(test_data), TEST_TAG);
+
+	test_data.nanosleep_arg = 0;
+	expect = do_nanosleep(1234, TEST_SUB_REGION);
+	ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+	ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+
+	pid = fork();
+	if (!pid) {
+		test_data.nanosleep_arg = 0; /* write prefault */
+		expect = do_nanosleep(3333, TEST_SUB_REGION);
+		ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+		exit(!ASSERT_EQ(test_data.nanosleep_arg, expect, __func__));
+	}
+
+	status = -1;
+	waitpid(pid, &status, 0);
+	ASSERT_EQ(status, 0, __func__);
+
+	ASSERT_EQ(test_data.nanosleep_arg, expect, __func__);
+	prctl_unregister_writable(&test_data, sizeof(test_data));
+}
+
+/*
+ * Test that the kernel can allocate lots of regions and find them.
+ */
+static void test_stress_regions(struct test_probe_write_user_registered *skel)
+{
+	const int STRESS_SIZE = 200;
+	struct test_data *large = malloc(STRESS_SIZE * sizeof(*large));
+	uint64_t expect;
+
+	ASSERT_NEQ(large, NULL, __func__);
+
+	memset(large, 0, STRESS_SIZE * sizeof(*large));
+
+	for (int i = 0; i < STRESS_SIZE; ++i) {
+		prctl_register_writable(&large[i], sizeof(*large), TEST_TAG);
+		ASSERT_ERR(prctl(PR_BPF_REGISTER_WRITABLE, &large[i], sizeof(*large), 0, 0), __func__);
+		expect = do_nanosleep(777, TEST_SUB_REGION);
+		ASSERT_EQ(large[i].nanosleep_arg, expect, __func__);
+		ASSERT_EQ(skel->data->found_user_registered, 1, __func__);
+	}
+
+	for (int i = 0; i < STRESS_SIZE; ++i) {
+		prctl_unregister_writable(&large[i], sizeof(*large));
+		ASSERT_ERR(prctl(PR_BPF_UNREGISTER_WRITABLE, &large[i], sizeof(*large), 0, 0), __func__);
+		large[i].nanosleep_arg = 0;
+		do_nanosleep(1992, TEST_SUB_REGION); /* no more writes */
+		ASSERT_EQ(large[i].nanosleep_arg, 0, __func__);
+		ASSERT_EQ(skel->data->found_user_registered, i < STRESS_SIZE - 1 ? 1 : 0, __func__);
+	}
+
+	for (int i = 0; i < STRESS_SIZE; ++i)
+		ASSERT_ERR(prctl(PR_BPF_UNREGISTER_WRITABLE, &large[i], sizeof(*large), 0, 0), __func__);
+
+	free(large);
+}
+
+/*
+ * Test setup.
+ */
+void test_probe_write_user_registered(void)
+{
+	struct test_probe_write_user_registered *skel;
+
+	skel = test_probe_write_user_registered__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load"))
+		return;
+
+	if (!ASSERT_OK(test_probe_write_user_registered__attach(skel), "attach"))
+		goto cleanup;
+
+	if (test__start_subtest("register_and_unregister"))
+		test_register_and_unregister(skel);
+	if (test__start_subtest("bad_tag"))
+		test_bad_tag(skel);
+	if (test__start_subtest("any_tag"))
+		test_any_tag(skel);
+	if (test__start_subtest("invalid_prctl"))
+		test_invalid_prctl(skel);
+	if (test__start_subtest("multiple_region"))
+		test_multiple_region(skel);
+	if (test__start_subtest("thread"))
+		test_thread(skel);
+	if (test__start_subtest("fork"))
+		test_fork(skel);
+	if (test__start_subtest("stress_regions"))
+		test_stress_regions(skel);
+
+cleanup:
+	test_probe_write_user_registered__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_probe_write_user_registered.c b/tools/testing/selftests/bpf/progs/test_probe_write_user_registered.c
new file mode 100644
index 000000000000..9174ff2e36f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_probe_write_user_registered.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023, Google LLC. */
+#include "vmlinux.h"
+#include <asm/unistd.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/*
+ * We just need the CLONE_VM definition. Without __ASSEMBLY__ sched.h would
+ * redefine clone_args, which is already defined by vmlinux.h
+ */
+#define __ASSEMBLY__
+#include <linux/sched.h>
+#undef __ASSEMBLY__
+
+#define TEST_TAG 0xf23c39ab
+
+/* Encoding of the test access-type in the tv_nsec parameter. */
+enum test_access {
+	TEST_SUB_REGION,
+	TEST_EQ_REGION,
+	TEST_ONE_BY_ONE,
+	TEST_ANY_TAG,
+};
+#define TEST_ACCESS(nsec) ((enum test_access)((nsec) & 0xff))
+
+struct test_data {
+	__u64 padding_start;
+	__u64 nanosleep_arg;
+	__u64 padding_end;
+};
+
+struct user_writable {
+	void *start;
+	size_t size;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct user_writable);
+} user_writable SEC(".maps");
+
+int found_user_registered = -1;
+
+/*
+ * This is used to test that the contents of per-task bpf_user_writable is sane.
+ *
+ * It also demonstrates another way (vs. prctl()) how the BPF program can obtain
+ * addresses associated with a tag. Beware, however, that this is O(#registered)
+ * and a production BPF program should cache its result in task local storage.
+ */
+static int find_user_registered(__u32 tag, void *start)
+{
+	const struct bpf_user_writable *uw = bpf_get_current_task_btf()->bpf_user_writable;
+	int count = 0;
+
+	if (!uw)
+		return count;
+
+      /*
+       * Ensure termination of the loop to make the verifier happy. Use
+       * bpf_loop() if you expect a very large number of registered regions.
+       */
+	for (__u32 idx = 0; idx < uw->size && idx < 1024; ++idx) {
+		if (uw->entries[idx].tag == tag && uw->entries[idx].start == start)
+			count++;
+	}
+
+	return count;
+}
+
+static void sys_nanosleep(struct pt_regs *regs)
+{
+	struct __kernel_timespec *ts;
+	struct user_writable *w;
+	__u32 dummy = -99;
+	__u64 tv_nsec;
+	int err;
+
+	_Static_assert(sizeof(ts->tv_nsec) == sizeof(tv_nsec), "ABI");
+
+	found_user_registered = -1;
+
+	w = bpf_task_storage_get(&user_writable, bpf_get_current_task_btf(), 0, 0);
+	if (!w)
+		return;
+
+	ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
+	if (bpf_probe_read_user(&tv_nsec, sizeof(ts->tv_nsec), &ts->tv_nsec))
+		return;
+
+	found_user_registered = find_user_registered(TEST_TAG, w->start);
+
+	bpf_printk("doing test accesses");
+
+	/*
+	 * Test failing accesses before, so that if they actually succeed, we
+	 * won't do the real write and the test will detect a missed write.
+	 */
+	if (!bpf_probe_write_user_registered(w->start + w->size - 1, &dummy, sizeof(dummy), TEST_TAG))
+		return;
+	if (!bpf_probe_write_user_registered(w->start - 1, &dummy, sizeof(dummy), TEST_TAG))
+		return;
+	if (!bpf_probe_write_user_registered(w->start + 100, &dummy, sizeof(dummy), TEST_TAG))
+		return;
+	if (TEST_ACCESS(tv_nsec) != TEST_ANY_TAG) {
+		if (!bpf_probe_write_user_registered(w->start, &dummy, sizeof(dummy), 123))
+			return;
+		if (!bpf_probe_write_user_registered(w->start, &dummy, sizeof(dummy), 0))
+			return;
+	}
+
+	switch (TEST_ACCESS(tv_nsec)) {
+	case TEST_SUB_REGION:
+		bpf_printk("sub region write");
+		err = bpf_probe_write_user_registered(w->start + sizeof(__u64), &tv_nsec, sizeof(tv_nsec), TEST_TAG);
+		break;
+	case TEST_EQ_REGION: {
+		struct test_data out = {};
+
+		bpf_printk("whole region write");
+		out.nanosleep_arg = tv_nsec;
+		err = bpf_probe_write_user_registered(w->start, &out, sizeof(out), TEST_TAG);
+		break;
+	}
+	case TEST_ONE_BY_ONE:
+		bpf_printk("write one by one");
+		for (int i = 0; i < 3; ++i) {
+			err = bpf_probe_write_user_registered(w->start + i * sizeof(__u64), &tv_nsec,
+							      sizeof(tv_nsec), TEST_TAG);
+			if (err)
+				break;
+		}
+		break;
+	case TEST_ANY_TAG:
+		bpf_printk("any tag write");
+		err = bpf_probe_write_user_registered(w->start + sizeof(__u64), &tv_nsec, sizeof(tv_nsec), 93845);
+		break;
+	default:
+		bpf_printk("unknown access method");
+		return;
+	}
+
+	if (err)
+		bpf_printk("write failed: %d", err);
+	else
+		bpf_printk("write success");
+}
+
+static void sys_prctl(struct pt_regs *regs)
+{
+	struct user_writable *w;
+	__u32 tag;
+
+	if (PT_REGS_PARM1_CORE_SYSCALL(regs) != /*PR_BPF_REGISTER_WRITABLE*/71)
+		return;
+
+	tag = (__u32)PT_REGS_PARM4_CORE_SYSCALL(regs);
+	if (tag && tag != TEST_TAG)
+		return;
+
+	w = bpf_task_storage_get(&user_writable, bpf_get_current_task_btf(), 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!w)
+		return;
+
+	bpf_printk("registered user writable region with tag %x", tag);
+	w->start = (void *)PT_REGS_PARM2_CORE_SYSCALL(regs);
+	w->size = PT_REGS_PARM3_CORE_SYSCALL(regs);
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter, struct pt_regs *regs, long id)
+{
+	switch (id) {
+	case __NR_prctl:
+		sys_prctl(regs);
+		break;
+	case __NR_nanosleep:
+		sys_nanosleep(regs);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/*
+ * The user writable region is copied on fork(). Also copy the per-task map we
+ * use in this test.
+ */
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_newtask, struct task_struct *t, unsigned long clone_flags)
+{
+	const struct user_writable *src;
+	struct user_writable *dst;
+
+	if (clone_flags & CLONE_VM)
+		return 0;
+
+	src = bpf_task_storage_get(&user_writable, bpf_get_current_task_btf(), 0, 0);
+	if (!src)
+		return 0;
+
+	dst = bpf_task_storage_get(&user_writable, t, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!dst) {
+		bpf_printk("failed to copy user_writable on fork()");
+		return 0;
+	}
+	*dst = *src;
+	bpf_printk("fork copied user writable region");
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.44.0.478.gd926399ef9-goog


