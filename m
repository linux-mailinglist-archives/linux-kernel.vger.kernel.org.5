Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E21801819
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441917AbjLAXut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjLAXul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:50:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832A10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:50:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db548aff7baso1765093276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474647; x=1702079447; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uS8pGWtETXg2WFdrfgf4aQEd7sN6fnFiI3KEJAmFcnQ=;
        b=Qwxdpe+OvR2aKj5F5/OWkSDLPN8gkV3TD4oWKi/FRVcHKy59OFHkqYG/Qtu3PNpyhj
         3K5OzbRqz1Tu36EYtMdFSF4iVKTnrHflQOyLqvDKx8IdRWJb2UX4yJyu+7pGoIsnjbkn
         ax9NxqoP6R9RsCgY+RwmeCH8AWTXuJRLR2/wKldqYKsmrPJfEo6MK9CT1sXD2wtSuR7J
         1Pt5vzWuWP/Y7yoVXWs8FzyzcD4hU1atr6DesP2w3n66qreGosBo8GFymYoxYuccLIXk
         MgkHDciLgE9pyEvKCnlyG/j3yOkKt+gp7qq4zTg+5qxvciEbTN6eUYgNTkarONbOPtYn
         8wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474647; x=1702079447;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uS8pGWtETXg2WFdrfgf4aQEd7sN6fnFiI3KEJAmFcnQ=;
        b=dNueBr3ia1zTQKQKCKFTXsQZffiYkjuGWyaNHyn4C5l1rf5U2UYahYkItuNadR9RQx
         UXCna0W7kVepLXKml8cne7NeFj5N14YcpQ3XhFwmtdueCPCXTT+9+XpK/Jf5TegqdgHW
         UnMsfO+kThNfQNQxlNTnVJLVCSrhV/S6KZX/GjrYTpsFPGq6jQUJvphLm7+JhGYMYQ1u
         QOCoypmW0lgfQxivbJCq2iiXNnHe2VlbGjxhT10cSQCVDNUsOjA56vijTM3Xx9Z0kEgZ
         kPiJFvhkyQrhaLo44gj1QHbLDepkiUxD77eRNp8kzxB4gANaS0kcMjsJWwnSZmTw6Zb/
         3OJQ==
X-Gm-Message-State: AOJu0Yy9hUmjOSrMDVJJRNgOfJuethzpdpgoUIuYnLWikzWptfWV34fj
        m7LjPR4QXBzK2hTFvQRO8W+yuJWxRMX5
X-Google-Smtp-Source: AGHT+IELuyhuddMHz5qtKM8eoJ79tm6AThFMCEOnNC7A6AOrGbqi8w9ilpLSl58oEgA5OGcFVrpJO15dM0Y8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a25:ddc1:0:b0:db5:347d:44b with SMTP id
 u184-20020a25ddc1000000b00db5347d044bmr257636ybg.11.1701474646915; Fri, 01
 Dec 2023 15:50:46 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:50:26 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-4-irogers@google.com>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 4/9] tools subcmd: Add a no exec function call option
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tools like perf fork tests in case they crash, but they don't want to
exec a full binary. Add an option to call a function rather than do an
exec. The child process exits with the result of the function call and
is passed the struct of the run_command, things like container_of can
then allow the child process function to determine additional
arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 2 ++
 tools/lib/subcmd/run-command.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..d435eb42354b 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -122,6 +122,8 @@ int start_command(struct child_process *cmd)
 		}
 		if (cmd->preexec_cb)
 			cmd->preexec_cb();
+		if (cmd->no_exec_cmd)
+			exit(cmd->no_exec_cmd(cmd));
 		if (cmd->exec_cmd) {
 			execv_cmd(cmd->argv);
 		} else {
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..d794138a797f 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -47,6 +47,8 @@ struct child_process {
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
 	void (*preexec_cb)(void);
+	 /* If set, call function in child rather than doing an exec. */
+	int (*no_exec_cmd)(struct child_process *process);
 };
 
 int start_command(struct child_process *);
-- 
2.43.0.rc2.451.g8631bc7472-goog

