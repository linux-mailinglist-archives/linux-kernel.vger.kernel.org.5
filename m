Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8F7D5E08
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjJXWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbjJXWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B210DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9c4ae201e0so251735276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186264; x=1698791064; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cG5+OY088Om6+iLiqKt06WFCMXUosiNbLSusAjLjbIM=;
        b=ZZqrKT+UjHHvy/H00VQVIZt3PiS/jfnqDnz7ouPps9VLW80Fv2MkQkEZp+0e3wLOvi
         aIC9Le/kVULcDKBJ0GuhTEYHFDpIpHkFYeU2Vivs0+agAus9cmVUypi2M6ZIE5lsnBwd
         F0x4UKY7hlNf8NIh4Hiky32niofP45ujmy8OV6r4DCzjX2xk21gGUPKeve6IZmY/i0/w
         MpxWzRL0gKARR1KGhg9O6ItbnHJWZ/Fd1AVL3ooyhebg2Fnjq1GzBJGN8uO/fVV+FRBT
         ef0MFik8vbgkT404AwvA9/VZ8dcmVWEn/uZN0ECmOGyWEFjzxotYS3SucyA82jueLp4D
         b7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186264; x=1698791064;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG5+OY088Om6+iLiqKt06WFCMXUosiNbLSusAjLjbIM=;
        b=d4WGfQrILMSEjNpPKavyT9Z51Sc1/isgzOdyugUqkEKw9C4Zt6LNROGEGoRohRiY6c
         pY+LzyjDtdjmQZABMPpjAHXcyUtQBQX1YvB/NZS7rWNsmT+WYwaeuaUIMeqERPwIWQJk
         euF4qgDjCHu/Jb5z46Q7q7rcDLKKnJaH+eeuVe/Si2UjbXdxOdX4QtjjfTnH7+5UPrUE
         GKbQGa66dSGd2qSo2Pb+tAy76nEmqN7KIOUeaeEN3VCJ11te8NuSurLzeb/ZceN1H1h1
         kMXputmf3bSKasKozuzrMdcu2ry6VzsVEupSxFmS9YHQtnOS/zW3XYBuqJeU1pnefLu3
         icpQ==
X-Gm-Message-State: AOJu0YxMN4ZeeLL1MDXvlvoIMHayYy9THt8Xd6zTc1xrIlgUMHXkz736
        QwBvP+aP90kzOzeb9KxIR8sp5vCasfnl
X-Google-Smtp-Source: AGHT+IFn//bqSDPEs2RC7FYYE8cGNXvKFT1zQAKQHXM0RMKa99x4nFnwh3d+RZhqnjrY7SobrnskwiRaU1e/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:34d1:0:b0:d9a:6360:485b with SMTP id
 b200-20020a2534d1000000b00d9a6360485bmr385686yba.2.1698186263960; Tue, 24 Oct
 2023 15:24:23 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:08 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-6-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 05/50] perf hist: Add missing puts to hist__account_cycles
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

Caught using reference count checking on perf top with
"--call-graph=lbr". After this no memory leaks were detected.

Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cde0078e6c90..0aa7e231172a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
-- 
2.42.0.758.gaed0368e0e-goog

