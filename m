Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF17BAF4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjJEXWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjJEXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:20:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92BD6B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f7d109926so21888607b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547360; x=1697152160; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=PpdONQIG+l/rnTq0ljQx59wae1i+ix+iFl/DO2P9TSNWJyIxXsdb3HnDxJvOF+w6xz
         RDd7k8qg/CnSYh3xwTjoVqQEmSEbUGPb6Mw1dJqYpN+9O4E+YR1AcxZ4UDoue5gQs62U
         Cex35U4yKYX18dSmKQmK4ml+Z4fohNc/7ib17IecGwKUHWKu6vpFwh0IPK8aHU60XcSO
         +2/jPTxPJ+H3arFgoLIvr3SJqWzuS74tJSa9uwkBmTl+YbgN6twjCy/mLP+M9dMGGqcb
         1zGanpr7tNww1SRO05E1EzUaI1BdXDhLegliVfVDi4Vo2GpnO5v//xlxR7T/zdWddjCl
         /F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547360; x=1697152160;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=nM6SQH+WNA3PTb7rzQ9GGsQauwwaZAM+7Zq9tPSQBu0zkPXnlm5dRJSMdgmrSWah1G
         fUmeRuzBTXhkF9x+SCKN5xXLCQu9YBRTjC4aohEC7YhCzcDUmvCVzvoT5Rh3V7wPI/Ko
         RauhG5GDusAtQCieh1clguzC84v53EHqHIL3U6vo8ssB8EeMuJQ3loos/jgdmNRqp/QO
         w+31WFaKM2Kp1blPaGEyaCEARFUnSTT0OMCz4VaT7yvjKP8KHk+fnaaUNGOaqN4u1IIK
         6mGFVYafRwdxQ/tAnu5gekerL6sXPSFD3+LVB67aoeIPWWcVLDvERuSHWFP2ntXy0U33
         bGYA==
X-Gm-Message-State: AOJu0YzWjBjMyX0j3tvI4HyhD0kxgX/pfTf/pCptq3WrvHWGEj5ImHGe
        JfRuN4mqJQ5JRVb+/7LqnhkHk+JtDrHZ
X-Google-Smtp-Source: AGHT+IFfAlyuHJuI2G/9KQCu0TQZva4KyspkcFBHCc0rPvHV/9ONdxVJXDxqSyZ675ZF86Wyxy9Zbxra+WAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP id
 b8-20020a81bd08000000b0059bc811a702mr118562ywi.6.1696547360615; Thu, 05 Oct
 2023 16:09:20 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:43 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-11-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 10/18] perf dlfilter: Be defensive against potential NULL dereference
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
2.42.0.609.gbb76f46606-goog

