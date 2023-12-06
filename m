Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08872806C35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377471AbjLFKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377570AbjLFKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:37:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA810EB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:37:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db401df7735so6088264276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859037; x=1702463837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVIa5cg328sO4f63WvwXvkSZbx/mUmzDkh+gAL5+Ahc=;
        b=J3zB7IfaNdCJnb/481Bb+YzU5Ah6AMBuAJidOqRQU9cgrF1R4FaR8tCPnCnIBtVdQE
         IperrvS0vn5GxHC/qu0wNV2RFYis5gEx3Do6+ZOnAratB1lR6bLxREjKUU1bMXre6c1x
         M6Z/DnIL7NPRg+c2g0wdFT5LGzKFmI8Mw03xEZJE9BZgd9FPPdQSiBOPCF/HY3TwF9xk
         yPAqabrheVyubUf258wNB/NABUqcBxxNtDrauN/2deBRu5HSTJPaH7Pj2cmYdKHsBtR3
         6Nm8HDys4X5KhLfOAx1+B0jIwjOHy+FwMQBsECaCPXAe5JZKehLOFi7iy8/MTsPaQeqj
         FnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859037; x=1702463837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVIa5cg328sO4f63WvwXvkSZbx/mUmzDkh+gAL5+Ahc=;
        b=NT2gaTJ8KKFeeilh/o62WyDSV91daoTAQulx4iiG7gp0593Ua6oF+l4uMwzygNFm9D
         rNtVPSolcZ5EcSZgSi/yU7I2tl6O4edSegtZKpkIPffcsF6Knl5qC8zGk9Y0AAeeBJVz
         fO4PBBM9a/ipG9rxJcw9RWEnJoqS16XwX1gWTYdfX6/EOSfW6bdKh2fJ/XH0+RLLcG3p
         mWqKW4CGEcA2rjL9N1sd4b/z2hMJCmaPzDl8rCu02b9H2kvlva8lOJXhEqqmkyDd4hdx
         QMBG9UdOBlcUuSSLh7xz6N5bTprqUaxXzSQ1PfmyBAPZkBvAiLD6+gAgNPd99JNE5FIG
         JN1w==
X-Gm-Message-State: AOJu0YziRUso9p862tsHcAighNs9Ur9RlKvutEsQ6EWmCbYVcjFK+bJB
        f41iB76bS5l80AtUmaNqUZPkD5rndjM=
X-Google-Smtp-Source: AGHT+IGkgKbxoygTMvEFVetsgh/4I8+posq2zTqpEUJ0xsC7qcK0racQMhZFneM9yrLm1+Uko2/h58wIowE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:e097:0:b0:db3:fa34:50b0 with SMTP id
 x145-20020a25e097000000b00db3fa3450b0mr4837ybg.4.1701859036922; Wed, 06 Dec
 2023 02:37:16 -0800 (PST)
Date:   Wed,  6 Dec 2023 02:36:59 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-6-surenb@google.com>
Subject: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
into destination buffer while checking the contents of both after
the move. After the operation the content of the destination buffer
should match the original source buffer's content while the source
buffer should be zeroed. Separate tests are designed for PMD aligned and
unaligned cases because they utilize different code paths in the kernel.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  24 +++
 tools/testing/selftests/mm/uffd-common.h     |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index fb3bbc77fd00..b0ac0ec2356d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 	return __copy_page(ufd, offset, false, wp);
 }
 
+int move_page(int ufd, unsigned long offset, unsigned long len)
+{
+	struct uffdio_move uffdio_move;
+
+	if (offset + len > nr_pages * page_size)
+		err("unexpected offset %lu and length %lu\n", offset, len);
+	uffdio_move.dst = (unsigned long) area_dst + offset;
+	uffdio_move.src = (unsigned long) area_src + offset;
+	uffdio_move.len = len;
+	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
+	uffdio_move.move = 0;
+	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
+		/* real retval in uffdio_move.move */
+		if (uffdio_move.move != -EEXIST)
+			err("UFFDIO_MOVE error: %"PRId64,
+			    (int64_t)uffdio_move.move);
+		wake_range(ufd, uffdio_move.dst, len);
+	} else if (uffdio_move.move != len) {
+		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
+	} else
+		return 1;
+	return 0;
+}
+
 int uffd_open_dev(unsigned int flags)
 {
 	int fd, uffd;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 774595ee629e..cb055282c89c 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -119,6 +119,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
+int move_page(int ufd, unsigned long offset, unsigned long len);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index debc423bdbf4..d8091523c2df 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -23,6 +23,9 @@
 #define  MEM_ALL  (MEM_ANON | MEM_SHMEM | MEM_SHMEM_PRIVATE | \
 		   MEM_HUGETLB | MEM_HUGETLB_PRIVATE)
 
+#define ALIGN_UP(x, align_to) \
+	((__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((align_to)-1)))
+
 struct mem_type {
 	const char *name;
 	unsigned int mem_flag;
@@ -1064,6 +1067,178 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	uffd_test_pass();
 }
 
