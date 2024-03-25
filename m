Return-Path: <linux-kernel+bounces-117838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751A88B215
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D1BA12A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A734AEC8;
	Mon, 25 Mar 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8F6TRGX"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E346444
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395667; cv=none; b=JepIJ5kprbX9iU5Nz30peiDEzFO3c3kmrW5tBZqJkOM5CeSPPGjUxI8n/rHYu/fsvUhR859/q5rsiou8DUHl5jMM7De5CUOtK5MrBu5HsZfOJyiZCpShTT9rU1M/8GW0MXF/XhHORhC3re/PMVlX1zzUocyEyj0ixIN2QNjjhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395667; c=relaxed/simple;
	bh=PgpYmWwF+ZKkxz+jpDH8JrvQco+XVEcrWMSMSoX2y8M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ky0sohHAZoR1KFO+EH/l6E3vt8R3lUGp1DMgfJzft9jibPY6d3vuXMWROUVTcNatKF2myF1ufrMyUCXJQzkzoQrejRSZroF2UvjuIsYw3YVdqvHhRTy0F0pjidl13ZmKY6RnEZrbJ9P6C29byS7UPggW4haNwv/I9Zs1EeThwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8F6TRGX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e0b29c2ea4so7801725ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711395665; x=1712000465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cX0Tst/fD3eEaDcxw6zP7p1X7prwnotLNua44hovj0E=;
        b=L8F6TRGX2pUZ4NxD0OEqxpuFAmlqh7xHLEQiOPwdZpit375ecApirFVWm2iBkij6yA
         5UYI81ze7JTguTnXmHniUQ8pOFSxS854IZ+xYv0G4GGVf3gtYBR/EpE2oUCBzHTDa0DD
         lX2Qm94gPTbw+f7YiMgokyRdVY4/YFiwIVyamT6x9AiZMgKZ+/0QCLOFHZwLy4JTqtkz
         MczcYXu/ymiEuhvvK77EjtVYBEHpsoK1U+Q/rKWUlUkdzhRpNbUxVH0gaSUaPi4w6Ec8
         2arRKQSq0EC2vts2RpFz4ZnheboYf5Xx5miKcmx5wQQz2qDJFfFbSbRpln8ngbvxKTdj
         hhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395665; x=1712000465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cX0Tst/fD3eEaDcxw6zP7p1X7prwnotLNua44hovj0E=;
        b=ii7VqiMl0DLwNt1Do31UkoAGPpWcBpjNSABUtmWxCQsE5Ov8/mpaLlerAG6W34UDzY
         3pOZjeevIzGgBSuagRac78j7d3clSqKtr6NrfxyD83Otvyho/B5JeWol0HDMQyQgKiVc
         +nN0xkokz5eRkgaNzvi+OWMV7on5IzMWD7ghBiYmeZx+uYj0kDgH3Gh4gNXx6W+N0K0h
         ITMQa7MKxatAE1I1lGmZCu+6mUJtt4jv0gJlihkjPC0aUxde+Z0tv8gzGyxNHqOJSYwl
         LpWDy28CFTmq8fR4WtqFPKGkn9cEGV5j4myWyWQYybvtHLjD5VnvI8vsmOMEMTiqmSuj
         Pl5A==
X-Gm-Message-State: AOJu0Yw4b39xLj9rqcLbHebKjeuZr7zaj/b9qxRpDp9Cnj0/bdV5MnUD
	rZt9lbwjEyQBJAJ06utlaSnS7MI1in5s2nJfw8Qvwmd4OsOnpDZ63QuxVJj+vydVIVHlSuEEx2p
	9ch2DIaq/D/jsR1slo55dL8U4pT69juxnvgc1vmSrcF9UGiQs6h9vO/xX7RGd5M8X5bsUbeKidD
	CBJlU49PJaeUaVhnzMBERwHMXjqfRZZxVX2lMEKFuU
X-Google-Smtp-Source: AGHT+IHu0ZTXU78B+0X+LXpELIc87+D4aJxq4bKR0NhoBZQXd5O+HZEP47xhnKe66UWD9zpspAK+wE700/M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d2cf:b0:1de:f18c:ce4 with SMTP id
 n15-20020a170902d2cf00b001def18c0ce4mr662860plc.0.1711395663954; Mon, 25 Mar
 2024 12:41:03 -0700 (PDT)
Date: Mon, 25 Mar 2024 19:40:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325194100.775052-1-edliaw@google.com>
Subject: [PATCH v3] selftests/mm: Fix ARM related issue with fork after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Lokesh Gidra <lokeshgidra@google.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Following issue was observed while running the uffd-unit-tests selftest
on ARM devices. On x86_64 no issues were detected:

pthread_create followed by fork caused deadlock in certain cases
wherein fork required some work to be completed by the created thread.
Used synchronization to ensure that created thread's start function has
started before invoking fork.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
[edliaw: Refactored to use atomic_bool]
Signed-off-by: Edward Liaw <edliaw@google.com>
---

v2: restored accidentally removed uffd_test_case_ops when merging
v3: fixed commit subject to use selftests/mm prefix

 tools/testing/selftests/mm/uffd-common.c     |  3 +++
 tools/testing/selftests/mm/uffd-common.h     |  2 ++
 tools/testing/selftests/mm/uffd-unit-tests.c | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index b0ac0ec2356d..7ad6ba660c7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -18,6 +18,7 @@ bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
+atomic_bool ready_for_fork;

 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -518,6 +519,8 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;

+	ready_for_fork = true;
+
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
 		if (ret <= 0) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index cb055282c89c..cc5629c3d2aa 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <stdatomic.h>

 #include "../kselftest.h"
 #include "vm_util.h"
@@ -103,6 +104,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
+extern atomic_bool ready_for_fork;

 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2b9f8cc52639..4a48dc617c6b 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -775,6 +775,8 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };

+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);

 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -790,6 +792,9 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");

+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
@@ -829,6 +834,8 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };

+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
 			  true, wp, false))
@@ -838,6 +845,9 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");

+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
--
2.44.0.396.g6e790dbe36-goog


