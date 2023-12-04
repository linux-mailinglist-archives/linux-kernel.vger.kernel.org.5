Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E9803CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjLDSXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjLDSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:23:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45414107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:23:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db3ef4c7094so4420408276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701714215; x=1702319015; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZ0pxQHPPtXifBYnQK2oqRhP2CZVwJXTHj6rC9GaE3c=;
        b=P9S4QcPW5Eh/3vBzx4A6vHvsIbdvrm7Hvr0V0y80HGL8IYg62FJv6KsMWsMFdUaWMO
         N9qhefubyi1bAbmDVqjYEFrorVqM6RHQCOZNgOG+9i7ZZD4rMWtt+EAikFY7TcK97jNy
         epM4/byRmFSZyv8abKGyFOSyomlXjYA9AasUlktW06JTychjoMLxbnhTJWLFkxR3HEiI
         RCxo5XyDefB4n24h4kbjhVVwmuebJhCQl/80WvulztIoHDjVA6P5nvQJLHWzkCJPtHsa
         tbACaKlXYz6/cCHdQupSqlt0662wrsF7IV0nNneTIdROvdgH2Mf8EglzBeXAAtpiivyO
         AiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714215; x=1702319015;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ0pxQHPPtXifBYnQK2oqRhP2CZVwJXTHj6rC9GaE3c=;
        b=SGm2OLiprvWbTXkT7DOjqlVeMcnLaRsX8q07EuSSGNgXwLtiT89f1sD5etHnXhhP2b
         tOPJKqOTWiRIFuLvqMnwOykH5RnuIxBiVhbYPt54xhTenwUo96lz2rtI1chAjjVglNJG
         LtJHBToPYRFlxuSY2sMAM88BpJuMtYrAE4qUg5H/PPfdNyr67a/Ktc9MOqnwkigNDC1H
         F41Wd5Rub8U3xJBohdt5btW/n1yWfrIGS6AE0QV8RxFQAzWg/0OHxqOaD9DmnsDCt1pr
         XXvo66EW4q7X8AMDCHuN1F/lQwoMeOb0isC2epTnQGuTiUZO96r0A0af9gZAPKB32Nb7
         /yUA==
X-Gm-Message-State: AOJu0YwYeKD6icmluLJ2Vb7FHdqRparwX+Q4X56vjhg4tfLyUNgvP9I0
        9LR+LG5RbtWYMBZ2mNVjWR6cVUNyAXdj
X-Google-Smtp-Source: AGHT+IEi0XJiqlbzPFe4i2AZZ6mCBKtqb89HyDPZeG0sLxj598uJOhxVo9IAsT589yyTX39eoBGSOL+OWZ5d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b241:d804:967e:c827])
 (user=irogers job=sendgmr) by 2002:a25:cace:0:b0:db5:4692:3aae with SMTP id
 a197-20020a25cace000000b00db546923aaemr331621ybg.4.1701714215509; Mon, 04 Dec
 2023 10:23:35 -0800 (PST)
Date:   Mon,  4 Dec 2023 10:23:29 -0800
Message-Id: <20231204182330.654255-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup isn't set
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric is default by having "Default" within its groups. The default
metricgroup name needn't be set and this can result in segv in
default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
that assume it has a value when there is a Default metric group. To
avoid the segv initialize the value to "".

Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0484736d9fe4..ca3e0404f187 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -225,7 +225,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 
 	m->pmu = pm->pmu ?: "cpu";
 	m->metric_name = pm->metric_name;
-	m->default_metricgroup_name = pm->default_metricgroup_name;
+	m->default_metricgroup_name = pm->default_metricgroup_name ?: "";
 	m->modifier = NULL;
 	if (modifier) {
 		m->modifier = strdup(modifier);
-- 
2.43.0.rc2.451.g8631bc7472-goog

