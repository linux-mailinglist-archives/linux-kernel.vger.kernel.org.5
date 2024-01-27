Return-Path: <linux-kernel+bounces-41031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C983EA73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F3D1C23910
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4B2BE6D;
	Sat, 27 Jan 2024 03:02:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC76BA2B;
	Sat, 27 Jan 2024 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706324563; cv=none; b=I3TLSvAwsaIIAO8jhdATWFUhUmKD+Z7IL6vHGRjk4tJjqm5cAKI89n1XJ3P/Q0SgybYSG42gKQvdzoxaa0uIYnImp5cjI0cQOeghPMhTU6XzoY9x6Ey+YL0Sujp4aDlv5JIWpmn1zPVjaTLWji9y+9nSmYh5t9bMo9nhWp+YBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706324563; c=relaxed/simple;
	bh=cxcqoOkkMX0SfjL+gJhhX+vXkdzYwwz4tm4/8tFtwwQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WpGa/n3M1poxI+BRz6o5LJzlhhKcMt52Iooq76JU9yQr7G14eWkmlt23V7KfyzTjjqeguxjQGRyEuljI5cZjwLhdzLyaTucxczA94GG/a4CF0xstyj4iVWZLRYPkZnyyZ6YUa+rUdcXGTjCphFRJX29ufTfgaryDWu5gzqKG6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TMK7y5bX2zvVNk;
	Sat, 27 Jan 2024 11:01:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id DA5F11404FC;
	Sat, 27 Jan 2024 11:02:37 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 11:02:37 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sat, 27 Jan 2024 02:57:56 +0000
Message-ID: <20240127025756.4041808-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

data->id has been initialized at line 2362, remove duplicate initialization.

Fixes: 3ad31d8a0df2 ("perf evsel: Centralize perf_sample initialization")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/evsel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4d14f14f2506..a0f36a6b8a2d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2363,7 +2363,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
-- 
2.34.1


