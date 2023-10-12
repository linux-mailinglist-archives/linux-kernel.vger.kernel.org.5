Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076277C6572
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377428AbjJLGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbjJLGYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDAD8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7aa161b2fso9747347b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091852; x=1697696652; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym33VVd2BajpUroKBZvd3tTL/sMIOEowMFesXhruLGo=;
        b=dtCItIPdQ3ab8HIPvToAzsIESurEr15VjpWWQ8yaO+Mg1RPqvT1cE14W9NklAd0jK4
         7yQ2iyo7WfgUQHpDzjw4V0bvJWMP9hGr1MpgnkicSitGIq9Hgx6OBpCyvqIgbhaytO4f
         wE2oz/3Zdc1UDmfqgeYmLjtPPZijSChFDH3QPEX6xvSQcIWUs6fsZeeHOUlMLjxtuLXh
         3p4fy/a9+mdQ/ejgOkZKtHwQ4HBkeVjdo6SW9BnVVB/NdYNT2A9GxxV+xXatq9lEOJwJ
         iQ6OC+badkskyGbxNCbXfyXX8nMbfz3mHiQ/mrp9ETD79Rv+3tw/76vxDOVuOpmZUfK+
         bGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091852; x=1697696652;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym33VVd2BajpUroKBZvd3tTL/sMIOEowMFesXhruLGo=;
        b=YO11XmGkLkqjP0o7F658InpDd0d8TjILPwgOACA794ICrTByAxX3VxErsH2MMujrx8
         rGgi4KVAubtFVqWcYPyulES2ubwbxNMUZOZyNcvgUQYmw/r3N0Lt+I9ULgG+nMnyr0ml
         fMjfPKGuAzvuv5p/ckOPInu0c+w1hQmwsPZ31nhGHY/MFPopIyC/p5pb1sQdsCn4xIAh
         DT8DgXw4FeQT38QWKZOXU5ew/RpTBLM96KUICSNQtQuNpXeD4ShjK8yNWrAmghAOtQe1
         IIpjF5lIG18mz96W5FpCpJgIVa/+pJ1e40Edj12BlzEN1FcwJer10StFRsrO6huOCmNr
         zNpw==
X-Gm-Message-State: AOJu0YwcmAuGMAWezPZvSdxisNUL+GKXUNsjc+0kZBa8O7vKCluyVogE
        mp/l7d4YccNdk2T91yW7Uj1CNZLfM6OH
X-Google-Smtp-Source: AGHT+IFamm+ol0Ge6e4jpFG/GjQbgher+01yNqOVMfFajP7Qe61Mum0E7T8Iepds/4dvQPRSXfa66oFUzQ9k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:870c:0:b0:d9a:3a25:36df with SMTP id
 a12-20020a25870c000000b00d9a3a2536dfmr196216ybl.8.1697091852080; Wed, 11 Oct
 2023 23:24:12 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:49 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-4-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 03/13] perf hist: Add missing puts to hist__account_cycles
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caught using reference count checking on perf top with
"--call-graph=lbr". After this no memory leaks were detected.

Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3dc8a4968beb..ac8c0ef48a7f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
-- 
2.42.0.609.gbb76f46606-goog

