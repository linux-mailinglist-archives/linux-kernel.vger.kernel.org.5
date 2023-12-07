Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C0807DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442077AbjLGBRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441968AbjLGBR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:29 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB75D5E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3a1f612b3so1802567b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911854; x=1702516654; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZVma1lrp2oy91ELMTmGFGFg9/I25IFe6Z4TysewRjs=;
        b=x9Q/OiL4uAbpgM1f8c21FZuKuVNpBnUW53hzBC/jHYn3n+fHEwnKWSzQZBrrna1VNh
         9Vtgm65ZcUlOriYR1tMVO6YlylnQV3k9Es4NX6VfMP4keGxa0v4rvlMrxTUAmc2H56G4
         7gpizSlS7fARuSHoxTCdjhGRTzyWkYlbIGkVZVNHSIIlXHO/sqNTq2mnAFPuUHpK3567
         d5QnGwOMdcz8vUXKepe8+Gq2VF578yzSHqm1oPWnaTVlbCjYGEO1VcTsVzPCc/5GAk/R
         5osUvRo4kOsdLOS8sHtGbsVkyAUzcBxvijC8wszI1mMClWZN4NEIxuE0WSVcBJaF4+QZ
         08tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911854; x=1702516654;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZVma1lrp2oy91ELMTmGFGFg9/I25IFe6Z4TysewRjs=;
        b=b4iqkj+HYKMdcZmNWnEU8V+DWgHLm3x45AWmOTmUKewB95M8P6oY4jQn2nGv6EKUPQ
         DHOmfnwrulSKIyzJFWBCoa35cI6+NXYnPXYoX0VbqbdNq7t1lHKx0NRXwNVrMBfm6Qs5
         QUWvvkjwDxkI8rxlq8fEdnpVwFokGvjAcKoqIb5xpkf1ZUrvlCDiOvVCLWlqucgNuslT
         aBDsSfOMHVkhmx0T0DaxkSJyuShyODEgTkAJW4EXuqsCf7rfp3MK8csRXqXbHWaL/zAo
         YKYFfdq14nMtUvyrWtphOU59lUH4zkp0mJBuQjRnq4qA4EF+moZon4mKwYUq7XtmGQWi
         rXCQ==
X-Gm-Message-State: AOJu0YwAe45/hiYU2P6iDUKSx5DUduCo3hE2IczfV9gTGPHfDskQ2SHr
        DpwHd3oLwaccjZ7snAWkfchwNis5lM74
X-Google-Smtp-Source: AGHT+IGXr1N17uDcE3z+qjpA3hfU04mTcYqcsLONo1h/vQUmSMh8GIVV09jBjCzZD8HWVaEj0DqTtHxTnz9d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2888:b0:5d3:cca8:1d59 with SMTP
 id ee8-20020a05690c288800b005d3cca81d59mr29912ywb.5.1701911854339; Wed, 06
 Dec 2023 17:17:34 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:37 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-4-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 03/47] perf events x86: Use function to add missing lock
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from loop macro maps__for_each_entry to maps__for_each_map
function that takes a callback. The function holds the maps lock,
which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/event.c | 103 +++++++++++++++++--------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 5741ffe47312..e65b7dbe27fb 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -14,66 +14,79 @@
 
 #if defined(__x86_64__)
 
-int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine)
+struct perf_event__synthesize_extra_kmaps_cb_args {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	union perf_event *event;
+};
+
+static int perf_event__synthesize_extra_kmaps_cb(struct map *map, void *data)
 {
-	int rc = 0;
-	struct map_rb_node *pos;
-	struct maps *kmaps = machine__kernel_maps(machine);
-	union perf_event *event = zalloc(sizeof(event->mmap) +
-					 machine->id_hdr_size);
+	struct perf_event__synthesize_extra_kmaps_cb_args *args = data;
+	union perf_event *event = args->event;
+	struct kmap *kmap;
+	size_t size;
 
-	if (!event) {
-		pr_debug("Not enough memory synthesizing mmap event "
-			 "for extra kernel maps\n");
-		return -1;
-	}
+	if (!__map__is_extra_kernel_map(map))
+		return 0;
 
-	maps__for_each_entry(kmaps, pos) {
-		struct kmap *kmap;
-		size_t size;
-		struct map *map = pos->map;
+	kmap = map__kmap(map);
 
-		if (!__map__is_extra_kernel_map(map))
-			continue;
+	size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
+		      PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
+		      args->machine->id_hdr_size;
 
-		kmap = map__kmap(map);
+	memset(event, 0, size);
 
-		size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
-		       PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
-		       machine->id_hdr_size;
+	event->mmap.header.type = PERF_RECORD_MMAP;
 
-		memset(event, 0, size);
+	/*
+	 * kernel uses 0 for user space maps, see kernel/perf_event.c
+	 * __perf_event_mmap
+	 */
+	if (machine__is_host(args->machine))
+		event->header.misc = PERF_RECORD_MISC_KERNEL;
+	else
+		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		event->mmap.header.type = PERF_RECORD_MMAP;
+	event->mmap.header.size = size;
 
-		/*
-		 * kernel uses 0 for user space maps, see kernel/perf_event.c
-		 * __perf_event_mmap
-		 */
-		if (machine__is_host(machine))
-			event->header.misc = PERF_RECORD_MISC_KERNEL;
-		else
-			event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+	event->mmap.start = map__start(map);
+	event->mmap.len   = map__size(map);
+	event->mmap.pgoff = map__pgoff(map);
+	event->mmap.pid   = args->machine->pid;
 
-		event->mmap.header.size = size;
+	strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
 
-		event->mmap.start = map__start(map);
-		event->mmap.len   = map__size(map);
-		event->mmap.pgoff = map__pgoff(map);
-		event->mmap.pid   = machine->pid;
+	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
+		return -1;
 
-		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
+	return 0;
+}
 
-		if (perf_tool__process_synth_event(tool, event, machine,
-						   process) != 0) {
-			rc = -1;
-			break;
-		}
+int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	int rc;
+	struct maps *kmaps = machine__kernel_maps(machine);
+	struct perf_event__synthesize_extra_kmaps_cb_args args = {
+		.tool = tool,
+		.process = process,
+		.machine = machine,
+		.event = zalloc(sizeof(args.event->mmap) + machine->id_hdr_size),
+	};
+
+	if (!args.event) {
+		pr_debug("Not enough memory synthesizing mmap event "
+			 "for extra kernel maps\n");
+		return -1;
 	}
 
-	free(event);
+	rc = maps__for_each_map(kmaps, perf_event__synthesize_extra_kmaps_cb, &args);
+
+	free(args.event);
 	return rc;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

