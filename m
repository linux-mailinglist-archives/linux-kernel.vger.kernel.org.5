Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20C679B9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbjIKU5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbjIKRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA0127
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e7e70fa52so4330850276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451976; x=1695056776; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRCYGoTjjcBophstCTgDgCPllSE9scm8ZFVfCDuwbMQ=;
        b=4EHxcPJv77hNl+7rXblAISOV1A5jk322xPjjLWmpMWPApLC5mtbFAJjcNlH/Cfg0CV
         O4Jx8u2UoxHzmuqKrimsynrN06cQkxtX9fXVdOuG9E/J532NH6RydHBMGQY+rkPG+3oV
         QoxZLzbBaS13lijfJ3LnmNyuamfwOYCRAEXIFm0FqN8XcR2ig4nOfKPAzoZ9+kXJ4LlV
         V+dfaqvgUx9ZjdZxbMIatpcOgN2WIxC+N9C1zcBsPvrLDZecvVNpXcKhf890rtMsPmoZ
         KtaiiEx1kJQHQoIH1if+RJy+7cRTz+g2OMSdGauz2KRabhBA7SBJa7mXVt8034MJDPN6
         r5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451976; x=1695056776;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRCYGoTjjcBophstCTgDgCPllSE9scm8ZFVfCDuwbMQ=;
        b=fARPd/U9oIYrEdk9WOaSeK+/T/x1OFJwJNaqtXwAUNB18CZp1yFgVXKEFRdhndnIqJ
         GJwZr2Hyhq4N5/V1Fz28pdqwNdGB6qYV6HIQpxqK1j7W+EeFNoFaCYA8fCiLB/gxqlCl
         snYyLu6dmBmSRjokJFwvW0Okt7rRScZt5On/QXQI2c8KudPdjamqaslmBqC3iRFoU00X
         Llen86z1i9iyIRDA+isn2WssWkzMeOhzLY3BYL61JL2JqQ0VCFSiz8dCU33mBQKh5D98
         L9jgXZb3BpS44u94UHibJADmj/VzUPQkuO8CU0l6DtQPaIPcaaj0FBuyTCYZg8n++KXO
         Y+Cw==
X-Gm-Message-State: AOJu0YzNqtHtcKYYbjh3qG9CodMoSWLn5Gvbrr9flZ8cmJHnO2/9PBZY
        0vJ9Y1qVQZCrynYXvngys5JeF7CpDgCj
X-Google-Smtp-Source: AGHT+IEYtgLkZOmrsQVv+5dnEAGGCmzF/e5/Bc/ESvtcLe0YzUoWzx6RXlKagJYsvqgnlYoolnqNvo6bX6Qr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a25:aa73:0:b0:d72:8661:ee25 with SMTP id
 s106-20020a25aa73000000b00d728661ee25mr214482ybi.2.1694451976506; Mon, 11 Sep
 2023 10:06:16 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:59 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-5-irogers@google.com>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 5/5] perf bpf-filter: Add YYDEBUG
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
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YYDEBUG enables line numbers and other error helpers in the generated
bpf-filter-bison.c. Conditionally enabled only for debug builds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.y | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 5dfa948fc986..0e4d6de3c2ad 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -3,6 +3,10 @@
 
 %{
 
+#ifndef NDEBUG
+#define YYDEBUG 1
+#endif
+
 #include <stdio.h>
 #include <string.h>
 #include <linux/compiler.h>
-- 
2.42.0.283.g2d96d420d3-goog

