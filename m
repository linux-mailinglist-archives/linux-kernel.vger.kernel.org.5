Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC03376CD83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjHBMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjHBMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDA2D4A;
        Wed,  2 Aug 2023 05:49:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbc64f9a91so57190995ad.0;
        Wed, 02 Aug 2023 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980556; x=1691585356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWetw+9fo7xpR+/Y1RDX5IOHvVHf8sfB8Rgzd3Bsv2A=;
        b=GIHzjFSzPcLYW4yJrPyLa5ImpMP+/3NnozdLXPCWfIEItaUDWT708653DBDRF9JDF1
         7KJP2GCIClBAH9TSQ1KVLatrwc9yTBnkpzhENvv4RrL7sEfnb7UiXjrEyIlloYFhdoPb
         kV1D/qaJGKouufSXYhMmCQ6s3RuM7Snwrzt8TCemadIkH1WZ+Bjv5jWhtNkd1ZyZsdBX
         V9GoTGqzCtbsRZqsjZNFncaj+eA6BDJ5scmBkGEoP4jvts/pO08/1t3W/xVXwEtFegRb
         mzsuOG7V5o6E5TBzDQ56qCiReA6n102vgs9RiJ+P/P0i3axrYk1X/byHeLt3snHWyPwR
         aBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980556; x=1691585356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWetw+9fo7xpR+/Y1RDX5IOHvVHf8sfB8Rgzd3Bsv2A=;
        b=RMSoKbTxu3CpfqqqlJ8ThXzPCJWfgfEffOJ+UcwW8a6y1beW0RG+b/SnFhC7ISv7J6
         klf1g5KJosImE4XA5lCwxTdElzxzIzEKRC0anRqfTGYZHTVq8E9nMA1Y+cABTICiWdRP
         OHmV6+J8uJE9ck4nuSaKbeL6ikmaHwioqzGVwbM75G4EfS7TuTVPUGwD+vMBipJ9CoFJ
         gm4BhbZQmuCudJuwOKc/M9CrGWR/WtIRyToMm4D4+1u7gP5ml1CdIZcUVMiVscAheDag
         gb9ROKYR/7ZZ7mXxZ+GF6Ro/JyERrMXvaxUr00+8PvzN3zMaR8rEvsrP6ROALB8f1g1A
         O51g==
X-Gm-Message-State: ABy/qLZuDCHWBNqKL7p9vDfX2eQe2sthYRGpbuwsAicoEU7GhDk9tWvK
        TlQSUNChgeVRSVxMwds3nks=
X-Google-Smtp-Source: APBJJlHw4hmPYrgetk+3UmXtsG7PL5InI9GFCxvW4F0oTwPBOrp7ldLy1FZuk2Y69spe/Xv1ftUHXA==
X-Received: by 2002:a17:902:f551:b0:1ae:8892:7d27 with SMTP id h17-20020a170902f55100b001ae88927d27mr17956049plf.42.1690980556116;
        Wed, 02 Aug 2023 05:49:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:49:15 -0700 (PDT)
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
Subject: [RFC PATCH v5 7/7] perf sched: prefer to use prev_state_char introduced in sched_switch
Date:   Wed,  2 Aug 2023 08:47:30 -0400
Message-ID: <20230802124840.335638-8-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802124840.335638-1-zegao@tencent.com>
References: <20230802124840.335638-1-zegao@tencent.com>
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
 tools/perf/builtin-sched.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index eb310d1a7625..7f76ba51e36d 100644
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
@@ -2143,7 +2155,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 		else if (r->last_time) {
 			u64 dt_wait = tprev - r->last_time;
 
-			if (r->last_state == 'R')
+			if (r->last_state == 'R' || r->last_state == 'p')
 				r->dt_preempt = dt_wait;
 			else if (r->last_state == 'D')
 				r->dt_iowait = dt_wait;
-- 
2.41.0

