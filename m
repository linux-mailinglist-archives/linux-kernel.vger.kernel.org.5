Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD2766482
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjG1Gu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjG1GuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:50:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91F3ABC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58378ae25bfso19333877b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526996; x=1691131796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCTbKLxJE0e0fl2gNVl7kq0Lz7zE9dDnQokd98Af9Ns=;
        b=X3zNA1RyzLTULsNbdzaguab4z5QUbvoNMUV1EWAEh8ykQMS+N/lSrXKHrjXCDjAIW0
         b8fAsPrrPrZUyGp2r2JOgYtx0Iyu2JRCxWsXHm0VA9DEhKb90ArH81bKpFGytwmaegL/
         ahLqi1dWB0gpwXhL71JAr4ayzjdZNvmRpaOg3DNpfus2x79fe2cK/zPF8M4yzx8dle8/
         lgYRqJGe5+65cNJgMBcb6mUsE4h8lwi7sFbN5W2Ys+inxantP8VFhm0mjMLMGq0MIX+3
         Q2qJAkJzldydQMadbHTKbjY/T5QuIThGF37ugL0IfZXuyIkE+c2o8kYT/YKIo3X65Ptf
         4j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526996; x=1691131796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCTbKLxJE0e0fl2gNVl7kq0Lz7zE9dDnQokd98Af9Ns=;
        b=R8WzPSvV/QC3g8q+9ExO2p4letQnk3CBvsfoIpXhrUIxektjRvKyoD6gUEG8KKBXgw
         0XcW7PNlKVGfR5tD3i4jBzN0ASA+0B+RVomRXTKTTfYwq4rVlg9CsaowxLMlLwWmp8bP
         9iI0/m1Ri1vfMKxL9XCJiQg+8H5Pw9qJopqzevuMDiRHpEdv7qNZclQawsrY8R3NEkDN
         Hz3ZV8rzLrkT0I4x3VAgFcwOLekSsW+Z5nNPZnbJvjnYVEKA8ZitITM33wIiwGJjrd/2
         WNI6Rw8WY7D7Kpz0v77srJDc3EmqZlmAI9+EbC9JWRCfqF89Hy8B4lRDfBdiaTfEQf6z
         z/HQ==
X-Gm-Message-State: ABy/qLY99TNUwMfDYNm8W+hJjeWMYbl04F/epQCr23dpj8HqUcjCvCGW
        4wzfDKafDuKhSDNmqpp0qih9jGDXAPUa
X-Google-Smtp-Source: APBJJlF1VBO/nA6o0F1Sw4iDyXLL+nD10wzaY2iHSF0gHcJmj7AOkP0CJ29sQFCewflEsjHmJprWtoE0EOv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:7392:0:b0:d1e:721b:469d with SMTP id
 o140-20020a257392000000b00d1e721b469dmr4543ybc.7.1690526996428; Thu, 27 Jul
 2023 23:49:56 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:17 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-7-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 6/6] perf build: Remove -Wno-redundant-decls in 2 cases
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

Properly fix a warning and remove the -Wno-redundant-decls C flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          | 2 --
 tools/perf/util/parse-events.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 20aa8545b127..b8f1e9ba8c6f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -312,8 +312,6 @@ CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
-CFLAGS_parse-events.o  += -Wno-redundant-decls
-CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
 CFLAGS_arm-spe.o       += -I$(srctree)/tools/arch/arm64/include/
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 926d3ac97324..ac315e1be2bc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -35,7 +35,6 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
 
-- 
2.41.0.487.g6d72f3e995-goog

