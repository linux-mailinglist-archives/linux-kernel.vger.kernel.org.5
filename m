Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088A079F7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjINCQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjINCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F206CA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:16:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bbae05970so6983707b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694657792; x=1695262592; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YPKWPHjjLgKJy2fs1wzoXbOYUhtcDdJLgwEmq5NtHvM=;
        b=fAijsZ7WkIUEPTw63mkQ1ELlBsgin4u3ACUgLY+yyRhRp5u3GKN3QxHBmvfUlPKsLY
         /YwQYP9emhfzuQGtBYk0K+R4g3QcuEtpD7NTbZzIJXeFyhlHlfQLf9qM9LfzZHgVaWVj
         ni2om8qr+ye9mB4MmVBwxtMQ5VLLwcb9gfmzCxGK/94EZFWjFXPzrEcLgmKYcgjWkqfC
         PPCVctWK2emnFxtOmcePWUY64f447PbwOHrjWZqn9G/L7UzzzXd5suNkQygbEfhvdXz5
         IyIwxOTgRdywtCmFMhWRsTLAL/6GjLG682px8xGbpfJY3vukbSHrPbCzNZkxHBQ7p2Jy
         hB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694657792; x=1695262592;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPKWPHjjLgKJy2fs1wzoXbOYUhtcDdJLgwEmq5NtHvM=;
        b=pjBi/6RyNGDDi5Dk7l4BVJEieLX7s6oFqCY/rRGNVXO4KlDJy5zdHQzNHeEQxKxDKA
         6xiiPNrKOyWuX7/ZhpGVZviCumG/rq1GwFMjpZztPtDLDprcBb78fxwonfXt0f9LYVik
         znoUfUq7qHjXPqsTz2xy9GWbh7qrc35k+g+B/v776DNCEHzgicVt2CtpnuNAxF4xL8FQ
         KoybeLGg+QuulXur1fXg/5fseZKBudUuclGR3qy9HjA0ByvpTI/MQPN9ZUObrUY1D5w2
         7+py1A00j3BhhAgHQg9NFm47SigRVgOZByqC6XmZwN/ITzT/+xTn3Xx5psKtHOQm+ot3
         qk1g==
X-Gm-Message-State: AOJu0YzJMxhKvGOlsenJ7B0GhkQ6aOzRYKgwftDm9uggWRP5KIUnAJzT
        0waTo0hPq2mUcvvTlduSrShpLHJJSHvb
X-Google-Smtp-Source: AGHT+IHgct12NXo2j/VT5NrnoFte0xgNrJBRPi8H7VZfSRZDlrbNYrNjODsaGwt//fsFVylXssLPAh57Rn5g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7612:4bb6:bcf1:779c])
 (user=irogers job=sendgmr) by 2002:a05:690c:4683:b0:59b:f3a2:cd79 with SMTP
 id gx3-20020a05690c468300b0059bf3a2cd79mr933ywb.8.1694657791802; Wed, 13 Sep
 2023 19:16:31 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:16:27 -0700
Message-Id: <20230914021627.1475054-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf jevents metric: Fix type of strcmp_cpuid_str
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser wraps all strings as Events, so the input is an
Event. Using a string would be bad as functions like Simplify are
called on the arguments, which wouldn't be present on a string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0e9ec65d92ae..3e673f25d5fd 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -413,10 +413,10 @@ def has_event(event: Event) -> Function:
   # pylint: disable=invalid-name
   return Function('has_event', event)
 
-def strcmp_cpuid_str(event: str) -> Function:
+def strcmp_cpuid_str(cpuid: Event) -> Function:
   # pylint: disable=redefined-builtin
   # pylint: disable=invalid-name
-  return Function('strcmp_cpuid_str', event)
+  return Function('strcmp_cpuid_str', cpuid)
 
 class Metric:
   """An individual metric that will specifiable on the perf command line."""
-- 
2.42.0.459.ge4e396fd5e-goog

