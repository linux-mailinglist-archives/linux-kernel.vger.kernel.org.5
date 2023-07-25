Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E95760BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjGYH1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjGYH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:26:29 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0519A2;
        Tue, 25 Jul 2023 00:23:17 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a04e5baffcso3613766b6e.3;
        Tue, 25 Jul 2023 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690269797; x=1690874597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBwG97iRZO4tN6Fiy1txLbQFfSCq1pL4Ni9ia1DF4dY=;
        b=fDWP8pJgo8CFkH9+IiKqXOh4RtqqEqQ/6GGY3V8azRSvvGfKhpE6KDe1fbUdl7Zpy9
         dBPsirxsiAz3pCvshqbdZtlUoRX8zx94wFRpw/Rdz6WXWg55bEmRlH1nzm5WhMFxW3yK
         +Ke1E46i/28HQOvfoSUM9Px7LQmVoho9ggOfEY9VRGW4uJtXYJ/Y6kSPVcjhprdkyzRt
         npvN/d2+2vqMXt8ZrsBjvErj8cwmHSdq7trsZcyu3egVacU7Iapvo7nlSx2ktw5EK53N
         r3uUvOnVlQ4Cgqf663FAU4bcLckT8RLyDkN48g/uoNFZqfoL31bgX7TbV9sgpVfJkzEO
         32uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269797; x=1690874597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBwG97iRZO4tN6Fiy1txLbQFfSCq1pL4Ni9ia1DF4dY=;
        b=FyHoHqt1sDm4gQk8u9Q+OaYQrMurSMuPKKp+1SE2uKH7q5+xG912NU/j/W5mach9wt
         PedHAP1US8h4P30JvCGwG0TM3sjnOomw7jilozumbLeBbhUYbqkxIOzmtZq19ZU3gcCR
         KyHONoMWXqS3GB9ZfEW6aqD6Czy2APn01KJrOn6duCV+KgqTTXdlMAMUDJ6rONsWTMY0
         LIOBRspRYmH0N7t9VMqxNmxR40EBvRKtPi0vz9vVH0a9ETjXCRW28NwVMIpm8YxxEeCd
         kMlvPZiKn/5ogoaQsJ/0Jcec/CxqAiiZ3iPBGlwcm8uXcuiIWxrf/4891lNrlE4IKr6j
         9yTg==
X-Gm-Message-State: ABy/qLYrTNZ6eKfSGTmg+Pqgop9gcWhuGOEeKIHyeLSuSBkGGKYQWFuP
        ZWCJ6w3YRdzoDCLrQijK/LMU7HtEO4zDww==
X-Google-Smtp-Source: APBJJlHnIYS2k4Gg3AdFfZruHgZ+iKMA1v+pyeYPD0a8D7QDa26/ZFtZvc1UNRqVWGF2vN6yqtP/aA==
X-Received: by 2002:a54:4703:0:b0:3a1:eb15:5ec4 with SMTP id k3-20020a544703000000b003a1eb155ec4mr9832357oik.42.1690269796838;
        Tue, 25 Jul 2023 00:23:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.googlemail.com with ESMTPSA id d12-20020a63734c000000b0055acfd94c20sm9863908pgn.35.2023.07.25.00.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:23:16 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 3/3] libtraceevent: sync with latest sched_switch tracepoint definition
Date:   Tue, 25 Jul 2023 15:22:54 +0800
Message-Id: <20230725072254.32045-4-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725072254.32045-1-zegao@tencent.com>
References: <20230725072254.32045-1-zegao@tencent.com>
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

Since tracepoint sched_switch changes its reported task state type,
update the parsing logic accordingly.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 plugins/plugin_sched_switch.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
index 8752cae..37c1be2 100644
--- a/plugins/plugin_sched_switch.c
+++ b/plugins/plugin_sched_switch.c
@@ -9,27 +9,6 @@
 #include "event-parse.h"
 #include "trace-seq.h"
 
-static void write_state(struct trace_seq *s, int val)
-{
-	const char states[] = "SDTtZXxW";
-	int found = 0;
-	int i;
-
-	for (i = 0; i < (sizeof(states) - 1); i++) {
-		if (!(val & (1 << i)))
-			continue;
-
-		if (found)
-			trace_seq_putc(s, '|');
-
-		found = 1;
-		trace_seq_putc(s, states[i]);
-	}
-
-	if (!found)
-		trace_seq_putc(s, 'R');
-}
-
 static void write_and_save_comm(struct tep_format_field *field,
 				struct tep_record *record,
 				struct trace_seq *s, int pid)
@@ -100,7 +79,7 @@ static int sched_switch_handler(struct trace_seq *s,
 		trace_seq_printf(s, "[%d] ", (int) val);
 
 	if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
-		write_state(s, val);
+		trace_seq_putc(s, (char) val);
 
 	trace_seq_puts(s, " ==> ");
 
-- 
2.40.1

