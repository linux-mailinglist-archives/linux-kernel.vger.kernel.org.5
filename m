Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBABA7FACFF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjK0WJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjK0WJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:09:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2261EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca61d84dc3so57551997b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122967; x=1701727767; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yE/mx3y9hk/72Wt179aFryA7Q0uV0ru4OYGsQ3IJn4=;
        b=e8q/iK0Y0SYzdyj/RTHR3KxMN1yDgIGROMZ8BUk26OrnjaU4i9UMfviDd6JoUy7UQL
         lYBv3dkxFTs5NWCRDt1ZqLJ9hfEClkwRDLKwGGcpki+edw9lBXVFdrkU6oV5FjfXo9zz
         ZTkc1iwSx5R3V23rTnYtcsnPY9W+egpX0HPEg9GWT8j6rzMtWwkeNYAe1mR2sCh6lWew
         pceAxnlTmGEz7pADMYjdKb4ZV9Vweb7TeJ0L2KF4jg1y7A3uDAVa/T2DkxmuDoYq91NF
         bBYhADqmPmYnOy6C5ynxDzor83B91ZbKS4sDA+XbD2DVMrXpaPiIEI0EuS0HcH4OaJLE
         cs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122967; x=1701727767;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yE/mx3y9hk/72Wt179aFryA7Q0uV0ru4OYGsQ3IJn4=;
        b=cIFm0z3RRO1yM0PLhbrH7S8VmnCfSRgF1D7jXgp38DlTiZAM9r8yAu7pOF77qaW5cq
         /Pzdd5nWGISClK7E2qs4qpFWFba1HukWKJ2Ar/XDKMHY9L6NYAr03y31UlE7bg/thhAk
         buyodxGIQjxDszoQ+1cWM2AQeLlyJBk+xu+gMp/bnVsseLwOYX737AKskNlwT4t1HtrA
         W9pXmJ8PlGECc7zWz1WRn/eTTm415RDwAYzYk6nJXVGY5HN/OZHaOmu9LjOE2oeuwJ2p
         AlCzTMXwqaOkYl7ZFlybJ1Sjr4ufHup+5aNKu7Rx5IHRWQVFXnXanctRSLZcK/4jFkFa
         SYRg==
X-Gm-Message-State: AOJu0YygMl/DXKrENsUQEI8tZFic95BW2XBC1gziuLWNwQPBIqDT6gsQ
        GTuIZf/N/k107bipvt4ab0IWbPwnuLDd
X-Google-Smtp-Source: AGHT+IH+kp0cr7e3tfRcW7G/fzeQbhgozMKmpMv+sNyuGnbT1AWsnlUvgnigQW3h0aFIYaaZ4+EjFjQpLco+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:250d:b0:5ce:3dd9:a380 with SMTP
 id dt13-20020a05690c250d00b005ce3dd9a380mr326475ywb.2.1701122967120; Mon, 27
 Nov 2023 14:09:27 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:15 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-4-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 03/50] perf mmap: Lazily initialize zstd streams
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

Zstd streams create dictionaries that can require significant RAM,
especially when there is one per-CPU. Tools like perf record won't use
the streams without the -z option, and so the creation of the streams
is pure overhead. Switch to creating the streams on first use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 26 ++++++++++-----
 tools/perf/util/compress.h  |  6 ++--
 tools/perf/util/mmap.c      |  5 ++-
 tools/perf/util/mmap.h      |  1 -
 tools/perf/util/zstd.c      | 63 +++++++++++++++++++------------------
 5 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8ec818568662..9b4f3805ca92 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -270,7 +270,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 
 static int record__aio_enabled(struct record *rec);
 static int record__comp_enabled(struct record *rec);
-static size_t zstd_compress(struct perf_session *session, struct mmap *map,
+static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
 			    void *dst, size_t dst_size, void *src, size_t src_size);
 
 #ifdef HAVE_AIO_SUPPORT
@@ -405,9 +405,13 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	 */
 
 	if (record__comp_enabled(aio->rec)) {
-		size = zstd_compress(aio->rec->session, NULL, aio->data + aio->size,
-				     mmap__mmap_len(map) - aio->size,
-				     buf, size);
+		ssize_t compressed = zstd_compress(aio->rec->session, NULL, aio->data + aio->size,
+						   mmap__mmap_len(map) - aio->size,
+						   buf, size);
+		if (compressed < 0)
+			return (int)compressed;
+
+		size = compressed;
 	} else {
 		memcpy(aio->data + aio->size, buf, size);
 	}
@@ -633,7 +637,13 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map, map->data, mmap__mmap_len(map), bf, size);
+		ssize_t compressed = zstd_compress(rec->session, map, map->data,
+						   mmap__mmap_len(map), bf, size);
+
+		if (compressed < 0)
+			return (int)compressed;
+
+		size = compressed;
 		bf   = map->data;
 	}
 
@@ -1527,10 +1537,10 @@ static size_t process_comp_header(void *record, size_t increment)
 	return size;
 }
 
