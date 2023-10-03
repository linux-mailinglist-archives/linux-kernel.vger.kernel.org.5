Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7877B5E11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbjJCASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjJCASh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:18:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C39DA;
        Mon,  2 Oct 2023 17:18:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-69335ddbe16so261911b3a.1;
        Mon, 02 Oct 2023 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292313; x=1696897113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY+Soyh4ezPzEsiTwAjxm3PLfRjJVUJ94CEs1TUSu9g=;
        b=V3+PbgEfFnAr52I7PpoeIqr0Ry7LZ6xSN+LPjKrdDoKxGP9PJIgekDO6559m187SUw
         D+vf9OD+MSYrkfmU2WjrWQAfeA3yCyCIip7Yyxjdp/VVBOJN6HQvcaLB6586YAzycIoN
         Xl8+Qi4Ajf95reQ8W6EcG6Nq66fZkW4MXyHYwUO77d0XYZvgwM33/s+ThUG5KiM6g7Oh
         o8o5cfAKvCQxHAX91ZBXvnrZOYl+dvIvN8938P/OL06921OOEzq9VzvgWJxMYm/wddT7
         sVRf2AeFdHpClGrQs10CsUeQPMn4IUkAINzSXh5r2YofmyGnb6BnSlo5fx4zIlRJAKLA
         NEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292313; x=1696897113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vY+Soyh4ezPzEsiTwAjxm3PLfRjJVUJ94CEs1TUSu9g=;
        b=CMm0iQBW/fvMb2RbTLpcobtGcgu1tmUijmUzc1OXTJLxB8gvLb0JkfzSSaZbr8mEVW
         yOtG5OCTCFi7CZKsow0iXsMvfidGakGXFH/PFVjjHRI5OyJ/VcGH0QEWYsVlVJreoAwF
         Bq0xEGbBRbpeP6KR5+L6QxSC0W8kuL26QFy8tZtMX3EQuRt6sF5EBrYPopLOAaWF1Awy
         kVy/S0AAUmyOus/h/6vWSdf688d23OZSHwIysws4WoZUZHwLCkL3kr0/+P4Il/h8hNSI
         t/VJ/cVkIj9zFY/bLJgsLLl6o/UFMt1AVBkm3PrmNYA62ll7Ub13hpIsQ5y5yZ/NMCOs
         Uhpg==
X-Gm-Message-State: AOJu0YxQfg+bkTmpbmECuQXB7g1DQ44A0vBNi8vlMvT/gwyRdj6Jhiuj
        dk8WO1YR3dtJjo9uYMNV1fQ=
X-Google-Smtp-Source: AGHT+IEmhPXWxliXuOtMzjnYVzhxuPmmze2DXVfJcRKH51ghReKXZNZYRTeU37cNrXhyi0RIQd0ChA==
X-Received: by 2002:a05:6a20:258d:b0:161:27c5:9c41 with SMTP id k13-20020a056a20258d00b0016127c59c41mr12322478pzd.28.1696292313120;
        Mon, 02 Oct 2023 17:18:33 -0700 (PDT)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b0068fda1db80bsm84015pfo.75.2023.10.02.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:18:32 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 3/3] selftests: add a selftest to verify hugetlb usage in memcg
Date:   Mon,  2 Oct 2023 17:18:28 -0700
Message-Id: <20231003001828.2554080-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003001828.2554080-1-nphamcs@gmail.com>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a new kselftest to demonstrate and verify the new
hugetlb memcg accounting behavior.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_hugetlb_memcg.c     | 234 ++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..ce9f40bcc2ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5269,6 +5269,7 @@ S:	Maintained
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
 F:	tools/testing/selftests/cgroup/memcg_protection.m
+F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c
 
@@ -9652,6 +9653,7 @@ F:	include/linux/hugetlb.h
 F:	mm/hugetlb.c
 F:	mm/hugetlb_vmemmap.c
 F:	mm/hugetlb_vmemmap.h
+F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 
 HVA ST MEDIA DRIVER
 M:	Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index af8c3f30b9c1..2732e0b29271 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -7,4 +7,5 @@ test_kill
 test_cpu
 test_cpuset
 test_zswap
+test_hugetlb_memcg
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index c27f05f6ce9b..00b441928909 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_cpu
 TEST_GEN_PROGS += test_cpuset
 TEST_GEN_PROGS += test_zswap
