Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30978788C69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjHYP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjHYP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:26:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518D2134;
        Fri, 25 Aug 2023 08:25:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a41031768so910476b3a.3;
        Fri, 25 Aug 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977155; x=1693581955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uVEm7+1ZpaZQWr2bgHUfzl7YJu5UdkQlkIaC2+5AOr8=;
        b=V2DAPtAP2YiMNmhoRB+6Fgu1VyiBnOg4q6HEPh14rBH713VmOtwSXEyVizcBsF1rev
         mQ+rcwCv1OWamUtlrGjejVcHcQSLfb5vOCCtnKN25yJO8Cafgl6rIrNOnrFLlVVTvyvn
         vddOxwcGfC+wxN5m5sRnIB3YA0H7tIEamEx4OJNIi1pai7E+Immiwhmi2uEUNirnAqlc
         7prBfuHnB/+QyFEZDEKskQtf7cdYY4AmqFazJS+Gd/fN+EmTThNuTpwn4QdJ8Z5VWApy
         QxkGNt6pTxNU8D654krE+z9MnaWWHvWG9zjvj1S+ePxvhZtNGWmqe7QUnxZa+yKtrGnk
         8zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977155; x=1693581955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVEm7+1ZpaZQWr2bgHUfzl7YJu5UdkQlkIaC2+5AOr8=;
        b=kIUGsoZiZkjT2a/eQC+hh2RsbVg6EqAS2brNFft+6RivVeJTA7g0804WJ6h7nHDJR6
         PKJHSecn2TEawgg6H8DD6bgeQV6+inAN48b6BCEIHTG2AhnTXaoxpW3EocJRgcWFAXB2
         c6Ldj5zYbiVAG52wiP5TC9Lgl7j6dYUdUUIUgzNFkSqYr90BrDZRYOREu26AAhGtL1dg
         WRoHuNpUNBp8vSeGfs2mOvnb5yD06JbomyivtM6Kd7WieY7D8ldIjSxdWgSE11UzBSJ0
         YvkWNkI6WAfRYNc3ly+FOgovLvfydu+BCBAo8gzxz1LmNvb318yOW/j2IVzUDE8uQiBr
         3aWw==
X-Gm-Message-State: AOJu0Yz8go98u/fwJsKDFgeCmqqXhFw70LFxW/vKp23jQnBsCiky8qZK
        TZpfwJ+pBv5fWj7RS3cpYIgQcHjpJjU=
X-Google-Smtp-Source: AGHT+IFTwQdNWRKUjc71WQe+NJ9LOhjD2xkoouMwBYmnuTBgPYuTt0QiSCrXMTk5TqjbWufUpqfykA==
X-Received: by 2002:a05:6a20:3d81:b0:148:658a:a73d with SMTP id s1-20020a056a203d8100b00148658aa73dmr20056039pzi.5.1692977155329;
        Fri, 25 Aug 2023 08:25:55 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b006879493aca0sm1701748pfn.26.2023.08.25.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:25:54 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, stable@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 1/4] perf tools: Handle old data in PERF_RECORD_ATTR
Date:   Fri, 25 Aug 2023 08:25:49 -0700
Message-ID: <20230825152552.112913-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PERF_RECORD_ATTR is used for a pipe mode to describe an event with
attribute and IDs.  The ID table comes after the attr and it calculate
size of the table using the total record size and the attr size.

  n_ids = (total_record_size - end_of_the_attr_field) / sizeof(u64)

This is fine for most use cases, but sometimes it saves the pipe output
in a file and then process it later.  And it becomes a problem if there
is a change in attr size between the record and report.

  $ perf record -o- > perf-pipe.data  # old version
  $ perf report -i- < perf-pipe.data  # new version

For example, if the attr size is 128 and it has 4 IDs, then it would
save them in 168 byte like below:

   8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
 128 byte: perf event attr { .size = 128, ... },
  32 byte: event IDs [] = { 1234, 1235, 1236, 1237 },

But when report later, it thinks the attr size is 136 then it only read
the last 3 entries as ID.

   8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
 136 byte: perf event attr { .size = 136, ... },
  24 byte: event IDs [] = { 1235, 1236, 1237 },  // 1234 is missing

So it should use the recorded version of the attr.  The attr has the
size field already then it should honor the size when reading data.

Fixes: 2c46dbb517a10 ("perf: Convert perf header attrs into attr events")
Cc: stable@vger.kernel.org
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Keep this version before the libperf change so that it can go through
the stable versions.

 tools/perf/util/header.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74..f89321cbfdee 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4381,7 +4381,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
 {
-	u32 i, ids, n_ids;
+	u32 i, n_ids;
+	u64 *ids;
 	struct evsel *evsel;
 	struct evlist *evlist = *pevlist;
 
@@ -4397,9 +4398,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 
 	evlist__add(evlist, evsel);
 
-	ids = event->header.size;
-	ids -= (void *)&event->attr.id - (void *)event;
-	n_ids = ids / sizeof(u64);
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids = n_ids / sizeof(u64);
 	/*
 	 * We don't have the cpu and thread maps on the header, so
 	 * for allocating the perf_sample_id table we fake 1 cpu and
@@ -4408,8 +4408,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
+	ids = (void *)&event->attr.attr + event->attr.attr.size;
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

