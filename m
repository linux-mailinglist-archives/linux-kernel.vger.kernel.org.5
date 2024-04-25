Return-Path: <linux-kernel+bounces-158133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A88B1BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D151E1C23D48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C178C8E;
	Thu, 25 Apr 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UFG/y6CE"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2986D1B0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030410; cv=none; b=bkt/0aqHZFX8xOD/9pDs0XsrW/TKFXawV8Rbrav3wWszPj1ELvJucfkxR5EA+9XOdBif9ufeum4gH8bKFx8q4+tJVKhuTJH5XnFj5NHj05Bl81VkTa1d4oCP9/kL/mEl7pcIpS9E3W5K9CuoIPySRKCGEKCVJm3cZJ8s50PjP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030410; c=relaxed/simple;
	bh=mHN9hs8IGVejgkls9jR3iaBoc87nNEzT105MD6zHbm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW8w/j/5TDAUO3oLx2zp0f9P/fu2tbzihkQFJezXGocFIlraS7b/FuA9Uo3CG+5Vh7+PeOLjAXC/dS2NZFK2CQ89YmGXiSNBYy8YWMCKld2RbI3VlAVzzt3LD/kHx7oBGwOph02Ck2itlwOTeeJXJQy6XmpLk0qWJyR4cfnBYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UFG/y6CE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B3943FE5F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714030407;
	bh=/dNvDnYrusTnWvle5YeikJ1eJyd4ePVKnyqmYISNV5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=UFG/y6CEYN1KF//NtoKQAQpJC/019f80KnsFXPWg6WI48UcQVOEF2Uxs/BiFndcTf
	 Kld/aA+lUO+8abMQSZZ5tc1Vcx2EaswwYbOX10/2tYIa38Yde/lNCYdsvM5e4jaaZ7
	 Xo64GA0Lsoc3c1Id53P+R9nfEShIYL47P81sSLJbhJFbQkkDnS6Lnv7ZH4jilBdkGw
	 Ob9ZZLWA3Zy5nE/owABXMp3Yk/HjYFol05SjLj4jSj9Xg6GPhcNC+QXnrX9td33UAi
	 sjIqbdXAgv29DSr/qi7GdWNJUL56aZs7HhNfwliyhVcydHRPT6OJDzKtyCXSvQ4kQ4
	 R5YaYPBTNaOCA==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2db6fbc1dedso5324131fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030406; x=1714635206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dNvDnYrusTnWvle5YeikJ1eJyd4ePVKnyqmYISNV5Q=;
        b=snC+rnAgxdWRxx0kKqcNjNhzd4QPDr3kGk7fo0GnZknAecRFWC1pIRho7gjeplsiHc
         JJC9pjmhoECYtdSfnUvWewZ+9PmBSTc22Ht81MQBP57D1cJ8r3LvTSBnxKIRnusjdKwk
         tafbiuRZw4kfqeLSqH4n1AHxGkVxDfcUZn7WJk7yYSKFwxetF/AvtQ6p2/GvyrCwUnK+
         FTKhn6f9GJScpI8jhvDGUs35gW4z018C/u1YKBf597qiM+HPO1EmqDxMKih6lV+oGPxk
         K6equ4qvgTbHx6XPaX/iH/7qTuR/x8kdA9bL46Nl2RLKDv14AkBPrageUZD0TKGcWpd+
         NJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNt3/ruUgQRZYt0af1RB9PEN6KDML41tiU8SSM77zCKU0RlO+i85lLGqGO6FxKZ0qut4R5860B6m6gyJbtypEiXju3xi9pIe3gCQLK
X-Gm-Message-State: AOJu0YyG3xm/Gijkq6wHDgesmNoJkjywhgQ+TNn4W2dBUZi/mnCQ+uNn
	A/yEqIMiAJxleoB1kXkTtqZGLqJtIV6kiQAAhraw3hQ4cUXYXAhL8hhdBPiUKrnKEp6LpBw73VV
	76klCsLm7S58rx19w4PyzndzSZNovFto00RiDLK8i5URBzc0rtQwFe4mkIH9eExxeKp21bYvopc
	FqpkVZrtw2Gs++
