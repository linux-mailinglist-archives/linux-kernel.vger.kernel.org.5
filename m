Return-Path: <linux-kernel+bounces-117164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C888A81A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3ECA1C62B45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79A312F580;
	Mon, 25 Mar 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSZkONXR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1412F36E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374099; cv=none; b=saYcXHWbinDY+HvzYPdg9VtcM7cuianlD60crQRlVIBNxsGB3bs5/V9114lGm+mnCnRZJ0Bemx4sw3Yi7SoYjACbx/NuQmfHgS8G5QrfaJURChTJy0F/L4qN2OK+4p5UCO8iKSZP0PjKfNpInueFHkK8K69m6Z9b3WGDcPkJCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374099; c=relaxed/simple;
	bh=rZ16SU0IrCGHRKMpmlvaaUlMrrEbSltSWDadSv6s3XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGCXMkOLM2qqOeJhXRQbSyenNy7Q5VqZEYbtc4K3ZwqhKsdLE0bC8LVAX3OOA1rBm+RlVdFDsgQptlCaeDH3H4mi+dOrivGvI6vhOznPpZ3WFZR8XHUgYtBFOwDGFuuKI98LfvfgoCUpQdeq6ZJW6gy3QGS+J5i0xSSe/MzIObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSZkONXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711374097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpEPWSpCeTwbxNQN5JgorLS4hcdt0dP0Q44OLrNb3L4=;
	b=iSZkONXRerQZMTaJGM8WiKLxH/0EghWhtQl6tgElHySIQCM2p2IAxlOfAI3ielGGgf/3y4
	hUOmwDu8HyjJpf0u4H1CiDiEwEpbEegBofatjbj42GlBoO4kRBk5v6J/I+0nXdWAMM58Fa
	APWkkEaJhvwMTh00yT/yAyohqTuCd8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-TiJUf4AYOGuuhRDZm9FyBA-1; Mon,
 25 Mar 2024 09:41:31 -0400
X-MC-Unique: TiJUf4AYOGuuhRDZm9FyBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 696A73CBD4E7;
	Mon, 25 Mar 2024 13:41:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA692166B31;
	Mon, 25 Mar 2024 13:41:28 +0000 (UTC)
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
Subject: [PATCH v1 2/3] selftests/memfd_secret: add vmsplice() test
Date: Mon, 25 Mar 2024 14:41:13 +0100
Message-ID: <20240325134114.257544-3-david@redhat.com>
In-Reply-To: <20240325134114.257544-1-david@redhat.com>
References: <20240325134114.257544-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Let's add a simple reproducer for a scneario where GUP-fast could succeed
on secretmem folios, making vmsplice() succeed instead of failing. The
reproducer is based on a reproducer [1] by Miklos Szeredi.

Perform the ftruncate() only once, and check the return value.

For some reason, vmsplice() reliably fails (making the test succeed) when
we move the test_vmsplice() call after test_process_vm_read() /
test_ptrace(). Properly cleaning up in test_remote_access(), which is not
part of this change, won't change that behavior. Therefore, run the
vmsplice() test for now first -- something is a bit off once we involve
fork().

[1] https://lkml.kernel.org/r/CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/memfd_secret.c | 44 +++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9b298f6a04b3..0acbdcf8230e 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -20,6 +20,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
+#include <fcntl.h>
 
 #include "../kselftest.h"
 
@@ -83,6 +84,43 @@ static void test_mlock_limit(int fd)
 	pass("mlock limit is respected\n");
 }
 
+static void test_vmsplice(int fd)
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
+	ksft_test_result(transferred < 0 && errno == EFAULT,
+			 "vmsplice is blocked as expected\n");
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
@@ -187,7 +225,6 @@ static void test_remote_access(int fd, const char *name,
 		return;
 	}
 
-	ftruncate(fd, page_size);
 	memset(mem, PATTERN, page_size);
 
 	if (write(pipefd[1], &mem, sizeof(mem)) < 0) {
@@ -258,7 +295,7 @@ static void prepare(void)
 				   strerror(errno));
 }
 
-#define NUM_TESTS 4
+#define NUM_TESTS 5
 
 int main(int argc, char *argv[])
 {
@@ -277,9 +314,12 @@ int main(int argc, char *argv[])
 			ksft_exit_fail_msg("memfd_secret failed: %s\n",
 					   strerror(errno));
 	}
+	if (ftruncate(fd, page_size))
+		ksft_exit_fail_msg("ftruncate failed: %s\n", strerror(errno));
 
 	test_mlock_limit(fd);
 	test_file_apis(fd);
+	test_vmsplice(fd);
 	test_process_vm_read(fd);
 	test_ptrace(fd);
 
-- 
2.43.2


