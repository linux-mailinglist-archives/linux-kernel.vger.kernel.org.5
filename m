Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7767B1021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjI1Aol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1Aok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:44:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3613BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:44:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8315aabfso152233527b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695861878; x=1696466678; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLEFyFxvD6KViNnGR9L0+5bNYA79A2gbOhmLgb+y/zY=;
        b=pFNf16Xp/YoRQvtzvCZXz7csn9MGJUPsacWcqOFvWa/RSSqOT3s//u+lffhHgbYwtm
         /zCuLKG/rxbynKYMoR7XU/xyU9evjemZ/76sIWKuaQyQE2nl5JV4JWsT10Xo0DHVioeg
         DIEWQ0RmVJTYGVcLMr+aurfIufYRg05fNbpkVS6BckrHNXd4DMJ0mHrucW5PIX8UTo2i
         8XZmHzSEo+9b2YnWztouOQjwCUW+DUURYEuvRWDupGrTc06MZfj3qM2zTlg21qJ44UmS
         /0w6EQvwCsxkSFvaiyPZbwU6Gc4Ck0LgOrFPm/m+nue3EMIu11TFr5VCtuyPubsAg83E
         mObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695861878; x=1696466678;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLEFyFxvD6KViNnGR9L0+5bNYA79A2gbOhmLgb+y/zY=;
        b=huTtNLPiHDtg2RLYr5he6il9FKe76AL225cBUgt3wz+vFDRr8LFx01PSlu1kUbSu0W
         qRQmCLZdlg3fcS8WsWMe4+mabClSwt1oYajPB9Xn/q4yl/hC+JhocQ6vjfty3NEvLs+h
         knCFrE4quAFzELCRQwAcmauSL9Cn6WnIT+0ZlsSxI8ins67bQWyBSl28W7wz2ZJHr+q6
         66Yic0u1/9JwqkaL4Xlruy1Pk1mGIYwwBVCFX749rcgfhWT5aIuwAecoK/RLKlXc62BY
         kneibCr7ZwUdPzsVn5VluE6bGdZTr3/+WrjP/mD0mF04+kViXNupmC1oo/2WudJx39Ph
         9YkA==
X-Gm-Message-State: AOJu0YyLE7lNSFtnJj2T5QbCW5IXV124f+xTYuU3N929W7xYxA76AsMy
        +hw4FYB0F4BI/J/9GTi6Q3QdfSBtFndJ
X-Google-Smtp-Source: AGHT+IF9m+PpMz88SWFoJ1fVhJvIy1VH7aI+4+IJsEAbzOp43eRkOnoLWjAKaqPXO87Yj68vgFbDuMEaPDau
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:247a:7324:7470:3619])
 (user=irogers job=sendgmr) by 2002:a05:6902:4b2:b0:d7e:8dee:7813 with SMTP id
 r18-20020a05690204b200b00d7e8dee7813mr56449ybs.8.1695861878129; Wed, 27 Sep
 2023 17:44:38 -0700 (PDT)
Date:   Wed, 27 Sep 2023 17:44:31 -0700
Message-Id: <20230928004431.1926969-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1] perf parse-events: Fix for term values that are raw events
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raw events can be strings like 'r0xead' but the 0x is optional so they
can also be 'read'. On IcelakeX uncore_imc_free_running has an event
called 'read' which may be programmed as:
```
$ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
```
However, the PE_RAW type isn't allowed on the right of a term, even
though in this case we just want to interpret it as a string. This
leads to the following error on IcelakeX:
```
$ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
event syntax error: '..nning/event=read/'
                                  \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event> event selector. use 'perf list' to list available events
```
Fix this by allowing raw types on the right of terms and treat them as
strings, just as is already done for PE_LEGACY_CACHE. Make this
consistent by just entirely removing name_or_legacy and always using
name_or_raw that covers all three cases.

Fixes: 6fd1e5191591 ("perf parse-events: Support PMUs for legacy cache events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4d9f3922a33d..de098caf0c1c 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -78,7 +78,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
 %type <str> PE_DRV_CFG_TERM
-%type <str> name_or_raw name_or_legacy
+%type <str> name_or_raw
 %destructor { free ($$); } <str>
 %type <term> event_term
 %destructor { parse_events_term__delete ($$); } <term>
@@ -669,8 +669,6 @@ event_term
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
 
-name_or_legacy: PE_NAME | PE_LEGACY_CACHE
-
 event_term:
 PE_RAW
 {
@@ -685,7 +683,7 @@ PE_RAW
 	$$ = term;
 }
 |
-name_or_raw '=' name_or_legacy
+name_or_raw '=' name_or_raw
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $3, &@1, &@3);
@@ -765,7 +763,7 @@ PE_TERM_HW
 	$$ = term;
 }
 |
-PE_TERM '=' name_or_legacy
+PE_TERM '=' name_or_raw
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__str(&term, $1, /*config=*/NULL, $3, &@1, &@3);
-- 
2.42.0.515.g380fc7ccd1-goog