X-Received: by 2002:a2e:a443:0:b0:2d6:f5c6:e5a1 with SMTP id v3-20020a2ea443000000b002d6f5c6e5a1mr3734866ljn.12.1714030406308;
        Thu, 25 Apr 2024 00:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQJtnvVjGkoBiH1AcBJyrCRFzXR25CaKZuxuIct87H/8ZtDjstKzHj+iLLTF07OP2hJibrQ==
X-Received: by 2002:a2e:a443:0:b0:2d6:f5c6:e5a1 with SMTP id v3-20020a2ea443000000b002d6f5c6e5a1mr3734811ljn.12.1714030405402;
        Thu, 25 Apr 2024 00:33:25 -0700 (PDT)
Received: from localhost.localdomain (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id f1-20020a170906ef0100b00a587cfd7a37sm3065742ejs.84.2024.04.25.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:33:24 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH v2] selftests/bpf: Add ring_buffer__consume_n test.
Date: Thu, 25 Apr 2024 09:33:19 +0200
Message-ID: <20240425073319.75389-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testcase for the ring_buffer__consume_n() API.

The test produces multiple samples in a ring buffer, using a
sys_getpid() fentry prog, and consumes them from user-space in batches,
rather than consuming all of them greedily, like ring_buffer__consume()
does.

Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c

ChangeLog v1 -> v2:
 - replace CHECK() with ASSERT_EQ()
 - fix skel -> skel_n
 - drop unused "seq" field from struct sample

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edc73f8f5aef..6332277edeca 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -455,7 +455,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_map_key.c
+	test_ringbuf_n.c test_ringbuf_map_key.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..d59500d13a41 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include "test_ringbuf.lskel.h"
+#include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 
 #define EDONE 7777
@@ -60,6 +61,7 @@ static int process_sample(void *ctx, void *data, size_t len)
 }
 
 static struct test_ringbuf_map_key_lskel *skel_map_key;
+static struct test_ringbuf_n_lskel *skel_n;
 static struct test_ringbuf_lskel *skel;
 static struct ring_buffer *ringbuf;
 
@@ -326,6 +328,66 @@ static void ringbuf_subtest(void)
 	test_ringbuf_lskel__destroy(skel);
 }
 
+/*
+ * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
+ * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
+ */
+#define N_TOT_SAMPLES	32
+#define N_SAMPLES	4
+
+/* Sample value to verify the callback validity */
+#define SAMPLE_VALUE	42L
+
+static int process_n_sample(void *ctx, void *data, size_t len)
+{
+	struct sample *s = data;
+
+	ASSERT_EQ(s->value, SAMPLE_VALUE, "sample_value");
+
+	return 0;
+}
+
+static void ringbuf_n_subtest(void)
+{
+	int err, i;
+
+	skel_n = test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_n_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		goto cleanup_ringbuf;
+
+	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
+	skel_n->bss->value = SAMPLE_VALUE;
+	for (i = 0; i < N_TOT_SAMPLES; i++)
+		syscall(__NR_getpgid);
+
+	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
+	for (i = 0; i < N_TOT_SAMPLES; i += err) {
+		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
+		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
+	}
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static int process_map_key_sample(void *ctx, void *data, size_t len)
 {
 	struct sample *s;
@@ -384,6 +446,8 @@ void test_ringbuf(void)
 {
 	if (test__start_subtest("ringbuf"))
 		ringbuf_subtest();
+	if (test__start_subtest("ringbuf_n"))
+		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
new file mode 100644
index 000000000000..8669eb42dbe0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
+
+#include <linux/bpf.h>
+#include <sched.h>
+#include <unistd.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TASK_COMM_LEN 16
+
+struct sample {
+	int pid;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+int pid = 0;
+long value = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_n(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	sample->pid = pid;
+	sample->value = value;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
-- 
2.43.0


