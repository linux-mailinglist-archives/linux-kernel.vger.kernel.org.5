Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45357A2DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 06:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjIPEJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 00:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbjIPEJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 00:09:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BB1BD1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 21:09:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0327b75dso23340357b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 21:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694837359; x=1695442159; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zipWfEEsnum9dauMSnXBQTgBSpY3twUkBA45BcLxABI=;
        b=idKeyoRr24pRaWecrAw7DJ7O9deBaDjKus4zQYhZ9wDfziiLGXTkkEEyR1UTiuwbL4
         dyQWK0hFXLkmTtNYLEGAL1zunC0pg2o/4bpzGYZnFFemnXi8v6FzVuI+XqdK5F5qvz4c
         uRkSBDmavtyTe3CQINeKdB9+sbwzFFQhjqgegufmE/50U3B8qAdB1y6HL6OUQPEEfm5h
         ECoMKeMO8t122ofA247EgWpRt8bNcMlGqclnRKDDMvJqozDsJNCoMOsNP/EVzdzXaXKM
         ++fVWTEa4Tlw5QrMra9BcjsWyzQBPK2IUi6qhouRKFgc6KwPU19xK0WyfawPQZtmCnRT
         sbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694837359; x=1695442159;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zipWfEEsnum9dauMSnXBQTgBSpY3twUkBA45BcLxABI=;
        b=jPM9RIuNpYyj5I0XYIJvmsfn1kYuVXg4tfO0V2To7cmPalf4J4oUbSj/8D2e7yattV
         TpYqMF0rRzzGwQoae0oxbF/kb9LjXi3OYot0I+l9tBI4v0GcpxstTt0I1Tu1iogLNCqR
         y/eCGpkHBk4Mp0oCDV0EzH+kZKfgt3OO7EEP0ujOMmbU90jsFUxdrYaR2K3sgJljn3Cq
         sT7QFabcI+Pqo8OccCWEZX44wpG2euRANKzzA0vEN4+n1hj98DUSHvWqR814RfyZgPe1
         mxr+E9BaiqY8EpfZShPWTjJrKqmkx6A0z4jR9CHAG+69PajiQZZEjTgizs3wVwc+AAEh
         ZTEQ==
X-Gm-Message-State: AOJu0Yz6qqCfWu14zW0FoApJJoQlARdHBMrurN9tBSYMhOhuPnJcF3+4
        MrrOX5dAdxWmh9n/XUTOcU2s+qG/bjPI
X-Google-Smtp-Source: AGHT+IFCMvRhEqBZ5w3q2IXMRP5+eviNQUZ+p7MKuvjjo68Vr2FD7mxfcCmn3VsoAaiTr1ZuqeKTJZYfjMnZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:de72:1a43:1938:6165])
 (user=irogers job=sendgmr) by 2002:a81:ac60:0:b0:59b:e669:c940 with SMTP id
 z32-20020a81ac60000000b0059be669c940mr96303ywj.5.1694837359199; Fri, 15 Sep
 2023 21:09:19 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:09:15 -0700
Message-Id: <20230916040915.1075620-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
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
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
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

Dummy events are created with an attribute where the period and freq
are zero. evsel__config will then see the uninitialized values and
initialize them in evsel__default_freq_period. As fequency mode is
used by default the dummy event would be set to use frequency
mode. However, this has no effect on the dummy event but does cause
unnecessary timers/interrupts. Avoid this overhead by setting the
period to 1 for dummy events.

evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
period=1. This isn't necessary after this change and so the setting is
removed.

From Stephane:

The dummy event is not counting anything. It is used to collect mmap
records and avoid a race condition during the synthesize mmap phase of
perf record. As such, it should not cause any overhead during active
profiling. Yet, it did. Because of a bug the dummy event was
programmed as a sampling event in frequency mode. Events in that mode
incur more kernel overheads because on timer tick, the kernel has to
look at the number of samples for each event and potentially adjust
the sampling period to achieve the desired frequency. The dummy event
was therefore adding a frequency event to task and ctx contexts we may
otherwise not have any, e.g., perf record -a -e
cpu/event=0x3c,period=10000000/. On each timer tick the
perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
non-zero, then the kernel will loop over ALL the events of the context
looking for frequency mode ones. In doing, so it locks the context,
and enable/disable the PMU of each hw event. If all the events of the
context are in period mode, the kernel will have to traverse the list for
nothing incurring overhead. The overhead is multiplied by a very large
factor when this happens in a guest kernel. There is no need for the
dummy event to be in frequency mode, it does not count anything and
therefore should not cause extra overhead for no reason.

Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 25c3ebe2c2f5..e36da58522ef 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
 		.type	= PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
+		/* Avoid frequency mode for dummy events to avoid associated timers. */
+		.freq = 0,
+		.sample_period = 1,
 	};
 
 	return evsel__new_idx(&attr, evlist->core.nr_entries);
@@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	evsel->core.attr.exclude_kernel = 1;
 	evsel->core.attr.exclude_guest = 1;
 	evsel->core.attr.exclude_hv = 1;
-	evsel->core.attr.freq = 0;
-	evsel->core.attr.sample_period = 1;
 	evsel->core.system_wide = system_wide;
 	evsel->no_aux_samples = true;
 	evsel->name = strdup("dummy:u");
-- 
2.42.0.459.ge4e396fd5e-goog

