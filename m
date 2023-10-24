Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325CB7D5E15
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjJXW0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjJXWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AC268D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a818c1d2c7so67909077b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186307; x=1698791107; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjcnIwKrkFOXzuG1ICX1mOzbNKaTUzCZsIGT1LrnoLg=;
        b=A/sLPVi15utRxV3CjBU32/s92AtPA2bp/c2dp6YztWheHrUY8dLN9rFysIB6ht0nYQ
         WaV6Uhad7Nql1+tEZAlJJ+QE6gj0jKCwaPWRz8a8qJBRU+IwvNZ+xMO6GnEopU5JMuOl
         GZao9usDQGKNz9ogCpn3nbCzmOPK5HDVniMi+qQfYL7NHvMIy0E/Qh/u3IUrHHs86ui4
         FEuUReCdpssCsJ/vrEQ1CpNYoblBJMRU+hLHWKbtnnq+U8N66cwgwOegbbHT8MNbPh1D
         XCjI1r2b/gVcoHcJ4dQ4Q6VbCIo3U0T867KEjPLR5Wi9Eh4y8nYuZCzmHcRdhJydrnbc
         NZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186307; x=1698791107;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjcnIwKrkFOXzuG1ICX1mOzbNKaTUzCZsIGT1LrnoLg=;
        b=YLNXQhcXtWZVacOmWG1o0ZSuJefBnWcWR/h0Ue67m9sjvVPrbs3RWNU54qKrwdvYrF
         dC5DuxkEW1mpJQrefLVm80VZJ0VFbWF8DZS8vASbuydT8F4nXPwOWqL9vvrkuzeQs9lf
         OYCvvGWzIFmKDBvYVrkrelk4c5D9AiuJS224QfEvspAASSXhPR412RsItwwTvjSY0Xyk
         me3nSMKyMe9e4KkybaPuPBIYZ9TdJC0CG8dZFnFgazva0bGigBmM+esvu2vXVh1v7lmP
         VNAg0N4Rug70D5pB/YSdLQW6i1PWa05LR5n0QR5qyy2DS2pSjOoieqDaUPyDn1wGtTlk
         KEKw==
X-Gm-Message-State: AOJu0Yzqz+0eVoVVa5xAH1rns/IkPOV1WPrmYTvHAdqHhVSIsK5Wa4Jx
        MguraOE9vAK7V8Th1Rf2aLZ0ntXVKjwp
X-Google-Smtp-Source: AGHT+IGNxDLxB8DJ6t1FvPU8fCuq5CTj9fbqcalS1N64EIKT/tzn3wJfPl0lgOQcVsHd9TkeRZLquaUJmDSH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a81:9196:0:b0:5a7:af47:9dda with SMTP id
 i144-20020a819196000000b005a7af479ddamr293519ywg.9.1698186306785; Tue, 24 Oct
 2023 15:25:06 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:27 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-25-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 24/50] perf events: Remove scandir in thread synthesis
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids scanddir reading the directory into memory that's
allocated and instead allocates on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a0579c7d7b9e..7cc38f2a0e9e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -38,6 +38,7 @@
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -751,10 +752,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      bool needs_mmap, bool mmap_data)
 {
 	char filename[PATH_MAX];
-	struct dirent **dirent;
+	struct io_dir iod;
+	struct io_dirent64 *dent;
 	pid_t tgid, ppid;
 	int rc = 0;
-	int i, n;
 
 	/* special case: only send one comm event using passed in pid */
 	if (!full) {
@@ -786,16 +787,19 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	n = scandir(filename, &dirent, filter_task, NULL);
-	if (n < 0)
-		return n;
+	io_dir__init(&iod, open(filename, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0)
+		return -1;
 
-	for (i = 0; i < n; i++) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char *end;
 		pid_t _pid;
 		bool kernel_thread = false;
 
-		_pid = strtol(dirent[i]->d_name, &end, 10);
+		if (!isdigit(dent->d_name[0]))
+			continue;
+
+		_pid = strtol(dent->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -829,9 +833,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	for (i = 0; i < n; i++)
-		zfree(&dirent[i]);
-	free(dirent);
+	close(iod.dirfd);
 
 	return rc;
 }
-- 
2.42.0.758.gaed0368e0e-goog