+static void
+uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
+			      unsigned long len)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
+
+	if (msg->arg.pagefault.flags &
+	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
+		err("unexpected fault type %llu", msg->arg.pagefault.flags);
+
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset &= ~(len-1);
+
+	if (move_page(uffd, offset, len))
+		args->missing_faults++;
+}
+
+static void uffd_move_handle_fault(struct uffd_msg *msg,
+				   struct uffd_args *args)
+{
+	uffd_move_handle_fault_common(msg, args, page_size);
+}
+
+static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
+				       struct uffd_args *args)
+{
+	uffd_move_handle_fault_common(msg, args, read_pmd_pagesize());
+}
+
+static void
+uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
+		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
+{
+	unsigned long nr;
+	pthread_t uffd_mon;
+	char c;
+	unsigned long long count;
+	struct uffd_args args = { 0 };
+	char *orig_area_src, *orig_area_dst;
+	unsigned long step_size, step_count;
+	unsigned long src_offs = 0;
+	unsigned long dst_offs = 0;
+
+	/* Prevent source pages from being mapped more than once */
+	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
+		err("madvise(MADV_DONTFORK) failure");
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, false, false))
+		err("register failure");
+
+	args.handle_fault = handle_fault;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	step_size = chunk_size / page_size;
+	step_count = nr_pages / step_size;
+
+	if (chunk_size > page_size) {
+		char *aligned_src = ALIGN_UP(area_src, chunk_size);
+		char *aligned_dst = ALIGN_UP(area_dst, chunk_size);
+
+		if (aligned_src != area_src || aligned_dst != area_dst) {
+			src_offs = (aligned_src - area_src) / page_size;
+			dst_offs = (aligned_dst - area_dst) / page_size;
+			step_count--;
+		}
+		orig_area_src = area_src;
+		orig_area_dst = area_dst;
+		area_src = aligned_src;
+		area_dst = aligned_dst;
+	}
+
+	/*
+	 * Read each of the pages back using the UFFD-registered mapping. We
+	 * expect that the first time we touch a page, it will result in a missing
+	 * fault. uffd_poll_thread will resolve the fault by moving source
+	 * page to destination.
+	 */
+	for (nr = 0; nr < step_count * step_size; nr += step_size) {
+		unsigned long i;
+
+		/* Check area_src content */
+		for (i = 0; i < step_size; i++) {
+			count = *area_count(area_src, nr + i);
+			if (count != count_verify[src_offs + nr + i])
+				err("nr %lu source memory invalid %llu %llu\n",
+				    nr + i, count, count_verify[src_offs + nr + i]);
+		}
+
+		/* Faulting into area_dst should move the page or the huge page */
+		for (i = 0; i < step_size; i++) {
+			count = *area_count(area_dst, nr + i);
+			if (count != count_verify[dst_offs + nr + i])
+				err("nr %lu memory corruption %llu %llu\n",
+				    nr, count, count_verify[dst_offs + nr + i]);
+		}
+
+		/* Re-check area_src content which should be empty */
+		for (i = 0; i < step_size; i++) {
+			count = *area_count(area_src, nr + i);
+			if (count != 0)
+				err("nr %lu move failed %llu %llu\n",
+				    nr, count, count_verify[src_offs + nr + i]);
+		}
+	}
+	if (step_size > page_size) {
+		area_src = orig_area_src;
+		area_dst = orig_area_dst;
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("join() failed");
+
+	if (args.missing_faults != step_count || args.minor_faults != 0)
+		uffd_test_fail("stats check error");
+	else
+		uffd_test_pass();
+}
+
+static void uffd_move_test(uffd_test_args_t *targs)
+{
+	uffd_move_test_common(targs, page_size, uffd_move_handle_fault);
+}
+
+static void uffd_move_pmd_test(uffd_test_args_t *targs)
+{
+	uffd_move_test_common(targs, read_pmd_pagesize(),
+			      uffd_move_pmd_handle_fault);
+}
+
+static int prevent_hugepages(const char **errmsg)
+{
+	/* This should be done before source area is populated */
+	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
+		/* Ignore only if CONFIG_TRANSPARENT_HUGEPAGE=n */
+		if (errno != EINVAL) {
+			if (errmsg)
+				*errmsg = "madvise(MADV_NOHUGEPAGE) failed";
+			return -errno;
+		}
+	}
+	return 0;
+}
+
+static int request_hugepages(const char **errmsg)
+{
+	/* This should be done before source area is populated */
+	if (madvise(area_src, nr_pages * page_size, MADV_HUGEPAGE)) {
+		if (errmsg) {
+			*errmsg = (errno == EINVAL) ?
+				"CONFIG_TRANSPARENT_HUGEPAGE is not set" :
+				"madvise(MADV_HUGEPAGE) failed";
+		}
+		return -errno;
+	}
+	return 0;
+}
+
+struct uffd_test_case_ops uffd_move_test_case_ops = {
+	.post_alloc = prevent_hugepages,
+};
+
+struct uffd_test_case_ops uffd_move_test_pmd_case_ops = {
+	.post_alloc = request_hugepages,
+};
+
 /*
  * Test the returned uffdio_register.ioctls with different register modes.
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
@@ -1141,6 +1316,20 @@ uffd_test_case_t uffd_tests[] = {
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = 0,
 	},
+	{
+		.name = "move",
+		.uffd_fn = uffd_move_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_case_ops,
+	},
+	{
+		.name = "move-pmd",
+		.uffd_fn = uffd_move_pmd_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_pmd_case_ops,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.43.0.rc2.451.g8631bc7472-goog

