Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0822759FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGSUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGSUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EDC26B3;
        Wed, 19 Jul 2023 13:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17868617CB;
        Wed, 19 Jul 2023 20:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0187AC433CC;
        Wed, 19 Jul 2023 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798608;
        bh=41NMeb8O2kAkF7/Aw6IzBaxDpGR5wEviXzLI33tbCk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0/lu3ji6RGVTyr4iG6scK5nJLhPVaMXRpEXUiYN/jZaqfRi0WGKjzSF5b+XFU+kk
         ebHgR7hcAfZIDGQ5s1SdNLKwgHwHnL4L3t07iVWuCTP1P8EWUV6zqBUc4RPfVUzb4y
         0zlteOaIoRjGZsehXkAWPjhpTMDBTCS0Opob8jGozF5frbMaDoPV+1hAwDHRqGJzS0
         BU4u1vP2gegg34vpFUPeS8kPVUbl68ohnMLN85S2wR+XWZlLB7CdMRMWzsmoAzx2Dd
         HVmMNA8v1HSXr3a5wAKSOYcNVT+NlHaV3MivoBFVlf7/7DP+68sJixQSJUMOxyLHE4
         CHsdzjY+DpNcQ==
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
Subject: [PATCH 3/6] perf trace: Register a thread priv destructor
Date:   Wed, 19 Jul 2023 17:29:48 -0300
Message-ID: <20230719202951.534582-4-acme@kernel.org>
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

To plug these leaks detected with:

  $ make EXTRA_CFLAGS="-fsanitize=address" BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin

  =================================================================
  ==473890==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 112 byte(s) in 1 object(s) allocated from:
    #0 0x7fdf19aba097 in calloc (/lib64/libasan.so.8+0xba097)
    #1 0x987836 in zalloc (/home/acme/bin/perf+0x987836)
    #2 0x5367ae in thread_trace__new /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:1289
    #3 0x5367ae in thread__trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:1307
    #4 0x5367ae in trace__sys_exit /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:2468
    #5 0x52bf34 in trace__handle_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3177
    #6 0x52bf34 in __trace__deliver_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3685
    #7 0x542927 in trace__deliver_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3712
    #8 0x542927 in trace__run /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:4055
    #9 0x542927 in cmd_trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:5141
    #10 0x5ef1a2 in run_builtin /home/acme/git/perf-tools-next/tools/perf/perf.c:323
    #11 0x4196da in handle_internal_command /home/acme/git/perf-tools-next/tools/perf/perf.c:377
    #12 0x4196da in run_argv /home/acme/git/perf-tools-next/tools/perf/perf.c:421
    #13 0x4196da in main /home/acme/git/perf-tools-next/tools/perf/perf.c:537
    #14 0x7fdf18a4a50f in __libc_start_call_main (/lib64/libc.so.6+0x2750f)

  Direct leak of 2048 byte(s) in 1 object(s) allocated from:
    #0 0x7f788fcba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
    #1 0x5337c0 in trace__sys_enter /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:2342
    #2 0x52bfb4 in trace__handle_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3191
    #3 0x52bfb4 in __trace__deliver_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3699
    #4 0x542883 in trace__deliver_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3726
    #5 0x542883 in trace__run /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:4069
    #6 0x542883 in cmd_trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:5155
    #7 0x5ef232 in run_builtin /home/acme/git/perf-tools-next/tools/perf/perf.c:323
    #8 0x4196da in handle_internal_command /home/acme/git/perf-tools-next/tools/perf/perf.c:377
    #9 0x4196da in run_argv /home/acme/git/perf-tools-next/tools/perf/perf.c:421
    #10 0x4196da in main /home/acme/git/perf-tools-next/tools/perf/perf.c:537
    #11 0x7f788ec4a50f in __libc_start_call_main (/lib64/libc.so.6+0x2750f)

  Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7fdf19aba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
    #1 0x77b335 in intlist__new util/intlist.c:116
    #2 0x5367fd in thread_trace__new /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:1293
    #3 0x5367fd in thread__trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:1307
    #4 0x5367fd in trace__sys_exit /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:2468
    #5 0x52bf34 in trace__handle_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3177
    #6 0x52bf34 in __trace__deliver_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3685
    #7 0x542927 in trace__deliver_event /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:3712
    #8 0x542927 in trace__run /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:4055
    #9 0x542927 in cmd_trace /home/acme/git/perf-tools-next/tools/perf/builtin-trace.c:5141
    #10 0x5ef1a2 in run_builtin /home/acme/git/perf-tools-next/tools/perf/perf.c:323
    #11 0x4196da in handle_internal_command /home/acme/git/perf-tools-next/tools/perf/perf.c:377
    #12 0x4196da in run_argv /home/acme/git/perf-tools-next/tools/perf/perf.c:421
    #13 0x4196da in main /home/acme/git/perf-tools-next/tools/perf/perf.c:537
    #14 0x7fdf18a4a50f in __libc_start_call_main (/lib64/libc.so.6+0x2750f)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6e73d0e957152d84..b7cbe4bcd136b137 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1296,6 +1296,19 @@ static struct thread_trace *thread_trace__new(void)
 	return ttrace;
 }
 
+static void thread_trace__delete(void *pttrace)
+{
+	struct thread_trace *ttrace = pttrace;
+
+	if (!ttrace)
+		return;
+
+	intlist__delete(ttrace->syscall_stats);
+	ttrace->syscall_stats = NULL;
+	zfree(&ttrace->entry_str);
+	free(ttrace);
+}
+
 static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 {
 	struct thread_trace *ttrace;
@@ -1635,6 +1648,8 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 	if (trace->host == NULL)
 		return -ENOMEM;
 
+	thread__set_priv_destructor(thread_trace__delete);
+
 	err = trace_event__register_resolver(trace->host, trace__machine__resolve_kernel_addr);
 	if (err < 0)
 		goto out;
-- 
2.41.0

