Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0608096DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjLHAFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:05:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4751716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:05:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d942a656b7so18225337b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701993924; x=1702598724; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7VAKwLUWVywjDo2dEK6wuoDMXw70DBGya721KiihN0=;
        b=x0tL1bBzPd2y1Arwym5V8VyRxX/wao6al+lRmd/1JaDyeGZUdKD62/YcJvRuJUOlJt
         14icRm9QIXPNDjqpYb6oAJ1LDAlpBBMe1zGrThdDauLLR8I9/g1y3FagG5tTuFES0tKZ
         dy3i7UM/Bah6LHAQ5Shq7ZIMBgCycTZDn/3GSahtYsyOgdQbF86S7b7PbQV/wVkUgNsN
         EGzDezAKNBZHDhm2ebsPc9ypuaSOVbNagY96s7rJujQGUTiIT9Cd9QBToaCeZ+bdu8BH
         O++Tc7tf7YAQJFHLs6+4CIC9deqU8J1haQNNRkMYgDHCGwOp7wC5WzN7dHaS3jcA4nqD
         jwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993924; x=1702598724;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7VAKwLUWVywjDo2dEK6wuoDMXw70DBGya721KiihN0=;
        b=doaClfcoPbAZe8a7fFXxWrhQx7hoCXG9gS95YGF4k/nE2ThzTdjpblZaXlRH7gXvGn
         ZbG/ZZIviXCFzD7NFci1DUnd4t2Ahj1cGtkyeQgXmIYoAHuMtJmEQcqsztojm4hB5z0P
         8bUbXHh9QCkh1eoMPBiEnb/FX3aoPx74MAK9BrRYvmDloO0oaEOZm2Crtu5E2Gbblrox
         vWQFSZsCPbfp9mVqDg+xo91Cz96lX27yurKv9ZR3avMhX4lWJACkgJZVigqmAcwV3anM
         HrIk3JGvBxUagjw2BGR3PAgB1zRrHhajKqlDHmf6TQ9wdH/qjVOd3YbC091QbPL7UcN8
         3Uyw==
X-Gm-Message-State: AOJu0YyjJbir1X8mYCZnH8Myl+pwwu9eVIancaFn9tYXVMPwlYgq8mP+
        8hbC6atz5bGFZ9khRxBeQjnUS7oTQN7S
X-Google-Smtp-Source: AGHT+IHu9T2Gy2CB3/Hupo7gAYRgMRacMV5kSjT6ATlNY2CuCYfwMUaXFiD8Fs/UWATBZndJDix8xNo+IImI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aa27:6848:76cc:141c])
 (user=irogers job=sendgmr) by 2002:a05:690c:4607:b0:5d3:9513:4aad with SMTP
 id gw7-20020a05690c460700b005d395134aadmr53065ywb.3.1701993924731; Thu, 07
 Dec 2023 16:05:24 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:05:13 -0800
Message-Id: <20231208000515.1693746-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uniq will write one command name over another causing the overwritten
string to be leaked. Fix by doing a pass that removes duplicates and a
second that removes the holes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index adfbae27dc36..8561b0f01a24 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -52,11 +52,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
-- 
2.43.0.472.g3155946c3a-goog

