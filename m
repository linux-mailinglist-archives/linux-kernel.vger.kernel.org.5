Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5786B7E464C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjKGQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjKGQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:41:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CC98
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:41:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9ad9341fso80303307b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699375306; x=1699980106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWXigsopt+53YBaI4b4357sg2DizXMBbljx+d3ESjAc=;
        b=NUzRCLM0wd8uvyor0Z6LLdwpiDRKXzZwJPIjJyYhjPqVOdcCI5QukmBIrc9HQMtRv2
         VYcTLLH420TPfVoMvXQhQ8QvADMoE02u57atRgpWVLo6IsnZGBy1WpO5pNItT3Ekr+Jm
         6XZhJTVbVNfoKOBKLCh3uSCp4Auj4ZjL3K8KxvxoGockWxASjh8T0vrvOsC5pBEEmR8L
         NZZ94qqiSd0DSvd6R4+tvlIKDAdvZjtM/ye7E6vyGqN9Ks7PYN2DnxGkS7q7Q4ANEis8
         uXYQiwaOX/6valtw3932JT1VrlpFv6j7oXFVsOQNubGfvaIvCY2XQrsXlFAh+hnz/w39
         oBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699375306; x=1699980106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWXigsopt+53YBaI4b4357sg2DizXMBbljx+d3ESjAc=;
        b=HIPS6jQuG/ZXlZdE6aoreF5yS1SfWJJ8R17fRvc6T9HRNUnOkrk3rJwy6SzSooI8od
         7JohbZRVAgvSe3fnitdjtSL4bFKbOo0fxdKCKmInkw7iU/Qeq+U9f7tBnL65huGWwU4Q
         o1Eq9KlZsyQN2qE++duSqz7ur0piPxGlpyEY/3JsPTDd2mV5zP8B2GzpxDpmW9oTuowq
         2TMLdTrA1SqPqKMUilZGsmjkVrjVOX/NFYe4pSjg4sDG/MfFrLcYlA+iScomx4qu3J/4
         PDm/dOCM66MMHDcTIoKzFIvXoT7FJFRTlJQ2LDXf7ajzzMIzQntpkipPZzmy4kHBHt8W
         bbDw==
X-Gm-Message-State: AOJu0YzB+mGk/BtTXy9WlKoecLj5EAL713W2mTf1DNNwvm/slUjSC8TX
        ELtGxI/bPTYP6IEsK1Fe9BQA3LknhS0=
X-Google-Smtp-Source: AGHT+IEkPwO7iQFIMavBYOO9fUiTWypdip5gm+qFfvhL8+bymNecQuWiMC+QjKvmTa8QR5m9dgMjE5NjOBI=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:38b1:2ca1:f401:605a])
 (user=avagin job=sendgmr) by 2002:a81:8454:0:b0:5a7:be3f:159f with SMTP id
 u81-20020a818454000000b005a7be3f159fmr290190ywf.5.1699375306300; Tue, 07 Nov
 2023 08:41:46 -0800 (PST)
Date:   Tue,  7 Nov 2023 08:41:38 -0800
In-Reply-To: <20231107164139.576046-1-avagin@google.com>
Mime-Version: 1.0
References: <20231107164139.576046-1-avagin@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107164139.576046-2-avagin@google.com>
Subject: [PATCH 2/2] selftests/mm: check that PAGEMAP_SCAN returns correct categories
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, tests read page flags from /proc/pid/pagemap files. With this
change, tests will check that PAGEMAP_SCAN return correct information
too.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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

