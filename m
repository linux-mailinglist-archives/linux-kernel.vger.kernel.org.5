Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E37BE9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbjJISlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbjJISk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:40:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35210C2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:40:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e8ebc0376so72644617b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876808; x=1697481608; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2w50121eaJxmD5xi4lyi9EP2qbUj9KHP7ryysYJjsrs=;
        b=LvSI3xcv1Pv0J5NIglp/ZC6IwgLyvnx/moBjo7CLmpirHKURidYO8kyPX5ATJN+/9X
         FIvOxsRuvv331fUYCkfSf+k+oJcwCp/Y92K03TvqsygFXs7jI2ydoWAdxNYCP94Ebs6b
         jFscQG+mTRb3r+0fKFzrQ7x9jTCfWJy67/vbyM7E/QXB+mQSWdElZeZ/N5s8417l03+I
         Xt9s4i6tC/21Q/EGV5aTbgVJQyIEJ0a5H5L2MehRSrkg3BkqVTaNCrymHd58jMnHRbEp
         J64iJyeYt6xjztb2imDCE5Ywax97cgxpyai4P3zAKIbLOmwBr0IHVQRJ7OJwqWdRAU+P
         ui+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876808; x=1697481608;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2w50121eaJxmD5xi4lyi9EP2qbUj9KHP7ryysYJjsrs=;
        b=QMx2JfS2xKIXF0fQn5GPROZEW7Rx+YrKJNkvM++htTSFRKfjiAHGYNKecxYgEMmySP
         cVazaAwc3yO8rs5oSK2NQhFT3kkv5kgJ5ULrPSuK873hoHWPIICtXfh7cw/1JjOc3uZs
         QKkxw0Si08aIidkNt/+Ui5kfHJJdiKid4nCSsU+k7oQg50hQZahX78VSVEx1hloXLeOk
         2ryQ1Z+LAOch8frDnRhLUozN925Rny2/dyW84jMgMBZVYboNWNLG4OUZzmmkM6y/RLcs
         Sz0MEe1G4KYN/HIV7Or98BzU+mhrh4FwYRCDdzDt3ZcqJuzx7c0nG+am+fyDrDY/loDH
         CMBw==
X-Gm-Message-State: AOJu0Ywg3s88oE2/41NuOCDiP/ii08KTf+4t4MDjAA03pETuaimp/iEM
        +ZlAH+Dl7k7mveXYML6+ZVOH3TTlEU1V
X-Google-Smtp-Source: AGHT+IGiCnrYwl2bz9V5BPunBrn18TVaUdmOO32yw1ylQCOt1vaQvnidceAE50bXIJfV7pObT3lh6Dqz9yAl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bc0d:0:b0:58c:b45f:3e94 with SMTP id
 a13-20020a81bc0d000000b0058cb45f3e94mr290065ywi.8.1696876808338; Mon, 09 Oct
 2023 11:40:08 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:19 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-19-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 17/18] perf header: Fix various error path memory leaks
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 60 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d812e1e371a7..e86b9439ffee 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2573,7 +2573,7 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 {
 	u32 nr, i;
-	char *str;
+	char *str = NULL;
 	struct strbuf sb;
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
@@ -2601,7 +2601,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
 			goto error;
 		size += string_size(str);
-		free(str);
+		zfree(&str);
 	}
 	ph->env.sibling_cores = strbuf_detach(&sb, NULL);
 
@@ -2620,7 +2620,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
 			goto error;
 		size += string_size(str);
-		free(str);
+		zfree(&str);
 	}
 	ph->env.sibling_threads = strbuf_detach(&sb, NULL);
 
@@ -2684,7 +2684,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
 			goto error;
 		size += string_size(str);
-		free(str);
+		zfree(&str);
 	}
 	ph->env.sibling_dies = strbuf_detach(&sb, NULL);
 
@@ -2699,6 +2699,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 
 error:
 	strbuf_release(&sb);
+	zfree(&str);
 free_cpu:
 	zfree(&ph->env.cpu);
 	return -1;
@@ -2736,10 +2737,9 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		n->map = perf_cpu_map__new(str);
+		free(str);
 		if (!n->map)
 			goto error;
-
-		free(str);
 	}
 	ff->ph->env.nr_numa_nodes = nr;
 	ff->ph->env.numa_nodes = nodes;
