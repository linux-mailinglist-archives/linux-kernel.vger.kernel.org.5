Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8288176004F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGXUNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGXUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:13:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4AE10D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:12:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d0d27cd9db9so3033604276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229578; x=1690834378;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpe672BMcYgw1/Tq0sSVEvWbR/AI8Dk2IlobtDn5kyw=;
        b=2M2G+MvDUvaC4v3ryP+ApSPqOaSP4AH5XVMKamZ8urbsjFkVLNInRrp2LTZ/GqUZim
         qN+Jv3Tt2AdT+frefTxmqnDGCW+wiZlucBQpvp7lKsJF/MEHEZSgNYS8ZzT80rswNt2f
         ZUdMU4hEFhqNlBCBWiq69krhqG2Ke7uhcA9GQxgcQyk8GWmhFMbhhyfK4ojYwJDtdno+
         GCY20xkBVTXG3/EHvQ4sI2oVmRKUGmCgihTYSmi6ie8nP85rl7+SMKT7+z5QlAyTmh2B
         kXqutf119zg8ph1niL6MYGmn1vDpOeWPobVxKNmAbtAvQ4YHSswk/InZE2XTOtMsuUe2
         2kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229578; x=1690834378;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cpe672BMcYgw1/Tq0sSVEvWbR/AI8Dk2IlobtDn5kyw=;
        b=B97rVlthv4z5L1QxvyNiE9pX7qiWm9csO9RuKY+Ea7aDb4vfLhV/geevMFEvOOeAp4
         HpMR25ndJajrjYqgJ60+JgpqkxgIAhrbXZrJ/6X6saw7/vorgGIkLnssHbA7nhmGQ784
         Cb8Z8pDNdw74P8mfrrQ4hifRBdHlqqV/FaXqiTD++QTaDH6CMWicwxx54pM5ythdgD+o
         OpfS9k0YlgK5PRhW1kgrJ/guQUob0btYPMw7nAfwj1Kd3WTw6AjvfYnB0buD533t+ocp
         LZ7JYCdRZWffTOejb//PmvnLrYwU+2gkUImSCHoxzikVNGdjqPn0rr257R3kj3+Vg5L9
         Ov3g==
X-Gm-Message-State: ABy/qLbAENMHgRGpc7wlMRg1656Ba3gQqzMQ2MBDZF/35Xs7+/rnlc3P
        sf0qDTviZ7DGwlfjULvDz4F4khv2Fwm9
X-Google-Smtp-Source: APBJJlF+r3JvE4POU8/iw3zmTMqwkKUWM9A4TplQkBMkPp+JYJG+ZBQQK2pKifSkc8U/9qvm8anWelibR1RQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a25:ac1f:0:b0:d04:6d5e:4ded with SMTP id
 w31-20020a25ac1f000000b00d046d5e4dedmr1994ybi.6.1690229578123; Mon, 24 Jul
 2023 13:12:58 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:12:45 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-3-irogers@google.com>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 2/4] perf parse-events: Avoid use uninitialized warning
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With GCC LTO a potential use uninitialized is spotted:
```
In function =E2=80=98parse_events_config_bpf=E2=80=99,
    inlined from =E2=80=98parse_events_load_bpf=E2=80=99 at util/parse-even=
ts.c:874:8:
util/parse-events.c:792:37: error: =E2=80=98error_pos=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
  792 |                                 idx =3D term->err_term + error_pos;
      |                                     ^
util/parse-events.c: In function =E2=80=98parse_events_load_bpf=E2=80=99:
util/parse-events.c:765:13: note: =E2=80=98error_pos=E2=80=99 was declared =
here
  765 |         int error_pos;
      |             ^
```
So initialize at declaration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index acde097e327c..da29061ecf49 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -762,7 +762,7 @@ parse_events_config_bpf(struct parse_events_state *pars=
e_state,
 			struct list_head *head_config)
 {
 	struct parse_events_term *term;
-	int error_pos;
+	int error_pos =3D 0;
=20
 	if (!head_config || list_empty(head_config))
 		return 0;
--=20
2.41.0.487.g6d72f3e995-goog

