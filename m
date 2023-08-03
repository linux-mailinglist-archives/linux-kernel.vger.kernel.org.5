Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3A76E345
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjHCIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjHCIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:36:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0A11BE;
        Thu,  3 Aug 2023 01:34:58 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a6f87b2993so521799b6e.3;
        Thu, 03 Aug 2023 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051698; x=1691656498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnemojx1FZtx2Li9vOAprJUm0iuiB3b7IS7depvyVaE=;
        b=qSSSnjKGejBP6Yomeu290FoFNqM817vMqLWUN5KoweAJlOAnf1LB5lncn6seQpXWil
         tbjfNCirCNiP9SBeViyFB3RGYCgWYh7VUrLz6oS2XiHjPycK7I+jkdA5ZNqzv2cqVxWZ
         q2q8mMc9guZei4vo1SKOmgNXEySqpBlL2cXa6INxgqBXEvej8S0bTYOcgl3UAiD5jmh0
         DOsUYTqjHJi6J2MtKIDJq3W/FEeptmBM3qNmk8P9tK++jUqIxN6aGdU3KXO5uwGZgVzX
         T1M4sHHLx942q8pAAV4arLo2Mgefn28qbDrcoHSWQ1Lzv+kjn7eJP27AeHWmvF6rO9S6
         9qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051698; x=1691656498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tnemojx1FZtx2Li9vOAprJUm0iuiB3b7IS7depvyVaE=;
        b=JVHrdJhpSa+mKC0sNDK4kraYRrPQhzFbpo0gtl5aE3mfXcW7YlvK/b5fa4q1/HJ0VT
         MwHCGVCZDP29c4JJMzrNfsDBCt9+l8EROBvBZzlUhRvfDrd9MwL2Nczvo0dFREi5xBlH
         2zJwW2QyvTQRcSR6UPdxetaXXEVDYiuZJcRRhubUDxbDDJe/6z+EecikOuC4HhX9VOYQ
         IipQs1uHagCtIUVILCExp0vhYh5fWG6AIevNjdt0YaEkZlPbGw8SYBiuYs/kgt78Na4B
         gpW9y7soYIIFv9NBeTysybwLT1btx1FkLLWlkwNo2SiHM44GMN1/KCSxsqWF4LTSVjYI
         VACQ==
X-Gm-Message-State: ABy/qLZ1xrdhgb9HtObTjrXMw4sfsZ5Z3WD0rxoxVxlbyvP4QLNFrfN9
        YWkd7SDaM1DL2u0Po6wIGCc=
X-Google-Smtp-Source: APBJJlHWflpa9e3tqPcUwqWc2E59rG4/UJwb8mAf/NKYNLHdEjsGl9pgH1dWdTt6AQKnx3ToZ9ml4A==
X-Received: by 2002:a05:6358:98a2:b0:134:c279:c829 with SMTP id q34-20020a05635898a200b00134c279c829mr9475891rwa.18.1691051697678;
        Thu, 03 Aug 2023 01:34:57 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id r6-20020a63b106000000b00563feb7113dsm12541876pgf.91.2023.08.03.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:34:57 -0700 (PDT)
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
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v6 5/5] perf sched: prefer to use prev_state_char introduced in sched_switch
Date:   Thu,  3 Aug 2023 04:33:52 -0400
Message-ID: <20230803083352.1585-6-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803083352.1585-1-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
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
 tools/perf/builtin-sched.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5042874ba204..6f99a36206c9 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -837,7 +837,7 @@ replay_wakeup_event(struct perf_sched *sched,
 
 static inline char task_state_char(int state)
 {
-	static const char state_to_char[] = "RSDTtXZPI";
+	static const char state_to_char[] = "RSDTtXZPIp";
 	unsigned int bit = state ? ffs(state) : 0;
 
 	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
@@ -846,9 +846,20 @@ static inline char task_state_char(int state)
 static inline char get_task_prev_state(struct evsel *evsel,
 				       struct perf_sample *sample)
 {
-	const int prev_state = evsel__intval(evsel, sample, "prev_state");
+	char prev_state_char;
+	int prev_state;
 
-	return task_state_char(prev_state);
+	/* prefer to use prev_state_char */
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
@@ -2145,7 +2156,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 		else if (r->last_time) {
 			u64 dt_wait = tprev - r->last_time;
 
-			if (r->last_state == 'R')
+			if (r->last_state == 'R' || r->last_state == 'p')
 				r->dt_preempt = dt_wait;
 			else if (r->last_state == 'D')
 				r->dt_iowait = dt_wait;
-- 
2.41.0

