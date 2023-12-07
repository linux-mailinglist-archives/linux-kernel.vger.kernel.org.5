Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E04807DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442055AbjLGBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442165AbjLGBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D618170D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d351694be7so1632847b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911869; x=1702516669; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3o96R63h4tW+QyyZZjx6MH+ZM3C6AiBinWxkS0w0I9s=;
        b=tuX7o+t72YJGCKVUcUGeCW35uDhnwPXNbY23vmltyo64hrqXI3iu3kK5Mmbp6F2A+6
         7eX+YTw5x6TmjAPj9x7XFm3me7K9P2LwWIq7hc9LOjCxViyElwIAO+YkfhGB+XQe4qPa
         GUhTQ2J5CSIjaUl6tTDC8snSjwuEVa1EoxGNI/hsL687epJyFvKaWy/iIGQXmKBLnKMz
         xuO7QDvUZfUjxmf7JTNFH+piSzYmsxA8/JzYS11MCQnSI25a0ecu2ksKvhLHb2YeAWbe
         /PTL7a/LS2VWt8AvQK5ho1DCI76LpkVVn3Vhhm5qtObMjzlKDudwR0k6U5cUNVpcygMO
         7l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911869; x=1702516669;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o96R63h4tW+QyyZZjx6MH+ZM3C6AiBinWxkS0w0I9s=;
        b=t/OnTlMNlRmEeWhp2o/5yjqELqR+2jv4S3ELbCHR1ac9ouihwsKsXnlZ7DHumqxe+W
         uMGyNFVSJHxUFMyj5s4fy9fXp9EXU8sw9n2b9LQbALam9l1n4JqubVF03h2seEpXhPh1
         LrbyFoSDIRyGGw+1QQfbmBKCFQ3drRqfXbhg6PoyMuGe7TcJVrxrkk5HxRIhlsVlwjIS
         28n7PUD4MCQs+W4E4QkJcFWHUaLtkXkYtYGXZ3a+jPr0MednLjHL16mqr7aRRqAebARt
         6xCUjo7gKtRvJwV+m7wxK2yVakrbhL61udyuuNIn5B5+DncxmJnARHUqQeDMg8v6p+Xq
         DTIQ==
X-Gm-Message-State: AOJu0YwzximU0JHx09zDBwmHCpvjOlvwEljgj8Nvw+1duzs+iypnDVOw
        R62RSQyP2nYLA07cs5BHfzFs7Kc37piD
X-Google-Smtp-Source: AGHT+IEldmR3/X81EpZlxZMbgINR4XFgb3uPK8wJLVSwf1670CHlBeFUHwbRDDtLnNjPUaqRivWe4dYfxrO5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be16:0:b0:5ca:20f3:ca21 with SMTP id
 i22-20020a81be16000000b005ca20f3ca21mr31031ywn.1.1701911868933; Wed, 06 Dec
 2023 17:17:48 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:43 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-10-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 09/47] perf synthetic-events: Use function to add missing
 maps lock
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

Switch perf_event__synthesize_modules from loop macro
maps__for_each_entry to maps__for_each_map function that takes
a callback. The function holds the maps lock, which should be
held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 118 ++++++++++++++++-------------
 1 file changed, 67 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a0579c7d7b9e..3712186353fb 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -665,18 +665,74 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
 }
 #endif
 
+struct perf_event__synthesize_modules_maps_cb_args {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	union perf_event *event;
+};
+
+static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
+{
+	struct perf_event__synthesize_modules_maps_cb_args *args = data;
+	union perf_event *event = args->event;
+	struct dso *dso;
+	size_t size;
+
+	if (!__map__is_kmodule(map))
+		return 0;
+
+	dso = map__dso(map);
+	if (symbol_conf.buildid_mmap2) {
+		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		event->mmap2.header.type = PERF_RECORD_MMAP2;
+		event->mmap2.header.size = (sizeof(event->mmap2) -
+					(sizeof(event->mmap2.filename) - size));
+		memset(event->mmap2.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap2.header.size += args->machine->id_hdr_size;
+		event->mmap2.start = map__start(map);
+		event->mmap2.len   = map__size(map);
+		event->mmap2.pid   = args->machine->pid;
+
+		memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
+
+		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
+	} else {
+		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		event->mmap.header.type = PERF_RECORD_MMAP;
+		event->mmap.header.size = (sizeof(event->mmap) -
+					(sizeof(event->mmap.filename) - size));
+		memset(event->mmap.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap.header.size += args->machine->id_hdr_size;
+		event->mmap.start = map__start(map);
+		event->mmap.len   = map__size(map);
+		event->mmap.pid   = args->machine->pid;
+
+		memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
+	}
+
+	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
+		return -1;
+
+	return 0;
+}
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
-	int rc = 0;
-	struct map_rb_node *pos;
+	int rc;
 	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event;
-	size_t size = symbol_conf.buildid_mmap2 ?
-			sizeof(event->mmap2) : sizeof(event->mmap);
+	struct perf_event__synthesize_modules_maps_cb_args args = {
+		.tool = tool,
+		.process = process,
+		.machine = machine,
+	};
+	size_t size = symbol_conf.buildid_mmap2
+		? sizeof(args.event->mmap2)
+		: sizeof(args.event->mmap);
 
-	event = zalloc(size + machine->id_hdr_size);
-	if (event == NULL) {
+	args.event = zalloc(size + machine->id_hdr_size);
+	if (args.event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
 			 "for kernel modules\n");
 		return -1;
@@ -687,53 +743,13 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	 * __perf_event_mmap
 	 */
 	if (machine__is_host(machine))
-		event->header.misc = PERF_RECORD_MISC_KERNEL;
+		args.event->header.misc = PERF_RECORD_MISC_KERNEL;
 	else
-		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
-
-	maps__for_each_entry(maps, pos) {
-		struct map *map = pos->map;
-		struct dso *dso;
+		args.event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		if (!__map__is_kmodule(map))
-			continue;
+	rc = maps__for_each_map(maps, perf_event__synthesize_modules_maps_cb, &args);
 
-		dso = map__dso(map);
-		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
-			event->mmap2.header.type = PERF_RECORD_MMAP2;
-			event->mmap2.header.size = (sizeof(event->mmap2) -
-						(sizeof(event->mmap2.filename) - size));
-			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
-			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = map__start(map);
-			event->mmap2.len   = map__size(map);
-			event->mmap2.pid   = machine->pid;
-
-			memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
-
-			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
-		} else {
-			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
-			event->mmap.header.type = PERF_RECORD_MMAP;
-			event->mmap.header.size = (sizeof(event->mmap) -
-						(sizeof(event->mmap.filename) - size));
-			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = map__start(map);
-			event->mmap.len   = map__size(map);
-			event->mmap.pid   = machine->pid;
-
-			memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
-		}
-
-		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
-			rc = -1;
-			break;
-		}
-	}
-
-	free(event);
+	free(args.event);
 	return rc;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

