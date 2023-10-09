Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B127BE9DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378422AbjJISkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378347AbjJISjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA0E192
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0dd156e5so81021157b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876789; x=1697481589; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=SRdA35YGOoLAZL9O7PKWBNf2JQLBzTaG1UsHWDN0YNJOyeWnXFklTqJ8LfGovInDPq
         S1OCCbjXHolGeHnjnsHfSXHjwWsWYKFaev8MFgJoOMqVdc7w5Eeoxrxg7RYFhnvHkjSk
         4h2Qdn4hFlf38ZRwAxN6WIoUBZvxHGlnUMkD5TiJpTAbjDJinzlN+vp51u0Q8nom8aSy
         eGDGjaOQxExOs8pJrvIqbKaSc5GTt+PZtW9QWv3xdfAfsQywBsmHezeLcnZhmn8s8mSu
         CZyIYAWyiaGBDXGW+rjm+XBx5D6Vbf/Z5kCyVWWrjpYzQa0ZfhQQJmls6rbALsQGqB+x
         SaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876789; x=1697481589;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=MSn85qlKavJk/a9fEn/c+VIRDFiHrh/DxpN+N/qX8yK9bikTLoT2JYpTTr6oDGGoQk
         iB8ai+qAMOyY5R3Ymo7z9tKt3Av6zuRlU8FCyxnMyEDAJbAWGHcNOf/mNh4RyYx/VCTV
         DIhdQeCDS2B3UhGMQ2G+FHrKOUvTZXTJj0Fwp6fjtec68wFuWLA6QH7ME1r7vfjC8cGC
         YBKqGfa9IT6sK5nOx4EskmZM0NR9QL1/mMANi9F2EwtR01/pUo5+PSGueLUSurgPPjHF
         DkfSiQAhTJjsfsAbSAG85dYxVQyt2K1Gh7YZj/IP8QDlwHECJiJZzNH8ymKLpmDziJbu
         ejXA==
X-Gm-Message-State: AOJu0Ywowt6QQYjzSU0Km1/72si3TBcXitqrU6R6vHe+1+jiAyAjQcDO
        dsgWjTAXOeXyFvmy95JqP85F9L0p19T0
X-Google-Smtp-Source: AGHT+IEx3Hxc/LpzCERzTEobvjg4svKw6js0XFbWqMEIgj61DG4507hSvRf9frx3x/Ew/SETU4UYqOBaGS51
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:690c:70b:b0:565:9bee:22e0 with SMTP id
 bs11-20020a05690c070b00b005659bee22e0mr297980ywb.0.1696876789191; Mon, 09 Oct
 2023 11:39:49 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:11 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-11-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 09/18] perf dlfilter: Be defensive against potential NULL dereference
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