-static size_t zstd_compress(struct perf_session *session, struct mmap *map,
+static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
 			    void *dst, size_t dst_size, void *src, size_t src_size)
 {
-	size_t compressed;
+	ssize_t compressed;
 	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
 	struct zstd_data *zstd_data = &session->zstd_data;
 
@@ -1539,6 +1549,8 @@ static size_t zstd_compress(struct perf_session *session, struct mmap *map,
 
 	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
 						     max_record_size, process_comp_header);
+	if (compressed < 0)
+		return compressed;
 
 	if (map && map->file) {
 		thread->bytes_transferred += src_size;
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 0cd3369af2a4..9eb6eb5bf038 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -3,6 +3,7 @@
 #define PERF_COMPRESS_H
 
 #include <stdbool.h>
+#include <stdlib.h>
 #ifdef HAVE_ZSTD_SUPPORT
 #include <zstd.h>
 #endif
@@ -21,6 +22,7 @@ struct zstd_data {
 #ifdef HAVE_ZSTD_SUPPORT
 	ZSTD_CStream	*cstream;
 	ZSTD_DStream	*dstream;
+	int comp_level;
 #endif
 };
 
@@ -29,7 +31,7 @@ struct zstd_data {
 int zstd_init(struct zstd_data *data, int level);
 int zstd_fini(struct zstd_data *data);
 
-size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
+ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
 				       size_t process_header(void *record, size_t increment));
 
@@ -48,7 +50,7 @@ static inline int zstd_fini(struct zstd_data *data __maybe_unused)
 }
 
 static inline
-size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
+ssize_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
 				       void *dst __maybe_unused, size_t dst_size __maybe_unused,
 				       void *src __maybe_unused, size_t src_size __maybe_unused,
 				       size_t max_record_size __maybe_unused,
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 49093b21ee2d..122ee198a86e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -295,15 +295,14 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
 
 	map->core.flush = mp->flush;
 
-	map->comp_level = mp->comp_level;
 #ifndef PYTHON_PERF
-	if (zstd_init(&map->zstd_data, map->comp_level)) {
+	if (zstd_init(&map->zstd_data, mp->comp_level)) {
 		pr_debug2("failed to init mmap compressor, error %d\n", errno);
 		return -1;
 	}
 #endif
 
-	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
+	if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				 MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (map->data == MAP_FAILED) {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index f944c3cd5efa..0df6e1621c7e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -39,7 +39,6 @@ struct mmap {
 #endif
 	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
-	int		comp_level;
 	struct perf_data_file *file;
 	struct zstd_data      zstd_data;
 };
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 48dd2b018c47..57027e0ac7b6 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -7,35 +7,9 @@
 
 int zstd_init(struct zstd_data *data, int level)
 {
-	size_t ret;
-
-	data->dstream = ZSTD_createDStream();
-	if (data->dstream == NULL) {
-		pr_err("Couldn't create decompression stream.\n");
-		return -1;
-	}
-
-	ret = ZSTD_initDStream(data->dstream);
-	if (ZSTD_isError(ret)) {
-		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
-		return -1;
-	}
-
-	if (!level)
-		return 0;
-
-	data->cstream = ZSTD_createCStream();
-	if (data->cstream == NULL) {
-		pr_err("Couldn't create compression stream.\n");
-		return -1;
-	}
-
-	ret = ZSTD_initCStream(data->cstream, level);
-	if (ZSTD_isError(ret)) {
-		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
-		return -1;
-	}
-
+	data->comp_level = level;
+	data->dstream = NULL;
+	data->cstream = NULL;
 	return 0;
 }
 
@@ -54,7 +28,7 @@ int zstd_fini(struct zstd_data *data)
 	return 0;
 }
 
-size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
+ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
 				       size_t process_header(void *record, size_t increment))
 {
@@ -63,6 +37,21 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t
 	ZSTD_outBuffer output;
 	void *record;
 
+	if (!data->cstream) {
+		data->cstream = ZSTD_createCStream();
+		if (data->cstream == NULL) {
+			pr_err("Couldn't create compression stream.\n");
+			return -1;
+		}
+
+		ret = ZSTD_initCStream(data->cstream, data->comp_level);
+		if (ZSTD_isError(ret)) {
+			pr_err("Failed to initialize compression stream: %s\n",
+				ZSTD_getErrorName(ret));
+			return -1;
+		}
+	}
+
 	while (input.pos < input.size) {
 		record = dst;
 		size = process_header(record, 0);
@@ -96,6 +85,20 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	ZSTD_inBuffer input = { src, src_size, 0 };
 	ZSTD_outBuffer output = { dst, dst_size, 0 };
 
+	if (!data->dstream) {
+		data->dstream = ZSTD_createDStream();
+		if (data->dstream == NULL) {
+			pr_err("Couldn't create decompression stream.\n");
+			return 0;
+		}
+
+		ret = ZSTD_initDStream(data->dstream);
+		if (ZSTD_isError(ret)) {
+			pr_err("Failed to initialize decompression stream: %s\n",
+				ZSTD_getErrorName(ret));
+			return 0;
+		}
+	}
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-- 
2.43.0.rc1.413.gea7ed67945-goog

