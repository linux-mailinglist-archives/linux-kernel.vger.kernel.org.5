Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81C76647A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjG1Gt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjG1Gtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:49:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EE3592
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d052f58b7deso1759222276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526987; x=1691131787;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhkzLjqRFF0tb62b0zCcrfbiHArZkxdbKwWW1/g/MaY=;
        b=4clqy47Iqnh9PeYyHrqFTBjZVVf2SsELiW1HtOdGDeARMMfpRfOc5BJg7RxKU+0K59
         RuhH+JcaohEwep2coSpp1uhn625qdWNvq18kjJeU1bqh4H+4r2JgRo+B/XHKkvIFAtAd
         R3kQBqwvyEa+TcMvRgBKHmm8MYf8+ukvA1ioGcNVQg/Gso5Ud9gz3tk0FPXR7o0hNTZf
         QFZB0DzH6H5VFQTA7uYQh+vnKMQhcU6NxtStCPkF6+G4gpUIT7bLYg6AmiimM+mPPiw2
         0cdqCrJgLMxv/olLDJ+/aTTgleRC2E7Z4U9KIdBIg2AKRYWN1ab8Va/7I+p7lyQfoMQd
         B22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526987; x=1691131787;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhkzLjqRFF0tb62b0zCcrfbiHArZkxdbKwWW1/g/MaY=;
        b=B9oY+AOvEEftDvd6AHk5hCKWg6gTO3AUWrU/eWw/KfxoG58SOtAPEr+eASLpgDURZ0
         PN6wnBzPVIMIzHh34Eu83776crdPNCzmp91JleA8KBSSer9W9fs6lz2hTigb5yIxMqFv
         Ys7UIzzwWD8pmoJnjw57sw8zd/4paN2jFcWdpJYqsRs1R2B96UCUqLj4+DDLOxvzTapb
         t1c/+xzgvErJvvVrx+slX3fRNFcppKbCtYWeSHkiHGu432ikhGihoDnZjTRgI6PL68xk
         9pu2H/f3BtoYEEUiHiWsqCAaktrchgkQzJ0dRRDOvytbEUvguOJ9Wanj1Z215BTW0RQy
         BzQw==
X-Gm-Message-State: ABy/qLZLSD2CCwVR8mgHtaNZT5ppOMr/jIZGAkwSRZwf971eFxa6kHoP
        IUyWBPxq78phGtczyvv9GD1x/54jPH4h
X-Google-Smtp-Source: APBJJlFItFzpwaYwOmttNt6LMhW33cuF50knjW5+ecNSk4vm9Ubps/H5m9OxllkRh3cs73v48l7MUO+HQmGt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:ae0c:0:b0:d05:38ba:b616 with SMTP id
 a12-20020a25ae0c000000b00d0538bab616mr4562ybj.6.1690526986818; Thu, 27 Jul
 2023 23:49:46 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:13 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-3-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 2/6] perf build: Don't always set -funwind-tables and -ggdb3
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
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a40cd90f5de ("perf tools: Add libunwind dependency for DWARF
CFI unwinding") added libunwind support but also -funwind-tables and
-ggdb3 to the standard build. These build flags aren't necessary so
remove, set -g when DEBUG is enabled for the build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a9cfe83638a9..14709a6bd622 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -246,6 +246,9 @@ ifeq ($(CC_NO_CLANG), 0)
 else
   CORE_CFLAGS += -O6
 endif
+else
+  CORE_CFLAGS += -g
+  CXXFLAGS += -g
 endif
 
 ifdef PARSER_DEBUG
@@ -324,8 +327,6 @@ FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
 
 CORE_CFLAGS += -fno-omit-frame-pointer
-CORE_CFLAGS += -ggdb3
-CORE_CFLAGS += -funwind-tables
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu11
@@ -333,8 +334,6 @@ CORE_CFLAGS += -std=gnu11
 CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
 CXXFLAGS += -fno-omit-frame-pointer
-CXXFLAGS += -ggdb3
-CXXFLAGS += -funwind-tables
 CXXFLAGS += -Wno-strict-aliasing
 
 HOSTCFLAGS += -Wall
-- 
2.41.0.487.g6d72f3e995-goog

