Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FA810607
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377737AbjLMAOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378021AbjLMANs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFD4F3;
        Tue, 12 Dec 2023 16:13:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d08a924fcfso59062855ad.2;
        Tue, 12 Dec 2023 16:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426422; x=1703031222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKWNHoppdDrptJRx330rZQjTF2Glc6qUjA2s/YDUwrg=;
        b=P27Tt8apeUEcbntKO4Yoaiv3k/I17jqZ0VXQeCwGS6/9qetEDkxG78Pb0hE2jv2Kfa
         JIhknpcIJFQYmjQMWI0FmlAJV7r/5VdzNf2AZRd2X/jAWK4euYMS3y9pGmbetlkIgNB7
         t8KFalajCmOoPf/ARaAU59VLUQkKzdxa263o/+YLAyWdI7VA6rtQPw9xwh1Cl7173oMX
         Vl0sCLd++oduSO4Kd6ggqu1O9FUeJStlRIV8sv+W9rZ/5s/VMtjh9rRDj+98pw8sJIPW
         hO70QOVkJm0jcUEaThFcDVjrodv3N8WLxmwQ5ynSjSEpe0k52aUj1dbHS2mN4TzgyUkg
         ntPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426422; x=1703031222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKWNHoppdDrptJRx330rZQjTF2Glc6qUjA2s/YDUwrg=;
        b=m+N5mXuVSC0deSnd1hrHCFSwmIPtRMxl+oiP4JPKiu8qvoFu3zo6rXushPSdIqgbjf
         +6yfR57rIjDQu+4HKjX5t894Xs1R+knMgyb5segdx7JEHd4folIh311i8k0Hyq8ARJK5
         O/C3jxpARv4HbBXK2pGlFfv0aweObodwpd6nFVUehZJIyuUL6Ke36ljygkXhdIg7iOZr
         2yaTnO0wJPsG0ZBAQeXDq1PLgVhnLhQAWusxAydWOjbVffNc/a5xBl22jOvfLJBtrBOp
         cr/c+k5PzShWgPtNFPIGC4xlOUCs6AlBEuFT9WEif6BtHQCpA1Xzmd1eOKyyAtDpc5vh
         irHQ==
X-Gm-Message-State: AOJu0YzpZjyGe336iS7oDUF3zW3SCUHGpcniOh1mwU/rOkR7v3u5BnO8
        4Xx6U09wLrtaz5ksH8E8vuo=
X-Google-Smtp-Source: AGHT+IHce07a7VVmOT81vFUmbn9YsSdtuhACZD3dCL8ZKMuSOny3LmeidBrrZi7fdcSvex4E2ubqiQ==
X-Received: by 2002:a17:902:8696:b0:1cf:ef92:18f3 with SMTP id g22-20020a170902869600b001cfef9218f3mr6793792plo.58.1702426421904;
        Tue, 12 Dec 2023 16:13:41 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:41 -0800 (PST)
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
Subject: [PATCH 09/17] perf report: Support data type profiling
Date:   Tue, 12 Dec 2023 16:13:15 -0800
Message-ID: <20231213001323.718046-10-namhyung@kernel.org>
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
 tools/perf/builtin-report.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 17fb171e898b..ed76152c8db8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -96,6 +96,7 @@ struct report {
 	bool			stitch_lbr;
 	bool			disable_order;
 	bool			skip_empty;
+	bool			data_type;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	const char		*pretty_printing_style;
@@ -170,7 +171,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	struct mem_info *mi;
 	struct branch_info *bi;
 
-	if (!ui__has_annotation() && !rep->symbol_ipc)
+	if (!ui__has_annotation() && !rep->symbol_ipc && !rep->data_type)
 		return 0;
 
 	if (sort__mode == SORT_MODE__BRANCH) {
@@ -1619,6 +1620,16 @@ int cmd_report(int argc, const char **argv)
 			sort_order = NULL;
 	}
 
+	if (sort_order && strstr(sort_order, "type")) {
+		report.data_type = true;
+		annotate_opts.annotate_src = false;
+
+#ifndef HAVE_DWARF_GETLOCATIONS_SUPPORT
+		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
+		goto error;
+#endif
+	}
+
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
 	else
@@ -1677,7 +1688,7 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation() || report.symbol_ipc ||
+	if (ui__has_annotation() || report.symbol_ipc || report.data_type ||
 	    report.total_cycles_mode) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
-- 
2.43.0.472.g3155946c3a-goog

