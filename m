Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F617DF95D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377176AbjKBR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjKBR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CC10EC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af53bde4so17607827b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947906; x=1699552706; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EV9D1jPa+kElHXElyrI3gRx863B2kEe3iRpQbNSicgw=;
        b=GL4apXn023PImmRdYsH9t5iRcNNCTYzxVZ2yb/mRuJ7NBeu8H0qrwZr7KaWeohmZip
         MXsjRdDgsyaLLsEdladjz0bNE6IJCzmZHKcJCsl8l8BU8VKxMGAlaC1tFVgi1pJhFDdd
         YagFo9LHZGQfOFThW6bnXmsE4jEkmfS6IlH+KHenV/t5BC+BE04zo2fDxgCMTtm9nbZW
         Kd00BeMIOIuRDwkOsI7RK4DN0Au2sPkkz3fiLWsc1Xe/6s8YOtLWp0hIWSqp9R/dBiRK
         XC1Q9mR2CX3Bqp0poGluVKfOBCC0NWK5NS+kxi0WBnHD3Eudt4Rvsxs2MeWIFdlgiBPA
         W3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947906; x=1699552706;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EV9D1jPa+kElHXElyrI3gRx863B2kEe3iRpQbNSicgw=;
        b=RisOJo2IffSGDQvxJrZ+NSBFZGpuLDcpZ5xkCBac/itYneXw8jEe2hTxf09LFJ3SEW
         CwKXKr1wPZlR6g8g8lo9VAwVHO0cmBsb+S7vkVPg5qA7aBQUhsLv6CMrdFam1k6+Xu51
         e07BIsckxsSpL5/yMJM8fRD44M+7gsra+5N2IcCWmRYQ0y3KggtIXQs3xNXbPOLjRC1B
         oT8pFIHyRy+iJqdMP0Uyqpet9n6DB6gL7syREVzikr7CGIWKzbeiGeKL2gtAMHtt7FBf
         C1hf9bgdurhyeV0ffjRzT/0Ddb5a67aXXP/UYUpZV0bv3rSCuXHuAoSVtlwO0TFJdKF7
         WHmg==
X-Gm-Message-State: AOJu0YxVjXLcsN/Hw6hz9jTNHggd/bACveRfHWA5RuWxnhDbZyZz7V13
        ofd2qLwVbUpxGeSQu5LuOHChcT5wPv8s
X-Google-Smtp-Source: AGHT+IEoIff/9uny/kWzsdquTX+eRmV7J+x02i9+cz/PZmcn46iw77mp05HIcH1oqij97IMGgYXriUdrYN1U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:83c6:0:b0:59b:eea4:a5a6 with SMTP id
 t189-20020a8183c6000000b0059beea4a5a6mr8562ywf.0.1698947906006; Thu, 02 Nov
 2023 10:58:26 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:55 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-14-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 13/53] perf header: Switch mem topology to io_dir__readdir
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

Switch memory_node__read and build_mem_topology from opendir/readdir
to io_dir__readdir, with smaller stack allocations. Reduces peak
memory consumption of perf record by 10kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e86b9439ffee..55f63d2ee232 100644
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
 
@@ -1447,7 +1448,7 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
 out:
-	closedir(dir);
+	close(dir.dirfd);
 	if (!ret) {
 		*cntp = cnt;
 		*nodesp = nodes;
-- 
2.42.0.869.gea05f2083d-goog

