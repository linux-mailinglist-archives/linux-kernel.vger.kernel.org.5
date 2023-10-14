Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB297C934D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjJNHma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjJNHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:42:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B85ECF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:42:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c88b46710bso20778465ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269343; x=1697874143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWOAPqRfJlFeGZpcN7zM2S+ByCB4SMNDEstgKNTnaCs=;
        b=AkHjspckxsgd2hxEurDMoIaqdpc26U/hAk3ns5JmzsnDOLfKFX9gPbQkDRScCIu97o
         TjeqYN2u7BZ3MZth50pxQRQ/YsiUWLaevy9kARkYNWCjln8AwqT68hhtvbJCqi59W1Xx
         kNMzbB1ELctinhUfOsfUM3ZUA0Y0Ue4bvdfX8oHY5wfSr6liGuMKPTKU0shgaWYBdcp+
         1qfRyT2fCPQfD0xBkGSe/imxdz/OCorZe4cStU1A02NrZSsuBK4gcM/bg0ywbkrpgdAQ
         u7YtZ6fTN4jUULn9kVzbGkg4YCEzTAUwXaS9fXqo8Ie13PtcLUcIHdX7dPSkgBwlgw5q
         3KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269343; x=1697874143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWOAPqRfJlFeGZpcN7zM2S+ByCB4SMNDEstgKNTnaCs=;
        b=wGAzTDns/PFkYJmthLIoK3YgbXtXKEEqjvj82YJ0IdIhPxeNm3N0Eo4KdSBcjQZVxD
         bXxNpT7Mzri8pxdtVm6LrZkxYkd5A53JpzwxC4UiV7I278jyJC4admBYRZjW6/MeYUW3
         Vcolj+M7+wa2E2BVvM8d0cIhyMDZ3CKDM/ST4ZZJl57NNZIREz9zb6PEkZGKUpBXoWgQ
         4FZSU0giteTkQkyukhIWG1szrU4s0wyDLPlrNKm5dAC7IwsFn4A3Y2iO5vV/X7xcn5Um
         FCur+mXajXUz7QwCiauWe/ncDAKKOhaf5PBDERfYw3qhTx/c8BALN+RpLB+lAIV9Ugvo
         NUyg==
X-Gm-Message-State: AOJu0YxTm6wf8U1XQVhJmOQE3kthPGOstMwYznPplkd5ysgUUKEGtage
        RJjBvPN/QZxtyoTpgx0X3XwGIw==
X-Google-Smtp-Source: AGHT+IE4fFHIwPowtX28NpMjG4rwpVawnPYgQzzkATlSIS071tzOVwmxcTYq9ltdsTO+Ac9Hv4/pXg==
X-Received: by 2002:a17:902:e80e:b0:1c6:2b9d:56ce with SMTP id u14-20020a170902e80e00b001c62b9d56cemr28094278plg.21.1697269342540;
        Sat, 14 Oct 2023 00:42:22 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001c5b8087fe5sm4957319pls.94.2023.10.14.00.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:42:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 RESEND 2/2] perf cs-etm: Respect timestamp option
Date:   Sat, 14 Oct 2023 15:41:59 +0800
Message-Id: <20231014074159.1667880-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014074159.1667880-1-leo.yan@linaro.org>
References: <20231014074159.1667880-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users pass the option '--timestamp' or '-T' in the record command,
all events will set the PERF_SAMPLE_TIME bit in the attribution.  In
this case, the AUX event will record the kernel timestamp, but it
doesn't mean Arm CoreSight enables timestamp packets in its hardware
tracing.

If the option '--timestamp' or '-T' is set, this patch always enables
Arm CoreSight timestamp, as a result, the bit 28 in event's config is to
be set.

Before:

  # perf record -e cs_etm// --per-thread --timestamp -- ls
  # perf script --header-only
  ...
  # event : name = cs_etm//, , id = { 69 }, type = 12, size = 136,
  config = 0, { sample_period, sample_freq } = 1,
  sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
  disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
  ...

After:

  # perf record -e cs_etm// --per-thread --timestamp -- ls
  # perf script --header-only
  ...
  # event : name = cs_etm//, , id = { 49 }, type = 12, size = 136,
  config = 0x10000000, { sample_period, sample_freq } = 1,
  sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
  disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
  ...

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index cf9ef9ba800b..58c506e9788d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -442,6 +442,15 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 					   "contextid", 1);
 	}
 
+	/*
+	 * When the option '--timestamp' or '-T' is enabled, the PERF_SAMPLE_TIME
+	 * bit is set for all events.  In this case, always enable Arm CoreSight
+	 * timestamp tracing.
+	 */
+	if (opts->sample_time_set)
+		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
+					   "timestamp", 1);
+
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
 	if (err)
-- 
2.34.1

