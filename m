Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12A810656
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378069AbjLMAOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378140AbjLMAOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41DED54;
        Tue, 12 Dec 2023 16:13:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d06819a9cbso38208615ad.1;
        Tue, 12 Dec 2023 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426433; x=1703031233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxLAF5RjXuu8mgch2ETJfxdZfj9JgVVMGl5qHF6yEa4=;
        b=Lof7l3mSxSFZZktBxx/wmeIf5p7QoPcHcEhSEq2/k7hzIwb8hqBUm2WT7JmvJwZjl0
         tXpagBxvR4Sv5efpIbw8AIDQZ8jPSzQhGsIIBB9OsucpsPA+HJc2E8/OmRUdDp3TE3Vf
         0DfKsqeo0cGxCVQcWEeC+GKfzomXDUH++tTgHWuz4Na7HiMeSUBJvkf061sqluZz8pN+
         8O/8hJ4igbw6bkuKW4iLxR56V6FQW/4oCwhiereE/gz8fAELa+y8LVv8h56+SwTkSmWj
         94Ec5nvp3jeTSbjbeZpkPyWXftPNpNP+9ptgSojKJdMclqXsrPGM6VC0wgG1MOEaTxEo
         Ef2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426433; x=1703031233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxLAF5RjXuu8mgch2ETJfxdZfj9JgVVMGl5qHF6yEa4=;
        b=vGoyUPDq7QZr/TqQ45L1Pd29xxn0am2LCzNYe0y6Y7N1XhsPBZIDoqN8etmAxm//p8
         MXSZQZH4yIzKqde9Rb/MlkGWxYc/QRrAx8dt5yalCkAeYF0eluQP9jLTzPssrxaUjfJE
         4h/2x6stsydXeTtpLkbmXWayuvz8gFRJ50um0Y/D/R2Fa08wuxE+lUW7YtKZHfsXb2ne
         BnuAXLg/7KaTtrWsuM1YhnnF1gK2Jau3V9iBO611fWuMrTpVGm30N7xV6ccf6jKa9gOY
         l6YsQxBOJVi+WOKpUTHzbF/OkTz0V3crcNZ8yTOb+Y+lGDRHglfcqfbL4/aPncSohjJg
         e05Q==
X-Gm-Message-State: AOJu0YxgAY8R6I1w1/JXkVAQ7dV3ZQY6tqtSC8HmLC97Sax1CfmiGBz/
        L8JF0tGdaCLXxw7tYTH0RUY=
X-Google-Smtp-Source: AGHT+IEr6tiiQWA+np8ums6vuW+JECMdOvPW+LcNfuzmkf6oyx4mYwGqbVcoOpzvw3Jy31EM/I1MPw==
X-Received: by 2002:a17:903:1c3:b0:1d3:4783:ce7 with SMTP id e3-20020a17090301c300b001d347830ce7mr860001plh.103.1702426432635;
        Tue, 12 Dec 2023 16:13:52 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:51 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 15/17] perf annotate: Support event group display
