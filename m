Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627C7FACFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjK0WJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjK0WJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:09:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53A187
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ccc8b7f578so74965077b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122965; x=1701727765; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LW5iu3CW2lKtmsJ3ZW+qTTKgcFmtY4yDP5ns7rJcimg=;
        b=Ik6rg0RijjlMXBcDelVnY03go2HXnrP5sD7WhESFH5F/0vwbI13yht3ikAZshpcvXg
         k3aS+LIdf8VG0dGQsLGTpj0DQJwhGh4I0eA9wgkwtJKaGKSu61P+8jcdTYSwEzb9wg0b
         eoQAJ1Ju3T+JRd7WZFwyaHcFQG7TML7EZcERn1/e6IwuR7fmURTKijxkVal2aeE785x7
         Yoxlfxmyeu97NOVIzXO9ZPcZswVSpqQw3VDvGbS9kDZ45gzJBckEswOngkkm6X5+SzdG
         oGlYlqQ1bYsMp+p9YgOQALga+8AUEpeNJFwqunzxmEDxit1GrBioTTdX4M2RnvwwQbsE
         A7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122965; x=1701727765;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW5iu3CW2lKtmsJ3ZW+qTTKgcFmtY4yDP5ns7rJcimg=;
        b=IauzdJzBAIGnhiglOd6nWLpFsGvO6nQjP+Zwy0bQ7J3H5IM8aiP5GgAspEgCW6zepq
         PlcPE0qsi7rNEBwbC8VekpMTzUxwO+oQYGJYKb1xWvw0SrRRG0HlJHf6rk3YXyW0R0tl
         dsfhloOUpApnv0ahsZhjFv8/ZVMd/cahB0TGKkTBNAAXdTTnP/+b+oSdVcBDUSgdm9SU
         9zpbDoFGPiv2LEQRXgKNd/zx8uG7tcyknwsJaqtxzyphTsj94E+oclxFMWaSqOs4YEAk
         Tgr+YksfseFlLkYzVwOLO4Vq5yCv9weMwhKDVIW5iVyAQh2M76wa7UPiAtQ12o/rier3
         mCRg==
X-Gm-Message-State: AOJu0Yww6Sctqt6Ia4J5kTb84pyuzlqSX6GiqVeUuZe2ZfyPfbRojwEO
        63UXqhENICVDaMZF2hen1NfxzsMS0hWL
X-Google-Smtp-Source: AGHT+IHrjzGaMohbnyZmZunt0pY/JBcPIj9iQ71g+HIknVMYLcz9ZiMJpSadREjAdP7yXiUZcSiIkkocQx/y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:d114:0:b0:dae:b98c:6ffa with SMTP id
 i20-20020a25d114000000b00daeb98c6ffamr375100ybg.8.1701122964882; Mon, 27 Nov
 2023 14:09:24 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:14 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-3-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 02/50] libperf: Lazily allocate/size mmap event copy
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

The event copy in the mmap is used to have storage to read an
event. Not all users of mmaps read the events, such as perf
record. The amount of buffer was also statically set to
PERF_SAMPLE_MAX_SIZE rather than the amount necessary from the
header's event size. Switch to a model where the event_copy is
reallocated if too small to the event's size. This adds the potential
for the event to move, so if a copy of the event pointer were stored
it could be broken. All the current users do:

  while(event = perf_mmap__read_event()) { ... }

and so they would be broken due to the event being overwritten if they
had stored the pointer. Manual inspection and address sanitizer
testing also shows the event pointer not being stored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/mmap.h |  3 ++-
 tools/lib/perf/mmap.c                  | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5a062af8e9d8..5f08cab61ece 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -33,7 +33,8 @@ struct perf_mmap {
 	bool			 overwrite;
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
-	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			*event_copy;
+	size_t			 event_copy_sz;
 	struct perf_mmap	*next;
 };
 
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 2184814b37dd..c829db7bf1fa 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -19,6 +19,7 @@
 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
 		     bool overwrite, libperf_unmap_cb_t unmap_cb)
 {
+	/* Assume fields were zero initialized. */
 	map->fd = -1;
 	map->overwrite = overwrite;
 	map->unmap_cb  = unmap_cb;
@@ -51,13 +52,19 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
-	if (map && map->base != NULL) {
+	if (!map)
+		return;
+
+	free(map->event_copy);
+	map->event_copy = NULL;
+	map->event_copy_sz = 0;
+	if (map->base) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
 		map->fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
-	if (map && map->unmap_cb)
+	if (map->unmap_cb)
 		map->unmap_cb(map);
 }
 
@@ -223,9 +230,17 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 		 */
 		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
 			unsigned int offset = *startp;
-			unsigned int len = min(sizeof(*event), size), cpy;
+			unsigned int len = size, cpy;
 			void *dst = map->event_copy;
 
+			if (size > map->event_copy_sz) {
+				dst = realloc(map->event_copy, size);
+				if (!dst)
+					return NULL;
+				map->event_copy = dst;
+				map->event_copy_sz = size;
+			}
+
 			do {
 				cpy = min(map->mask + 1 - (offset & map->mask), len);
 				memcpy(dst, &data[offset & map->mask], cpy);
-- 
2.43.0.rc1.413.gea7ed67945-goog

