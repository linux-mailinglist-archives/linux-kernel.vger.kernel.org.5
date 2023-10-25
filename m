Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF57D5F16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbjJYAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbjJYAb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:31:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E404B9;
        Tue, 24 Oct 2023 17:31:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578b4981526so3087125a12.0;
        Tue, 24 Oct 2023 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698193885; x=1698798685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GpAI6ozunbQoZWUQVTayqufjb3hbc6BcZ1+mXMEKxPs=;
        b=M2+PxccDyn2L92869k0CYOU6hsXIUuz789rKmFSEzqQm9FFiQsIzDvCHe2vcuAmtJ/
         OtNAU0olNNFOCiGyAgzqeN1+yzXSOfj5CTHpz2YZKKg7GKA2PZtSklMinR67bmvp2RB3
         85RwsaQh0zfcska2GiWaqkwYo9fnsRLylbm6zgKuEb8pbq9/3oWGndpjmdovAsIRLjF6
         VTkNHW4n1Rbb6GNBWb1lFnl4pzDsh5yLx4BK/kKeo1NtV1CLjP6ZfAGROKnYHldSjlmm
         KgdmlYY3ks8VNxpJ4Z9o6yqXRfBptFyrmSXdesaAw9XuP/OCQvb+FE2lJCbvEcpDbgBE
         qhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193885; x=1698798685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpAI6ozunbQoZWUQVTayqufjb3hbc6BcZ1+mXMEKxPs=;
        b=UCZXL4KKO5SC2rA6wXoo+WGcv8IJ/L64GgODwiIMGZ3XsVZ4MRGstQN6bbvjwmjCds
         pSdOm06m9uQQYXGB1G6t/vC4Dwp5mExFHZ3lDhprMUQ7JQBZXqsm9rDy/9exOCD4co4I
         AskjRan5AC3nR2XOUCcPnU2iPxJQWAW1et0L1ZAzJ1eHbVFS3l2ufqaM1KdQCjSg5Ek5
         uwzSRPDe9IuyvBPt/7Gp6vN5nHNXWV0b2wjL2cbIBPal9Wc89ghTo3yO5ycwhl9jBLGp
         SxDNHmm39aRO8Zwyj5WCXDl4pOjiIv0X/9Qipk/Wznz1YyogoAvGoVmcFI3vXzNH/UsN
         77Sg==
X-Gm-Message-State: AOJu0YyvkB0HcTPke/yZYabHSk+s3v9CjcgnMYbJYCZBNIQZlRjPKnuU
        /vYjxmeuL+PSm1Oae/jkYs0=
X-Google-Smtp-Source: AGHT+IExbYkV20Qsce/iBoTkvlqsPI+HiuO852xRML9Pw1o5w9+HtqXK+8TBwMKRj/6bH2lzOjAUdA==
X-Received: by 2002:a05:6a21:47c7:b0:17e:5d2f:f439 with SMTP id as7-20020a056a2147c700b0017e5d2ff439mr4638886pzc.46.1698193884786;
        Tue, 24 Oct 2023 17:31:24 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:9710:a537:7681:714f])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a00079100b006930db1e6d1sm8251094pfu.203.2023.10.24.17.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:31:23 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf report: Fix hierarchy mode on pipe input
Date:   Tue, 24 Oct 2023 17:31:21 -0700
Message-ID: <20231025003121.2811738-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
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

The hierarchy mode needs to setup output formats for each evsel.
Normally setup_sorting() handles this at the beginning, but it cannot
do that if data comes from a pipe since there's no evsel info before
reading the data.  And then perf report cannot process the samples
in hierarchy mode and think as if there's no sample.

Let's check the condition and setup the output formats after reading
data so that it can find evsels.

Before:

  $ ./perf record -o- true | ./perf report -i- --hierarchy -q
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  Error:
  The - data has no samples!

After:

  $ ./perf record -o- true | ./perf report -i- --hierarchy -q
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
      94.76%        true
         94.76%        [kernel.kallsyms]
            94.76%        [k] filemap_fault
       5.24%        perf-ex
          5.24%        [kernel.kallsyms]
             5.06%        [k] __memset
             0.18%        [k] native_write_msr

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcedfe00f04d..ca8f2331795c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -691,10 +691,25 @@ static int report__browse_hists(struct report *rep)
 
 static int report__collapse_hists(struct report *rep)
 {
+	struct perf_session *session = rep->session;
+	struct evlist *evlist = session->evlist;
 	struct ui_progress prog;
 	struct evsel *pos;
 	int ret = 0;
 
+	/*
+	 * The pipe data needs to setup hierarchy hpp formats now, because it
+	 * cannot know about evsels in the data before reading the data.  The
+	 * normal file data saves the event (attribute) info in the header
+	 * section, but pipe does not have the luxury.
+	 */
+	if (perf_data__is_pipe(session->data)) {
+		if (perf_hpp__setup_hists_formats(&perf_hpp_list, evlist) < 0) {
+			ui__error("Failed to setup hierachy output formats\n");
+			return -1;
+		}
+	}
+
 	ui_progress__init(&prog, rep->nr_entries, "Merging related events...");
 
 	evlist__for_each_entry(rep->session->evlist, pos) {
-- 
2.42.0.758.gaed0368e0e-goog

