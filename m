Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5727A2DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 06:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjIPD5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 23:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjIPD4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 23:56:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837F819BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 20:56:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so3365759276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 20:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694836604; x=1695441404; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bzQLVbdICvR0anuI1LoACUXsVUlI7kEOUbUElnKpCyc=;
        b=z2lK/rL6REsJTz8nWFhbdu3qH1sgSxD6izbmJis5piNDbb1VHMqHMEwYRcB7ooqVXK
         BGR2NPUruPSSvcb6kLWaiwtzUTPegK7eLsjKfxu+lTEcQdQ7bzpw7xtJsnmrn6lH4YLB
         Txb8Aow4JWhfQh9/vFGeNBwp6lOhzOkM5FtytAr35jSreA8mJqNkT/WAPS9nCi4zk0YB
         oIafRoUJPyQmGZJA+fUboIBEfm/5oCPWgOrGpSu9JY6HlH+TllvcILKU20kXnO2YpqEy
         Tpl10wXMT8Xa/lFi/Qv4v+MDVd6h34yp6BYJ06UBL3Wg5Dyeqkxkz0nceOQMvXRfXj7r
         ofIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694836604; x=1695441404;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzQLVbdICvR0anuI1LoACUXsVUlI7kEOUbUElnKpCyc=;
        b=L2iyO8dIaLt+SN5oTY3x+jdaW03CWS36TOklzuAUqcEndKgH1M+p8/AKLeQFUw4nJE
         rff95EGEYnv2c86jKmKKXW2oZo35K74u0QJYzvYdyRdF0hM6doKakcnhx3h0P36ku4rd
         J2co/oYq93lTH577O3GDtaSWaz6Na/IfC23+pdh8j6BF6NJItJuhXHQLujCDYGBN/vg/
         VHp586nb02BTZFrsCgMe4SNP/QSTTNfVCHiIaU2FeRiIuqdmkRsXG9AhCDUluGpXF2to
         pyoFcKFjrPZJAkYdj5U7euSl7Tl0VNV0vqCRYZGR7MeruruPovKemc2rYv4gzuqaG1dZ
         1p0g==
X-Gm-Message-State: AOJu0Yy7y6+ApEujmGlkyhDkYTT/8odxUBUGc/kS7GLm8NeEscgYd3Z/
        ie9X6r4218bVzmrNUwd5xUge1Hhu1chw
X-Google-Smtp-Source: AGHT+IHPl2mfI2FXOQHCNG1ebyKKkDV0rSTCXZae55BeQ1YbUjz4gqpnWaVzSdtYUzwE5EG9x/odWUcTn9JV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:de72:1a43:1938:6165])
 (user=irogers job=sendgmr) by 2002:a05:6902:118a:b0:d80:183c:92b9 with SMTP
 id m10-20020a056902118a00b00d80183c92b9mr90954ybu.4.1694836604799; Fri, 15
 Sep 2023 20:56:44 -0700 (PDT)
Date:   Fri, 15 Sep 2023 20:56:40 -0700
Message-Id: <20230916035640.1074422-1-irogers@google.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

