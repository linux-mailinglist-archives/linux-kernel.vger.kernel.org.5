Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2637F34CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjKURRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjKURRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:17:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD741AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c9e6c37bc4so39523747b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700587014; x=1701191814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oQWC9tOLeE7lomKytBDg6Tp5S7jbgII3AVJArGJfwY=;
        b=s2EiaItpZeT0o0dByrVdBzuwITejUh6B8Dp7V6nbsKSM5w09YfFQCZYcAzCj4yoCv4
         NmrlbTTW0ghvxLEHJOoVHpy3VTwl2Ig2PiktKD3U5M1vTXtXZ2sjYLnCnxWs6uP2mTQ2
         d9Jo9jzwmhNGUkGQBzWTzDoWHHHIHT/NIqC+3hDFYeHC4TlPPnZdvgN+V4RC09oRoRM+
         SLrO7jsUR6B+xG+ej8HdshzVX/Xc6dLfmRqgMOwXwiMVOq1iUnQK7nMZ/CxfYsMi91tB
         4SvUGKcRBClzx/gvGLVe10iF0xNqTgAnyN1ieZfTFdKwk1SN1LQkOdmCOmtq2Ck0FdoJ
         gO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587014; x=1701191814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oQWC9tOLeE7lomKytBDg6Tp5S7jbgII3AVJArGJfwY=;
        b=MbiIiXsOJuYnj0L+m1bXdFNQIShVdgN1oaTbaS97m6QWJ4VF5ChRm77DBAxiHL0aQ/
         Vh+9LhiL+1jBDSYE+TPvW9pPEFsjUWXvq67RDs84sWDPU9jGREaRFeBBomQKwURyOTwW
         omrsqGeLH81I0G+ufjRsT952stQwo0xS4GywmitGOtJ2jppNOg72SLOxMI904iV/YkDp
         9UoYFVvvLcylOMyxnrAz5ijjcmGqxqeTIdEYfwLlD2DZ5+xqAG13fkmJdGbUCSpGczm4
         p/LaadtFRvXSGCtDwa8GqiDndKpf15np12v2mImf5q3Gqu+K3dmA/Lhm865fYoY+BtI6
         j0fQ==
X-Gm-Message-State: AOJu0Yy2X/c2jVFG/rvbXwg6Dwld9lX5bNFf4Qsl3Rs42k9UZNlz5F0d
        gmon6LSTXLZffhJgTwIpsuT22XqoywA=
X-Google-Smtp-Source: AGHT+IGt4XeQzmmYh3UGYq1fZSYeCCXt9DvRPaCqVRLnjG7738p7ZSz3vsLWilwzFfU1DtxScxBgR2AWR/c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:2045:f6d2:f01d:3fff])
 (user=surenb job=sendgmr) by 2002:a05:690c:891:b0:5c9:1c6a:40f with SMTP id
 cd17-20020a05690c089100b005c91c6a040fmr290590ywb.5.1700587014155; Tue, 21 Nov
 2023 09:16:54 -0800 (PST)
Date:   Tue, 21 Nov 2023 09:16:36 -0800
In-Reply-To: <20231121171643.3719880-1-surenb@google.com>
Mime-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121171643.3719880-4-surenb@google.com>
Subject: [PATCH v5 3/5] selftests/mm: call uffd_test_ctx_clear at the end of
 the test
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
2.43.0.rc1.413.gea7ed67945-goog

