Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31588096E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444139AbjLHAF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjLHAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:05:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE561716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:05:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db542ec49d9so2002688276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701993927; x=1702598727; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf5gnEGQIoXazSeiXhfMb12CybARggvMyxZM26gKG4Q=;
        b=kv6RQLIeqqQgCftrGdYe9u8RB45ZC9g4uHSOLndZz6pwpZtis87Dwxrlzebn+HLSa6
         rLCM2SBKNEYVcdK2S5LyAOTmau7yeJMQDr10JtalD2nNnWyQlbDfbQT0k6GMyHwzeQXU
         fE6/BqMgPbRxR2JQyS5MNTaQQCQOg3Kq0aHRhIqtQLrsKtuhoXkuEscLbL64sd6FoLof
         Z5JK6IeBEZpNNYWqX89SFKqTpB//Gt1sGXfMh1QUzEbVQGATXLw7j/MKvKmD5Il5eDH2
         sbih2vcRYFCYnyw8L+aKZjh2vN1w/3aP32P//vyASDXJqp7DXV0/6HYLfZ4oLUWwmfD4
         OJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993927; x=1702598727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf5gnEGQIoXazSeiXhfMb12CybARggvMyxZM26gKG4Q=;
        b=JLKpWw1/QoEw64nSVR39Vbnc59c4ShzemG5uWcAZ4TIrBiQM1cCAQHRtxYfSHKnlED
         AvMRE72PEkex7GIkXPH/bQlSJHuOTNojqMTvnh9rcvcwUOZqp+H9x9P+16as+DRYXu3k
         Rpd9k+Mfx5yYEsx4Twupu0+brEaJU5SK4YjuHSB/79iCFGWfhmcnXQ2kbSdxvm6oW34X
         Ui+GPxYAfXlOzuymNLeiiwtFDzxQW2mmkIp5HelgNAtFFRGcK9KmyZwrZGMxCgFAxKz+
         cvpSjLau1gks20k9QfmxPoV6N6/xEmj3K31fXcHg0mUW/f2j2CiMQbqJ0BFhZhOllu3+
         s/Ow==
X-Gm-Message-State: AOJu0YyTV63MYyqEcbBQ9smpYkjC40EUAuVYU0+ad18IR17VT6VgPr6P
        H0dKUSadnpELtUIm+QB5JZEs6xi9sVrY
X-Google-Smtp-Source: AGHT+IGkk6tmDRZSDzkUEEDm+lkMYS+lFIUbPXflkEU4krTvsf/mz9zYtbA+Z0XDSnxtsd1nMc041ivFa+Xg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aa27:6848:76cc:141c])
 (user=irogers job=sendgmr) by 2002:a25:5509:0:b0:dbc:1b46:9aeb with SMTP id
 j9-20020a255509000000b00dbc1b469aebmr40703ybb.2.1701993926977; Thu, 07 Dec
 2023 16:05:26 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:05:14 -0800
In-Reply-To: <20231208000515.1693746-1-irogers@google.com>
Message-Id: <20231208000515.1693746-2-irogers@google.com>
Mime-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 2/3] perf: Suggest inbuilt commands for unknown command
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
        Chenyuan Mi <cymi20@fudan.edu.cn>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing unknown command code looks for perf scripts like
perf-archive.sh and perf-iostat.sh, however, inbuilt commands aren't
suggested. Add the inbuilt commands so they may be suggested too.

Before:
```
$ perf reccord
perf: 'reccord' is not a perf-command. See 'perf --help'.
```

