Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF548806C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377536AbjLFKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377535AbjLFKhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:37:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FBF10C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:37:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db547281f5dso5863039276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859034; x=1702463834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKRfVsFKiKRj/bBn07n7V+AeCZxk2uFtLWEya65cVnY=;
        b=zBQBfwnHtcx5m8jWIsNFi9gWXWZZafzWxmgrDnoXDTda1D5dLBs6Vq+FL2x5AFYUG/
         sJ9N+0mLnY/PrqbirTDho4b//fsqB7nMb9k15+YsW50d7oOYEKweUtuXgIrVzewLqq7C
         gQAYxf/ZEm83/GSFxNhOXYv0oifNis7DHaWLDTRE4b8a7rSOP/sDa5PijcUWHgO4IJv+
         B1VF8A0iLeLm0Vbhp+ZRhWg1vDpLZ6OpL7/RZcgQhmSNagkmxCr30/21B7MSgWLAH3u4
         GoPrqyRbcZcggOUznqhoAUhaSfvOpzWVYEQOf5OZGTagywm0xgI8TQilisd/ldSp/AC1
         lzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859034; x=1702463834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKRfVsFKiKRj/bBn07n7V+AeCZxk2uFtLWEya65cVnY=;
        b=G424r7T2YPrdS9LX1aHnr04P1I3MXCUqTYxjZgyo6H1uAimWrQ/gcNVXB9ZEtfnyLY
         5rShcu8aLNVTu21b8LDDAQxjFc8g0EFzudDk+l3KY9q8ElNkOBwA7NQk1QRUtDHiwSzy
         o78XSGOrOlj7ARZGTUdZ6PKA0yB1df1K1gduVPHCDUDT1qPDuJHBOFktalob50P8ymtX
         3UKN2ihPlwLHnU8Sxdusv/vTC5zZptfHGUj10jUnwjMItJzp/q91fhl7S0uuRlADzRN+
         VxHneLCVJia0s2fp1q7e1GYr7hCX+WJ/KLr7iexVdzfx++tSPJEU2hMfuoACOkarfuZ5
         O6aA==
X-Gm-Message-State: AOJu0YxWzU1GrgUik0NVMBP7iqrAV/7N1bhCVtJAgkB4x4QJKVe7vX27
        0paVIeKtygOdPuK7AegBAk8bRhzFLkg=
X-Google-Smtp-Source: AGHT+IHftIhmpWTuhBJ4KgQdy7Iz+ajmipBw3xyDTOe9qFzmSjg8LtWMwYZC/utheufnhCJo9BaLVXYt0+s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:d095:0:b0:db5:4766:e365 with SMTP id
 h143-20020a25d095000000b00db54766e365mr5227ybg.8.1701859034586; Wed, 06 Dec
 2023 02:37:14 -0800 (PST)
Date:   Wed,  6 Dec 2023 02:36:58 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-5-surenb@google.com>
Subject: [PATCH v6 4/5] selftests/mm: add uffd_test_case_ops to allow test
 case-specific operations
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, ryan.roberts@arm.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently each test can specify unique operations using uffd_test_ops,
however these operations are per-memory type and not per-test. Add
uffd_test_case_ops which each test case can customize for its own needs
regardless of the memory type being used. Pre- and post-allocation
operations are added, some of which will be used in the next patch to
implement test-specific operations like madvise after memory is allocated
but before it is accessed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 13 +++++++++++++
 tools/testing/selftests/mm/uffd-common.h     |  7 +++++++
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 583e5a4cc0fd..fb3bbc77fd00 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,6 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
+uffd_test_case_ops_t *uffd_test_case_ops;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -298,6 +299,12 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	unsigned long nr, cpu;
 	int ret;
 
+	if (uffd_test_case_ops && uffd_test_case_ops->pre_alloc) {
+		ret = uffd_test_case_ops->pre_alloc(errmsg);
+		if (ret)
+			return ret;
+	}
+
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
 	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
 	if (ret) {
@@ -306,6 +313,12 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 		return ret;
 	}
 
+	if (uffd_test_case_ops && uffd_test_case_ops->post_alloc) {
+		ret = uffd_test_case_ops->post_alloc(errmsg);
+		if (ret)
+			return ret;
+	}
+
 	ret = userfaultfd_open(&features);
 	if (ret) {
 		if (errmsg)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 870776b5a323..774595ee629e 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -90,6 +90,12 @@ struct uffd_test_ops {
 };
 typedef struct uffd_test_ops uffd_test_ops_t;
 
+struct uffd_test_case_ops {
+	int (*pre_alloc)(const char **errmsg);
+	int (*post_alloc)(const char **errmsg);
+};
+typedef struct uffd_test_case_ops uffd_test_case_ops_t;
+
 extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
@@ -102,6 +108,7 @@ extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
 extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
+extern uffd_test_case_ops_t *uffd_test_case_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index e7d43c198041..debc423bdbf4 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -78,6 +78,7 @@ typedef struct {
 	uffd_test_fn uffd_fn;
 	unsigned int mem_targets;
 	uint64_t uffd_feature_required;
+	uffd_test_case_ops_t *test_case_ops;
 } uffd_test_case_t;
 
 static void uffd_test_report(void)
@@ -185,6 +186,7 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
 {
 	map_shared = mem_type->shared;
 	uffd_test_ops = mem_type->mem_ops;
+	uffd_test_case_ops = test->test_case_ops;
 
 	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
 		page_size = default_huge_page_size();
-- 
2.43.0.rc2.451.g8631bc7472-goog