Date:   Tue, 12 Dec 2023 16:13:21 -0800
Message-ID: <20231213001323.718046-16-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When events are grouped together, it'd be natural to show them at once
like in other mode.  Handle group leaders with members to collect the
number of samples together and display like below:

  $ perf annotate --data-type --group
  ...
  Annotate type: 'struct page' in vmlinux (1 samples):
   event[0] = cpu/mem-loads,ldlat=30/P
   event[1] = cpu/mem-stores/P
   event[2] = dummy:u
  ============================================================================
                            samples     offset       size  field
            1          0          0          0         64  struct page     {
            0          0          0          0          8      long unsigned int  flags;
            0          0          0          8         40      union       {
            0          0          0          8         40          struct          {
            0          0          0          8         16              union       {
            0          0          0          8         16                  struct list_head       lru {
            0          0          0          8          8                      struct list_head*  next;
            0          0          0         16          8                      struct list_head*  prev;
                                                                           };
            0          0          0          8         16                  struct          {
            0          0          0          8          8                      void*      __filler;
            0          0          0         16          4                      unsigned int       mlock_count;
                                                                           };
            0          0          0          8         16                  struct list_head       buddy_list {
            0          0          0          8          8                      struct list_head*  next;
            0          0          0         16          8                      struct list_head*  prev;
                                                                           };

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 89 ++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8acfbbc1b9c2..3956ea1334cc 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -325,19 +325,64 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 	return symbol__tty_annotate2(&he->ms, evsel);
 }
 
+static void print_annotated_data_header(struct hist_entry *he, struct evsel *evsel)
+{
+	struct dso *dso = map__dso(he->ms.map);
+	int nr_members = 1;
+	int nr_samples = he->stat.nr_events;
+
+	if (evsel__is_group_event(evsel)) {
+		struct hist_entry *pair;
+
+		list_for_each_entry(pair, &he->pairs.head, pairs.node)
+			nr_samples += pair->stat.nr_events;
+	}
+
+	printf("Annotate type: '%s' in %s (%d samples):\n",
+	       he->mem_type->self.type_name, dso->name, nr_samples);
+
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+		int i = 0;
+
+		for_each_group_evsel(pos, evsel)
+			printf(" event[%d] = %s\n", i++, pos->name);
+
+		nr_members = evsel->core.nr_members;
+	}
+
+	printf("============================================================================\n");
+	printf("%*s %10s %10s  %s\n", 11 * nr_members, "samples", "offset", "size", "field");
+}
+
 static void print_annotated_data_type(struct annotated_data_type *mem_type,
 				      struct annotated_member *member,
 				      struct evsel *evsel, int indent)
 {
 	struct annotated_member *child;
 	struct type_hist *h = mem_type->histograms[evsel->core.idx];
-	int i, samples = 0;
+	int i, nr_events = 1, samples = 0;
 
 	for (i = 0; i < member->size; i++)
 		samples += h->addr[member->offset + i].nr_samples;
+	printf(" %10d", samples);
+
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+
+		for_each_group_member(pos, evsel) {
+			h = mem_type->histograms[pos->core.idx];
+
+			samples = 0;
+			for (i = 0; i < member->size; i++)
+				samples += h->addr[member->offset + i].nr_samples;
+			printf(" %10d", samples);
+		}
+		nr_events = evsel->core.nr_members;
+	}
 
-	printf(" %10d %10d %10d  %*s%s\t%s",
-	       samples, member->offset, member->size, indent, "", member->type_name,
+	printf(" %10d %10d  %*s%s\t%s",
+	       member->offset, member->size, indent, "", member->type_name,
 	       member->var_name ?: "");
 
 	if (!list_empty(&member->children))
@@ -347,7 +392,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 		print_annotated_data_type(mem_type, child, evsel, indent + 4);
 
 	if (!list_empty(&member->children))
-		printf("%*s}", 35 + indent, "");
+		printf("%*s}", 11 * nr_events + 24 + indent, "");
 	printf(";\n");
 }
 
@@ -391,8 +436,6 @@ static void hists__find_annotations(struct hists *hists,
 		}
 
 		if (ann->data_type) {
-			struct dso *dso = map__dso(he->ms.map);
-
 			/* skip unknown type */
 			if (he->mem_type->histograms == NULL)
 				goto find_next;
@@ -414,11 +457,7 @@ static void hists__find_annotations(struct hists *hists,
 					goto find_next;
 			}
 
-			printf("Annotate type: '%s' in %s (%d samples):\n",
-				he->mem_type->self.type_name, dso->name, he->stat.nr_events);
-			printf("============================================================================\n");
-			printf(" %10s %10s %10s  %s\n", "samples", "offset", "size", "field");
-
+			print_annotated_data_header(he, evsel);
 			print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
 			printf("\n");
 			goto find_next;
@@ -521,8 +560,20 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			evsel__reset_sample_bit(pos, CALLCHAIN);
 			evsel__output_resort(pos, NULL);
 
-			if (symbol_conf.event_group && !evsel__is_group_leader(pos))
+			/*
+			 * An event group needs to display other events too.
+			 * Let's delay printing until other events are processed.
+			 */
+			if (symbol_conf.event_group) {
+				if (!evsel__is_group_leader(pos)) {
+					struct hists *leader_hists;
+
+					leader_hists = evsel__hists(evsel__leader(pos));
+					hists__match(leader_hists, hists);
+					hists__link(leader_hists, hists);
+				}
 				continue;
+			}
 
 			hists__find_annotations(hists, pos, ann);
 		}
@@ -533,6 +584,20 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		goto out;
 	}
 
+	/* Display group events together */
+	evlist__for_each_entry(session->evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+		u32 nr_samples = hists->stats.nr_samples;
+
+		if (nr_samples == 0)
+			continue;
+
+		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
+			continue;
+
+		hists__find_annotations(hists, pos, ann);
+	}
+
 	if (use_browser == 2) {
 		void (*show_annotations)(void);
 
-- 
2.43.0.472.g3155946c3a-goog

