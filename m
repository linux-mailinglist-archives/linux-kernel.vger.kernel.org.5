Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF77D7CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjJZG0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:26:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12736187;
        Wed, 25 Oct 2023 23:26:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd73395bceso391633b3a.0;
        Wed, 25 Oct 2023 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698301577; x=1698906377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KGFAGOw1jMD4qW4ZS/5Zs1JohmRnxW/EBkFlBVus7WE=;
        b=TVBgFX2siBkLnhqsU680SN5MHyEkZYJTrAYsho5DJMDiKrnGYLmN/do+B0re8/H5gi
         KszNxjvPbLImN6HcJs6zH7Om8RygxM/fuTJqibDt82XsWynHMwOKnSObHybsSfzQszeZ
         AaPjbQgir6B/s9gAVF1nyQccCNGXuHHt6iiV2++KKbXiXIQ3aZM22JHOLDr3PZ6hsbFN
         h4kMBbhF12/pjJWlxEsbABV2qpGzy5KxjPLwI3G96fHMB7yE+U5mMYVX8XIK5MvbYgyf
         7AlskJ/7gvFa5IMbuE6Q7s/VdJnxPQXojxEZDH8cTB20gL+nFWDSTF94pKNvfS/4pGTX
         nXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301577; x=1698906377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGFAGOw1jMD4qW4ZS/5Zs1JohmRnxW/EBkFlBVus7WE=;
        b=GBSeOr8eKQ7EHdrOQ0i7WrovnGjkbNCtQMed7xthRmI+6I82Cx95A66eH9m1hCubs7
         N1/obMu7zNXGuZn2izAgZ3TQSHeM8OtfcX4AHTwQOoUTDojVuzGCMSHy/Ri8eCIqQUP5
         Mdo0Ou9j53PLypwcY1jp1o8TutmfyHpxPwhIyre5yFqX9NgNqH21Xd9x0hrgcQ/tDIqU
         FqCeNGAe13taDml9gzlfqWL91qpubvcm3hiP1NFHvyA4fCx6zkEOjUIKpie/7zqGk4Js
         G14UlUXza6A9F3q8vomfpYsq19zbNiqKYXh+fUJd+mtD3rOPhlN4+RsfC49Ci/7D0bAD
         tA7w==
X-Gm-Message-State: AOJu0Yzi2P7tOBbzcvf9wvEYGBvN7CGanQ0nAe1PC4n8QuFTyx3GMe70
        d7BaufaPI2Mz5W9xdnmo3CM=
X-Google-Smtp-Source: AGHT+IFLmc+yJ/UAbI38jDjOnkPI+SS1Wbgv3/5Ir3Khrr/2t9WicUpIm1U7LXXAuOrkV8m/MhgemA==
X-Received: by 2002:a05:6a00:280f:b0:692:6417:728a with SMTP id bl15-20020a056a00280f00b006926417728amr1844186pfb.14.1698301577369;
        Wed, 25 Oct 2023 23:26:17 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:5393:ee8f:5738:b9c3])
        by smtp.gmail.com with ESMTPSA id ca27-20020a056a00419b00b006c05374202dsm989282pfb.71.2023.10.25.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:26:16 -0700 (PDT)
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
Subject: [PATCH] perf tools: Add -H short option for --hierarchy
Date:   Wed, 25 Oct 2023 23:26:15 -0700
Message-ID: <20231026062615.3096537-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found the hierarchy mode useful, but it's easy to make a typo when
using it.  Let's add a short option for that.

Also update the documentation. :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt | 29 ++++++++++++++++++++-
 tools/perf/Documentation/perf-top.txt    | 32 +++++++++++++++++++++++-
 tools/perf/builtin-report.c              |  2 +-
 tools/perf/builtin-top.c                 |  2 +-
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index af068b4f1e5a..7d8916b2b7f7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -528,8 +528,35 @@ include::itrace.txt[]
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
+-H::
 --hierarchy::
-	Enable hierarchical output.
+	Enable hierarchical output.  In the hierarchy mode, each sort key groups
+	samples based on the criteria and then sub-divide it using the lower
+	level sort key.
+
+	For example:
+	In normal output:
+
+	  perf report -s dso,sym
+	  # Overhead  Shared Object      Symbol
+	      50.00%  [kernel.kallsyms]  [k] kfunc1
+	      20.00%  perf               [.] foo
+	      15.00%  [kernel.kallsyms]  [k] kfunc2
+	      10.00%  perf               [.] bar
+	       5.00%  libc.so            [.] libcall
+
+	In hierarchy output:
+
+	  perf report -s dso,sym --hierarchy
+	  #   Overhead  Shared Object / Symbol
+	      65.00%    [kernel.kallsyms]
+	        50.00%    [k] kfunc1
+	        15.00%    [k] kfunc2
+	      30.00%    perf
+	        20.00%    [.] foo
+	        10.00%    [.] bar
+	       5.00%    libc.so
+	         5.00%    [.] libcall
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 3c202ec080ba..a754875fa5bb 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -261,8 +261,38 @@ Default is to monitor all CPUS.
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
+-H::
 --hierarchy::
-	Enable hierarchy output.
+	Enable hierarchical output.  In the hierarchy mode, each sort key groups
+	samples based on the criteria and then sub-divide it using the lower
+	level sort key.
+
+	For example, in normal output:
+
+	  perf report -s dso,sym
+	  #
+	  # Overhead  Shared Object      Symbol
+	  # ........  .................  ...........
+	      50.00%  [kernel.kallsyms]  [k] kfunc1
+	      20.00%  perf               [.] foo
+	      15.00%  [kernel.kallsyms]  [k] kfunc2
+	      10.00%  perf               [.] bar
+	       5.00%  libc.so            [.] libcall
+
+	In hierarchy output:
+
+	  perf report -s dso,sym --hierarchy
+	  #
+	  #   Overhead  Shared Object / Symbol
+	  # ..........  ......................
+	      65.00%    [kernel.kallsyms]
+	        50.00%    [k] kfunc1
+	        15.00%    [k] kfunc2
+	      30.00%    perf
+	        20.00%    [.] foo
+	        10.00%    [.] bar
+	       5.00%    libc.so
+	         5.00%    [.] libcall
 
 --overwrite::
 	Enable this to use just the most recent records, which helps in high core count
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ca8f2331795c..b16680d0f82c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1392,7 +1392,7 @@ int cmd_report(int argc, const char **argv)
 		    "only show processor socket that match with this filter"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
 		    "Show raw trace event output (do not use print fmt or plugins)"),
-	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
+	OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..3cccb2a516dc 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1573,7 +1573,7 @@ int cmd_top(int argc, const char **argv)
 		    "add last branch records to call history"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
 		    "Show raw trace event output (do not use print fmt or plugins)"),
-	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
+	OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
 		    "Use a backward ring buffer, default: no"),
-- 
2.42.0.758.gaed0368e0e-goog

