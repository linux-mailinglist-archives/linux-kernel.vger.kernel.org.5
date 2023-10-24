Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00C7D5E14
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjJXW0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344586AbjJXWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE61FDB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ba10cb90so67236437b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186289; x=1698791089; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATYLaWcN5bU+Dpgi7a7JWdfUJz5sZd2hiBE3rpvu+hs=;
        b=YX73kaQOwuAStnFE3CSau5V0IlVcOWh41WNt+xkX/UsxmwQuGGrsZ4CXrp3e3AMPcK
         y2f9yD9kKb712LZF7vzSiQ2fvH/CLFP7tQxvWhB1/kOHI80Y9mB9qA/Fd98LJ0ZMuK3e
         p/FtL228WBsz1/KvF+g95duidgiIqJDbxrbQsx/wtXEMYI6jeEVjcRNCOdHN56t3Hlk+
         XFUSEEUenG6MjLEJ3u3zFUDuRlVF0fnn1Is/M6KwfboSRDX+xTmNLM/ee4usdtT173Yz
         7t/8+LBKGq7HlRqDHKLhxEeZgzc9sRkBXSppcO/juzkeEgFZ6f3NKpQZN7P5WButQJRD
         bsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186289; x=1698791089;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATYLaWcN5bU+Dpgi7a7JWdfUJz5sZd2hiBE3rpvu+hs=;
        b=ORCgdLjfTfjYtDhdUjCf7VKb1uhdFe4S8L7+Lt4dxllT46fcuX+0kpHzbNS00qwnCI
         BYL8x9JsYQ7ro63Ic83oenfDX3VjbqYYG0t9GMzhUyzQ2j5DfnRJg+0uyAx8R942CNXV
         olkCDeblMpIiEACHWnHmznQd2+ZYuWm/0MZ26g8BbxMQMH5BD0GrV2PCWRS8RIaW7zhL
         Jf8FYo3PO8OatDXc1P0VdZamtYSj+Cd/EUDmxuILWXQpXJk7uF98N7hUZpgGCR3+Ft6z
         CkozeVoiMttfmluqiPeZW2fXxvfeEzcNd4re9SApn9RFp+opiz+XExczpApy0P9O6gmN
         TBUg==
X-Gm-Message-State: AOJu0YyJkLLW46IKS5mklIZn4xk746JytiWAOi3FpmJ9zUYg3HJsolV7
        V1Rg5+W327nrGDHaxc8s4oY1IySV280c
X-Google-Smtp-Source: AGHT+IFT+Pd5kd1I8od4cX2G1Bf5fCmCBiz79LjBb1HZ4UWsKZi/GR9vVgFu5bdBd6BAlHb7OsUquC0cyFl1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:4f4c:961b with SMTP
 id v3-20020a056902108300b00d9a4f4c961bmr353608ybu.1.1698186288663; Tue, 24
 Oct 2023 15:24:48 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:19 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-17-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 16/50] tools api fs: Switch filename__read_str to use io.h
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filename__read_str has its own string reading code that allocates
memory before reading into it. The memory allocated is sized at BUFSIZ
that is 8kb. Most strings are short and so most of this 8kb is
wasted.

Refactor io__getline so that the newline character can be configurable
and ignored in the case of filename__read_str.

Code like build_caches_for_cpu in perf's header.c will read many
strings and hold them in a data structure, in this case multiple
strings per cache level per CPU. Using io.h's io__getline avoids the
wasted memory as strings are temporarily read into a buffer on the
stack before being copied to a buffer that grows 128 bytes at a time
and is never sized larger than the string.

For a 16 hyperthread system the memory consumption of "perf record
true" is reduced by 180kb, primarily through saving memory when
reading the cache information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 56 +++++++++++--------------------------------
 tools/lib/api/io.h    |  9 +++++--
 2 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 5cb0eeec2c8a..496812b5f1d2 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -16,6 +16,7 @@
 #include <sys/mount.h>
 
 #include "fs.h"
+#include "../io.h"
 #include "debug-internal.h"
 
 #define _STR(x) #x
@@ -344,53 +345,24 @@ int filename__read_ull(const char *filename, unsigned long long *value)
 	return filename__read_ull_base(filename, value, 0);
 }
 
-#define STRERR_BUFSIZE  128     /* For the buffer size of strerror_r */
-
 int filename__read_str(const char *filename, char **buf, size_t *sizep)
 {
-	size_t size = 0, alloc_size = 0;
-	void *bf = NULL, *nbf;
-	int fd, n, err = 0;
-	char sbuf[STRERR_BUFSIZE];
+	struct io io;
+	char bf[128];
+	int err;
 
-	fd = open(filename, O_RDONLY);
-	if (fd < 0)
+	io.fd = open(filename, O_RDONLY);
+	if (io.fd < 0)
 		return -errno;
-
-	do {
-		if (size == alloc_size) {
-			alloc_size += BUFSIZ;
-			nbf = realloc(bf, alloc_size);
-			if (!nbf) {
-				err = -ENOMEM;
-				break;
-			}
-
-			bf = nbf;
-		}
-
-		n = read(fd, bf + size, alloc_size - size);
-		if (n < 0) {
-			if (size) {
-				pr_warn("read failed %d: %s\n", errno,
-					strerror_r(errno, sbuf, sizeof(sbuf)));
-				err = 0;
-			} else
-				err = -errno;
-
-			break;
-		}
-
-		size += n;
-	} while (n > 0);
-
-	if (!err) {
-		*sizep = size;
-		*buf   = bf;
+	io__init(&io, io.fd, bf, sizeof(bf));
+	*buf = NULL;
+	err = io__getline_nl(&io, buf, sizep, /*nl=*/-1);
+	if (err < 0) {
+		free(*buf);
+		*buf = NULL;
 	} else
-		free(bf);
-
-	close(fd);
+		err = 0;
+	close(io.fd);
 	return err;
 }
 
diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index a77b74c5fb65..50d33e14fb56 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -141,7 +141,7 @@ static inline int io__get_dec(struct io *io, __u64 *dec)
 }
 
 /* Read up to and including the first newline following the pattern of getline. */
-static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
+static inline ssize_t io__getline_nl(struct io *io, char **line_out, size_t *line_len_out, int nl)
 {
 	char buf[128];
 	int buf_pos = 0;
@@ -151,7 +151,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
 
 	/* TODO: reuse previously allocated memory. */
 	free(*line_out);
-	while (ch != '\n') {
+	while (ch != nl) {
 		ch = io__get_char(io);
 
 		if (ch < 0)
@@ -184,4 +184,9 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
 	return -ENOMEM;
 }
 
+static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
+{
+	return io__getline_nl(io, line_out, line_len_out, /*nl=*/'\n');
+}
+
 #endif /* __API_IO__ */
-- 
2.42.0.758.gaed0368e0e-goog

