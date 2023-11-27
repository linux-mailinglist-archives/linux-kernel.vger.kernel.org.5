Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470637FAD15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjK0WL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjK0WLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:11:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE126A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d032ab478fso22187397b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123019; x=1701727819; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ac/6qiU0CE391qQluGr8+N93c3qEfm8YU+gNySdqzik=;
        b=ErWAzoVPnxhfE/+Z0Z8PJqkWEZp4g33EG283ml20WLX1eLobk99N90+qC4bcNfDOUd
         oQFCk1EUMQdMP0UTxmdrA1tk9O8AgpjA+HT6NTC1fjZLxA85zBkGRKBHdp3QQ6vqQdF+
         LrzWutE9nG+88FZ2ReQLSrVpPy2DFXRfE7658E9fe8pUvIr8eThJZeofHy3bQptS/ArC
         SyEKWIZQ6Gc/xMWFn9fxoakiQKJCUTo+vhvAjfaeLalwGQRdhxObBWb7qOqcl36PWy95
         FIbJJMzXZIji71S2IwxUnUnwc1mkL12ZDaTYyTXriaNlo9Vf5Fq7c0lopW39j/PUrkBm
         veyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123019; x=1701727819;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac/6qiU0CE391qQluGr8+N93c3qEfm8YU+gNySdqzik=;
        b=bnEGfDjA48qeTHm6C9TgKwgSqhW3M3aCrsy4KLPPjaYMw5J69MV297PtphDwkOa6cu
         /vBevrTvoO2HMr2zaZOrKTNURGUmh1DECjuKro2OQE3/XTMMf+C9PznPdDN7APO5Fu5x
         fvSWROHK3HwJibQwg8SbXd7lp1imkc7DCNqpAOSI49nq/R7FanANXHpmwUIweEIX6FBk
         NTriiVRhjmZNoo3gGDemCkkIyd2THQ/4L2Q+l0knbMfg8DX1La+eTYKVqiLXTOoASTIb
         +fTgG+5LNc8O69yHIM/q38OxGpKaj+yglVlavnzDGEog/77Gdd8Ypvapw/ynFMxOCL6F
         /UaA==
X-Gm-Message-State: AOJu0YxPSAieSlPGLQVwjvpDbYHMWdwXW9oWI9SZ7Ymh16Qt7QH9BtwZ
        JkGaROYliaH6inZJu0cwTqVWRzg/PXkJ
X-Google-Smtp-Source: AGHT+IEXXAl6p+M+olmFxD/rf4AtM68xnqGl9h+GI6eQZ8wLewlBdH4r8z4932ePuvIrvHRyQG28FDDLVJ2W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:811:b0:5ca:f8cb:181d with SMTP id
 bx17-20020a05690c081100b005caf8cb181dmr425176ywb.3.1701123019001; Mon, 27 Nov
 2023 14:10:19 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:36 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-25-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 24/50] perf maps: Fix up overlaps during fixup_end
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
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maps are sometimes made overlapping, in particular kernel maps. If the
end of a map overlaps the start of the next, shorten the overlapping
map. This should remove potential non-determinism in maps__find, ie
finding maps by address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 01c15d0b300a..fba95a00ecdf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -700,7 +700,7 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
+		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
 			map__set_end(prev->map, map__start(curr->map));
 
 		prev = curr;
-- 
2.43.0.rc1.413.gea7ed67945-goog

