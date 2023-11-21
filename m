Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC07F34CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjKURRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjKURRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:17:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A9D7D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0c6d62ec8so7366767276.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700587018; x=1701191818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+YU4xakrSZAEeiCshOnJPmfZHIUA9DyOQyL2tdclCw=;
        b=Dsmkh/EY7l8bRxXLJoQtnDkFMltAK4lvdf0MAe5uNJDCPQC8WJECgh7GrY6ZhdozAb
         om8oDKp0TmfN6w8njsl9/Ippvp7yD0DEWE4grUoUTnctHXWYudfdNLwe7SpSrGV+5m0s
         lkeo9ZZIhWnngX2I3WxDyQ7SNR5G2XE2/slptavmgssrAW/SfTXZwTig6CPXbBUQyXne
         tRh4sla5TOwkfXVZ/qA6Fvdq925zAFmWEiygcXXXs1vTMz9BqbIdR6esVob0Wqpz4cjT
         0cjyAjye5Jg8JaHoIxIONFf3wFTxQcznrKmf+MGZBCfxd4gAgfbqIvN0IJQlKy3771Yx
         OrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587018; x=1701191818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+YU4xakrSZAEeiCshOnJPmfZHIUA9DyOQyL2tdclCw=;
        b=S6a8uthhQ5MyGTVirft5kNU42p5J2oP7IQicFhCJ4F5+rRi7o4aEMM+RF0Wg2yReta
         lNz/nB1eHKMzEoOujy1kQkApeskzaqsL9dFyOzOD1iTz+aQU96XPBS7SBZN8x4c915Jr
         QkuI+6Bw1YohCs2pYi7pKSP3gAfUokpMjTJ4kpIZrAYswLUXjUf9ebl408f7+5ghWiN+
         WrZBKHoIhaTwEUcEwc00K0jIbhcXrmHZg6g++nAIyzjOL1l/tS669pM4W0W0cmT/h62c
         CQVZOZzcmBDk/68TE5wLLGwaapGPGkUqk8Ui3r2EfyMaAl71eWzvfhzJnwHV/kTqHm7M
         Szfg==
X-Gm-Message-State: AOJu0Yxg7rZpWmeyJufOQ9mRRFKDpx80Y0LUARvonepoy/9pRlOmJWgB
        lmgBarXHNeQaE5kATSc7vDsuqQq6NXs=
X-Google-Smtp-Source: AGHT+IGnjdfTVee3DSZlNOy3KhbC3j8nIypXTk1N0NzS6E/A59+6kLC/Rjntyn5b7LkHCGkdnVF0AOMslLI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:2045:f6d2:f01d:3fff])
 (user=surenb job=sendgmr) by 2002:a25:b84:0:b0:d9a:c27e:5f37 with SMTP id
 126-20020a250b84000000b00d9ac27e5f37mr249877ybl.3.1700587018586; Tue, 21 Nov
 2023 09:16:58 -0800 (PST)
Date:   Tue, 21 Nov 2023 09:16:38 -0800
In-Reply-To: <20231121171643.3719880-1-surenb@google.com>
Mime-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121171643.3719880-6-surenb@google.com>
Subject: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
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
index debc423bdbf4..e4e271511db9 100644
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
+	uffd_move_handle_fault_common(msg, args, default_huge_page_size());
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
+	if (step_size > page_size) {
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
+	uffd_move_test_common(targs, default_huge_page_size(),
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
2.43.0.rc1.413.gea7ed67945-goog

