Return-Path: <linux-kernel+bounces-119183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24E88C532
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388A1303BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5F513C676;
	Tue, 26 Mar 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkDUmpzS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E513C3E1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463566; cv=none; b=q1BhxYEzci5kiLgKwVmS8ThnpThGdX/tDEUzKQ2BPCDrrGKdNdATx35Wrfbo8kAph5yp7s87PTtCyHX7S9sQyudWxF06c0kNE/PQ0AmKo74Y8VMv2hsS6miqI50NMJEINt8xD9JLqkH10I/vZeMK/4xJKu0atUZkyGU7vQKz7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463566; c=relaxed/simple;
	bh=+q7oN0RHHkf3xdx5Sx6lpZeZdUjteYjleOK/Z4hnVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AciRNZMT9MwPqQ8uUvLLVsjVr6eaYngC1a/X6AJe4lu12rc3iXUF5D0bgBnBD4eaKHkxFNheazQKmHbJJEbP8KFQ6reyX6NHEE8lAwx1A4dg9HmtXStgIIDrMjGSmqkPNvn+NU1OUJWL0n3x0W3gMCLdOoPjIsyEIh72O8mPCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkDUmpzS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711463563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82tUC6dlxq3xFltomUX9Np5kaF2oYCvvKygUhhN8Yg8=;
	b=dkDUmpzSBbDYePIxUFf2apar35ClW59JMbswPzAgxpqpqYWIeDe50L6XsYodHUx0WtBN0o
	RiYMSL36pDxsQ3tFoQqdAIcifoJgzkGy9XWR4rWfFeZo+d/RfhN61jRG0PcY5vezu7QvKY
	k+dCPhw6ArAT+uKjmE6B8RnDQK7ANUA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-Xgt-kVftPyGYoQ5JQWdHag-1; Tue,
 26 Mar 2024 10:32:40 -0400
X-MC-Unique: Xgt-kVftPyGYoQ5JQWdHag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE76C382C468;
	Tue, 26 Mar 2024 14:32:39 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 01750400D698;
	Tue, 26 Mar 2024 14:32:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v2 2/3] selftests/memfd_secret: add vmsplice() test
Date: Tue, 26 Mar 2024 15:32:09 +0100
Message-ID: <20240326143210.291116-3-david@redhat.com>
In-Reply-To: <20240326143210.291116-1-david@redhat.com>
References: <20240326143210.291116-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's add a simple reproducer for a scenario where GUP-fast could succeed
on secretmem folios, making vmsplice() succeed instead of failing. The
reproducer is based on a reproducer [1] by Miklos Szeredi.

We want to perform two tests: vmsplice() when a fresh page was just
faulted in, and vmsplice() on an existing page after munmap() that
would drain certain LRU caches/batches in the kernel.

In an ideal world, we could use fallocate(FALLOC_FL_PUNCH_HOLE) /
MADV_REMOVE to remove any existing page. As that is currently not
possible, run the test before any other tests that would allocate memory
in the secretmem fd.

Perform the ftruncate() only once, and check the return value.

[1] https://lkml.kernel.org/r/CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/memfd_secret.c | 51 ++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9b298f6a04b3..9a0597310a76 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -20,6 +20,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
+#include <fcntl.h>
 
 #include "../kselftest.h"
 
@@ -83,6 +84,45 @@ static void test_mlock_limit(int fd)
 	pass("mlock limit is respected\n");
 }
 
+static void test_vmsplice(int fd, const char *desc)
+{
+	ssize_t transferred;
+	struct iovec iov;
+	int pipefd[2];
+	char *mem;
+
+	if (pipe(pipefd)) {
+		fail("pipe failed: %s\n", strerror(errno));
+		return;
+	}
+
+	mem = mmap(NULL, page_size, prot, mode, fd, 0);
+	if (mem == MAP_FAILED) {
+		fail("Unable to mmap secret memory\n");
+		goto close_pipe;
+	}
+
+	/*
+	 * vmsplice() may use GUP-fast, which must also fail. Prefault the
+	 * page table, so GUP-fast could find it.
+	 */
+	memset(mem, PATTERN, page_size);
+
+	iov.iov_base = mem;
+	iov.iov_len = page_size;
+	transferred = vmsplice(pipefd[1], &iov, 1, 0);
+
+	if (transferred < 0 && errno == EFAULT)
+		pass("vmsplice is blocked as expected with %s\n", desc);
+	else
+		fail("vmsplice: unexpected memory access with %s\n", desc);
+
+	munmap(mem, page_size);
+close_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
 static void try_process_vm_read(int fd, int pipefd[2])
 {
 	struct iovec liov, riov;
@@ -187,7 +227,6 @@ static void test_remote_access(int fd, const char *name,
 		return;
 	}
 
-	ftruncate(fd, page_size);
 	memset(mem, PATTERN, page_size);
 
 	if (write(pipefd[1], &mem, sizeof(mem)) < 0) {
@@ -258,7 +297,7 @@ static void prepare(void)
 				   strerror(errno));
 }
 
-#define NUM_TESTS 4
+#define NUM_TESTS 6
 
 int main(int argc, char *argv[])
 {
@@ -277,9 +316,17 @@ int main(int argc, char *argv[])
 			ksft_exit_fail_msg("memfd_secret failed: %s\n",
 					   strerror(errno));
 	}
+	if (ftruncate(fd, page_size))
+		ksft_exit_fail_msg("ftruncate failed: %s\n", strerror(errno));
 
 	test_mlock_limit(fd);
 	test_file_apis(fd);
+	/*
+	 * We have to run the first vmsplice test before any secretmem page was
+	 * allocated for this fd.
+	 */
+	test_vmsplice(fd, "fresh page");
+	test_vmsplice(fd, "existing page");
 	test_process_vm_read(fd);
 	test_ptrace(fd);
 
-- 
2.43.2


