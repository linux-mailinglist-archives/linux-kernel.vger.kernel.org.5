Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD375151B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjGMATD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjGMASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:18:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A41995
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26314c2bdb8so18056a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689207523; x=1691799523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmSXGhNgjtW0Yb8+yIyK70NmvAjyR1vjV+RIYl0ULq4=;
        b=FlZRL9jUxJFKgY4MqDtKMkc0rMg/7jFvumz8fttZ1mweOBBWCGzvC8lc/FCQJuLkTZ
         A3qVeyiodQbUroyDwmQMCZw9jh+ovjD2C6URvGmE5mQg2qAG3rIFa3u5O3utY9wqWDdh
         y2yPK+CMKrOvd+Vf4PsWNx1mpzo4cScAJX/G/GmXtN3BrOtfw2lROeQROcur5BX+u/nI
         HMmRA4ujFCbKxeSV9RFjI91KjjN5dVl+5reqgQrM5L+aNYcjlbm1Kknrzn4l69z7WPtO
         K7sCo37UfV1f9414ZzedguXvQ6M3kjBSF+jGOr6vSzlnQwTqTeW0uoCbjObPBWxUQGY6
         wV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689207523; x=1691799523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmSXGhNgjtW0Yb8+yIyK70NmvAjyR1vjV+RIYl0ULq4=;
        b=LjloJDnhf/K40R7EsH1/H92xVYkQYi8IMOpQ/m3fVn6FvA2VOLgS3OD24UOYDG49Cw
         bdiVWt61f9kmCvOUUdT6Oho6ul+nlQzL2H5yhixy8FrTncINC+FnGt2TFychvuqETn4L
         P/SSN5IugNfvWDVtZt29Bv/+nLhyB5dST7NhtikIb6s/ZK5vM/SMVYsmO/FH9te+g3lN
         K27mt3JUZfbsX7lgEyuUbdn0Le72vEPTuZZBU7gBuouEZT75Zf9jpqRphtmRA+JCcO+v
         aKyOgmhmaGqgsTfBnrQxeDZ7Td/35hyMMdKJe2BWzIryEkWHoX2wN08xCSt+NtYJjyOX
         YHAQ==
X-Gm-Message-State: ABy/qLYmYXYajMSzscmfpAZBqk0nurixKXi4tB6E51NVWG8xWJW+1TS4
        dxVTTwsC4Rz8GVk5kbszBUoZTPNwamRJBw==
X-Google-Smtp-Source: APBJJlG1yocyNKvw7nuw2+n9bzHNP/TDAk4jjb7zrKQsqMxgJBPSYO7jxfm4d0oFBf2YofHbmBKExQhGGJ0LSw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:d50f:b0:1b8:a555:385d with SMTP
 id b15-20020a170902d50f00b001b8a555385dmr624plg.9.1689207523281; Wed, 12 Jul
 2023 17:18:43 -0700 (PDT)
Date:   Thu, 13 Jul 2023 00:18:33 +0000
In-Reply-To: <20230713001833.3778937-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230713001833.3778937-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713001833.3778937-5-jiaqiyan@google.com>
Subject: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs read
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     linmiaohe@huawei.com, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jthoughton@google.com,
        Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for the improvement made to read operation on HWPOISON
hugetlb page with different read granularities. For each chunk size,
three read scenarios are tested:
1. Simple regression test on read without HWPOISON.
2. Sequential read page by page should succeed until encounters the 1st
   raw HWPOISON subpage.
3. After skip a raw HWPOISON subpage by lseek, read()s always succeed.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 7e2a982383c0..cdc9ce4426b9 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -5,6 +5,7 @@ hugepage-mremap
 hugepage-shm
 hugepage-vmemmap
 hugetlb-madvise
+hugetlb-read-hwpoison
 khugepaged
 map_hugetlb
 map_populate
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 66d7c07dc177..b7fce9073279 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -41,6 +41,7 @@ TEST_GEN_PROGS += gup_longterm
 TEST_GEN_PROGS += gup_test
 TEST_GEN_PROGS += hmm-tests
 TEST_GEN_PROGS += hugetlb-madvise
