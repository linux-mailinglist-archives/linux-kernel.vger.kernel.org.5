Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74268759FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGSUal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGSUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6EE2D6B;
        Wed, 19 Jul 2023 13:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A0F617E4;
        Wed, 19 Jul 2023 20:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E5C433C9;
        Wed, 19 Jul 2023 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798602;
        bh=goX2lDmeZF8/0WGZE1xE1qdjbTmkUWJAnLQ7R0lm72Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEDfoUsmNHbSkzHppAbTaO7Bjutnh+Mbk65s/ZGip7I6hA5YOH15YX2cW4XZ6eJpF
         GMJkoUgXmOYSv+8MOjJALcIVIxVn6dQYiGhsRkyrHxF1+rEoUd/ddumTdQJ49py2Is
         t2sJFU/CKw/CpsNOL3FFNvriX0o0d1FlfUa9Ud8Jnx0UNDcoGhdfTZHQOSzZC0H6sr
         9Sht3vtL4lMY8OW/GKYlpV9d8qXzb3auxYatV+sgHWf4IBcAaQ8tBTYZXo6pXKiRue
         3QHErko/kiy0D/91MQrXtIwJnKZeurmpc4srG+kFVb3JknGMrbC5tqBBfGFa6aQruu
         83MLGZFrO5XBQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/6] perf evsel: Free evsel->filter on the destructor
Date:   Wed, 19 Jul 2023 17:29:46 -0300
Message-ID: <20230719202951.534582-2-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202951.534582-1-acme@kernel.org>
References: <20230719202951.534582-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Noticed with:

  make EXTRA_CFLAGS="-fsanitize=address" BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin

Direct leak of 45 byte(s) in 1 object(s) allocated from:
    #0 0x7f213f87243b in strdup (/lib64/libasan.so.8+0x7243b)
    #1 0x63d15f in evsel__set_filter util/evsel.c:1371
    #2 0x63d15f in evsel__append_filter util/evsel.c:1387
    #3 0x63d15f in evsel__append_tp_filter util/evsel.c:1400
    #4 0x62cd52 in evlist__append_tp_filter util/evlist.c:1145
    #5 0x62cd52 in evlist__append_tp_filter_pids util/evlist.c:1196
    #6 0x541e49 in trace__set_filter_loop_pids /home/acme/git/perf-tools/tools/perf/builtin-trace.c:3646
    #7 0x541e49 in trace__set_filter_pids /home/acme/git/perf-tools/tools/perf/builtin-trace.c:3670
    #8 0x541e49 in trace__run /home/acme/git/perf-tools/tools/perf/builtin-trace.c:3970
    #9 0x541e49 in cmd_trace /home/acme/git/perf-tools/tools/perf/builtin-trace.c:5141
    #10 0x5ef1a2 in run_builtin /home/acme/git/perf-tools/tools/perf/perf.c:323
    #11 0x4196da in handle_internal_command /home/acme/git/perf-tools/tools/perf/perf.c:377
    #12 0x4196da in run_argv /home/acme/git/perf-tools/tools/perf/perf.c:421
    #13 0x4196da in main /home/acme/git/perf-tools/tools/perf/perf.c:537
    #14 0x7f213e84a50f in __libc_start_call_main (/lib64/libc.so.6+0x2750f)

Free it on evsel__exit().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 762e2b2634a5532a..e41bc4d9925f69a4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1474,6 +1474,7 @@ void evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
+	zfree(&evsel->filter);
 	zfree(&evsel->pmu_name);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
-- 
2.41.0

