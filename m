Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218DF79F7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjINCWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjINCWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:22:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E5198
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:22:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59beb3a8291so4246677b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694658128; x=1695262928; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HlEcmDja1ZIoCrnt8HbZ+hkvBpXdTmxF97ewUnwPOAQ=;
        b=WX0imZaN5CxKDVSlCgy83ocZjlPBL0dU+5rAn+1w5S6zBs1YQ4Psccd9fGd9YTbpeI
         2F0hQqadDBj7wSfntqMNta2h9ai2hm+M2Do+8LAUy54fEes3ULEI80XmGlcgjdXFvP3k
         Kn9IAk3DuRlT2qzDAOJYmLSpQPf8mbsPaQS361i0dVOObJhBbuW06AglD2PTtnewO7E2
         dU2eAeFmyEO8HB9Fv02bNSR+b4oSytvbrbhnbMnNIlRd1yz9LWBua6HYsWXq34f2wHfz
         JOBs022IJdgJN6bG188/ldJYlj48Ov3QSK6ozbgQaJiasnPiCfqo2CZ1Yt8XVobc/3PC
         75lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694658128; x=1695262928;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlEcmDja1ZIoCrnt8HbZ+hkvBpXdTmxF97ewUnwPOAQ=;
        b=g5nqINaoAyDkzpoL8uVrBoRYb/vyFSO2BF4QGkD+wXU0e0d7x/nUshMhSpsXLsx9EF
         cOLHfPBdkUvw6nN/NFOR7+g1y5phA05AvuuIHR5nilhCl6hmLOGxlz5ESC3D+Dvv932l
         atRX/AC9oIMbwGrI9lVBO6rrSvnCK82GErdolpwGDDTaTRLWSCrQMEa6KaET4Si+5nER
         isupyulT5aRmW/aYfR2avzhdhAiKw3DyPFGqKq8DbrjsdDy8UwqcLvb0Xv6Wka9Z2yrm
         MB+TXU581wQZ9SGDvZxt7ItLWWzqNRTdkGpTFiqc+4F2mzb5IIvhxI34QUVvofF5A16u
         61GQ==
X-Gm-Message-State: AOJu0Yx2ePs3vp0AIhcOJ6lepaRS9abBDfX54hctfWUGfmp08o6+EFrV
        dC855wzTJCU4eZqrgQ2NoFTHnXVrmxni
X-Google-Smtp-Source: AGHT+IHL67rMwo9L1rXI7bpaX/pikOGXx7rhRBJDWRhrPs3ofYlloK6TCu0x5DgtmS9hby0YB8vdfeTTLXQ9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7612:4bb6:bcf1:779c])
 (user=irogers job=sendgmr) by 2002:a81:ac20:0:b0:58c:6ddd:d27c with SMTP id
 k32-20020a81ac20000000b0058c6dddd27cmr105722ywh.6.1694658128069; Wed, 13 Sep
 2023 19:22:08 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:22:04 -0700
Message-Id: <20230914022204.1488383-1-irogers@google.com>
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

Fixes: 9d5da30e4ae9 ("perf jevents: Add a new expression builtin
strcmp_cpuid_str()")

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