@@ -2913,10 +2913,10 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		return -1;
 
 	for (i = 0; i < cnt; i++) {
-		struct cpu_cache_level c;
+		struct cpu_cache_level *c = &caches[i];
 
 		#define _R(v)						\
-			if (do_read_u32(ff, &c.v))\
+			if (do_read_u32(ff, &c->v))			\
 				goto out_free_caches;			\
 
 		_R(level)
@@ -2926,22 +2926,25 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		#undef _R
 
 		#define _R(v)					\
-			c.v = do_read_string(ff);		\
-			if (!c.v)				\
-				goto out_free_caches;
+			c->v = do_read_string(ff);		\
+			if (!c->v)				\
+				goto out_free_caches;		\
 
 		_R(type)
 		_R(size)
 		_R(map)
 		#undef _R
-
-		caches[i] = c;
 	}
 
 	ff->ph->env.caches = caches;
 	ff->ph->env.caches_cnt = cnt;
 	return 0;
 out_free_caches:
+	for (i = 0; i < cnt; i++) {
+		free(caches[i].type);
+		free(caches[i].size);
+		free(caches[i].map);
+	}
 	free(caches);
 	return -1;
 }
@@ -3585,18 +3588,16 @@ static int perf_header__adds_write(struct perf_header *header,
 				   struct feat_copier *fc)
 {
 	int nr_sections;
-	struct feat_fd ff;
+	struct feat_fd ff = {
+		.fd  = fd,
+		.ph = header,
+	};
 	struct perf_file_section *feat_sec, *p;
 	int sec_size;
 	u64 sec_start;
 	int feat;
 	int err;
 
-	ff = (struct feat_fd){
-		.fd  = fd,
-		.ph = header,
-	};
-
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
 	if (!nr_sections)
 		return 0;
@@ -3623,6 +3624,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	err = do_write(&ff, feat_sec, sec_size);
 	if (err < 0)
 		pr_debug("failed to write feature section\n");
+	free(ff.buf); /* TODO: added to silence clang-tidy. */
 	free(feat_sec);
 	return err;
 }
@@ -3630,11 +3632,11 @@ static int perf_header__adds_write(struct perf_header *header,
 int perf_header__write_pipe(int fd)
 {
 	struct perf_pipe_file_header f_header;
-	struct feat_fd ff;
+	struct feat_fd ff = {
+		.fd = fd,
+	};
 	int err;
 
-	ff = (struct feat_fd){ .fd = fd };
-
 	f_header = (struct perf_pipe_file_header){
 		.magic	   = PERF_MAGIC,
 		.size	   = sizeof(f_header),
@@ -3645,7 +3647,7 @@ int perf_header__write_pipe(int fd)
 		pr_debug("failed to write perf pipe header\n");
 		return err;
 	}
-
+	free(ff.buf);
 	return 0;
 }
 
@@ -3658,11 +3660,12 @@ static int perf_session__do_write_header(struct perf_session *session,
 	struct perf_file_attr   f_attr;
 	struct perf_header *header = &session->header;
 	struct evsel *evsel;
-	struct feat_fd ff;
+	struct feat_fd ff = {
+		.fd = fd,
+	};
 	u64 attr_offset;
 	int err;
 
-	ff = (struct feat_fd){ .fd = fd};
 	lseek(fd, sizeof(f_header), SEEK_SET);
 
 	evlist__for_each_entry(session->evlist, evsel) {
@@ -3670,6 +3673,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
+			free(ff.buf);
 			return err;
 		}
 	}
@@ -3695,6 +3699,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		err = do_write(&ff, &f_attr, sizeof(f_attr));
 		if (err < 0) {
 			pr_debug("failed to write perf header attribute\n");
+			free(ff.buf);
 			return err;
 		}
 	}
@@ -3705,8 +3710,10 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	if (at_exit) {
 		err = perf_header__adds_write(header, evlist, fd, fc);
-		if (err < 0)
+		if (err < 0) {
+			free(ff.buf);
 			return err;
+		}
 	}
 
 	f_header = (struct perf_file_header){
@@ -3728,6 +3735,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	lseek(fd, 0, SEEK_SET);
 	err = do_write(&ff, &f_header, sizeof(f_header));
+	free(ff.buf);
 	if (err < 0) {
 		pr_debug("failed to write perf header\n");
 		return err;
-- 
2.42.0.609.gbb76f46606-goog

