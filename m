Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780CF7C6376
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376863AbjJLDw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377097AbjJLDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F32138;
        Wed, 11 Oct 2023 20:51:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdf4752c3cso4012275ad.2;
        Wed, 11 Oct 2023 20:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082696; x=1697687496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZII5vF3dprwXJP49CiS8ixHpGtBs+wAGFWOW7yk/k14=;
        b=kKTQafDwBS3LnqLJJl/sGP0kPj0dFyOBIdszVkK/c2O2NsyGGINKG2UTmdGs5LyK0q
         DbrAzKI97ANciQ9bHroC3HygOoGshLomfSW6ohN3RIj2iQn24zWWBmiehttQ1HkWg24Z
         wR2xqRRF46EOmQ2FeklYlhbmWIVXuAH4wsfUQuf7UfzF8WZ4FC5nkOtV5KcEP3Fs3u5z
         vy0T369S9P++g3ZvqQuF0dbgjn/njnmSuBGsplqFcLANPntNA3mchl+8B0InJ0CMF4Os
         /Bt0RODOFS06ypD4T3hxCSQ3LoszGLIX2yvAgZ827FhrVARijcvvTz+VGxyMEfA5I60m
         BCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082696; x=1697687496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZII5vF3dprwXJP49CiS8ixHpGtBs+wAGFWOW7yk/k14=;
        b=C4JwWdn4wVVKkSHJMuRHfY7MuX/Op71+9xPubXesNCeizBGlVnFPiH2GDEyG+cX1ed
         G97ceBTOzws+e3UYGrpXswelTycUG4BauNw8CjCdiZvUd2MHAoFsP+DC8efxBdG/BejH
         sNLK/XuwLJSmFMClTQ269Jpq1hzfz8AmZ+sCZGhr8LJQ1H4M9U0+Yk6vHppdz0qWrGtX
         umsAnXet5JHil0KS7airM/yAFVmManFDrAAzXAKhwO9fDRmq12HP5Y2c1dFxplQ4YtA8
         gPTp0r9Irg1OGtiIQYDl/ydpe1HYRU3JNKdlk51JwU870uu3Yz6Rg1/qUe7bHPrH9G/m
         uEtg==
X-Gm-Message-State: AOJu0YyCY1a3LgClmb59AeKdEjPFZiBMLg+RgKj2h6seVMl9aQVbxyOS
        13GEA1RURYU7aSuFz+3s+EE=
X-Google-Smtp-Source: AGHT+IEIgqdokKUdY0Jf5HR5a5Ezvauld/zyeGxQe5mfTKMuxdBz2qQI6SIiqrgYj4w0bmg90PJhgQ==
X-Received: by 2002:a17:902:6bc5:b0:1c9:bef4:e11 with SMTP id m5-20020a1709026bc500b001c9bef40e11mr5717841plt.46.1697082695866;
        Wed, 11 Oct 2023 20:51:35 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:35 -0700 (PDT)
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
Subject: [PATCH 16/48] perf report: Support data type profiling
Date:   Wed, 11 Oct 2023 20:50:39 -0700
Message-ID: <20231012035111.676789-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
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

Enable type annotation when the 'type' sort key is used.
It shows type of variables the samples access at the moment.
Users can see which types are accessed frequently.

  $ perf report -s dso,type --stdio
  ...
  # Overhead  Shared Object      Data Type
  # ........  .................  .........
  #
      35.47%  [kernel.kallsyms]  (unknown)
       1.62%  [kernel.kallsyms]  struct sched_entry
       1.23%  [kernel.kallsyms]  struct cfs_rq
       0.83%  [kernel.kallsyms]  struct task_struct
       0.34%  [kernel.kallsyms]  struct list_head
       0.30%  [kernel.kallsyms]  struct mem_cgroup
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcedfe00f04d..e60c6bb32d92 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -96,6 +96,7 @@ struct report {
 	bool			stitch_lbr;
 	bool			disable_order;
 	bool			skip_empty;
+	bool			data_type;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -171,7 +172,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	struct mem_info *mi;
 	struct branch_info *bi;
 
-	if (!ui__has_annotation() && !rep->symbol_ipc)
+	if (!ui__has_annotation() && !rep->symbol_ipc && !rep->data_type)
 		return 0;
 
 	if (sort__mode == SORT_MODE__BRANCH) {
@@ -323,10 +324,19 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.map != NULL)
 		map__dso(al.map)->hit = 1;
 
-	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
+	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode ||
+	    rep->data_type) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
 				     rep->nonany_branch_mode,
 				     &rep->total_cycles);
+		if (rep->data_type) {
+			struct symbol *sym = al.sym;
+			struct annotation *notes = sym ? symbol__annotation(sym) : NULL;
+
+			/* XXX: Save annotate options here */
+			if (notes)
+				notes->options = &rep->annotation_opts;
+		}
 	}
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
@@ -1600,6 +1610,9 @@ int cmd_report(int argc, const char **argv)
 			sort_order = NULL;
 	}
 
+	if (sort_order && strstr(sort_order, "type"))
+		report.data_type = true;
+
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
 	else
@@ -1658,7 +1671,7 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation() || report.symbol_ipc ||
+	if (ui__has_annotation() || report.symbol_ipc || report.data_type ||
 	    report.total_cycles_mode) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
-- 
2.42.0.655.g421f12c284-goog

