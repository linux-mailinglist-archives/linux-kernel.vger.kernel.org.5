Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC97E2F99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjKFWKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjKFWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:10:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7022D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:10:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b99999614bso3033114a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699308605; x=1699913405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+0IXrXyLnBASTyaRkaW02XkIlMLQTt/pd2sX4XzHqI=;
        b=RTeZZBV5KJMi88V1yakPqTgIZp7zvggW6cNAw9k/H1v5/O7/3cUrpjfRuKn8VGjqWy
         W7XlpJPN+1LrvsKN1uP7QkS0k//P5RKsbBdklqoGXE8dcrpxuRoDGNvq+8aAtz7ECfM+
         JekPvFyBxgzXeFNXwm2xnMPuD9cs0AFKr61ZaTZIfWr/PMPRZzB1AkSB+EcXxT/smY+I
         B/K9S4SugkuESDXm74EMxqO7oxX8ol2oMdE4g48J6zSuTwrLJazY5jhtV70I2dd7fYE6
         0OCz+c4OcPPzjTU2/Qu+1F00Hekf8sbmbR3/kHGJfSPgTup0Nw1V0hg+4/bAS5TsnzkZ
         6psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308605; x=1699913405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+0IXrXyLnBASTyaRkaW02XkIlMLQTt/pd2sX4XzHqI=;
        b=NAh59NyCqG4bf8raVjDADpix5JqZ+KJyvXiJTVIvo1XE+2eecgxCXbBucbf0TNyNkr
         iO6LeOZhsAVV0CFDKi38fKCeeYVIFKql5YnND01XVOTf3bLpYt4aaDWv7LJIP2hItsWY
         NtwvBZK9sFJRmVfW7Emqzj9e/I5lP4jKFSkw72olKvTKZVatj5kkZVUxUNOPoedmJ1c0
         sqah+XvoRAmpFZsjC1S/cdSqMZFLvSL8lP/tmNTuQxykR0kTb8n6jcLua7UMg4fbNub9
         TmdI4YXIBAbDujK2rFqC0RF3sKzCW5p1o6GpJ+5XyDPxICFJvjCCzihpj/jsNG0txWqB
         dr0g==
X-Gm-Message-State: AOJu0YyEkDHWpDt+0orczzFuJwaGA8IlA7qHMrwqfKwcrDe04Qf4oVTj
        afHN4IcTL9ZfeJ9aoF/p/qmkKaDw38U=
X-Google-Smtp-Source: AGHT+IHvWyWvWNiZvRDxBOTf4nb2uZgpFd1ZQfkUs9aDmetn8wjaUcLAiyT1Wk91OWiiz/Fe7vNJHz4D6Tg=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:b187:459d:af36:db4c])
 (user=avagin job=sendgmr) by 2002:a63:7018:0:b0:589:8df1:7eb1 with SMTP id
 l24-20020a637018000000b005898df17eb1mr537436pgc.4.1699308605331; Mon, 06 Nov
 2023 14:10:05 -0800 (PST)
Date:   Mon,  6 Nov 2023 14:09:59 -0800
In-Reply-To: <20231106220959.296568-1-avagin@google.com>
Mime-Version: 1.0
References: <20231106220959.296568-1-avagin@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106220959.296568-2-avagin@google.com>
Subject: [PATCH 2/2] selftests/mm: check that PAGEMAP_SCAN returns correct categories
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>
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

Right now, tests read page flags from /proc/pid/pagemap files. With this
change, tests will check that PAGEMAP_SCAN return correct information
too.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/mm/vm_util.c | 53 ++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 3082b40492dd..ec3478b96e4c 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -4,6 +4,7 @@
 #include <dirent.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>
+#include <linux/fs.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include "../kselftest.h"
@@ -28,19 +29,65 @@ uint64_t pagemap_get_entry(int fd, char *start)
 	return entry;
 }
 
+static uint64_t pagemap_scan_get_categories(int fd, char *start)
+{
+	struct pm_scan_arg arg;
+	struct page_region r;
+	long ret;
+
+	arg.start = (uintptr_t)start;
+	arg.end = (uintptr_t)(start + psize());
+	arg.vec = (uintptr_t)&r;
+	arg.vec_len = 1;
+	arg.flags = 0;
+	arg.size = sizeof(struct pm_scan_arg);
+	arg.max_pages = 0;
+	arg.category_inverted = 0;
+	arg.category_mask = 0;
+	arg.category_anyof_mask = PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN | PAGE_IS_FILE |
+				  PAGE_IS_PRESENT | PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |
+				  PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY;
+	arg.return_mask = arg.category_anyof_mask;
+
+	ret = ioctl(fd, PAGEMAP_SCAN, &arg);
+	if (ret < 0)
+		ksft_exit_fail_msg("PAGEMAP_SCAN failed: %s\n", strerror(errno));
+	if (ret == 0)
+		return 0;
+	return r.categories;
+}
+
+static bool page_entry_is(int fd, char *start, char *desc,
+			  uint64_t pagemap_flags, uint64_t pagescan_flags)
+{
+	bool m, s;
+
+	m = pagemap_get_entry(fd, start) & pagemap_flags;
+	s = pagemap_scan_get_categories(fd, start) & pagescan_flags;
+	if (m == s)
+		return m;
+
+	ksft_exit_fail_msg(
+		"read and ioctl return unmatched results for %s: %d %d", desc, m, s);
+	return m;
+}
+
 bool pagemap_is_softdirty(int fd, char *start)
 {
-	return pagemap_get_entry(fd, start) & PM_SOFT_DIRTY;
+	return page_entry_is(fd, start, "soft-dirty",
+				PM_SOFT_DIRTY, PAGE_IS_SOFT_DIRTY);
 }
 
 bool pagemap_is_swapped(int fd, char *start)
 {
-	return pagemap_get_entry(fd, start) & PM_SWAP;
+	return page_entry_is(fd, start, "swap", PM_SWAP, PAGE_IS_SWAPPED);
 }
 
 bool pagemap_is_populated(int fd, char *start)
 {
-	return pagemap_get_entry(fd, start) & (PM_PRESENT | PM_SWAP);
+	return page_entry_is(fd, start, "populated",
+				PM_PRESENT | PM_SWAP,
+				PAGE_IS_PRESENT | PAGE_IS_SWAPPED);
 }
 
 unsigned long pagemap_get_pfn(int fd, char *start)
-- 
2.42.0.869.gea05f2083d-goog

