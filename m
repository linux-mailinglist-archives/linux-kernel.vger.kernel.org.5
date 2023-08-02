Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5F76CC63
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjHBMM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjHBMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:12:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D12D67;
        Wed,  2 Aug 2023 05:11:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbc06f830aso6317755ad.0;
        Wed, 02 Aug 2023 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978309; x=1691583109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWetw+9fo7xpR+/Y1RDX5IOHvVHf8sfB8Rgzd3Bsv2A=;
        b=PaK8I2pkE/WPQvl+laJR/GJw/w02Y7dJDqAA5GgpevxcqOGG13yboTTT5Md2wJv3ST
         yUlTF6785qm0HTky1cm31dKOVmmyaC2APjqWE/34WvEn5iwWl84Ejox14uRwoXk3rRt2
         bVtriVwHhLSWlbP2gpRrpvXL4Jf0pW/EwwkVGaJKanE8iE0ySp6KmC18f4rmIp41nSmx
         X8lk8qU34Vja2V/FTZ3tXVTr3pc8THhHVGBLOtTxsPbWYAMn+CltDI+c9lpn1Lh3hFW9
         KRo1d9RaIXDsBHf7kWoSm0tq0VPVB19gUhxt+Iwl65AxQQluEOIx0brGxn9Er0rC9w0N
         MxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978309; x=1691583109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWetw+9fo7xpR+/Y1RDX5IOHvVHf8sfB8Rgzd3Bsv2A=;
        b=FMK8hjm16VdCZQ/x752e9cwkAUOC4z3HJUyGCx3QsVmEoQUeODfCmBBM6LfmTMwcUF
         gvGyAu5wAr7KIU9V487n3fndFWpuXi6fjVCYUnhWIbQxayYASb9I0mIuw23hfAPEbe3v
         HzppD/5yOvpTxZGsLONddf4VwK9oZdMLkUW1uyGZqbh6//vl3GMjSIbBQLeKZUoPWsWL
         SnhYXUviuZa/QGWVFywo+M3xJRGPkTNqDkGOgZzLBgkJ2yKvccYQgZRCuqP6kt+ujfUv
         oejRYQgrTZ0coCYiiLjNTEyXFQxXYXUkmzFZhOWcFWW3vtv8ri7dcN3rkBzWao+nafbQ
         tO7w==
X-Gm-Message-State: ABy/qLbU2GpVcHAEjtnP8cO4BIhbtl8jhnDEkwz2LFqcW3RTZ6IkQe/I
        VYk2EcpnPRRXJ++t8Nxg0EI=
X-Google-Smtp-Source: APBJJlFo+Ep23l/5zl7HB5pJos/ZlOO6Cp9DEkOPyXKkibeYCOf8uXFLXhe5Vk4qcIWhW0ciD+vvig==
X-Received: by 2002:a17:902:d511:b0:1b8:76cb:c6a4 with SMTP id b17-20020a170902d51100b001b876cbc6a4mr20219434plg.21.1690978309236;
        Wed, 02 Aug 2023 05:11:49 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id kx14-20020a170902f94e00b001b890009634sm12293173plb.139.2023.08.02.05.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:11:48 -0700 (PDT)
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
Subject: [RFC PATCH v4 6/7] perf sched: prefer to use prev_state_char introduced in sched_switch
Date:   Wed,  2 Aug 2023 08:10:01 -0400
Message-ID: <20230802121116.324604-7-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802121116.324604-1-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
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