After:
```
$ perf reccord
perf: 'reccord' is not a perf-command. See 'perf --help'.

Did you mean this?
        record
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin.h               |  4 ++-
 tools/perf/perf.c                  | 21 +++++++++++---
 tools/perf/util/help-unknown-cmd.c | 45 ++++++++++++++----------------
 3 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index f2ab5bae2150..f4375deabfa3 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,8 +2,10 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
+struct cmdnames;
+
 void list_common_cmds_help(void);
-const char *help_unknown_cmd(const char *cmd);
+const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds);
 
 int cmd_annotate(int argc, const char **argv);
 int cmd_bench(int argc, const char **argv);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 921bee0a6437..c719e6ccd9e2 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -18,6 +18,7 @@
 #include <subcmd/run-command.h>
 #include "util/parse-events.h"
 #include <subcmd/parse-options.h>
+#include <subcmd/help.h>
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/util.h" // usage()
@@ -557,7 +558,7 @@ int main(int argc, const char **argv)
 	pthread__block_sigwinch();
 
 	while (1) {
-		static int done_help;
+		int done_help;
 
 		run_argv(&argc, &argv);
 
@@ -565,14 +566,26 @@ int main(int argc, const char **argv)
 			break;
 
 		if (!done_help) {
-			cmd = argv[0] = help_unknown_cmd(cmd);
+			struct cmdnames main_cmds;
+
+			for (unsigned int i = 0; i < ARRAY_SIZE(commands); i++) {
+				add_cmdname(&main_cmds,
+					    commands[i].cmd,
+					    strlen(commands[i].cmd));
+			}
+			cmd = argv[0] = help_unknown_cmd(cmd, &main_cmds);
+			clean_cmdnames(&main_cmds);
 			done_help = 1;
+			if (!cmd)
+				break;
 		} else
 			break;
 	}
 
-	fprintf(stderr, "Failed to run command '%s': %s\n",
-		cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
+	if (cmd) {
+		fprintf(stderr, "Failed to run command '%s': %s\n",
+			cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
+	}
 out:
 	if (debug_fp)
 		fclose(debug_fp);
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index eab99ea6ac01..2ba3369f1620 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -52,46 +52,44 @@ static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	return 0;
 }
 
-const char *help_unknown_cmd(const char *cmd)
+const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
 {
 	unsigned int i, n = 0, best_similarity = 0;
-	struct cmdnames main_cmds, other_cmds;
+	struct cmdnames other_cmds;
 
-	memset(&main_cmds, 0, sizeof(main_cmds));
-	memset(&other_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
 
 	perf_config(perf_unknown_cmd_config, NULL);
 
-	load_command_list("perf-", &main_cmds, &other_cmds);
+	load_command_list("perf-", main_cmds, &other_cmds);
 
-	if (add_cmd_list(&main_cmds, &other_cmds) < 0) {
+	if (add_cmd_list(main_cmds, &other_cmds) < 0) {
 		fprintf(stderr, "ERROR: Failed to allocate command list for unknown command.\n");
 		goto end;
 	}
-	qsort(main_cmds.names, main_cmds.cnt,
-	      sizeof(main_cmds.names), cmdname_compare);
-	uniq(&main_cmds);
+	qsort(main_cmds->names, main_cmds->cnt,
+	      sizeof(main_cmds->names), cmdname_compare);
+	uniq(main_cmds);
 
-	if (main_cmds.cnt) {
+	if (main_cmds->cnt) {
 		/* This reuses cmdname->len for similarity index */
-		for (i = 0; i < main_cmds.cnt; ++i)
-			main_cmds.names[i]->len =
-				levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
+		for (i = 0; i < main_cmds->cnt; ++i)
+			main_cmds->names[i]->len =
+				levenshtein(cmd, main_cmds->names[i]->name, 0, 2, 1, 4);
 
-		qsort(main_cmds.names, main_cmds.cnt,
-		      sizeof(*main_cmds.names), levenshtein_compare);
+		qsort(main_cmds->names, main_cmds->cnt,
+		      sizeof(*main_cmds->names), levenshtein_compare);
 
-		best_similarity = main_cmds.names[0]->len;
+		best_similarity = main_cmds->names[0]->len;
 		n = 1;
-		while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
+		while (n < main_cmds->cnt && best_similarity == main_cmds->names[n]->len)
 			++n;
 	}
 
 	if (autocorrect && n == 1) {
-		const char *assumed = main_cmds.names[0]->name;
+		const char *assumed = main_cmds->names[0]->name;
 
-		main_cmds.names[0] = NULL;
-		clean_cmdnames(&main_cmds);
+		main_cmds->names[0] = NULL;
 		clean_cmdnames(&other_cmds);
 		fprintf(stderr, "WARNING: You called a perf program named '%s', "
 			"which does not exist.\n"
@@ -107,15 +105,14 @@ const char *help_unknown_cmd(const char *cmd)
 
 	fprintf(stderr, "perf: '%s' is not a perf-command. See 'perf --help'.\n", cmd);
 
-	if (main_cmds.cnt && best_similarity < 6) {
+	if (main_cmds->cnt && best_similarity < 6) {
 		fprintf(stderr, "\nDid you mean %s?\n",
 			n < 2 ? "this": "one of these");
 
 		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+			fprintf(stderr, "\t%s\n", main_cmds->names[i]->name);
 	}
 end:
-	clean_cmdnames(&main_cmds);
 	clean_cmdnames(&other_cmds);
-	exit(1);
+	return NULL;
 }
-- 
2.43.0.472.g3155946c3a-goog

