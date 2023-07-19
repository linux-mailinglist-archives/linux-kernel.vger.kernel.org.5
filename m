Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11DF759FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGSUcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGSUcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AAB1FCE;
        Wed, 19 Jul 2023 13:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44367617EF;
        Wed, 19 Jul 2023 20:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A12C433C7;
        Wed, 19 Jul 2023 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798611;
        bh=W5TxjO0FZLzZwTfwZhu1oBz8pm8d9YfgcvKsQLRyIvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtWzTqqICusKSGjbNnyVzMjE8Dfl1qMjSh/Xu3oyB41xSqW/4QwcJEQJinP0jRwwl
         5Qu272LZfeKTh7+beVG2q7/DL9h6AJlU06B1ijhrpocK0Jio87Mpye9M7n/Pko5S+y
         Rh2Emq+pWhv48/fy37QIzvp8fanySQByKq/uzphLgMyLzCrAUSt4HCXo6Eg7w9/Cxq
         jMlVgsRDBIwyKy7YeUB4CtmnznNyrnLu+KgKrLFUA36wAGIScD3Bsmg85wOCC87JC7
         Bj8q5lqdIbztrqx1LX3NWGHPaPMilphUNI4lCrvGKuLQGDzcTSrGakZUKsdeUMkkFF
         xiJ1dVDMq8qGg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH 4/6] perf trace: Really free the evsel->priv area
Date:   Wed, 19 Jul 2023 17:29:49 -0300
Message-ID: <20230719202951.534582-5-acme@kernel.org>
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

In 3cb4d5e00e037c70 ("perf trace: Free syscall tp fields in
evsel->priv") it only was freeing if strcmp(evsel->tp_format->system,
"syscalls") returned zero, while the corresponding initialization of
evsel->priv was being performed if it was _not_ zero, i.e. if the tp
system wasn't 'syscalls'.

Just stop looking for that and free it if evsel->priv was set, which
should be equivalent.

Also use the pre-existing evsel_trace__delete() function.

This resolves these leaks, detected with:

  $ make EXTRA_CFLAGS="-fsanitize=address" BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin

  =================================================================
  ==481565==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
      #0 0x7f7343cba097 in calloc (/lib64/libasan.so.8+0xba097)
      #1 0x987966 in zalloc (/home/acme/bin/perf+0x987966)
      #2 0x52f9b9 in evsel_trace__new /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:307
      #3 0x52f9b9 in evsel__syscall_tp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:333
      #4 0x52f9b9 in evsel__init_raw_syscall_tp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:458
      #5 0x52f9b9 in perf_evsel__raw_syscall_newtp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:480
      #6 0x540e8b in trace__add_syscall_newtp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3212
      #7 0x540e8b in trace__run /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3891
      #8 0x540e8b in cmd_trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:5156
      #9 0x5ef262 in run_builtin /home/acme/git/perf-tools-next/tools/perf/perf.c:323
      #10 0x4196da in handle_internal_command /home/acme/git/perf-tools-next/tools/perf/perf.c:377
      #11 0x4196da in run_argv /home/acme/git/perf-tools-next/tools/perf/perf.c:421
      #12 0x4196da in main /home/acme/git/perf-tools-next/tools/perf/perf.c:537
      #13 0x7f7342c4a50f in __libc_start_call_main (/lib64/libc.so.6+0x2750f)

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
      #0 0x7f7343cba097 in calloc (/lib64/libasan.so.8+0xba097)
      #1 0x987966 in zalloc (/home/acme/bin/perf+0x987966)
      #2 0x52f9b9 in evsel_trace__new /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:307
      #3 0x52f9b9 in evsel__syscall_tp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:333
      #4 0x52f9b9 in evsel__init_raw_syscall_tp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:458
      #5 0x52f9b9 in perf_evsel__raw_syscall_newtp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:480
      #6 0x540dd1 in trace__add_syscall_newtp /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3205
      #7 0x540dd1 in trace__run /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3891
      #8 0x540dd1 in cmd_trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:5156
      #9 0x5ef262 in run_builtin /home/acme/git/perf-tools-next/tools/perf/perf.c:323
      #10 0x4196da in handle_internal_command /home/acme/git/perf-tools-next/tools/perf/perf.c:377
      #11 0x4196da in run_argv /home/acme/git/perf-tools-next/tools/perf/perf.c:421
      #12 0x4196da in main /home/acme/git/perf-tools-next/tools/perf/perf.c:537
      #13 0x7f7342c4a50f in __libc_start_call_main (/lib64/libc.so.6+0x2750f)

  SUMMARY: AddressSanitizer: 80 byte(s) leaked in 2 allocation(s).
  [root@quaco ~]#

With this we plug all leaks with "perf trace sleep 1".

Fixes: 3cb4d5e00e037c70 ("perf trace: Free syscall tp fields in evsel->priv")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b7cbe4bcd136b137..56651d666480cc16 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3151,13 +3151,8 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		struct evsel_trace *et = evsel->priv;
-
-		if (!et || !evsel->tp_format || strcmp(evsel->tp_format->system, "syscalls"))
-			continue;
-
-		zfree(&et->fmt);
-		free(et);
+		evsel_trace__delete(evsel->priv);
+		evsel->priv = NULL;
 	}
 }
 
-- 
2.41.0

