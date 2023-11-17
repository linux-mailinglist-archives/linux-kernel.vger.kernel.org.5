Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5DD7EF753
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjKQSLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:11:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BDD5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:11:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so17831037b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700244690; x=1700849490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eB+R5KD8/irGc6HqCh9MWmXy3WjqKHp3pksL4FoiCDc=;
        b=moN0zigZTVumSNXN4CkeyIUVd/IQj6ia69lOzkj5zLvdxb6DK7jv6AuJP4iqrEMe/F
         4xE23/z/CPrwjCFhv7I6zvVhUs40Rd6l7Am0zU3XudsRqyu+yf4QCFCS9MN1Z1lsofJ+
         DuRxCQB/VprY+Ke4ovOLFxSEQKBjCKIsMI+3j7dXy3MtwKN3RydzIQwLqGTouH2ghcI/
         ulcxE7cvUHKk3b+p7ZysgCcojjiOaCxQbi6WcnyLqR4aVAnyxgVXJiYJn0ZmAKbSMbaU
         XcOvMZQcHSLWGUuTtO6jDQA9PtN27GXnniIldJ3E6Z0+MriiCaNa7PcxmvjneZoPft24
         pYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700244690; x=1700849490;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eB+R5KD8/irGc6HqCh9MWmXy3WjqKHp3pksL4FoiCDc=;
        b=aqhmQhGVeXRtDP1D5YpayHU0pyz0HL03JFm5fmNsxCyFynxl+eVjqamkqz+sqBB1bj
         talocS7TO8ojGmUX3eCPxyDgbLRJEn9dfjvZZ/zEEJoxPvlK0NZNzVK9FvnZHyVu8q00
         7PHOzCwpqtODWRUzt8/zF8sUaQoCIQh3Jn6MFpkY7FxCVJ5s0JTtg0hBQoaA7bV9GLgR
         XQvGtO8Nbkgztg1kf0RkV75YnFj35bPunjktnQ4kJfUby8nl8MKpfhU+DW4ma+TUIBcr
         aup8wyQwGCTFf3buOA53QD9eUsELmJxCksZG6l82fCcS34EKsiGgiMOY1QegY2OP7+Ca
         JkjQ==
X-Gm-Message-State: AOJu0YzqFm2+q99LDAwONNK8uhSrvGQm/BhE9EdcyuLI54pknp+MGIWy
        n4YNXmX/Up+Z3efnx8wLi5r2tT4hXZM=
X-Google-Smtp-Source: AGHT+IFOyw76XMMuir4iCyAHifIi/yzgQfcxp9rLFqqXVNvF+ZX+sV5ABQd4m4M1e3iNHELoBkBfLe7W6uk=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:3e6e:efaf:3809:5555])
 (user=avagin job=sendgmr) by 2002:a81:5285:0:b0:5be:9a1e:5863 with SMTP id
 g127-20020a815285000000b005be9a1e5863mr183243ywb.4.1700244689855; Fri, 17 Nov
 2023 10:11:29 -0800 (PST)
Date:   Fri, 17 Nov 2023 10:11:27 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117181127.2574897-1-avagin@google.com>
Subject: [PATCH] selftests/mm: don't fail if pagemap_scan isn't supported
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows to run tests on old kernels.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/lkml/696a0a99-eb42-4e13-be14-58a88c9c33f7@arm.com/
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/mm/vm_util.c | 51 +++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index ec3478b96e4c..4aeb8d5299ff 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -29,15 +29,13 @@ uint64_t pagemap_get_entry(int fd, char *start)
 	return entry;
 }
 
-static uint64_t pagemap_scan_get_categories(int fd, char *start)
+static uint64_t __pagemap_scan_get_categories(int fd, char *start, struct page_region *r)
 {
 	struct pm_scan_arg arg;
-	struct page_region r;
-	long ret;
 
 	arg.start = (uintptr_t)start;
 	arg.end = (uintptr_t)(start + psize());
-	arg.vec = (uintptr_t)&r;
+	arg.vec = (uintptr_t)r;
 	arg.vec_len = 1;
 	arg.flags = 0;
 	arg.size = sizeof(struct pm_scan_arg);
@@ -49,7 +47,15 @@ static uint64_t pagemap_scan_get_categories(int fd, char *start)
 				  PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY;
 	arg.return_mask = arg.category_anyof_mask;
 
-	ret = ioctl(fd, PAGEMAP_SCAN, &arg);
+	return ioctl(fd, PAGEMAP_SCAN, &arg);
+}
+
+static uint64_t pagemap_scan_get_categories(int fd, char *start)
+{
+	struct page_region r;
+	long ret;
+
+	ret = __pagemap_scan_get_categories(fd, start, &r);
 	if (ret < 0)
 		ksft_exit_fail_msg("PAGEMAP_SCAN failed: %s\n", strerror(errno));
 	if (ret == 0)
@@ -57,18 +63,39 @@ static uint64_t pagemap_scan_get_categories(int fd, char *start)
 	return r.categories;
 }
 
+/* `start` is any valid address. */
+static bool pagemap_scan_supported(int fd, char *start)
+{
+	static int supported = -1;
+	int ret;
+
+	if (supported != -1)
+		return supported;
+
+	/* Provide an invalid address in order to trigger EFAULT. */
+	ret = __pagemap_scan_get_categories(fd, start, (struct page_region *) ~0UL);
+	if (ret == 0)
+		ksft_exit_fail_msg("PAGEMAP_SCAN succedded unexpectedly\n");
+
+	supported = errno == EFAULT;
+
+	return supported;
+}
+
 static bool page_entry_is(int fd, char *start, char *desc,
 			  uint64_t pagemap_flags, uint64_t pagescan_flags)
 {
-	bool m, s;
+	bool m = pagemap_get_entry(fd, start) & pagemap_flags;
 
-	m = pagemap_get_entry(fd, start) & pagemap_flags;
-	s = pagemap_scan_get_categories(fd, start) & pagescan_flags;
-	if (m == s)
-		return m;
+	if (pagemap_scan_supported(fd, start)) {
+		bool s = pagemap_scan_get_categories(fd, start) & pagescan_flags;
 
-	ksft_exit_fail_msg(
-		"read and ioctl return unmatched results for %s: %d %d", desc, m, s);
+		if (m == s)
+			return m;
+
+		ksft_exit_fail_msg(
+			"read and ioctl return unmatched results for %s: %d %d", desc, m, s);
+	}
 	return m;
 }
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

