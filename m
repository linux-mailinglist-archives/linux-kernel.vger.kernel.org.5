Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B97766095
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjG1ANE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjG1AM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:12:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306C2139
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:12:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57059f90cc5so17012367b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503176; x=1691107976;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6neUT/Z5ZxqZSvjTzsd3t4vT8zLu+ilqjGFbF/BwHo=;
        b=p3UY5OrtqjoAHr4YStHKi65rVDwgAEV7PTWNIAzOHMRRHlj/Q7SO5SS/iWoKuNGKNQ
         q3KH8pM5awvIVnWOT63BFHtZwwa9Eg1ijQC251g+h0PH1+pOncYTEvnlR8HJPVc1e9Zw
         zy2Bs+axgBATCD+3uHBG/x3UhoysgCIiCEISgdeClzUhp3C4K/PSNQXAIfZ/egs9XtIc
         LNUaKQbzbgSGfpDnqiWt7O2TA6OSyg3VFwMTP/o3zYgJ1HL654KUYJIiINd3H+rL9i+4
         quOk3i/9iHtGRcOE3yKsB9jhMKECdvcp+GKr49ZFChLE+XmKDMnN3oxeiRt5QV5mIeUn
         dLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503176; x=1691107976;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6neUT/Z5ZxqZSvjTzsd3t4vT8zLu+ilqjGFbF/BwHo=;
        b=W/gis6keWNGhmwk0GBmsye5x0b0sDz2tqkNUxKHR9SYj0+EYVUBSRTLTXEtGV2EssP
         dB3lznVVUkL5Sxl8JdEOImf9nqUULPWy1aB5vcSBcSV2LQrIN0Ca2Zui4Z6G/Qp1+8Dg
         2TF6a150uvVtyNngR3FHpS6cJwN1Bp5DUPVM0kePmM95XQ6tlXnrDsNWbUT3qWHwhGcI
         jgSJT/ODfskNu7iFMF1whtJpjvPj94ypdxBgiD/FEW0zX9qoG/Ceo9yXDtdqBT8kyvzf
         F1fpWY8qTBKrWJFktGSwtZhePfN7E66du+EsL2f7+/9GRRIeLXyEA1ILErBmMiVSxQB9
         Ej6w==
X-Gm-Message-State: ABy/qLYg9uB5OHga5LhcxTSOnj311x1KoKsdZUtTWbvJwwhqFudhRglM
        WvfGloE/D385zVOiHkfdaQClV90xE2mP
X-Google-Smtp-Source: APBJJlEt4iXxJP8WryqVeJzhMdGPpRqxcb6Ce1vKD99ePr2ibeCxFflRmitKYAp0ZponEC0d5cc+brXqHo0W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a05:690c:72b:b0:57a:118a:f31 with SMTP id
 bt11-20020a05690c072b00b0057a118a0f31mr1109ywb.7.1690503176098; Thu, 27 Jul
 2023 17:12:56 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:12:10 -0700
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
Message-Id: <20230728001212.457900-2-irogers@google.com>
Mime-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/3] perf parse-event: Avoid BPF test segv
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loc is passed as NULL in tools/perf/tests/bpf.c do_test, meaning
errors trigger a segv when trying to access. Add the missing NULL
check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 926d3ac97324..02647313c918 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -758,7 +758,7 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 
 	return 0;
 errout:
-	parse_events_error__handle(parse_state->error, param.loc->first_column,
+	parse_events_error__handle(parse_state->error, param.loc ? param.loc->first_column : 0,
 				strdup(errbuf), strdup("(add -v to see detail)"));
 	return err;
 }
-- 
2.41.0.487.g6d72f3e995-goog

