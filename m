Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296037BED78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378729AbjJIVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377177AbjJIVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:41:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8399D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:41:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d4bbfc7so79694827b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696887709; x=1697492509; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lab+IK477apFFSLjWykol92FbgsP0NP2xQdCcWnRJJc=;
        b=K9pUEWqiZcinseww7WXpCz4QMMx9aZ93ON8J8Zehe6VG/FlMFMR2pt4+bl+gkmqqja
         CkUF29uEXeh7Bkp5mZiY0Yu8Pjn1MvYJXhFBkz2Lr1Dc2CeRMApnbXsYr9NtADkT1zkq
         5c3oJeepAPSSH7zNZ1yxx0tDPe/OxtjcEvK9uiE35oQkClq82L5NKj50h5BzhfGAc+wM
         kTJFu/28gIlbdZTu9vSrXoC7e+HmTJxrlFri0g7edr4bx5mFiKWPGPlPiDG1CjRZB0Ki
         lis5nHOwXX0HrT+pMykJCvBIkbd41waXUY2mhJMO4+XrnIh7M6vhn7rZyG9nSe7vI0UB
         NIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696887709; x=1697492509;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lab+IK477apFFSLjWykol92FbgsP0NP2xQdCcWnRJJc=;
        b=gC3+MRgpu5EoKSth4uL1uljioH7IcpL/aJoDWwL/ATNPeBRjEJnKjaR/nEHL35KrbU
         y3eTIgOT07ry3y8Fd3pHNBcCsQy+cENg1lIq3f7NnjdxCfGbPZRukI6vY4aJ789X1Yaf
         Z2Qopp7lgVsX7LZpk4lvN+LtFPyqAwAQkD6FuKC4GpKrCQkSUu9zC+yoII4/e6WKCdeL
         mqD6wBWB3Mar/GdybykNYfGiwBOJ838MPdtWWrqJu52YbPI8dLrrEUUQa8bioopJFfnF
         YM2qyWHdkvjjI1jm25ziTsN2QO+LZuO7uYiKPFVV3ijb09bFkKxh4Dm6tX8VetvsXq6/
         W8Lg==
X-Gm-Message-State: AOJu0YyWLSNxO5KZZYV0ABy/A6vF4zwEvm7QXIfUSaQG6WZ89Y5GZtAR
        ExFMt9VH0wBy1Hs/D1P9x+LHHxf/buS+
X-Google-Smtp-Source: AGHT+IGzh2MJLvBdA0jC3P3CQdImlAG66wNFPAdO21hsujTQLSbMPvwXgNC2udPrZmYhI8dlvuLIWcUb34dF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:a849:0:b0:577:619e:d3c9 with SMTP id
 f70-20020a81a849000000b00577619ed3c9mr344168ywh.10.1696887708906; Mon, 09 Oct
 2023 14:41:48 -0700 (PDT)
Date:   Mon,  9 Oct 2023 14:41:41 -0700
Message-Id: <20231009214143.349978-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 1/3] perf machine: Avoid out of bounds LBR memory read
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
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Artem Savkov <asavkov@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running perf top with address sanitizer and "--call-graph=lbr" fails
due to reading sample 0 when no samples exist. Add a guard to prevent
this.

Fixes: e2b23483eb1d ("perf machine: Factor out lbr_callchain_add_lbr_ip()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index addfae2f63ef..e0e2c4a943e4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2622,16 +2622,18 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		save_lbr_cursor_node(thread, cursor, i);
 	}
 
-	/* Add LBR ip from first entries.to */
-	ip = entries[0].to;
-	flags = &entries[0].flags;
-	*branch_from = entries[0].from;
-	err = add_callchain_ip(thread, cursor, parent,
-			       root_al, &cpumode, ip,
-			       true, flags, NULL,
-			       *branch_from);
-	if (err)
-		return err;
+	if (lbr_nr > 0) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				root_al, &cpumode, ip,
+				true, flags, NULL,
+				*branch_from);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.42.0.609.gbb76f46606-goog

