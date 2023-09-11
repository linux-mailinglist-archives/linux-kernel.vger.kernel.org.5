Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36579B25A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjIKVXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbjIKRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EAA121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59593051dd8so48096787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451968; x=1695056768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plnRe05PLz5HwJERoEdGb+td666IsNXhJdSMGYIgC0g=;
        b=35ZhUrc4mC8wm++mqZHj5N58Wb6AxXOh3zE4qdiZC4tghBatLr1k3SKhymondkzsrx
         Oq2mNCzHTuzyoQ/UlPgSr8ojbWqcsXRW27r5TWhl3EZlqhN5jGHagfeSvFhmt6LSoZCX
         Xi/qEY8aC+SDq4iytTM6njtvDHFRHIHmvjsdc+5sN46GyiN+UXL80R1/81K+5zlON7VU
         N/T0iC+Ev11w8bIaqI0uM7eT2rjciAXFybv9W4GRdPGuA2lGArXP4uh67hkL5GmCW19e
         4Dq1jk7UwastkrMk3B36KMLtSQ0LaXsTTLdJjcOndQlm9sJUNQMUsIVGNX6kdn7plXYW
         J1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451968; x=1695056768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plnRe05PLz5HwJERoEdGb+td666IsNXhJdSMGYIgC0g=;
        b=DcLNwvXUn751N0Oott/EaZrqintpOzZKSav7HJOIHxB3E6pdd6YI3TyNIPQ1ICtaz4
         rm/DhqUJSWw3MpxQh8LmuJkeOThiL69rrtF2VPDYfyIczw3UQU5qy/g3Et5S5ntf6G9N
         WX8cx7sXLZ+7CObsbhm7BS0wphDF6IAmTgeuHTDKIblMMWH7uVebRg0e0l/PaOn1F/sl
         899dhdSxU+uBMALDhPhGYy6gtFiMpgfvddyZR4dP8pQZGmv2b20eCNK/1y0bLY6+durI
         8xZBoHsAWCbXWgH11pxUBGZdPzG86oogd7xqDb+oI8fr/ywr8C/ME5d8cnM6aUf9FiXK
         wkzg==
X-Gm-Message-State: AOJu0YxLxYY50WFkAzFBeYUWwuNmE6PwMRqMqn9UleqkfbEDs9Xf1OTB
        DS6VwJekkwxI30sqYTWPTSbC/Wgbk0LH
X-Google-Smtp-Source: AGHT+IEnfS1l+N2qwMCzhtLFyNIHFAeL8hpCr7r2M2aEhvvJJ66Ru6k4JSQfK49zP5WGO8fpgWBl7gvJULw+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a25:4153:0:b0:d74:6bcc:7b22 with SMTP id
 o80-20020a254153000000b00d746bcc7b22mr217383yba.6.1694451968569; Mon, 11 Sep
 2023 10:06:08 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:56 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-2-irogers@google.com>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/5] perf parse-events: Make YYDEBUG dependent on doing a
 debug build
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
parse-events-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index ef03728b7ea3..786393106ae6 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -6,7 +6,9 @@
 
 %{
 
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 
 #include <errno.h>
 #include <linux/compiler.h>
-- 
2.42.0.283.g2d96d420d3-goog

