Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6576ABB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjHAJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHAJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:01:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B462101;
        Tue,  1 Aug 2023 02:01:52 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-78363cc070aso284289239f.1;
        Tue, 01 Aug 2023 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880512; x=1691485312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ly2QJNLAEtTlKSCo6d7xttDO2/tTmofDJcjQHz0sLg=;
        b=hyyuAqCyfKq1hI6vDQjj50c2JrrsShWN1524EFNYdqnUb3k2Z3Lq03ZYIw/Vu0QpSF
         FggL5X4qgFMTuBFVyeo3QeYhDnwtB+Nr28nZGZFtCJ28OtgWw4DgPM2Qt3s+MzJNSpjO
         TGrlSoCFQfnkn0UdeKr7MLQQAlFEF1TlPYf9WPiF8EOGCia0PMFqjoAAFiPDYeewPYYL
         K+pm/rxv9AhT2UH42Jj6qbiDvmuUky+Fz6a4DiIJxcvv/+rtn/rYNYvLNgAkBUAfMilQ
         X7/PWqfASAaDv0BvRkBWQ3WDSkWgJAsJkRN4ML9xLTaI5vFmRikDQU6t2B/YwFkSjIh0
         C5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880512; x=1691485312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ly2QJNLAEtTlKSCo6d7xttDO2/tTmofDJcjQHz0sLg=;
        b=RWCT7Sx5Zi9p9GmVxfLZup5VoCt6GWKxsr4DLwInG5BBtDVwlj7xtrnP7ASrVz4QTe
         JN9IvZK6CSBguVJ1ptEXJjFE0rN3LHNRw++GSwtCgIupz6FOGMyG8gJIEeFJRrC9ny/l
         E84JWGfdBWznR7GtFzZxkxM83wS1bqN4wNxpCGYfphBXTGCMhnh+BlISkuR3c44exmXu
         4yEKvim/HyUCeweKxFqTvGGpBWH3TIVBEX1lyJp3+UsSR6n319eqvBOnbcxyYLwDv7nl
         Cr+CzlewJINfolP+K07kjPeGpxTQlKuWWq/Op5ZQcviUCizXQd9E4wIR5orFXQpATF01
         eT8Q==
X-Gm-Message-State: ABy/qLbN86XNHs77O/d6nN3nCus6q8axvwVNTGMOLDQb/1ytkwYr9UXe
        qdxlr7AvJHIFlLSV13MKRVM=
X-Google-Smtp-Source: APBJJlFPmEwgJhL3yR0VN9ChGXsHvr+G++Y7pVp45DkKxQeeCKMl6D9N82WEZwxntTt3X2C2DMHq7Q==
X-Received: by 2002:a05:6e02:218d:b0:346:d51:9922 with SMTP id j13-20020a056e02218d00b003460d519922mr14239768ila.13.1690880511998;
        Tue, 01 Aug 2023 02:01:51 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm1592523pjj.1.2023.08.01.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:01:51 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v3 5/6] perf sched: prefer to use prev_state_char introduced in sched_switch
Date:   Tue,  1 Aug 2023 17:01:23 +0800
Message-Id: <20230801090124.8050-6-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801090124.8050-1-zegao@tencent.com>
References: <20230801090124.8050-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the sched_switch tracepoint introduces a new variable to
report sched-out task state in symbolic char, we prefer to use
it to spare from knowing internal implementations in kernel.

Also we keep the old parsing logic intact but sync the state char
array with the latest kernel.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 275da655b67a..6ca60d4773d3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -837,7 +837,7 @@ replay_wakeup_event(struct perf_sched *sched,
 
 static inline char task_state_char(int state)
 {
-	static const char state_to_char[] = "RSDTtXZPI";
+	static const char state_to_char[] = "RSDTtXZPIp";
 	unsigned bit = state ? ffs(state) : 0;
 	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
 }
@@ -845,8 +845,20 @@ static inline char task_state_char(int state)
 static inline char get_task_prev_state(struct evsel *evsel,
 				       struct perf_sample *sample)
 {
-	const int prev_state = evsel__intval(evsel, sample, "prev_state");
-	return task_state_char(prev_state);
+	char prev_state_char;
+	int prev_state;
+
+	//prefer to use prev_state_char
+	if (evsel__field(evsel, "prev_state_char"))
+		prev_state_char = (char) evsel__intval(evsel,
+				sample, "prev_state_char");
+	else {
+		prev_state = (int) evsel__intval(evsel,
+				sample, "prev_state");
+		prev_state_char = task_state_char(prev_state);
+	}
+
+	return prev_state_char;
 }
 
 static int replay_switch_event(struct perf_sched *sched,
-- 
2.40.1

