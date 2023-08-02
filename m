Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9076CC65
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjHBMMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjHBMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:12:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B623598;
        Wed,  2 Aug 2023 05:11:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb775625e2so6239035ad.1;
        Wed, 02 Aug 2023 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978313; x=1691583113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPn/mgTWKV+oBePvxacidtJnH5NXaYh0/ilB9/OG6C4=;
        b=mc45EmmtV/Q7oq8TvX7NxwbUG3N2cWSLCMYDnJhAaGMTC3hdT7RjVpSaZNs+mFSdQ9
         v5bWNo26P1bPdS9OyeYlyyK+t0enQvHxYSETe/5pKPfT45ajR2+u6Gj+onzM582zPJLk
         LXLXdhhgzmxiO+b70ZwZAP6Jb1b45c/0XHxpCoYaPLMQMBYxHC7zLf5PG90xKEG3qZGO
         c2qBaWhWp6QU9wbOE0k7J1esoKTsll8myh2eOuD3SZffaOl75HFZPCeVSSb9QlkfYxTK
         LF37kESuUQtd6tX6mJWDSeSw+u4bNdFmZPJylzbxjmuQK6t3+KXwfLpvFqVtb5MXxylT
         WHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978313; x=1691583113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPn/mgTWKV+oBePvxacidtJnH5NXaYh0/ilB9/OG6C4=;
        b=KDt6hlyH24pe5ZhMuirPmSSwrw/gKrY1s+11BGNlzOev1cey9OODeZKyrAC0DKhXP3
         UuH9v9w2SpTKwd6DECSuYK02yRay8jK1Qy3oYvvz5NUZDFwUJBNpaQ7+xDhFrDiZDQ3w
         jGupCixohev/J+BXVLGuDV6219rfLSCg9fhdUIIAMP6AXDYA8HSG73RH9FxIj+TMbaFP
         5xYFEiu9Kiv7rZkXIft9UEsC5IXxDb10Kp7HpVHjJZZxE0pCOWqHgL25e1Qr+x0NvyLd
         5v2xN31pO9mPB83eAV21DrGkOVtt3zENCfqYqsK0ciP52WcekcXxokDRQlHxYwvpVhOh
         +pDw==
X-Gm-Message-State: ABy/qLbSxlOCP8NAZ7JqiBYupPYeRxI0+Pcs1ZZHbaCgAhV4/K6CspXl
        4JnlGkYZ2/MdXLMqfcZuJXlSPa3zMQLR6g==
X-Google-Smtp-Source: APBJJlE1hPI0N7A/fZmGmw3xgp2PHC4kcoZFRbMOnihD+ucaetXjldjU0n3gx+y9C4fqVGzmITNOQg==
X-Received: by 2002:a17:902:e745:b0:1b8:af5e:853c with SMTP id p5-20020a170902e74500b001b8af5e853cmr20084789plf.26.1690978313225;
        Wed, 02 Aug 2023 05:11:53 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id kx14-20020a170902f94e00b001b890009634sm12293173plb.139.2023.08.02.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:11:52 -0700 (PDT)
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
Subject: [RFC PATCH v4 7/7] libtraceevent: prefer to use prev_state_char introduced in sched_switch
Date:   Wed,  2 Aug 2023 08:10:02 -0400
Message-ID: <20230802121116.324604-8-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802121116.324604-1-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
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
report sched-out task state in symbolic char, we prefer to use
it to spare from knowing internal implementations in kernel.

Also we keep the old parsing logic intact but sync the state char
array with the latest kernel.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 plugins/plugin_sched_switch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
index e0986ac..4c57322 100644
--- a/plugins/plugin_sched_switch.c
+++ b/plugins/plugin_sched_switch.c
@@ -11,7 +11,7 @@
 
 static void write_state(struct trace_seq *s, int val)
 {
-	const char states[] = "SDTtXZPI";
+	const char states[] = "SDTtXZPIp";
 	int found = 0;
 	int i;
 
@@ -99,7 +99,12 @@ static int sched_switch_handler(struct trace_seq *s,
 	if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) == 0)
 		trace_seq_printf(s, "[%d] ", (int) val);
 
-	if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
+	//find if has prev_state_char, otherwise fallback to prev_state
+	if (tep_find_field(event, "prev_state_char")) {
+		if (tep_get_field_val(s,  event, "prev_state_char", record, &val, 1) == 0)
+			trace_seq_putc(s, (char) val);
+	}
+	else if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
 		write_state(s, val);
 
 	trace_seq_puts(s, " ==> ");
-- 
2.41.0

