Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5F792D54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjIESWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbjIESWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:22:45 -0400
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93BCE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:22:17 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-58fc7afa4beso32007867b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693937769; x=1694542569; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XqA+7q5S8GcuFEv94zqkxsospEdyuEhg8U7iQVn4Bg=;
        b=0gK75Xe2qwZoaOCnfybp/uWLsuOVio7NQdVkmSjerjNW0V3TgwKa2cVBwBQu0REegb
         Q0FfVP0sIe3yG1jy+YI7m3cV51XdiRkcdPUtWUb8U6f8kHyX75CE6fiOj5aC1cKsdUdV
         Sk8pLWC7pgRxZdyqcc6ZSt8AVfxKSEY1XRe+BuZH6J+B64NebnjOOjfV1kfecMXLX4jK
         j9e7WCVWxhxCgyeP2y1FtDJD13nqbu90bV5IYmZEL7vjSQWpuCGQZvl4h9tdDMlzAUF9
         WyBtA05liWTpYKFSPhh6CzwWZY1MM7EAT4cEC1yZFVvLq2nmyvanImuZeijGsu6t3GTt
         lMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937769; x=1694542569;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XqA+7q5S8GcuFEv94zqkxsospEdyuEhg8U7iQVn4Bg=;
        b=EoSAGWNKtbjQ/dR0gLkFap5xToxlifsd17lL6lqpF4oJD1ttWVL2FedSqi/CW4GXND
         ohSgL4QVQuP3rMEg9sNg/ryoSOp5tckgDaLf3IWHH9v+DoNx222yU1zFuEXZioXFgsQ6
         LUqNct5+kbnR6+DauRTRowHBTYC9Oz8RktkX0teuxV+VGlT6jM3DlXnwY+T9FKK7uxy2
         bZGYg5pprSIKMGHYB8x+SoAPWWj/I9LAA2vWQaEAf/zZWyV7SD6/vG/hyH3lQQn/vmC5
         uy/PQ/IlGDGBTRZwp6o4oAEkQrsjf5w7ctzdvb3e900vvLPc74dkpUMgsKLGTYx+capB
         Tdhg==
X-Gm-Message-State: AOJu0YwwykR4PB8oUwRaJJ5+391uETMr/VqvPXOh5UjnkHUbwTYV44nW
        +Mx3bxQehjh66hYiev+KuC3hRp1a/qlO
X-Google-Smtp-Source: AGHT+IGg80w1b+ouYPhBbnVvKUQ0/xUemtvB+rChC83tYWEcPTgI+TgyrY14wNh4lQjnwp9XhrOBGFV9Ev0N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a81:ef04:0:b0:595:870c:1554 with SMTP id
 o4-20020a81ef04000000b00595870c1554mr431925ywm.5.1693937768958; Tue, 05 Sep
 2023 11:16:08 -0700 (PDT)
Date:   Tue,  5 Sep 2023 11:15:54 -0700
In-Reply-To: <20230905181554.3202873-1-irogers@google.com>
Message-Id: <20230905181554.3202873-3-irogers@google.com>
Mime-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 3/3] perf completion: Support completion of metrics/metricgroups
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow metrics to expand for -M or --metrics options.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-completion.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 319ad724b97a..f224d79b89e6 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -202,6 +202,10 @@ __perf_main ()
 		$prev_skip_opts == @(record|stat|top) ]]; then
 	        local evts=$($cmd list --raw-dump pfm)
 		__perfcomp "$evts" "$cur"
+	elif [[ $prev == @("-M"|"--metrics") &&
+		$prev_skip_opts == @(stat) ]]; then
+	        local metrics=$($cmd list --raw-dump metric metricgroup)
+		__perfcomp "$metrics" "$cur"
 	else
 		# List subcommands for perf commands
 		if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
-- 
2.42.0.283.g2d96d420d3-goog

