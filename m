Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78747BAF48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjJEXW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjJEXUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:20:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1111C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b59e1ac70so22587827b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547363; x=1697152163; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3F7gnNpkmZUAErgbCdtUAHzB9Tx2qchcvlKXuBK3uQ=;
        b=cC8v9htN85xK0I6vqU1MDGWwZO5vyo1LQVqQFGFr4Z+FZr1tmDW/e6Tb1cPWIx9YIJ
         O+noGGselEBgl6GbGJfwA3fmN6vBWbaomnl6Wgv1VUKsTToE0PpGC5bAdNscgO2oL5+T
         8NUOYpDwRtBf4O1SsfFoz9p9nvFKH8yMP1ygZUi0DQTVgyebgZi0EPr+ibCbTQmX4o6J
         ejZx6+0vJse+jGHM9C7eWv6gxqEfgKzMhOIU9z0zQ0hB05axy2yT6ebgw4pWq5W5vjgw
         phylQWFgbwAty2EPxnYocLPs2NLT7vaxi/VD82NlHQc7tAF90KqPss+aSZWp8OdmZAuI
         8GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547363; x=1697152163;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3F7gnNpkmZUAErgbCdtUAHzB9Tx2qchcvlKXuBK3uQ=;
        b=HRLKClRoS//f4lMVso6R7BQAe6NZ+tI2kTVcuMYBL6NoMM1C00JZEOHlPV7qZg3zNr
         zTFKU7ysuC0qg1rU4WsC1y9ayCP6g+RixVHybBz0hgAci/Un8XzJFbrzrEil2HBlcIL/
         Fhtx0rKfooxUkl2V8mDqPFswqzTECF7awrFgYTjLsvr6g4BYHn7Yblk9X9eV2IKMi5Au
         bv4XuYjnbIW92Ggp4d6Dwh5eSAuJyYB/g853Ijc2FhZT3qTNAfG86GjWQatxoKn+70Jw
         f+UtrYMM58Fk47v1y4eyma1DLEVvTPb2noNxwihLqXu5TAoFB+O58qbOTy7p/TrUFmEd
         i2tw==
X-Gm-Message-State: AOJu0YzNnZkPO4fOmcYywe7WYdrhdiv41zII7hzATAZxbGoewCKNgFBd
        Rdt1chNimInXAIQLTC0y4tRvV5zviQH1
X-Google-Smtp-Source: AGHT+IHoFU+z5aCBXXTlJuMvUJucciH7eGrZGAnChgvuI/WO2miJm/u/BOXK9wZuLbh4UH+ko6EzN43c6WUR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc9:b0:5a4:f657:5362 with SMTP id
 dg9-20020a05690c0fc900b005a4f6575362mr116930ywb.3.1696547363151; Thu, 05 Oct
 2023 16:09:23 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:44 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-12-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 11/18] perf hists browser: Reorder variables to reduce padding
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
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
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

Address clang-tidy warning:
```
tools/perf/ui/browsers/hists.c:2416:8: warning: Excessive padding in 'struct popup_action' (8 padding bytes, where 0 is optimal).
Optimal fields order:
time,
thread,
evsel,
fn,
ms,
socket,
rstype,
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 70db5a717905..f02ee605bbce 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2416,12 +2416,12 @@ static int switch_data_file(void)
 struct popup_action {
 	unsigned long		time;
 	struct thread 		*thread;
+	struct evsel	*evsel;
+	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol 	ms;
 	int			socket;
-	struct evsel	*evsel;
 	enum rstype		rstype;
 
-	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 };
 
 static int
-- 
2.42.0.609.gbb76f46606-goog

