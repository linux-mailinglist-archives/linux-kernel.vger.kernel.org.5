Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108A7570C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGRAHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRAHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:07:47 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265EBFA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:07:43 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-345d6dc271dso27276355ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689638862; x=1692230862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5A7RBP0ulBeus/Dr/u1dt97uJhS/urrd6iaA4GMRuJs=;
        b=UgCL6BkrsuqpYPHxFkIh7zo+xkSqambpQ2uzj0Pg09bsPkJJX7jsV1Sn5smi9o64Br
         FAg6QOInWJEiVzCdKJIdaDLsWpeWUe4LSGtrdYEPuN2wfLY1xbnoe8Qczsx8odrHVXJf
         qW2uFvPRufkQ/RB1HOGjXOU+dn9XvN3Rp8Mtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689638862; x=1692230862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A7RBP0ulBeus/Dr/u1dt97uJhS/urrd6iaA4GMRuJs=;
        b=joKduxptK89EZWHSDM/bbj5F8EkM7Eb/EtaH2Ucb0bv/fRtnoMAaan0hfPSid1De+N
         ZWGJQd5GyVNs7zuWStkgdA0+eO4pHI8kbGzQqFD5gU7K4smDiG+/KSFXFtyumX9161xR
         gFgPJYMAjHvGu4esLuh8gnu9FORPWQAvRXxM1Fw+K2chtliMOXJKgLfu2S0Im2X6eNPT
         yl/pESGIizgb0AplvHrS6pEUY2jfIuSNbfTpMOZWBgbqPBGK1qlEM0YxrpOEn58DK6Rv
         kUuxV0eUMm55xeoHjsQQRweqNZ0CYlMI/kWypdCNCY7/XzAJEszfOFhia+G/NGs9NcBf
         qo3Q==
X-Gm-Message-State: ABy/qLbCzeNlvgmFkuKzhZPCw72HHhuj6hewpZ6qPcvOtuMinAbIzX3H
        0ftJwC4tNSO82LJjasuRsVUCrw==
X-Google-Smtp-Source: APBJJlE5aF9X6yI5/KIE4LqPbssfBBVRFzlSCcckiOZyPAc8NoJ1W/u/o+kETCAVgtxswFX1KLw+PA==
X-Received: by 2002:a05:6e02:219b:b0:345:a818:ed3b with SMTP id j27-20020a056e02219b00b00345a818ed3bmr1293537ila.7.1689638862515;
        Mon, 17 Jul 2023 17:07:42 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:b8fa:bd5a:9379:3b89])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a199000b00267a487f01bsm356703pji.48.2023.07.17.17.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 17:07:42 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-perf-users@vger.kernel.org
Cc:     kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf script: print cgroup on the same line as comm
Date:   Mon, 17 Jul 2023 17:07:37 -0700
Message-ID: <20230718000737.49077-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
added support for printing cgroup path in perf script output.

It was okay if you didn't want any stacks:

    $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup
    jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.service
    jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.service

With stacks it gets messier as cgroup is printed after the stack:

    $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,sym
    jpegtran:23f4bf 3321915 [013] 404718.587488:
                    5c554 compress_output
                    570d9 jpeg_finish_compress
                    3476e jpegtran_main
                    330ee jpegtran::main
                    326e2 core::ops::function::FnOnce::call_once (inlined)
                    326e2 std::sys_common::backtrace::__rust_begin_short_backtrace
    /idle.slice/polish.service
    jpegtran:23f4bf 3321915 [031] 404718.592073:
                    8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
                55af68e62fff [unknown]
    /idle.slice/polish.service

Let's instead print cgroup on the same line as comm:

    $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,sym
    jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.service
                    5c554 compress_output
                    570d9 jpeg_finish_compress
                    3476e jpegtran_main
                    330ee jpegtran::main
                    326e2 core::ops::function::FnOnce::call_once (inlined)
                    326e2 std::sys_common::backtrace::__rust_begin_short_backtrace

    jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.service
                    8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
                55af68e62fff [unknown]

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
---
 tools/perf/builtin-script.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 200b3e7ea8da..517bf25750c8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2199,6 +2199,17 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(RETIRE_LAT))
 		fprintf(fp, "%16" PRIu16, sample->retire_lat);
 
+	if (PRINT_FIELD(CGROUP)) {
+		const char *cgrp_name;
+		struct cgroup *cgrp = cgroup__find(machine->env,
+						   sample->cgroup);
+		if (cgrp != NULL)
+			cgrp_name = cgrp->name;
+		else
+			cgrp_name = "unknown";
+		fprintf(fp, " %s", cgrp_name);
+	}
+
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
@@ -2243,17 +2254,6 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(CODE_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
 
-	if (PRINT_FIELD(CGROUP)) {
-		const char *cgrp_name;
-		struct cgroup *cgrp = cgroup__find(machine->env,
-						   sample->cgroup);
-		if (cgrp != NULL)
-			cgrp_name = cgrp->name;
-		else
-			cgrp_name = "unknown";
-		fprintf(fp, " %s", cgrp_name);
-	}
-
 	perf_sample__fprintf_ipc(sample, attr, fp);
 
 	fprintf(fp, "\n");
-- 
2.41.0

