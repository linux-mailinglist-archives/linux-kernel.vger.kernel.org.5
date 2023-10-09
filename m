Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2B7BE9D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378203AbjJISkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378287AbjJISjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E5128
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a23fed55d7so77427437b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876784; x=1697481584; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GouG30KZVQtjqm6aov/swqA2g+y6OD5o5DKI6J9/hJA=;
        b=hdiUtupSykpW0XElbBBe/4kSZCj8u8m+VgHsIC9uBIpw2OeCQntgd2Or4zBdEbuTgf
         o8Fl8dvqTdKCPzb9QQ96OYyO2jocXYnCk7YsfGy8OWlPlSvLYmUYK7xngvymGis72dz6
         6LRwWnfhjVkVcmisRxN8zyXC2n1o0GxOilWeOHGjM3s8STxdCs7zVv0B0q7vfWrX66Pd
         BRPIVRof0u2JM8YFLWlrPnXtKmI+k0r1Boai3dUA/VLl7sqiApH+sYQYeqTYFBH98LUy
         QSVrUuknZsdVaXQr1MgaowmkngG6z61yOUBTPU4j9wB9/3mw6Zg7DTl5AGhsgYFlyOEx
         Pdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876784; x=1697481584;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GouG30KZVQtjqm6aov/swqA2g+y6OD5o5DKI6J9/hJA=;
        b=XbBdDWZinalTdZvIzx+KmqGTYuwhesYxrNDYmxLLqqNblOpxZ/njFvzDOBUqrtYV+L
         HsvcZPTAim2YjC+H6HYxb6Kn3E88woT/VWMueWzYieuv3PmLT91pNB9y3Erz0AYnKAvf
         RGP0BmD3rdRHdA2dPxux1IEZg3puybgpDQWTMhB8HdJQtdY02ojpEXzl0GRjP6/kQ61R
         G3fljxw74/fzxboPV610ke2/zvVvNz/aoOmklNVM5XpNb2+mv94eFVtASrHBJDrl0F2q
         iOQArFuB/c4AO7STFiDki2Hw7kPnead+ix7rn92XHZ4lF3Nm8iNDNIRdc3xB+YUpZDZS
         yHKw==
X-Gm-Message-State: AOJu0YyqkUffi0Lpjoqel2nDLwmi7jmVtnjgpAYMkmx1nG2dvCcTTxMi
        B6S9tXecyZu9w9jTGC9JyE68onBExV/h
X-Google-Smtp-Source: AGHT+IFoEQ7Dzv18PcmdjnpaSDsoWF/VAum2oAmj8wWzPzLIX73XPP1Ukf1ru5WFK6DwCtdvNWmpgT87L/bK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:d12:0:b0:d9a:3bee:255c with SMTP id
 18-20020a250d12000000b00d9a3bee255cmr25038ybn.7.1696876784641; Mon, 09 Oct
 2023 11:39:44 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:09 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-9-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 07/18] perf jitdump: Avoid memory leak
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

jit_repipe_unwinding_info is called in a loop by jit_process_dump,
avoid leaking unwinding_data by free-ing before overwriting. Error
detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 6b2b96c16ccd..1f657ef8975f 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -675,6 +675,7 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	jd->eh_frame_hdr_size = jr->unwinding.eh_frame_hdr_size;
 	jd->unwinding_size = jr->unwinding.unwinding_size;
 	jd->unwinding_mapped_size = jr->unwinding.mapped_size;
+	free(jd->unwinding_data);
 	jd->unwinding_data = unwinding_data;
 
 	return 0;
-- 
2.42.0.609.gbb76f46606-goog

