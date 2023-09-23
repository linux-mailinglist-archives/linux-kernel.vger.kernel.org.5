Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9349F7ABDFE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIWFhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjIWFg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579CA1999
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c081a44afso54153727b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447373; x=1696052173; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUz0aBRZdXV/HoyCWN8uhHLmcq/r3toZQGl1fsyAqS4=;
        b=OkXbC3XLL2fncEKVJfpjTFy736KtharUkMy6ukL593J21+rL5OaMLbdMbdnnKTnyDn
         ogUHpB+aqf+M6lcW7BtzlFyyjLWUxHlOOHuc2s5ZGH+v+SYF/hqraalOEx40Ur8g0XTM
         XCsW2qdqSRQH7IUbQp+L3oz7vtlgtxPx5HNWLR8dotRkwVrT+++AR/JC/JDB854fR6uC
         yw3/OustjyAh3SJeGo/+8KR7i6o5YFmRllDrN8tQOQGROryy7nfEQ9k8V18JRHZe+99M
         qhGS9s6onDyFnq0shMQINInk2p2WN4V/2Lu0Unei2OJGkfeGMfz2TBBB8LTAPeyge9sr
         Da5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447373; x=1696052173;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUz0aBRZdXV/HoyCWN8uhHLmcq/r3toZQGl1fsyAqS4=;
        b=e22lf4Q6srpX3Oy5K7qlIlXNDHa23EzfQlX8fmPZJlswzfW4H90RIHBuSMdYZm86SF
         FMxAjV3CH1YE+5U5985WCGj1v8CCbMD6pvP19P2BJY2H3DZbqg0GjQ7OlvtY/CPKKtsS
         824VOXb1eQZvVN32sIOBZ7C4P7QSP7S69oHQ/jGTq9LzMQMlto2wU56tYb6Yg+5Zl1Yz
         JjzGvr79+fhjBNzWxyQ4IXQgxAL5r4Nf/GURojbsebeDCSDhkJ0N7aD8m5B87jJXMxOY
         sTofx4ONEGIptRlLIqFubLnF+yNDL0/UgvN1s82O+GE/UYa+5DT1F/TvFozlp8R8sBHL
         BvYA==
X-Gm-Message-State: AOJu0YzriH7Eew0pmMdXjC8S0ULqE/otPB52E8RUP9FRsl7SatRAxtt3
        T44sxFdEirKUEepmn41dYe9Cglz2/7H4
X-Google-Smtp-Source: AGHT+IGBnACIcG/dQO74ULFKTr6l4nsrfL6I5S655YMfy6NLsr0dzVgpJAVXl+mmfzsp/SPWCJX2H8Efcow9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:451d:0:b0:592:7a39:e4b4 with SMTP id
 s29-20020a81451d000000b005927a39e4b4mr18996ywa.6.1695447372993; Fri, 22 Sep
 2023 22:36:12 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:13 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-17-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 16/18] perf trace-event-info: Avoid passing NULL value to closedir
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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

If opendir failed then closedir was passed NULL which is
erroneous. Caught by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 319ccf09a435..c8755679281e 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -313,7 +313,8 @@ static int record_event_files(struct tracepoint_path *tps)
 	}
 	err = 0;
 out:
-	closedir(dir);
+	if (dir)
+		closedir(dir);
 	put_tracing_file(path);
 
 	return err;
-- 
2.42.0.515.g380fc7ccd1-goog

