Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28F2760052
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGXUNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:13:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC61735
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:13:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso47295937b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229583; x=1690834383;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hkxh9LqcegTaK3Zyb2Y04p/jheCyz+iGuZbjHft5A=;
        b=dFnffByPi/9dPdpPXDPeErJAHkm4U9xmJEkUxTK523YIBmo/FhKa35iXauOduV2Pif
         qhrvAqczwoe1kO5YrqsE4HVa/uBo3+8dpoYCh3NieWigFEDe/IVK3O6HH6OdtI5i+ZM+
         2KRDhnab4TtHa6Xfwmg8rPe40dTtSGrCgHfS12vvP8ClkpFCg2qRBovuROUDtaY7RgGC
         rq6iGpbsv+MFoUANFCBaKzXVulRiJgAxltKkaziWxEl+HKkX9SEO4FlhIeLqgOjRtUd/
         7j9DqAayTNnDqpM5MrM1rjP74kQsTEvcd8AjHnDSeFYehB/V4Gfm0pF0X93t3kqOaUQl
         OgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229583; x=1690834383;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hkxh9LqcegTaK3Zyb2Y04p/jheCyz+iGuZbjHft5A=;
        b=SnCwu9llm6MC9CP9YfNPxQE6WNgDgUGK2NnTLKwbvh8qmAwl0+44m+wLjFI3dciY3L
         bmE3+QAtOKRQ667CSHsXcvPa5rKMozZDpL6jHYhzpgCHe9XW66Vf1afDHWA2PPqiQF3Z
         KO+4Em4WSWojUl1mK6ZvLgQZqP+TZw4uwVBZK2zAlY02BrXS0/HKuhIU3DW16No/edaP
         JQzFuEblubrL7de2ZaX1+QXb14nMpBqjKJStMOWpe83OF/0tYO0NQgbco+QXfWtgk6SM
         JbHxqyh3q/HB/0PZ7FRJsxrw5qehK/BsIi4BmCTFh2+qmA7mc7IlpG6lB+a7kHAP2IUX
         v+xA==
X-Gm-Message-State: ABy/qLax4Pbe49ccYKhJb1PlWgN9Zp4V+KTs+vJYYFfVSsDTtz6CMAAm
        vvd8kc2/eDfDZHUugjJCPvzldiO5VQ2A
X-Google-Smtp-Source: APBJJlEcBOZe3u432ZlnenysdB3kMfqSv4wJ57ueFyPxQ8WNtoVZQq8B8/KVokgcDdDgdzCi3rPmRZZpci+e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a81:af21:0:b0:56c:e585:8b17 with SMTP id
 n33-20020a81af21000000b0056ce5858b17mr70674ywh.5.1690229583398; Mon, 24 Jul
 2023 13:13:03 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:12:47 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-5-irogers@google.com>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 4/4] perf build: Add LTO build option
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
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     maskray@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LTO build option, that sets the appropriate CFLAGS and CXXFLAGS
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c5db0de49868..a9cfe83638a9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -256,6 +256,11 @@ ifdef PARSER_DEBUG
   $(call detected_var,PARSER_DEBUG_FLEX)
 endif
 
+ifdef LTO
+  CORE_CFLAGS += -flto
+  CXXFLAGS += -flto
+endif
+
 # Try different combinations to accommodate systems that only have
 # python[2][3]-config in weird combinations in the following order of
 # priority from lowest to highest:
-- 
2.41.0.487.g6d72f3e995-goog

