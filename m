Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871CA7ABDEE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjIWFgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjIWFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC7CE0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f2c7a4f24so34827397b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447359; x=1696052159; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCtwtK8xajC9XBojO6y6JASy5d+HVvOMNbjwUuJaLFE=;
        b=LuMU0brGoqbkQFRHLWzbeHkOnf3oP4GDDOl+7qXPmfKYVrlk40SXTvAm2tiyWpwMG6
         ucDNznBjD1+YC1tl0gUOp45nZ5ieMYQzr67TOZj5LsTc2ujuHnBQyEQQCPFJ4WekV3Pq
         JHImKHd4XVENfqcjl7a3EphJxFIv6idTtxzaPVxj1+D6Qn39ca5xLuIq+CaWfcDcLqFw
         F2d85dTEZ/0dM8E4R6Ue8ro02UZX/Wj873r8uEo7mf+DKMvy0rKjheX2hNgRBE8tj8Lm
         mJGkoXIepZDXXvgYxjOqWvDCOoU3lWiv7WIc7LUc/SVYBW+WKs1R2AxVSI2ZArEY4zoE
         xVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447359; x=1696052159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCtwtK8xajC9XBojO6y6JASy5d+HVvOMNbjwUuJaLFE=;
        b=f/0wvCCHaddZv4dpG4AnGnoCi8OE+Kfi0RqyRSTXrnNFiJJX7l+BLd2HHyzhRYy1x0
         jpd4LDIr+D3ZsH0qU4My7xWSonrZt7I66py0KztzBJbvUIGssRKsWK2PjPwSaHKMD6DE
         k0NszybLCCATx0pcWOKAobM1wLsYQzymIRePvdQ+xD+J3DWWdvoyo1450J+MkeNNWph5
         vZ9nE8jrzqPJxZnjrd7ZjF9XvYZ5O6kgVuFAV2G6vY4xzRTIkmg/ARmq8BMqoXTCIwSh
         OHlFxX1zT3HC89wUxMv8zLucKPmINJALzeARBrNn7q4FRfOVUzstU2BvA2RKxT+snUgJ
         CeWQ==
X-Gm-Message-State: AOJu0YwRXjsCQxt6IcCK/XxQ+BwbuBF7X/SblCcL3WZtF2aofOUVYopL
        rmJZcVZXEcOFkXixjjEIJImh2vyvvEhY
X-Google-Smtp-Source: AGHT+IFb+mlhJVRkd55x1iEq/qHM5aF05s6yk09PvbU0fJIXBSHtgAy824hVDau+Ns2A4L4kX9JpuxpfL/T9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:d251:0:b0:d62:7f3f:621d with SMTP id
 j78-20020a25d251000000b00d627f3f621dmr13487ybg.11.1695447359056; Fri, 22 Sep
 2023 22:35:59 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:07 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-11-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 10/18] perf dlfilter: Be defensive against potential NULL dereference
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

In the unlikely case of having a symbol without a mapping, avoid a
NULL dereference that clang-tidy warns about.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dlfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 1dbf27822ee2..5e54832137a9 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -52,8 +52,10 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		d_al->sym_end = sym->end;
 		if (al->addr < sym->end)
 			d_al->symoff = al->addr - sym->start;
-		else
+		else if (al->map)
 			d_al->symoff = al->addr - map__start(al->map) - sym->start;
+		else
+			d_al->symoff = 0;
 		d_al->sym_binding = sym->binding;
 	} else {
 		d_al->sym = NULL;
-- 
2.42.0.515.g380fc7ccd1-goog

