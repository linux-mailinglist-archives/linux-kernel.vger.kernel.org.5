Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B879244A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjIEP6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjIEDiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:38:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD9CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 20:38:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbc0e0c6dso21111157b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 20:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693885089; x=1694489889; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RtnM2lSnMvooeKQ4ZkPF0YnuLxt+osNAFntTo/Bcl0M=;
        b=dELJWcx/VX9cK5dczh6x1loDTn1xkwHl83Z2QC3n0SRof9aOZHeIJ/KzkMkJacwGBL
         iVPqPBMcCK4BhrM1Eh94WO63/x8JnvDJRahZRhV6Q8LoZrRe+4hspUxLhcSUo2FiQgKd
         gYYi2fX77yUxW63vjfRb3gH3xac9EmWSxIV9HIB0jZehWDmtmyeYpxCWbq7XakXzFDFR
         8fk781OeaGuTkox/Olih/zHW924N7LTFPNtCDlP4F3+lKb/sHgGl2DjG2gYUgf0fmTch
         MmkN/ijecQ19aKyhyPsYot1LDcBuCv0ooFd5c2u+lOn8ZuX8HfKye5Id3xiEGtZUtpc5
         IjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885089; x=1694489889;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtnM2lSnMvooeKQ4ZkPF0YnuLxt+osNAFntTo/Bcl0M=;
        b=XVLw2bH5R6OQU/65jEPwONvR+hcfQ3ZMkr9IDk4skRw5O088mIBJRhgJycXg+ZhNXa
         rpRaqc5q5fQ/HcJkRRupyawtq7LsNXfuF32fj0Bh1ufKXCVqLg2yTrtxufkqYtsgSqIC
         glhuOYC+tigh24+DUj7G+aQsUqae4mGHmo4/uUA1RsNurvxTyXJsFlduqmkLLosjCR/1
         aqEqesOh5gNPraO7pIZe+JWeNAUAItJ6VP3O024Q6vGdu6nz2QZyT1Amp0WJicvn8yYL
         hIXITJNr9/To2Ejsjec6AkxDWstm4rDA5QeocYh4vS4cyZl8OkAPaOzDHhIXVmEVY1rY
         ghtg==
X-Gm-Message-State: AOJu0YwAG52V1QU8ZfoqMAKrE55BO0nzFq2a+6Tw4mArHNe/fkzMqN/a
        k663jqjkRNY4NUtd0YIbqB5zHWwuVQyM
X-Google-Smtp-Source: AGHT+IEVU8gM7rNq+UH+h2AXjp3JAXNBpqbDRZ1/FSUIs1w1vltNnUemBaxZvAsC4kexX5N8m82eF5v56P0F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a05:6902:10e:b0:d7f:4ba0:b5da with SMTP id
 o14-20020a056902010e00b00d7f4ba0b5damr68093ybh.13.1693885089268; Mon, 04 Sep
 2023 20:38:09 -0700 (PDT)
Date:   Mon,  4 Sep 2023 20:38:05 -0700
Message-Id: <20230905033805.3094293-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf parse-events: Fix driver config term
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inadvertently deleted in commit 30f4ade33d64 ("perf tools: Revert
enable indices setting syntax for BPF map").

Reported-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4a305df61f74..21bfe7e0d944 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -839,6 +839,23 @@ PE_TERM
 
 	$$ = term;
 }
+|
+PE_DRV_CFG_TERM
+{
+	struct parse_events_term *term;
+	char *config = strdup($1);
+	int err;
+
+	if (!config)
+		YYNOMEM;
+	err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG, config, $1, &@1, NULL);
+	if (err) {
+		free($1);
+		free(config);
+		PE_ABORT(err);
+	}
+	$$ = term;
+}
 
 sep_dc: ':' |
 
-- 
2.42.0.283.g2d96d420d3-goog

