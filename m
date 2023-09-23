Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3330D7ABDE7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjIWFgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIWFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:35:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1711A5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5924b2aac52so52331107b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447348; x=1696052148; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TUsgHG34tvRYixG1937P5Fi9+1duOaYRJoYEfUpa7o=;
        b=ac7U+/zovsVy7j2SNYIovLA3UTVgWwKkggpmvZy5N/ZOenXtldGk0iq5BsUEhfUvJh
         +QrxL21ZnLKxKmFLPi8WbF0mNVlKeOAVdbTybYw9jWt8IEakEV8CbXhtzt88E3WmZexb
         Z1L5hY210/5+lW2ZJHO9/Rd97HqpGf4XdAaXVrXMJU1HAxjwI6rwjh0pB49Y2APrsbjE
         DdNpJ95UeYLHgQEnTpK8frdOaIMZ8BqNfjq69W7adGekJUzDIJiZOFwF20gp5OyovTxU
         3YiItascMr1zE6XJqAdItnyiSJKWtZdM/ngBLPQZXKvLEahBcZH7FlEAH/2jgH50LK+j
         DmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447348; x=1696052148;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TUsgHG34tvRYixG1937P5Fi9+1duOaYRJoYEfUpa7o=;
        b=CF6deMNg6CmjTCGlGxPuNUsY+H+WZaDkNHk/8w7jL0WQahmIQ5OB3PI5G2Cu9YmhWv
         efyvhwTeNkoHxftQcfq3ainIG6L4jxIRCRdxGuRNYrDDYIbAm0UYtYDtP6HGJKwMx2Gy
         sLs96D4Xi/ouREKyjKYH8uos46afLFQxuLDrgMjnjroBFlQToasuTuxeGFSCrCVMEq7A
         FAUaHbBlGC5mPa02tUdvcXvOQE5Jnoy64iA9F1kDTpCrDURb6OPYi/wFuFZiNMfBwzzQ
         l+KrJR2dEwLW7Yxg8gg+646T3IZunHDm87kkXXKPiZRQHomtUdHUY1rRQX3wANlIL1rJ
         X+7g==
X-Gm-Message-State: AOJu0YzOmXDYcXGf4qnnDs6IOlZ73TZyjfyJb2qq6CbeVu+VgQXZwXhW
        KhI89GOzNO09IE910Zzi0fzUoFdPImSM
X-Google-Smtp-Source: AGHT+IEp4kbeLYXnxxqvZKp5O2vhys9x017pPzfHBmcwh+n5Yk8hZwya6+TOe1kFu1OjvjZAFx6MM0x3TpT1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:a8c:b0:d80:6110:835e with SMTP id
 cd12-20020a0569020a8c00b00d806110835emr12073ybb.3.1695447348106; Fri, 22 Sep
 2023 22:35:48 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:02 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-6-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 05/18] perf bench uprobe: Fix potential use of memory after free
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by clang-tidy:
```
bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                bench_uprobe_bpf__destroy(skel);
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 914c0817fe8a..5c71fdc419dd 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 	return err;
 cleanup:
 	bench_uprobe_bpf__destroy(skel);
+	skel = NULL;
 	return err;
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