+TEST_GEN_PROGS += test_hugetlb_memcg
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
@@ -27,3 +28,4 @@ $(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_cpu: cgroup_util.c
 $(OUTPUT)/test_cpuset: cgroup_util.c
 $(OUTPUT)/test_zswap: cgroup_util.c
+$(OUTPUT)/test_hugetlb_memcg: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
new file mode 100644
index 000000000000..f0fefeb4cc24
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <linux/limits.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+#define ADDR ((void *)(0x0UL))
+#define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
+/* mapping 8 MBs == 4 hugepages */
+#define LENGTH (8UL*1024*1024)
+#define PROTECTION (PROT_READ | PROT_WRITE)
+
+/* borrowed from mm/hmm-tests.c */
+static long get_hugepage_size(void)
+{
+	int fd;
+	char buf[2048];
+	int len;
+	char *p, *q, *path = "/proc/meminfo", *tag = "Hugepagesize:";
+	long val;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		/* Error opening the file */
+		return -1;
+	}
+
+	len = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (len < 0) {
+		/* Error in reading the file */
+		return -1;
+	}
+	if (len == sizeof(buf)) {
+		/* Error file is too large */
+		return -1;
+	}
+	buf[len] = '\0';
+
+	/* Search for a tag if provided */
+	if (tag) {
+		p = strstr(buf, tag);
+		if (!p)
+			return -1; /* looks like the line we want isn't there */
+		p += strlen(tag);
+	} else
+		p = buf;
+
+	val = strtol(p, &q, 0);
+	if (*q != ' ') {
+		/* Error parsing the file */
+		return -1;
+	}
+
+	return val;
+}
+
+static int set_file(const char *path, long value)
+{
+	FILE *file;
+	int ret;
+
+	file = fopen(path, "w");
+	if (!file)
+		return -1;
+	ret = fprintf(file, "%ld\n", value);
+	fclose(file);
+	return ret;
+}
+
+static int set_nr_hugepages(long value)
+{
+	return set_file("/proc/sys/vm/nr_hugepages", value);
+}
+
+static unsigned int check_first(char *addr)
+{
+	return *(unsigned int *)addr;
+}
+
+static void write_data(char *addr)
+{
+	unsigned long i;
+
+	for (i = 0; i < LENGTH; i++)
+		*(addr + i) = (char)i;
+}
+
+static int hugetlb_test_program(const char *cgroup, void *arg)
+{
+	char *test_group = (char *)arg;
+	void *addr;
+	long old_current, expected_current, current;
+	int ret = EXIT_FAILURE;
+
+	old_current = cg_read_long(test_group, "memory.current");
+	set_nr_hugepages(20);
+	current = cg_read_long(test_group, "memory.current");
+	if (current - old_current >= MB(2)) {
+		ksft_print_msg(
+			"setting nr_hugepages should not increase hugepage usage.\n");
+		ksft_print_msg("before: %ld, after: %ld\n", old_current, current);
+		return EXIT_FAILURE;
+	}
+
+	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, 0, 0);
+	if (addr == MAP_FAILED) {
+		ksft_print_msg("fail to mmap.\n");
+		return EXIT_FAILURE;
+	}
+	current = cg_read_long(test_group, "memory.current");
+	if (current - old_current >= MB(2)) {
+		ksft_print_msg("mmap should not increase hugepage usage.\n");
+		ksft_print_msg("before: %ld, after: %ld\n", old_current, current);
+		goto out_failed_munmap;
+	}
+	old_current = current;
+
+	/* read the first page */
+	check_first(addr);
+	expected_current = old_current + MB(2);
+	current = cg_read_long(test_group, "memory.current");
+	if (!values_close(expected_current, current, 5)) {
+		ksft_print_msg("memory usage should increase by around 2MB.\n");
+		ksft_print_msg(
+			"expected memory: %ld, actual memory: %ld\n",
+			expected_current, current);
+		goto out_failed_munmap;
+	}
+
+	/* write to the whole range */
+	write_data(addr);
+	current = cg_read_long(test_group, "memory.current");
+	expected_current = old_current + MB(8);
+	if (!values_close(expected_current, current, 5)) {
+		ksft_print_msg("memory usage should increase by around 8MB.\n");
+		ksft_print_msg(
+			"expected memory: %ld, actual memory: %ld\n",
+			expected_current, current);
+		goto out_failed_munmap;
+	}
+
+	/* unmap the whole range */
+	munmap(addr, LENGTH);
+	current = cg_read_long(test_group, "memory.current");
+	expected_current = old_current;
+	if (!values_close(expected_current, current, 5)) {
+		ksft_print_msg("memory usage should go back down.\n");
+		ksft_print_msg(
+			"expected memory: %ld, actual memory: %ld\n",
+			expected_current, current);
+		return ret;
+	}
+
+	ret = EXIT_SUCCESS;
+	return ret;
+
+out_failed_munmap:
+	munmap(addr, LENGTH);
+	return ret;
+}
+
+static int test_hugetlb_memcg(char *root)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+
+	test_group = cg_name(root, "hugetlb_memcg_test");
+	if (!test_group || cg_create(test_group)) {
+		ksft_print_msg("fail to create cgroup.\n");
+		goto out;
+	}
+
+	if (cg_write(test_group, "memory.max", "100M")) {
+		ksft_print_msg("fail to set cgroup memory limit.\n");
+		goto out;
+	}
+
+	/* disable swap */
+	if (cg_write(test_group, "memory.swap.max", "0")) {
+		ksft_print_msg("fail to disable swap.\n");
+		goto out;
+	}
+
+	if (!cg_run(test_group, hugetlb_test_program, (void *)test_group))
+		ret = KSFT_PASS;
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int ret = EXIT_SUCCESS, has_memory_hugetlb_acc;
+
+	has_memory_hugetlb_acc = proc_mount_contains("memory_hugetlb_accounting");
+	if (has_memory_hugetlb_acc < 0)
+		ksft_exit_skip("Failed to query cgroup mount option\n");
+	else if (!has_memory_hugetlb_acc)
+		ksft_exit_skip("memory hugetlb accounting is disabled\n");
+
+	/* Unit is kB! */
+	if (get_hugepage_size() != 2048) {
+		ksft_print_msg("test_hugetlb_memcg requires 2MB hugepages\n");
+		ksft_test_result_skip("test_hugetlb_memcg\n");
+		return ret;
+	}
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	switch (test_hugetlb_memcg(root)) {
+	case KSFT_PASS:
+		ksft_test_result_pass("test_hugetlb_memcg\n");
+		break;
+	case KSFT_SKIP:
+		ksft_test_result_skip("test_hugetlb_memcg\n");
+		break;
+	default:
+		ret = EXIT_FAILURE;
+		ksft_test_result_fail("test_hugetlb_memcg\n");
+		break;
+	}
+
+	return ret;
+}
-- 
2.34.1
