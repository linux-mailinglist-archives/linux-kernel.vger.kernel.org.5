Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191807DF94B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbjKBR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbjKBR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A7D4A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso25302997b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947889; x=1699552689; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7edOHvx+k3z5/fijEH56VX5ra/if0k0+ViUkD/Wexv8=;
        b=ZHsWbW6UnVo24aJdKBCQc42AYMRbIlJg3n8Q8WmJylYtAcgoibActLtIPVUB40NsjG
         K5qgR9OPcMMoJCgu2Lsj763b244fPfWePhyUy816EpQWravIKrDdaIk4l+7Ojz0Lh8N9
         Oqbn97UpLzfFufz4Ryd4aS085YO3t+CYzHX+8i4X1ltBdGDyL4uVm6/SRaoUA7JVMR+2
         Zg/042Tb+mA2n+ksbf7tLYjnYw8IGoXajV36RAEzAfwZAbDGbH/IJyHLZlmSy/OASHHO
         zpqWd3rhLb26gEQY7iO3qpp2m7LUlarpOC6Gu4hFQkQiFOBNM/rzzp0DFaMwlfLyXl3+
         77gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947889; x=1699552689;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7edOHvx+k3z5/fijEH56VX5ra/if0k0+ViUkD/Wexv8=;
        b=czvfZ/9FOHeb868juzNLfnHWNDYsO9qdqiTbDF95s+TKHJluorOKx53BvrH86Btbrp
         xx/xH8MfZxJhDw835gBeRnDjJiD99soT2/MkV1n8RGAQBstvyck39bziXPlVPUeszb1O
         f0gmW0TYJJZgS3ndVN8+js9zmsDx9DN3C1aOkvbujNeoq+hgcNGw/19XosaBy5MSzF25
         qhkkfFDq4PGg0mJfDvLaxzEvOTLc/xoAxLdKa33tl23JI9XJmGk2z8qlKb0XZGIXQ3xd
         o6ZB3TD3LlZKchWnL+Vgr4Mw3Og5dRbs6lJUTb7J/McFcZkeKaCrPPAGBkhHO13X5Cuo
         r9Tw==
X-Gm-Message-State: AOJu0Yzj6LJnCPYsAWGVR6PIP6a2n6YIh9nwQxpX7NLaPucgi9sLrgat
        VnTTtTEsg9ogweTJbucLUY99bHBCVjsY
X-Google-Smtp-Source: AGHT+IGrtK58OlLFuuDOSRw3nGyFtGkfcY126uR1/EbBqUO0EeyGIQtuT+LK/NdrkcsBcJwUWTKb7Y6yiihQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:dd06:0:b0:59b:f863:6f60 with SMTP id
 e6-20020a81dd06000000b0059bf8636f60mr8462ywn.4.1698947889557; Thu, 02 Nov
 2023 10:58:09 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:48 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-7-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 06/53] tools api fs: Switch filename__read_str to use io.h
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
2.42.0.869.gea05f2083d-goog

