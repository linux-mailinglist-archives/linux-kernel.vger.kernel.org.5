Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CA807FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjLGFFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjLGFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:04:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85691D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:05:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so703817276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925499; x=1702530299; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQL7jSRusjmNnXVovrf6s5ZXv2q3XjGZXt0cQXTXyH0=;
        b=adeQ1HrBBNuzpsW+RthE9e4k5jpdyG60N+dtMasE1XmaiThK0/Jj/xIjweED8y2MPv
         6KdfWgEaIOLLXt+AohCvXB2q33bSM/W9KVD1IfiLjGqlULGzCwPri8TcIsxMO1XQW5rM
         uLzbNxCUCI0tGfZt5pMSBGn9B3Zonji+OcPzRst5anItTipC96Go9rkcT41GThTwgS7U
         hCdoWZMFbF/bHDkj/WlMOz/E9vPSV79adX3eMYRdgjybII5jt3V07KPHsB0AgK0TrjpH
         0/9ynUYGUOnkuv8xt70AOtEDC5puUUQmN6JQUV0KSBsv6PZPDAGcFFhhngoadEDSTTz4
         zFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925499; x=1702530299;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQL7jSRusjmNnXVovrf6s5ZXv2q3XjGZXt0cQXTXyH0=;
        b=MJ++R9u3kLA+KJnHZPSpabqPScblZMN2D416PvjdJEE98a0xZJoGb2s2VQ7aDQ+saX
         RSk1hl1A+WYAB1FlVQZJohFf5yf1h/gBf2UO9e3JVTWI/gmdmq4jU6P6eT4w7WYdraqk
         2meMDchlXfYBG6b1fQZAUspTUCpTJV8WGVLc6XKYbKzRwpFQs1+I80j+D0SWm3dwSXdZ
         2Xq2s2AeNF4PONkb4zjRgrKVaqTs8IKVXFP1Tv/qiLBJpHvIw/LCC2l89VJe7RZJeceS
         ysxTx+6B+ONMovQqOAxfmqt/NwTpGqMnmAjwk+zdJzoX4Sq540P/7skse7bLVPx1usdD
         vdAw==
X-Gm-Message-State: AOJu0Yxd5X9nIlyujBDLmpVATtkgenFK/fj+ivTP8Lv0kRkuOo6HyqDJ
        kMYLbetRmlUPKFZZWSlgulsnonyp9Ji4
X-Google-Smtp-Source: AGHT+IEIES8vtcKWQ6hHeWuSFzb//31lxElZ3NI6bEf1mOom/dSrMlQcefANtfLZm0opUAdKEtbAMTMjqjGE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:df0b:0:b0:d9a:efcc:42af with SMTP id
 w11-20020a25df0b000000b00d9aefcc42afmr31557ybg.2.1701925499548; Wed, 06 Dec
 2023 21:04:59 -0800 (PST)
Date:   Wed,  6 Dec 2023 21:04:32 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-6-irogers@google.com>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 5/6] perf header: Switch mem topology to io_dir__readdir
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Switch memory_node__read and build_mem_topology from opendir/readdir
to io_dir__readdir, with smaller stack allocations. Reduces peak
memory consumption of perf record by 10kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 08cc2febabde..d4a3e28376fd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -44,6 +44,7 @@
 #include "build-id.h"
 #include "data.h"
 #include <api/fs/fs.h>
+#include <api/io_dir.h>
 #include "asm/bug.h"
 #include "tool.h"
 #include "time-utils.h"
@@ -1341,11 +1342,11 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 {
 	unsigned int phys, size = 0;
 	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
+	struct io_dirent64 *ent;
+	struct io_dir dir;
 
 #define for_each_memory(mem, dir)					\
-	while ((ent = readdir(dir)))					\
+	while ((ent = io_dir__readdir(&dir)) != NULL)			\
 		if (strcmp(ent->d_name, ".") &&				\
 		    strcmp(ent->d_name, "..") &&			\
 		    sscanf(ent->d_name, "memory%u", &mem) == 1)
@@ -1354,9 +1355,9 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 		  "%s/devices/system/node/node%lu",
 		  sysfs__mountpoint(), idx);
 
-	dir = opendir(path);
-	if (!dir) {
-		pr_warning("failed: can't open memory sysfs data\n");
+	io_dir__init(&dir, open(path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (dir.dirfd < 0) {
+		pr_warning("failed: can't open memory sysfs data '%s'\n", path);
 		return -1;
 	}
 
@@ -1368,20 +1369,20 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	n->set = bitmap_zalloc(size);
 	if (!n->set) {
-		closedir(dir);
+		close(dir.dirfd);
 		return -ENOMEM;
 	}
 
 	n->node = idx;
 	n->size = size;
 
-	rewinddir(dir);
+	io_dir__rewinddir(&dir);
 
 	for_each_memory(phys, dir) {
 		__set_bit(phys, n->set);
 	}
 
-	closedir(dir);
+	close(dir.dirfd);
 	return 0;
 }
 
@@ -1404,8 +1405,8 @@ static int memory_node__sort(const void *a, const void *b)
 static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 {
 	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
+	struct io_dirent64 *ent;
+	struct io_dir dir;
 	int ret = 0;
 	size_t cnt = 0, size = 0;
 	struct memory_node *nodes = NULL;
@@ -1413,14 +1414,14 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 	scnprintf(path, PATH_MAX, "%s/devices/system/node/",
 		  sysfs__mountpoint());
 
-	dir = opendir(path);
-	if (!dir) {
+	io_dir__init(&dir, open(path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (dir.dirfd < 0) {
 		pr_debug2("%s: couldn't read %s, does this arch have topology information?\n",
 			  __func__, path);
 		return -1;
 	}
 
-	while (!ret && (ent = readdir(dir))) {
+	while (!ret && (ent = io_dir__readdir(&dir))) {
 		unsigned int idx;
 		int r;
 
@@ -1449,7 +1450,7 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 			cnt += 1;
 	}
 out:
-	closedir(dir);
+	close(dir.dirfd);
 	if (!ret) {
 		*cntp = cnt;
 		*nodesp = nodes;
-- 
2.43.0.rc2.451.g8631bc7472-goog

