Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8890A792D68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjIESdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjIESdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:33:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28DAC1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:32:53 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-76e57b1239eso253528285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693938694; x=1694543494; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klhRss+hz2sCHrma37LRr7SfQt+BwpB8srd4HmiASto=;
        b=C6NMu/6htGdY8Dd02PWkacx6M6nCVrALOgAKTtnh68O+WXtpYYOhF+Lo7vTQDGUXsE
         PhOw1w9W03XBQ0PfeZdHIjIsgwd90tb1dPKnIgRiRs95F/uWNwJYbFKvP7sVKsG7zeQq
         6K3v1YxqMnBjnOcBlOpIoQoPHOsxprOFYZgvfnuip74P4QxT3p8fjs9GHMltS+etreCy
         RiuqTTCXB4l5mfgxLjJjFVOLwcDEbIIzbBlm1qhJVkjosg8999Vsg9L4Gh1gQPa/Ork5
         I5JWGxH8srhNgv7ainUpaCFfQOUwsIipcm66Em1z2YIV9su1uW2fPael8FKZtDdmjTt4
         D+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938694; x=1694543494;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klhRss+hz2sCHrma37LRr7SfQt+BwpB8srd4HmiASto=;
        b=gcSy9zCTy0wVe6wZnP1pQJlOY3SrVI1rEAmDXNfkQP+vPVtD2mToZhix2jEHF7cMaI
         LhM+X9HHNlfJQ+ZIr55dnzfMwvfqFvYdkyiOPtW5qVlFZdky4WPdlPDP5dBCmpeN54ZU
         gNKH++7DnWpKmkg08CnaUurMqEdSZvR3GUjqprmeIFTQbGLhQN4R0str9S2njmhUttxd
         U1u1ufP3W3m3u5OF5OS0Yl3Q9V30WrEGpHD0x64/rxNgoW+vt7F74rdUvIEAWjzrPy1C
         P3IRx3iS0i8VmqNXRx7obFOR8Shk//7L3TvJ3tRUwUKBSD6IAVmI0m3BmWkoYYQR6T+L
         FSWQ==
X-Gm-Message-State: AOJu0YyyLNjiQ1rc4WvEQRDBmZ9yDEo384CzK6+ffdr7/GBjz9sgqnPO
        /zqDF4IZhdrGQ1DOicSeWZzfAGsqwb6i
X-Google-Smtp-Source: AGHT+IG/AdiLHm5ncrJjTjGm8xs1OtOpUdIbMcfrDR37zr2W9w7e2sotGDs3MfNaiS25vhbdPdTsAgrbBhX1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a81:eb0a:0:b0:576:8cb6:62a9 with SMTP id
 n10-20020a81eb0a000000b005768cb662a9mr344705ywm.6.1693937766716; Tue, 05 Sep
 2023 11:16:06 -0700 (PDT)
Date:   Tue,  5 Sep 2023 11:15:53 -0700
In-Reply-To: <20230905181554.3202873-1-irogers@google.com>
Message-Id: <20230905181554.3202873-2-irogers@google.com>
Mime-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/3] perf completion: Support completion of libpfm4 events
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `perf list --raw-dump pfm` to support completion of libpfm4 events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-completion.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 40cfc30ad7ad..319ad724b97a 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -198,6 +198,10 @@ __perf_main ()
 		else
 			__perfcomp_colon "$evts" "$cur1"
 		fi
+	elif [[ $prev == @("--pfm-events") &&
+		$prev_skip_opts == @(record|stat|top) ]]; then
+	        local evts=$($cmd list --raw-dump pfm)
+		__perfcomp "$evts" "$cur"
 	else
 		# List subcommands for perf commands
 		if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
-- 
2.42.0.283.g2d96d420d3-goog