+TEST_GEN_PROGS += hugetlb-read-hwpoison
 TEST_GEN_PROGS += hugepage-mmap
 TEST_GEN_PROGS += hugepage-mremap
 TEST_GEN_PROGS += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
new file mode 100644
index 000000000000..ba6cc6f9cabc
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <linux/magic.h>
+#include <sys/mman.h>
+#include <sys/statfs.h>
+#include <errno.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+
+#define PREFIX " ... "
+#define ERROR_PREFIX " !!! "
+
+#define MAX_WRITE_READ_CHUNK_SIZE (getpagesize() * 16)
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
+
+enum test_status {
+	TEST_PASSED = 0,
+	TEST_FAILED = 1,
+	TEST_SKIPPED = 2,
+};
+
+static char *status_to_str(enum test_status status)
+{
+	switch (status) {
+	case TEST_PASSED:
+		return "TEST_PASSED";
+	case TEST_FAILED:
+		return "TEST_FAILED";
+	case TEST_SKIPPED:
+		return "TEST_SKIPPED";
+	default:
+		return "TEST_???";
+	}
+}
+
+static int setup_filemap(char *filemap, size_t len, size_t wr_chunk_size)
+{
+	char iter = 0;
+
+	for (size_t offset = 0; offset < len;
+	     offset += wr_chunk_size) {
+		iter++;
+		memset(filemap + offset, iter, wr_chunk_size);
+	}
+
+	return 0;
+}
+
+static bool verify_chunk(char *buf, size_t len, char val)
+{
+	size_t i;
+
+	for (i = 0; i < len; ++i) {
+		if (buf[i] != val) {
+			printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
+				i, buf[i], val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
+				       off_t offset, size_t expected)
+{
+	char buf[MAX_WRITE_READ_CHUNK_SIZE];
+	ssize_t ret_count = 0;
+	ssize_t total_ret_count = 0;
+	char val = offset / wr_chunk_size + offset % wr_chunk_size;
+
+	printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
+	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
+	       expected);
+	if (lseek(fd, offset, SEEK_SET) < 0) {
+		perror(PREFIX ERROR_PREFIX "seek failed");
+		return false;
+	}
+
+	while (offset + total_ret_count < len) {
+		ret_count = read(fd, buf, wr_chunk_size);
+		if (ret_count == 0) {
+			printf(PREFIX PREFIX "read reach end of the file\n");
+			break;
+		} else if (ret_count < 0) {
+			perror(PREFIX ERROR_PREFIX "read failed");
+			break;
+		}
+		++val;
+		if (!verify_chunk(buf, ret_count, val))
+			return false;
+
+		total_ret_count += ret_count;
+	}
+	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
+	       total_ret_count);
+
+	return total_ret_count == expected;
+}
+
+static bool read_hugepage_filemap(int fd, size_t len,
+				  size_t wr_chunk_size, size_t expected)
+{
+	char buf[MAX_WRITE_READ_CHUNK_SIZE];
+	ssize_t ret_count = 0;
+	ssize_t total_ret_count = 0;
+	char val = 0;
+
+	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
+	       expected);
+	while (total_ret_count < len) {
+		ret_count = read(fd, buf, wr_chunk_size);
+		if (ret_count == 0) {
+			printf(PREFIX PREFIX "read reach end of the file\n");
+			break;
+		} else if (ret_count < 0) {
+			perror(PREFIX ERROR_PREFIX "read failed");
+			break;
+		}
+		++val;
+		if (!verify_chunk(buf, ret_count, val))
+			return false;
+
+		total_ret_count += ret_count;
+	}
+	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
+	       total_ret_count);
+
+	return total_ret_count == expected;
+}
+
+static enum test_status
+test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
+{
+	enum test_status status = TEST_SKIPPED;
+	char *filemap = NULL;
+
+	if (ftruncate(fd, len) < 0) {
+		perror(PREFIX ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
+		goto done;
+	}
+
+	setup_filemap(filemap, len, wr_chunk_size);
+	status = TEST_FAILED;
+
+	if (read_hugepage_filemap(fd, len, wr_chunk_size, len))
+		status = TEST_PASSED;
+
+	munmap(filemap, len);
+done:
+	if (ftruncate(fd, 0) < 0) {
+		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
+		status = TEST_FAILED;
+	}
+
+	return status;
+}
+
+static enum test_status
+test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
+			   bool skip_hwpoison_page)
+{
+	enum test_status status = TEST_SKIPPED;
+	char *filemap = NULL;
+	char *hwp_addr = NULL;
+	const unsigned long pagesize = getpagesize();
+
+	if (ftruncate(fd, len) < 0) {
+		perror(PREFIX ERROR_PREFIX "ftruncate failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
+		goto done;
+	}
+
+	setup_filemap(filemap, len, wr_chunk_size);
+	status = TEST_FAILED;
+
+	/*
+	 * Poisoned hugetlb page layout (assume hugepagesize=2MB):
+	 * |<---------------------- 1MB ---------------------->|
+	 * |<---- healthy page ---->|<---- HWPOISON page ----->|
+	 * |<------------------- (1MB - 8KB) ----------------->|
+	 */
+	hwp_addr = filemap + len / 2 + pagesize;
+	if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
+		perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
+		goto unmap;
+	}
+
+	if (!skip_hwpoison_page) {
+		/*
+		 * Userspace should be able to read (1MB + 1 page) from
+		 * the beginning of the HWPOISONed hugepage.
+		 */
+		if (read_hugepage_filemap(fd, len, wr_chunk_size,
+					  len / 2 + pagesize))
+			status = TEST_PASSED;
+	} else {
+		/*
+		 * Userspace should be able to read (1MB - 2 pages) from
+		 * HWPOISONed hugepage.
+		 */
+		if (seek_read_hugepage_filemap(fd, len, wr_chunk_size,
+					       len / 2 + MAX(2 * pagesize, wr_chunk_size),
+					       len / 2 - MAX(2 * pagesize, wr_chunk_size)))
+			status = TEST_PASSED;
+	}
+
+unmap:
+	munmap(filemap, len);
+done:
+	if (ftruncate(fd, 0) < 0) {
+		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
+		status = TEST_FAILED;
+	}
+
+	return status;
+}
+
+static int create_hugetlbfs_file(struct statfs *file_stat)
+{
+	int fd;
+
+	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
+	if (fd < 0) {
+		perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(file_stat, 0, sizeof(*file_stat));
+	if (fstatfs(fd, file_stat)) {
+		perror(PREFIX ERROR_PREFIX "fstatfs failed");
+		goto close;
+	}
+	if (file_stat->f_type != HUGETLBFS_MAGIC) {
+		printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
+		goto close;
+	}
+
+	return fd;
+close:
+	close(fd);
+	return -1;
+}
+
+int main(void)
+{
+	int fd;
+	struct statfs file_stat;
+	enum test_status status;
+	/* Test read() in different granularity. */
+	size_t wr_chunk_sizes[] = {
+		getpagesize() / 2, getpagesize(),
+		getpagesize() * 2, getpagesize() * 4
+	};
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
+		printf("Write/read chunk size=0x%lx\n",
+		       wr_chunk_sizes[i]);
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf(PREFIX "HugeTLB read regression test...\n");
+		status = test_hugetlb_read(fd, file_stat.f_bsize,
+					   wr_chunk_sizes[i]);
+		printf(PREFIX "HugeTLB read regression test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf(PREFIX "HugeTLB read HWPOISON test...\n");
+		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
+						    wr_chunk_sizes[i], false);
+		printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+
+		fd = create_hugetlbfs_file(&file_stat);
+		if (fd < 0)
+			goto create_failure;
+		printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
+		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
+						    wr_chunk_sizes[i], true);
+		printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
+		       status_to_str(status));
+		close(fd);
+		if (status == TEST_FAILED)
+			return -1;
+	}
+
+	return 0;
+
+create_failure:
+	printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
+	return -1;
+}
-- 
2.41.0.255.g8b1d071c50-goog

