Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07107806C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377531AbjLFKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377508AbjLFKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:37:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0584ED4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:37:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db53b5f9b52so5727559276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859032; x=1702463832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Puo0/IOkGZzeDNo6LANVKcztB/uZ2FwQ4rTVo9jmukU=;
        b=Xy4NiCIVkWQjHZI12g0N2bHajZMA/cr07PnsRO0B/yUClSeECRq/6mEO9aISfKRpqz
         sMKqEPuTZIptWUi28yRh/GagOLyowh0pz3NvHKcfNsvrXsaeStysyDZQfb6lkVio6ZdR
         HNLw0RlnJDcBEN3xhiqqQDC6A48MflcgkeItoZh+gSlYV30kiju/qGNN666xj7o5uSC4
         rEyFUokNkkhA93hCNcy0lphHRtof4yU6KUufzM8dQYKxyswLEUBkK1VHHq+2ACJBaeDk
         hDphhG6Nqdrcm2JkHhSOwqZ71BqYyLA+yMYTMKbylxEullHjVCQw0qgaiitVLqp1bE4q
         VPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859032; x=1702463832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Puo0/IOkGZzeDNo6LANVKcztB/uZ2FwQ4rTVo9jmukU=;
        b=VUMLN9nHv8Isi5H0+2awTYetrKZdmG7KmMg6Fme+TBhlXQQqKQHSxHdEdz5oM5Hxmg
         x+pRCaGcghh85QtK8JLxa3Fd/e6iFnkiaQi5m5xAK0z3L1AJytqArn1QjjoiRe2MJAT5
         v88jFFtzg/FRuLXrpfBDkys/GGiqzIFrxbzktMZrgFr8Gye7SKnByq7ZL7oZ6ikkfbWk
         XlGLv89j+2jTLtHqLz6fCRzujVITZfUijhXg/UrNwoqTAWOYyis/YU8VM6NP6ObAK4y/
         VSAXEafrfzgFmt8loJ15TA3o9X0XO8NZWo8TVxW7ZCKJLep4vjSWNUeYIAuj3wsGDik7
         S+pQ==
X-Gm-Message-State: AOJu0YxCIypq16H+htGp2JSJN91LgZyLzMWKScrcXqJpy8uveu9Po+WS
        VPT/hAgx3UGMrNpnsrqBikPCGKH29u8=
X-Google-Smtp-Source: AGHT+IHA1Y29L+NkSe0tx6k2aoEfMY/lNB6ALySjHtUB1ExXnuX9TN8ZY2Jn+/kFOMbKEKZSCPu3KGAmWc0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:3144:0:b0:da0:5452:29e4 with SMTP id
 x65-20020a253144000000b00da0545229e4mr5930ybx.0.1701859032195; Wed, 06 Dec
 2023 02:37:12 -0800 (PST)
Date:   Wed,  6 Dec 2023 02:36:57 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-4-surenb@google.com>
Subject: [PATCH v6 3/5] selftests/mm: call uffd_test_ctx_clear at the end of
 the test
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

uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
areas used in the previous test run. This approach is problematic because
while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
which might differ from one test run to another.
Fix this by calling uffd_test_ctx_clear() after each test is done.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 4 +---
 tools/testing/selftests/mm/uffd-common.h     | 1 +
 tools/testing/selftests/mm/uffd-stress.c     | 5 ++++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..583e5a4cc0fd 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -262,7 +262,7 @@ static inline void munmap_area(void **area)
 	*area = NULL;
 }
 
-static void uffd_test_ctx_clear(void)
+void uffd_test_ctx_clear(void)
 {
 	size_t i;
 
@@ -298,8 +298,6 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	unsigned long nr, cpu;
 	int ret;
 
-	uffd_test_ctx_clear();
-
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
 	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
 	if (ret) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..870776b5a323 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -105,6 +105,7 @@ extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
+void uffd_test_ctx_clear(void);
 int userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 469e0476af26..7e83829bbb33 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -323,8 +323,10 @@ static int userfaultfd_stress(void)
 		uffd_stats_reset(args, nr_cpus);
 
 		/* bounce pass */
-		if (stress(args))
+		if (stress(args)) {
+			uffd_test_ctx_clear();
 			return 1;
+		}
 
 		/* Clear all the write protections if there is any */
 		if (test_uffdio_wp)
@@ -354,6 +356,7 @@ static int userfaultfd_stress(void)
 
 		uffd_stats_report(args, nr_cpus);
 	}
+	uffd_test_ctx_clear();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2709a34a39c5..e7d43c198041 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1319,6 +1319,7 @@ int main(int argc, char *argv[])
 				continue;
 			}
 			test->uffd_fn(&args);
+			uffd_test_ctx_clear();
 		}
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

