Return-Path: <linux-kernel+bounces-110542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A5886058
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DB1C21E79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F411332BA;
	Thu, 21 Mar 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGVPHQbV"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08C85938
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044612; cv=none; b=jbQ6yyyOJgYs6zI+1jJuiW7o6M7TSWTxYEldAFt8MTzMTYI52PvnG+A/0hxy7/9X3JD+1DIz9pHMcZuFpM+9JoQ6iMZZPv3vKjLcFiC8D29yarZhvCJ+QEfBmH9TOosu9LsIzr9vy+8T3k0V6aa6cQpRxTtjPJ+1LudEsmLTWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044612; c=relaxed/simple;
	bh=J5T69WFQ9USHQjLVUN1osaWhJDJNI4GDdeUlvKQfx7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=feQ1pQPntagyQc5ECKgeZzpdnlzZFnB+Oh79K+euTfhcP/Rox06L7zcltrSuGR3PXrXdoxrh4sMHHS3y9mg929r2HHxkrOjV8qjvPnbdfRx2imOVskc11TvDJS3DmRvJseA0B5t7cCGUHYDtnQ0s1RKrSEW0ULnAR0jtjE4bXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGVPHQbV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ea8084133aso37306b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711044611; x=1711649411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbnhbS3nC1f/Uw+2QJySA42Qs2PFTt6bDMzEjk8k/Mc=;
        b=xGVPHQbVVuZwyQMxHksHdcprJy3/Npu36CDbaK4ztx4gIy0oCxQKI7yeEXolCTn9sd
         5c9/lkHiBYL77zMqpffFuy747oKDvTBQE3NTHFwvg0CTz4ZoG0j9/C3bU3DPVbOJhEM8
         +4zY2sQJYI+Ma2+eqUcWfOWB9TAtVxwHs2/tXRcJtOcD6W3MEpvS0pMAoRe0962DZ6fT
         i0QyiMXZqYZvBldXn2CFaXmKikV7iXzLM07xBE4yrVBOdEL7v+5/3rTF5ZHRxeOLuI6h
         ZN8Apj32cpwQU4mVSjM8UUue0r4g2E0f1x2Kj6UwCY5M24YuQiPc3S5IKO2i+28z91b3
         Cd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044611; x=1711649411;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbnhbS3nC1f/Uw+2QJySA42Qs2PFTt6bDMzEjk8k/Mc=;
        b=QydVMivCQajRB7QUVbBioNNMghBHZYZvTP7RBV0+5oCJwISDNQN5sslB4e71rOjDqJ
         SRizo4dM0LdfOF/GfDF36/69L6LmG99gjNMdGdrQScBf9WjzSSIKG/BNSHxi3Rds1vig
         Ws8z1rVeW1uI2crAkVvE1pzeUVmt1pxdQxuRRC3BSiTO4AUM74GgNkXa5gXDTu079edE
         gYQE9xSL5tjl0D1huUIHiutK82+Fo7BEkw6XoLy7rNQlzPBSUDpKTAq68fOY2zlhX2CC
         Lkzw6X8mQFfvGt7s/0HaRnLc84nnaRkf+58zhIVNMukFOhScXxuGPC2e/yqFqLY41Ekm
         G6+Q==
X-Gm-Message-State: AOJu0YyjPOo7UHQeniScGg/GopID2pIu0vRH8kGfJZCYbuQ9sXLzTSsQ
	fL1HV9ReUtISGm2+HZkImy8UEmt47jzvjsnmbdHqkkm2Gy7skeUUedl8BshEoEAZp2DvDQVTCd+
	GyYZ6ABMtY7+UMMLiDMHCPsXqT7YjgJvoUIzrwg7shVLsHtqRBMj38PFqBLEh1t/NaiH1AD/rwv
	uN06NnC3vzChCHbwcv3oFo5+vbI7KJqWZYVFLUH0pb
X-Google-Smtp-Source: AGHT+IFYni3VvlWRaTmYz+82jv0WpYU31SYMq2cohi3G9fHRYPBqE7DFoZnmZbyg80iXWTMzj1CSpz2vwMs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:938b:b0:6e7:3fcb:38ba with SMTP id
 ka11-20020a056a00938b00b006e73fcb38bamr10155pfb.6.1711044610507; Thu, 21 Mar
 2024 11:10:10 -0700 (PDT)
Date: Thu, 21 Mar 2024 18:09:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321180933.1029746-1-edliaw@google.com>
Subject: [PATCH v1] uffd-unit-tests: Fix ARM related issue with fork after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org
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
 tools/testing/selftests/mm/uffd-common.c     |  4 +++-
 tools/testing/selftests/mm/uffd-common.h     |  2 ++
 tools/testing/selftests/mm/uffd-unit-tests.c | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index b0ac0ec2356d..14ed98c3a389 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,7 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
-uffd_test_case_ops_t *uffd_test_case_ops;
+atomic_bool ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -518,6 +518,8 @@ void *uffd_poll_thread(void *arg)
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


