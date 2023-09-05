Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D712792D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjIESSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbjIESSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:18:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCF171A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:17:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fbfcb8d90so29183517b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693937764; x=1694542564; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y07qFiYECd11N+vNvyoUjAree2R1P2rvhI0ssuxH2Wo=;
        b=5AooYeZNFOvx3uewyZLZ1QCM1ZfEoxMP6OKst4zb64nG0X8JVlR6sUzXXWNks2OFho
         PV/jBAHLGv/5sAsNbNeV3YdHXXWTx1qMRfUIlaK2/b48cffEyLVqzrMBw4YMwcT1JEbZ
         RCXA2wuayqPP1rTM8EGzVxkj6jyDpQzyaedOt9PBg1mf1ZvlcYaMA0oWr0DporGZ21gA
         V195vh9iaGZFBaTdxryJB4SNQ6r12pYTIlm2MlYHDR+ahR3BuThbFCpDOC/OdaqoGfJA
         VS7mGQFz0en0pcEE4KvA0HrzCr7Bo6lhKTgisNpIsv3jHYGCNT/OZjJ/95GBTXeHZ926
         6htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937764; x=1694542564;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y07qFiYECd11N+vNvyoUjAree2R1P2rvhI0ssuxH2Wo=;
        b=OEEHKQTPinhMcmeGERXGgqpbnGOLUaUxrNl7Ut1aWb2Ws6IcWOQpzYSVLpuPlanXGn
         t8PpBa5VxPAbzaTaD2z8JdZCcO0hGBTm+g1FvDIC81tbpW/U9ChQucj1EKrTiINMbDJs
         ODrj1SZ1eK2QqQVRH94mmEGKhW2Z9By5i85H+ui5k+v9NaPspYNfXykeuja22LWLImxK
         1efxZP+uOaVmruILbuI26gIHOnhG9H2tQGTpEQySBHGIpRrZhqKWB4GLa5khGNvL6EGp
         wKngSfjcnTM1lfcXhq8PULaXR32IbniRcDwCcUxM8DfM3vjlfbF90LtlzU19c/uj55kl
         hVeA==
X-Gm-Message-State: AOJu0YyxRe2q7331ztx6ji1H2kolk1hHugO87Su9bfSJVZzV6Zec/Jd2
        iHSdKimKBnluOOzvUkVeShPRTeHMADIG
X-Google-Smtp-Source: AGHT+IGKRFAQrI1REpVPNXdfYLh5y8eD2YG5x0DJqWAPOVbWUocmJHtuWN0HGbLbFiPnjQkJF1YHSzpLpx7e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a05:6902:180c:b0:d0f:a0a6:8e87 with SMTP
 id cf12-20020a056902180c00b00d0fa0a68e87mr308639ybb.2.1693937764506; Tue, 05
 Sep 2023 11:16:04 -0700 (PDT)
Date:   Tue,  5 Sep 2023 11:15:52 -0700
Message-Id: <20230905181554.3202873-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/3] perf completion: Restrict completion of events to events
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf list will list libpfm4 events and metrics which aren't valid
options to the '-e' option. Restrict the events gathered so that
invalid ones aren't shown.

Before:
$ perf stat -e <tab><tab>
Display all 633 possibilities? (y or n)

After:
$ perf stat -e <tab><tab>
Display all 375 possibilities? (y or n)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 978249d7868c..40cfc30ad7ad 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -164,7 +164,7 @@ __perf_main ()
 		$prev_skip_opts == @(record|stat|top) ]]; then
 
 		local cur1=${COMP_WORDS[COMP_CWORD]}
-		local raw_evts=$($cmd list --raw-dump)
+		local raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
 		local arr s tmp result cpu_evts
 
 		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
-- 
2.42.0.283.g2d96d420d3-goog

