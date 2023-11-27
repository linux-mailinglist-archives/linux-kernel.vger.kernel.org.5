Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E067FAD00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjK0WJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjK0WJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:09:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8512FD63
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c994880223so71176687b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122970; x=1701727770; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+npLEGGKvJyv+71CfQEu2hz5DvzwiDBsST/T9MEHhUI=;
        b=B+aaexRFn+mONgzI620XBiKRLYHebg2f9JEEoU8lSHKMbLTriU4yVnQ3KW9AFZfg5u
         jVt9hQA7ocfqIH8q5NwcV7CNtM0MWpRYUHgLpQypwxTdqRq1s1oxn7iNt8j+0XpiDjc9
         ZbGqZlqIUwZveqBOnehZLKIO/K/9hQZ2W3cINhUuola7K2v0q0ZfjCiOu+Sr5fVh/cui
         4GpU0/AEc6i5mNM25euQWx7d5rv4SwCYs6Ll6hphw/844hUQJ4GMuaejlSpxsDXpWg6K
         oTT7uu48hMHhI2xB+oDlTCladkcs8U8Yz3W6uw5+IzFObMK+hMDBu95tBinuqzKluRY2
         icyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122970; x=1701727770;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+npLEGGKvJyv+71CfQEu2hz5DvzwiDBsST/T9MEHhUI=;
        b=jNQAhL3TgFhUO5yJltF4dVntvIV3s/G9Vth8vHEifZ9V5uiV5rNbql0etiMzZppKRQ
         jHw2yxNxNpQvJMZAgp9JSjxYVQ/rWWiAB3zMUw00aQ44LG+Zdt0rwelJkiO6x+2wsoOH
         73WA0zZymsru581zQCCb0OKuhvVhV8SdlFZfESm75PiMFG6PVIIwQv1JtdFpluBuldMF
         vRhCwDy9fpvt516QkfS/4xoDXfEfOiTk7I8a2b4ibOPp8a8Q0XyltgHq2qCCg0jpELBa
         7PbPtidpgkUwEewSCjjiPJuPkH5ylrYjj0kfidrT3N7kgmVQnd4IG9Nrx/ZbnOtmj1ny
         wXKA==
X-Gm-Message-State: AOJu0YytCSxI+tzo4j8uuNIhMruKPWjmLjPDxqwTcs7TLa9HHOKYgzLC
        BKh8sfsUpkClTAF6dkWGQXZevHRigRUK
X-Google-Smtp-Source: AGHT+IHwU97pk+h4k1eMkg7NmyJMCsNSx1hj11TSCdGmx3Jjlk/RVUHXsz7fsAwpHv1FH3iDgmc2lKjZsR5D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a81:ff05:0:b0:5cd:c47d:d89a with SMTP id
 k5-20020a81ff05000000b005cdc47dd89amr472301ywn.2.1701122969624; Mon, 27 Nov
 2023 14:09:29 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:16 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-5-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 04/50] tools api fs: Switch filename__read_str to use io.h
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

filename__read_str has its own string reading code that allocates
memory before reading into it. The memory allocated is sized at BUFSIZ
that is 8kb. Most strings are short and so most of this 8kb is
wasted.

Refactor io__getline, as io__getdelim, so that the newline character
can be configurable and ignored in the case of filename__read_str.

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
 tools/lib/api/io.h    | 11 ++++++---
 2 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 5cb0eeec2c8a..004f2af5504b 100644
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
+	err = io__getdelim(&io, buf, sizep, /*delim=*/-1);
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
index a77b74c5fb65..a28157d2ebee 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -140,8 +140,8 @@ static inline int io__get_dec(struct io *io, __u64 *dec)
 	}
 }
 
-/* Read up to and including the first newline following the pattern of getline. */
-static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
+/* Read up to and including the first delim. */
+static inline ssize_t io__getdelim(struct io *io, char **line_out, size_t *line_len_out, int delim)
 {
 	char buf[128];
 	int buf_pos = 0;
@@ -151,7 +151,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
 
 	/* TODO: reuse previously allocated memory. */
 	free(*line_out);
-	while (ch != '\n') {
+	while (ch != delim) {
 		ch = io__get_char(io);
 
 		if (ch < 0)
@@ -184,4 +184,9 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
 	return -ENOMEM;
 }
 
+static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
+{
+	return io__getdelim(io, line_out, line_len_out, /*delim=*/'\n');
+}
+
 #endif /* __API_IO__ */
-- 
2.43.0.rc1.413.gea7ed67945-goog

