Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E27A0FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjINVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjINVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B616270F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:20:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e5e2e608so19019627b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726406; x=1695331206; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEBLCnDyHWS5IuPY851bB1uYjpvWDCqujKcJXiny/1I=;
        b=bzu+DbleT9wrOxJdJLp2RsnQvzhNTflsREXKrwLaHgs/Z2cJe4Rhy8WE9eGIXgSjSS
         iLsHeNuNq6H5xL/L2yLTiLGIJVD+jNFVRbzPJ374oInXRktPUrT9AO0lVgpdr+RV+xqE
         iEHJil3xwUhvn8+SJP+U5D34p9DUc0nkj506Y7YAfKSiKXqN6EQntS/THNBTHfh35XT7
         dIRD7eYEvNNyk77GrE5KPWjl3bXBaKcinepszOcu9KZeGYFKktzsb1x070gS02XZ/2yn
         6plBlb2i+KZpHgePtRH4PuVwEu6Nnt3kxhU609zKkvM/RgqlJwklqbsSSzVP+LLq0I69
         IEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726406; x=1695331206;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEBLCnDyHWS5IuPY851bB1uYjpvWDCqujKcJXiny/1I=;
        b=davo5/K6m0MTJxeI4Ndnwr5JRWSWKar/9FuurQuU+9xTdij96DWmRuiUCUi+rflt1N
         cRjPVeW6Zbw6IK5CJxYCo4cbHVvo+x39khkuuDpsUFy8GcANYN8HUPKtpp6mXe6iwo7B
         7H0aH5JHDLsh8rUlSdfvS1CA4i5fH5Kc4FWnLdfWSZIa1kymQtTYEPsVog1nb/KhXxjX
         g0oxfyrKkivCYn4mdK+K5h6lk0U75upMEDLjvKnzJoxl+M/5X9fm/aNLiHdUp2YRHLT3
         ds+yO2YmXr2RtwTuCKJeA4I+ZAJhk/gZhp5sHUer7CpKCtZd/F3cBRRr2NaFPaN3uS0i
         2Wpg==
X-Gm-Message-State: AOJu0YxwVZnwgKZyfSJ9y8ootBIkyrUXyKQj4Rhosk9PNYo/TAY4GBm3
        exGJaa42Mgp5QGGhTOnfyIW454cIuEQc
X-Google-Smtp-Source: AGHT+IFjNitaNwEgv3EEZ6iXNRaR95WvUU1GpXUYm1fAho7ynBUmSGSSBv8y18SlBKTVkWFYTJLjScNmdKn2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a5b:bc6:0:b0:d7e:a025:2672 with SMTP id
 c6-20020a5b0bc6000000b00d7ea0252672mr153772ybr.9.1694726405869; Thu, 14 Sep
 2023 14:20:05 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:19:47 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-5-irogers@google.com>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 4/5] perf test: Ensure EXTRA_TESTS is covered in build test
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
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to run variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a3a0f2a8bba0..d9945ed25bc5 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -138,6 +138,7 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
+run += make_extra_tests
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_no_libperl
-- 
2.42.0.459.ge4e396fd5e-goog

