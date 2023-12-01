Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04EE801821
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441962AbjLAXvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjLAXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:50:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC219AB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:50:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daf6c1591d5so1422119276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474657; x=1702079457; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lUnGKwfnXUenrlTEoRlDOWCoPKyTMDM98VpoOLbg3Q=;
        b=Huz+6C2NqmiG/UkpuwkCmC6sEWSHrlhxShYluejTROtV6E81hDMcxG0bfuIdqR1q3x
         gImPvhktLUBrkbPoFkHQQMNMMkWg4bt3KMLBaD7SVSrxTynEfJG751Ycd/cfG5RLNTmc
         fkaPxZB4V9VbYLEeXiH50dILKf5lH2fgaM/Ke31q5qIXZpd3DJ9QHD+4GYlUUEYB48HY
         fxKcWVcfocnwLiXow21P6W2hAJZHPmQJ5CsIfIyziWMsV0Vttrqjgk+x9ftQvGB6ho65
         IoAjTMmjB2g37s6hXqt5w9WWvOZ9v8Nnn9k5QM87rzyjqXWC0DHbFAmxO+KR8h6q7efr
         SAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474657; x=1702079457;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lUnGKwfnXUenrlTEoRlDOWCoPKyTMDM98VpoOLbg3Q=;
        b=vw7ayolxQQr48da6kbIqyN6eFzKJFbwT1DEKThu+5jizcrvhQ4OPUefDnFlj0xSyZZ
         4vtUqJ98Yr6gaNJcSujvaVodVTi4WJMa+85CumopV+Vq2EPw2euXt9UtYup0bwyx5HYa
         7NmzlAkdrJBtwayAy77du2j+q08g6abE6taWd8J4nD3FgxhYghW5oxMmcu66324lBN5V
         qNu6DQQQEZMz2jjtaspUYXxmqciJq/l0SN1DLVsTT2bnsrrJ8T2L6pQ8TMGCi/1Feh7w
         gn3tSnFHYM0vROlvsfDi8HY1LVcjLCITV+244/YA92z1Oca9qg38EDtyLqlWYhDE23Rt
         pdAA==
X-Gm-Message-State: AOJu0YytyucjDnMrzhF4soVUIcNxPoLjj201EbYMYORceoaZgj6yQ+gq
        oSMhhS471DGpYHlxIoQ1yJIliVORuNV0
X-Google-Smtp-Source: AGHT+IHhTfxjeqb/2Oow+1932o5xoEw597jdDkx3b5HoCXdGGldelKroIRhiDKbkrHbi1LEljtDajoEqDaAR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a25:74c9:0:b0:db5:3b4b:ad1e with SMTP id
 p192-20020a2574c9000000b00db53b4bad1emr240617ybc.10.1701474656852; Fri, 01
 Dec 2023 15:50:56 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:50:30 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-8-irogers@google.com>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 8/9] perf srcline: Add missed addr2line closes
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

The child_process for addr2line sets in and out to -1 so that pipes
get created. It is the caller's responsibility to close the pipes,
finish_command doesn't do it. Add the missed closes.

Fixes: b3801e791231 ("perf srcline: Simplify addr2line subprocess")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 034b496df297..7addc34afcf5 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -399,6 +399,8 @@ static void addr2line_subprocess_cleanup(struct child_process *a2l)
 		kill(a2l->pid, SIGKILL);
 		finish_command(a2l); /* ignore result, we don't care */
 		a2l->pid = -1;
+		close(a2l->in);
+		close(a2l->out);
 	}
 
 	free(a2l);
-- 
2.43.0.rc2.451.g8631bc7472-goog

