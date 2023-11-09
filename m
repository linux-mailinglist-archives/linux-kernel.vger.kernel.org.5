Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A823F7E7579
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbjKJABs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbjKJABS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B324C12;
        Thu,  9 Nov 2023 16:00:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso1299961a91.1;
        Thu, 09 Nov 2023 16:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574443; x=1700179243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJFFyw141jUP/xKayMqLdMQ+KiPiQ49S3rXykXIzrtU=;
        b=hewpSY+M0Ilee/HvRvj+BMRJ5nds7ngzW3sNArweE5dKbyElgMsVFrLa/soTZSiQyC
         6yUqPEW8yfUF8u7/+dXfjO+xEPiRRGR0XM/HdVjo9wskXjr4F0fjED5/841J7ubjv2ww
         GEjCptdXWtePI71qD4eKMTYpPsHo4tpeNBiGZXt/Z6njLp2ZkUub/TbUciq8O+JKutGi
         S3Yg3Vq8EcNF7Q3h96my8YVd+YZh5gx2VL63p9vGuSOmDVD1VpQxhihjmfyQSO6vaGaG
         UDd6wwob+jhqMhZWq/cM1MmpfCU3M/9fEBBdxX4Pk0ntlVeGjMW14/r+XmvJH925Zla/
         ipgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574443; x=1700179243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJFFyw141jUP/xKayMqLdMQ+KiPiQ49S3rXykXIzrtU=;
        b=OWsh++P4a2uXIIu9n+E8QeC5SHq189/21i33deZWA5fo+3NkRJOshYRkdiRcSDgCbL
         lBgDeJ79fzoXcnBnTEkJ7TdXkHBtrIfPWBpVJwESMYMCGsXrY2ZCPKfO2eXNlrxY029p
         Ko5hzWVdV7zitSFcaCnVhUHrjyFcT0VjpoHNA2juEmNYlT5NFxlzFqFVb2Jdr75JCTeb
         nuaiHofK2zt7J1QedGdEYL2yB83ts1yZmm446tm9DrEkutR+3PhN3diu4JiphSvne5Wy
         SMhNMJS8NukMegRUgecwdrWYbeIgx3+Gp/beJ/+oO5an/o0Yh474TcJ4/Pnu0CWbqWCa
         lhBw==
X-Gm-Message-State: AOJu0Ywc24/a8V3i93XtUIciJFLZX3gF4ivF2FRRiSZ4ha/MYDnC2vM9
        a5i8Ne/2P/SLC3ijW35xKxQ=
X-Google-Smtp-Source: AGHT+IHDHaDW37hwqHR5XoEDWe6IHBrXhO7qVBENgL2GooV3ZNmPbnE5m9AccnpfOrMZO/2UbyU/dQ==
X-Received: by 2002:a17:90a:ea85:b0:280:2652:d46 with SMTP id h5-20020a17090aea8500b0028026520d46mr3769910pjz.28.1699574443393;
        Thu, 09 Nov 2023 16:00:43 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:43 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 19/52] perf report: Support data type profiling
Date:   Thu,  9 Nov 2023 15:59:38 -0800
Message-ID: <20231110000012.3538610-20-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/builtin-report.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 121a2781323c..cd2cefd1ea9a 100644
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
@@ -1622,6 +1632,11 @@ int cmd_report(int argc, const char **argv)
 			sort_order = NULL;
 	}
 
+	if (sort_order && strstr(sort_order, "type")) {
+		report.data_type = true;
+		report.annotation_opts.annotate_src = false;
+	}
+
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
 	else
@@ -1680,7 +1695,7 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation() || report.symbol_ipc ||
+	if (ui__has_annotation() || report.symbol_ipc || report.data_type ||
 	    report.total_cycles_mode) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
-- 
2.42.0.869.gea05f2083d-goog

