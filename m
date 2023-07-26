Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9C76360E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjGZMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjGZMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:16:46 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C82698;
        Wed, 26 Jul 2023 05:16:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-345fcf8951fso27553145ab.1;
        Wed, 26 Jul 2023 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373799; x=1690978599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzcxxlbFJ3XgasuaSW3q94g6VrQbmuetHpQHuGg7FzU=;
        b=jWr2FVUNFVAj8c4IATVZ7wOpIy5pyYjdrKhq1XnaRhW1LWqd5o94aebPTcPg6y62Zn
         VxNeDdLGwitNL9vOKacamAgjsVgGmOwgKaY8yKEuJw+kiQpcVhKdjipI7lNgvxUadI6A
         m/NriPfv8n0kFYHkjwWYwtNO9qxJbYBovyrRAU7lQxna//uxQHpt3hw6dd1Cyf7SKrGn
         zCJHJVqTSsdFLb1rgn/ipwTkz8Iv9tIwjJtTdrk5wtLOCZgT1LP+tqWwLG6dkFR3h7p+
         zVd3jQOvAQdgI6DPk6xKH9DRtETNMBLvZmDvky8v/gTsWHa8EzwJlDRaUTbEAXH7PCGB
         t44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373799; x=1690978599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzcxxlbFJ3XgasuaSW3q94g6VrQbmuetHpQHuGg7FzU=;
        b=L/+6VjyMA6Sz9Ygb9VK9HglL6HyZ9nZGjBqlGu9Qw5kbavuZldbXcCRNYDnCXR32Hu
         ifyCTnFbtumRyOboe4UOyxE1MCEfPGoBwpGZZqqbSWIeh4OKTx18ot4AW8ciXBMsZj9k
         9pKUxY5RpYmYnYO8x5auZ1ARym/lHyzW7LORI1qMFCw4cESOERJckHZbdoHSOj5/WCTx
         uslaCtwnH1i/ldcYdTwJA76RF7K3akadaVrHRAX7tijYXYBu/teXnz7wAzBHemDaU1s0
         MwovRIoacdDWdeKwEPWLIBp4k1ts772nDP/Lz66x7i0vRR4AEO2sbHWOGPL+p/wyrJw0
         GY+w==
X-Gm-Message-State: ABy/qLasiJQSFIl6rJto0b98ukAz5rmYWcAfkNzTE5ZD0JGz5w6gkI7Z
        sLP/KfkWYz2/scbFdIg2s9U=
X-Google-Smtp-Source: APBJJlH6zbVQEJmJs/+ocaXTXJkfchg/0JB0jQo/dB+RUpuMADYLeL3yOmhm61B37jhB88FyH+zIdg==
X-Received: by 2002:a92:c549:0:b0:345:8373:bf68 with SMTP id a9-20020a92c549000000b003458373bf68mr1969298ilj.25.1690373798957;
        Wed, 26 Jul 2023 05:16:38 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id ms19-20020a17090b235300b00263f446d432sm1172880pjb.43.2023.07.26.05.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:16:38 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v2 3/3] libtraceevent: use the new prev_state_char instead in tracepoint sched_switch
Date:   Wed, 26 Jul 2023 20:16:18 +0800
Message-Id: <20230726121618.19198-4-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726121618.19198-1-zegao@tencent.com>
References: <20230726121618.19198-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the sched_switch tracepoint introduces a new variable to
report sched-out task state in symbolic char, we switch to use
that instead to spare from knowing internal implementations
in kernel.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 plugins/plugin_sched_switch.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
index 8752cae..5dbdc28 100644
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
@@ -97,10 +76,10 @@ static int sched_switch_handler(struct trace_seq *s,
 	trace_seq_printf(s, "%lld ", val);
 
 	if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) == 0)
-		trace_seq_printf(s, "[%d] ", (int) val);
+		trace_seq_printf(s, "[%d] ", (short) val);
 
-	if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
-		write_state(s, val);
+	if (tep_get_field_val(s,  event, "prev_state_char", record, &val, 1) == 0)
+		trace_seq_putc(s, (char) val);
 
 	trace_seq_puts(s, " ==> ");
 
@@ -115,7 +94,7 @@ static int sched_switch_handler(struct trace_seq *s,
 	trace_seq_printf(s, "%lld", val);
 
 	if (tep_get_field_val(s, event, "next_prio", record, &val, 1) == 0)
-		trace_seq_printf(s, " [%d]", (int) val);
+		trace_seq_printf(s, " [%d]", (short) val);
 
 	return 0;
 }
-- 
2.40.1

