Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9613D7F3BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbjKVC2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjKVC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:28:18 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1CEE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:28:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c87663a873so69616947b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700620094; x=1701224894; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9IER+tn3y73SnSAMuBhvXywbHOoikax61O9o+LNCM00=;
        b=bwb5hwGK+G0RyFqP8rWxyp5SQdIk0YoDhCFusnvQVU5bbhUZWqSQt2aNeZlleEwxbY
         E5NVuJ6uRvaTgrJYsXpuXv9LPOXVXEKbyOxJGAH5UZhnPedBmY8Ui7FinCopZkp0/QT9
         ZT0fGrQDamJcqiLg61QUB4bOw/ujQ43KOhvEAmRBtmKlH4ZUe0ASlJULnPFPSasFSKbY
         J9SwGzs/pYCa4pSDxV8438XBvdsBhmJI8Al8VC5H+68w4x12bIjbj4VxwdoKOhCj2nKX
         5bt+0b9r/TrwcTHcmIkY9Drs3x4J4bj7rCJeRGbODdysOmahVAyvPNaQ4dMTGIVwxZP4
         Y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700620094; x=1701224894;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IER+tn3y73SnSAMuBhvXywbHOoikax61O9o+LNCM00=;
        b=YHDOxYYW75BalRM8tspEEQWsdDM3kGtjtqq0gvBufj8VPs0F68Df5AMiAO48bIDd4U
         GgGq1DSbySLAI/5V6U7fWadEoiVK8QxYyBvfIhlK+C/pQycgwGLAFQ/mIEbuC5ERdK9y
         9PdLTPGtJAfX7WrztQbO8s1bqBGLeXvE1ckZsqDd6q4iWqTbrURDL2iSOqoRSgrOGrf3
         fc8cgGa2fO64yPyuUhLeSiyz7WoZb7TrOQJQqiXAAA7Is5uXA0zrS+6UYifK1u49dFwl
         anqSziw1eOxI5Nv3Bqg3N+7bmW/YCCUZwn7XGRVNhV5T4nin3inzqndVkH6FkP3Jd1H/
         tsrg==
X-Gm-Message-State: AOJu0Yz+aAQXAbs627ODyKUjnR3syqujpLLNYYorTzImmaJEg2nMbnp+
        80XsPH3I9Ygzr03QC56B1D5K5JKh8Fj7
X-Google-Smtp-Source: AGHT+IEMWMjJj09uw4Nlu7T4ianRv1mF94E9duB9ORIltrxhzkgw2vuhjiSzHYsw5cFB71Lm1H+2io6r+y6B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c36:a8cf:912c:9142])
 (user=irogers job=sendgmr) by 2002:a81:4851:0:b0:5cb:f2cf:1572 with SMTP id
 v78-20020a814851000000b005cbf2cf1572mr22851ywa.1.1700620093802; Tue, 21 Nov
 2023 18:28:13 -0800 (PST)
Date:   Tue, 21 Nov 2023 18:28:05 -0800
Message-Id: <20231122022805.511839-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
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
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The necessary files for generating sysreg-defs.h need adding to the
perf tool MANIFEST that lists the files for packaging the perf tool
source code. Fix for the following:

```
$ make perf-tar-src-pkg
$ tar xvf perf-6.7.0-rc2.tar
$ cd perf-6.7.0-rc2
$ make -C tools/perf
...
  PERF_VERSION = 6.7.rc2.gc2d5304e6c64
make[3]: *** No rule to make target 'perf-6.7.0-rc2/arch/arm64/tools/gen-sysreg.awk', needed by 'perf-6.7.0-rc2/tools/arch/arm64/include/generated/asm/sysreg-defs.h'.  Stop.
make[2]: *** [Makefile.perf:456: arm64-sysreg-defs] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory 'perf-6.7.0-rc2/tools/perf'
...
```

Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
---
Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/MANIFEST | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 1da7f4b91b4f..dc42de1785ce 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,3 +1,5 @@
+arch/arm64/tools/gen-sysreg.awk
+arch/arm64/tools/sysreg
 tools/perf
 tools/arch
 tools/scripts
-- 
2.43.0.rc1.413.gea7ed67945-goog

