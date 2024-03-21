Return-Path: <linux-kernel+bounces-110697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9C886298
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD6F282152
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4F4A2F;
	Thu, 21 Mar 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/iNqgs4"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E57135A7A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057066; cv=none; b=ZXgUBBxAfRS7EGBjzuMl97QGWppnJmYldchs5+EQzuquRr608Li0FJU8W7QaFWsrJcEGXbN4L+g/Uc14NN+F6432rXId1st+h/Y/fwS9U7Ay/89yOiEQYghRdA2qxPjvalGRCc8b+qEdNTmsN534fB/qeifaUP3CNutrsgAhSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057066; c=relaxed/simple;
	bh=17nLr5++Gj5gPnA/3LVk7GlcT9/oObVsxL2RNm5//ng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sLrlPEynDbLhUnvZJkg4DQdt/bU3FRakjTuYZ0wDdn6EzdxWyCg6EHskf8OGdRVD7yvBIE7+wmEzg0ZZcJwfYh6N/JjOzk29usTr+7v7dp9xvkKzEbnMeyjAEcWLZy9r4xdwUUGbVgNmLq2yohnryMu9KSJ1YDdCvNOUFl+uoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/iNqgs4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso808031a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711057064; x=1711661864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOtrT19asMXEr0TwJpVFoh7wEKo99GZ26en2SG6Gpmk=;
        b=Q/iNqgs4gw6lX/aGYhbdqFjzv2Zp4SvBhyy/Dhmv61Nz0VUXGys7OgTSKGFv5bHggf
         5aaMe6tide4/m0qheZ6hMgoLqat3gCjHbmix6aJHTfg2rrKl0g2j/c19kFpcjzg55FTA
         71Bk5VAwbqSHWu6FBNEK8L6OOp2/PVSecyUEbwxQySJLFJDV9t8urTQydvlIrdsPUPrR
         fED4EmoB32ADBfasfNVYFvE6eVogrfQG9VWS0o25XMXHTrDHHkXjerPcRmiUFWJcyLw+
         vZKpMq85kQEGDJKJh1UyIgVesA8MOA/m7oLo54+8YgNBo2nfUT5rT0tXAIGMyObp+ogH
         slVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711057064; x=1711661864;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOtrT19asMXEr0TwJpVFoh7wEKo99GZ26en2SG6Gpmk=;
        b=fWxDmL0W58LZ4uih1Vu+nBqksqLLgHvjvHIaT5WYZanCK58/9zPXdy9UwaeG8i6wry
         T1R0ozsskr4GDjO1kQbUioOIyubtOIcXXzKn3TTEA6GMRdSovhzWRV1LGv1o28KZhxAx
         tPjuQOsJn+vUHbVSoXUfxJ3uVhcMXaIXb9txZ3L70iZo3iUXQITRoAQ6IQFqUMYvo71D
         LeQxBqlrswATonl6pindvImvicVZ0WcBTAdQBLtxIZi5FhcPTM9qSPHWioiAcprQ76Be
         R3GgSMyVyems+MupDUI7zgeaEO0h3FGniKxvJdpTAPpKQqP5WVF+WZFmYyy7Fb/UmiVb
         SUXw==
X-Gm-Message-State: AOJu0Yy4trmHiM3guZWh8P5+uMT087j6EsFMXRjZ3G004FBRyd9OVDsS
	H0DmD0trGyMAsQYzOFGJOFHTExkZ5lCHvG72jNjrWZE/LX7xUZaN989vnYJ67w52vXLG+CPBR/5
	WEx3gIHaJIRvrhncobBN/LgK8239iIBzBZmLj2u4OALoS/DuELJmVL9338ynVj0Nz/Xn0Jqnsoc
	bOCrx5bEpWB/AJxgcNz8O8vj6ssZaL0hxxytMl3W+F
X-Google-Smtp-Source: AGHT+IFG44GRpyLSoCdzTAgGOvr+Ykn7xEnNSiVaxpdqGc3Wa47XGjUxz3BVE+W4nqXyifeoqem9jdAgDIM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:f1e:0:b0:5d5:1e4d:c845 with SMTP id
 e30-20020a630f1e000000b005d51e4dc845mr1288pgl.10.1711057063490; Thu, 21 Mar
 2024 14:37:43 -0700 (PDT)
Date: Thu, 21 Mar 2024 21:37:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321213738.1705396-1-edliaw@google.com>
Subject: [PATCH v2] uffd-unit-tests: Fix ARM related issue with fork after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Lokesh Gidra <lokeshgidra@google.com>
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


