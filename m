Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292AB7DF954
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjKBR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjKBR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F28D67
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso1517704276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947897; x=1699552697; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk/VzT94qDMubCcKVAsuWCAs+LXHGNl5LhGnwC/C5pk=;
        b=ah9r9+5Mx7Ay7TVE5aEN5x7jcF+tPkgOeQTM+jnCw68fHVIdy2pwm5fsbDFqETN9zx
         p3jRoljPgx+Zoo0KSKnzKTcH9d1mwZBNi4TSovjqyKbZGnbxLOFe8zJHbYZCIEYriROw
         hxFCPC5kmigF1MoUtTqWKyXpgH+DDvbesAVwQpqBrNdGsl2XqOJTxW98PVta5tIajAP1
         Eq+qYga0+wukw1Z9kWISluFhq1CK6/kmklkFKNdHnxGkoza9ALmnvNEposdRX2SQTuXA
         qwDvlDCeC68uEKAdFzcGnLONYrJa40yUcVhuz5WP0/fqFRDe3Nn9svBm03kAnyhzEYMZ
         D33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947897; x=1699552697;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk/VzT94qDMubCcKVAsuWCAs+LXHGNl5LhGnwC/C5pk=;
        b=at732XxqwcauwDPMYZjpCnmyylQx5SdD41ard3+CnLtyKnXAbKGxV+QjyRGTJt2n8t
         I39QZHrDdb9hdm9sg4odsR8EBJBSclPXoX2+h+bbjZ1xPkYLMNxyX7iENF4wrDTB9Hwg
         b6eOoE75Acl6BxOLQ0H8MlaeQoUcq6KIyWenUZDZOtH7utJrxzLCFHx/l3IaPEIlNicR
         PhhFJYeev4kslyC5RHM/veQGUlwa545O/Dx8ABwzAv3p8HZvDd6ZQcayg3DLu6jJ5wMV
         hCYA7etqyIE0tgUS1ShkyztDxBNcAEGBLXXNYeotTdaKQAgjaa+l4taHw2hbpYDQu4kC
         hh8Q==
X-Gm-Message-State: AOJu0Yw7tr90bRNdZaV1SIgz6VB0yzCbr+D2n4nzk2IDUv9iCvL7e3ZY
        pBdQXnelZ5x7ASLOPyMaNR2Mfxmxtugj
X-Google-Smtp-Source: AGHT+IGpeDRD/GEyMSa21NJNFRrWsZEsEPu1fdzYK2ak56e29qQnCpW4H/uIWSAKpNpQBE5QB1PJMQbOQvxL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:770f:0:b0:da0:73c2:db78 with SMTP id
 s15-20020a25770f000000b00da073c2db78mr397036ybc.9.1698947896754; Thu, 02 Nov
 2023 10:58:16 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:51 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-10-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 09/53] perf maps: Switch modules tree walk to io_dir__readdir
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to glibc's opendir/readdir this lowers the max RSS of perf
record by 1.8MB on a Debian machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a985d004aa8d..be3dab9d5253 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -36,6 +36,7 @@
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
 #include "arm64-frame-pointer-unwind-support.h"
+#include <api/io_dir.h>
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -1552,25 +1553,21 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 
 static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, int depth)
 {
-	struct dirent *dent;
-	DIR *dir = opendir(dir_name);
+	struct io_dirent64 *dent;
+	struct io_dir iod;
 	int ret = 0;
 
-	if (!dir) {
+	io_dir__init(&iod, open(dir_name, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0) {
 		pr_debug("%s: cannot open %s dir\n", __func__, dir_name);
 		return -1;
 	}
 
-	while ((dent = readdir(dir)) != NULL) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char path[PATH_MAX];
-		struct stat st;
 
-		/*sshfs might return bad dent->d_type, so we have to stat*/
 		path__join(path, sizeof(path), dir_name, dent->d_name);
-		if (stat(path, &st))
-			continue;
-
-		if (S_ISDIR(st.st_mode)) {
+		if (io_dir__is_dir(&iod, dent)) {
 			if (!strcmp(dent->d_name, ".") ||
 			    !strcmp(dent->d_name, ".."))
 				continue;
@@ -1603,7 +1600,7 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 	}
 
 out:
-	closedir(dir);
+	close(iod.dirfd);
 	return ret;
 }
 
-- 
2.42.0.869.gea05f2083d-goog

