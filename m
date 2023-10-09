Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1027BE9E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378367AbjJISkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378356AbjJISkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:40:02 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85111B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55afcc54d55so4380996a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876794; x=1697481594; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=nXL+qmAYa1mUdOquFhy+XA/PWm93Ug1IW4cRgHg+EqS00GRLOom2nBJGffgxekuDXV
         wbrE1PmxDKYLYPPiT8kuXB2rEVLLXt/DZxHCItIPQ4PNJOTKSpTEDUswFBtWZma1i0BY
         7KYRrcsDRVikprlCDbpKoctnizhnSStoR7IoKOYjNZAjz6iKIN3z82prctEov4KWfVtO
         HADyYWdsJctr2SoudMqgxo9DL9CrlN97HTGEKFUfyuLjB5nCovyZ6PznLrZYcc61x+g0
         5L9e+C2vBdTcD44dUiDnoTG7dryyPmQ2gXGapHoSTv5mqU4L8r0GuakCTvSjh/h0conU
         4rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876794; x=1697481594;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=k90EyTIWk+ndupsDaSW6m/pBsckEGGqd3w3yBBqrH1wULCcPeEbOL4EF1okJvPKjZi
         CW+uUeZFZ5v7KD2j/R+eakKxkXjXA1cw/Basm79dOFLI5MHoU86d0a+ty/yxNL1Nn8TO
         hfD5BfGRPKtLe8R2BtGN8ub1QjUpiNNSb+NSNQO3hK9hAumGq0PFxNnvuqG3ms5oKV8k
         PHgp1hMPfvn+Z2iWOOxifaKcwqDW+7FUJX4m4y4CS7dX+WHUmaWeAv5/Iwt/Yfp5m9yA
         RKEi5d8Ss/aobo2FBHiSG71hW6+apqoy85L/xDuU5MPZhBrJNczzXzLn0NNwie1AJvF9
         wTxw==
X-Gm-Message-State: AOJu0Yw297KTjMd7A7zLwvL1oLh0ZGqd2D3PgtWRh/O9vOR0SiEaL5gh
        0pJLZ/uuiJXFUn8CpYALPyHx+fYBRP4l
X-Google-Smtp-Source: AGHT+IGswY8IBRO4qisurfCsmW1G2owhcv59h934/6N9kUBhkSh8az8mizPfb84iHYV8EZ8p3euRKpw5IRrs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a17:90a:bc48:b0:277:d8:abd9 with SMTP id
 t8-20020a17090abc4800b0027700d8abd9mr318272pjv.0.1696876794049; Mon, 09 Oct
 2023 11:39:54 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:13 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-13-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 11/18] perf hists browser: Avoid potential NULL dereference
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
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On other code paths browser->he_selection is NULL checked, add a
missing case reported by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f02ee605bbce..f4812b226818 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3302,7 +3302,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 							&options[nr_options],
 							&bi->to.ms,
 							bi->to.al_addr);
-		} else {
+		} else if (browser->he_selection) {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-- 
2.42.0.609.gbb76f46606-goog

