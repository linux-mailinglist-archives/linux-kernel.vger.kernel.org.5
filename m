Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F427FD061
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjK2IK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjK2IKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:10:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491D1990
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:10:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da39d244087so7772996276.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701245430; x=1701850230; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=X/snFXEy8faZNX6QoGJzhEUbNV1WjZARbZDPCvqBThRN12rlcWhd6juUuU6E+vfzIF
         HDnaayxQuUF+Wg33rLzJp0HqET17oiK+ooFXT1yuMAzRpaUSIpAwy71YUDItnPoNdh9T
         zVpN+dx/k/AY3od4+skeLV+Dv3aOsP0PGgniJTo5cvZU2RmfXGZRJgTs1y6szv57iXsj
         kYThJ24xeEQVP4oG979Pe/oPCrj5/8mHHO/nRFYIGRh6cqVG9y/ZxVlxvWIeetXt9qNC
         1q9m9mUF1pCKhbIY3iAntfnnQBzOIHX5QfWv8JNc8DstLN72noFnuMCUiV5TSpzsMoTz
         lxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245430; x=1701850230;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=dV5iDfYEE5+ZKWtGYWQr5v3oDM6OaRUKV64H39Ogk9tvVw4UQTQD9hobeIjxoV6x5L
         mtgvvOo00GYFW/zHv+/fu6AODsH6SmRxRpCNdlzaMxbxQ0G/a/M66Jnoa1Yt6L4vIuVp
         G3C+P/9btHnd4vjHZDeKtJFXh1lbgauZBHPZDtUxIo2SBvMDLn6Tcexxwsk0ZLyNsZIo
         TousI0ySWkJ+0wdYJ2c6BBYcq+2uIc7YYZWt4oB9RFquJZXQdA/CbFSyc0wxHvXQvKOC
         MxQiggeaHPZLa93nsVAXBfM750KLI795M/CRdNzsJygmxmGYjj2EeLrATLd77pldJyi/
         /pDg==
X-Gm-Message-State: AOJu0Yy0NotXAzj2w1ZOxaN5W1FPa5Q4pw/BpZYOAG3Voo03Jrd+S6n1
        h8SIbeyrl6XDL/LroQCBwpF6E9kwmb9V
X-Google-Smtp-Source: AGHT+IGmneAGaPYvOs8mdl9PtOV8N6GGuxvdo2hPaYRLDR7wynZTsfXHXMus8ynoyI5qMDICYh6DPo/GfI/B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:ca04:0:b0:da3:a91c:7356 with SMTP id
 a4-20020a25ca04000000b00da3a91c7356mr440438ybg.8.1701245429912; Wed, 29 Nov
 2023 00:10:29 -0800 (PST)
Date:   Wed, 29 Nov 2023 00:10:03 -0800
Message-Id: <20231129081004.1918096-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 1/2] perf list: Fix json segfault
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
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Json output didn't set the skip_duplicate_pmus callback yielding a
segfault.

Fixes: cd4e1efbbc40 ("perf pmus: Skip duplicate PMUs and don't print list suffix by default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index a343823c8ddf..61c2c96cc070 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -434,6 +434,11 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool json_skip_duplicate_pmus(void *ps __maybe_unused)
+{
+	return false;
+}
+
 static bool default_skip_duplicate_pmus(void *ps)
 {
 	struct print_state *print_state = ps;
@@ -503,6 +508,7 @@ int cmd_list(int argc, const char **argv)
 			.print_end = json_print_end,
 			.print_event = json_print_event,
 			.print_metric = json_print_metric,
+			.skip_duplicate_pmus = json_skip_duplicate_pmus,
 		};
 		ps = &json_ps;
 	} else {
-- 
2.43.0.rc1.413.gea7ed67945-goog

