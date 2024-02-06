Return-Path: <linux-kernel+bounces-54508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818984B015
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1783028173C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED212C803;
	Tue,  6 Feb 2024 08:37:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCE12D17F;
	Tue,  6 Feb 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208656; cv=none; b=dP9hAw2f+DJy2RK6WhSXaeNS14KPcPtd5eObLMa2BYagY7GJjh8a0NricBUm8X2/n7XlDwqINJbgC3cCLYjbMx80VEvdalXCH8ojKItFfyTSAFBgVLtVqOpQCenc2EQ2KGdy3CVw+Ct54/s6cv/M74PQq+GGfQ/bL905OrP6L8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208656; c=relaxed/simple;
	bh=KD6XdYRpKTdS6+uyeil6KtGFbsdwckMxsTa/vEY6iDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtT2RM6JlcoD2jpQPrGpX+V+ifIspRmw6d4dFUR32KmUA9kkIOeGXaUi7SGqTlovakKXqHLx60Z3K8Jz/R0GA63IIQuDtpAArMSGcesMVMyKF4rr6B9eO0Bi5X+/1w5HeAB2Ahv4RbkfSF459LGSnbX8Evua0Zn2R/4fKZlw21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TTc5y6WZKzsWk2;
	Tue,  6 Feb 2024 16:36:06 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id ADF9018006C;
	Tue,  6 Feb 2024 16:37:26 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 16:37:26 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH v2 2/5] perf sched: Fix memory leak in perf_sched__map()
Date: Tue, 6 Feb 2024 08:32:25 +0000
Message-ID: <20240206083228.172607-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206083228.172607-1-yangjihong1@huawei.com>
References: <20240206083228.172607-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)

perf_sched__map() needs to free memory of map_cpus, color_pids and
color_cpus in normal path and rollback allocated memory in error path.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-sched.c | 41 ++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 08dec557e6be..1513e87ce4f2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3208,8 +3208,6 @@ static int perf_sched__lat(struct perf_sched *sched)
 
 static int setup_map_cpus(struct perf_sched *sched)
 {
-	struct perf_cpu_map *map;
-
 	sched->max_cpu.cpu  = sysconf(_SC_NPROCESSORS_CONF);
 
 	if (sched->map.comp) {
@@ -3218,16 +3216,15 @@ static int setup_map_cpus(struct perf_sched *sched)
 			return -1;
 	}
 
-	if (!sched->map.cpus_str)
-		return 0;
-
-	map = perf_cpu_map__new(sched->map.cpus_str);
-	if (!map) {
-		pr_err("failed to get cpus map from %s\n", sched->map.cpus_str);
-		return -1;
+	if (sched->map.cpus_str) {
+		sched->map.cpus = perf_cpu_map__new(sched->map.cpus_str);
+		if (!sched->map.cpus) {
+			pr_err("failed to get cpus map from %s\n", sched->map.cpus_str);
+			zfree(&sched->map.comp_cpus);
+			return -1;
+		}
 	}
 
-	sched->map.cpus = map;
 	return 0;
 }
 
@@ -3267,20 +3264,34 @@ static int setup_color_cpus(struct perf_sched *sched)
 
 static int perf_sched__map(struct perf_sched *sched)
 {
+	int rc = -1;
+
 	if (setup_map_cpus(sched))
-		return -1;
+		return rc;
 
 	if (setup_color_pids(sched))
-		return -1;
+		goto out_put_map_cpus;
 
 	if (setup_color_cpus(sched))
-		return -1;
+		goto out_put_color_pids;
 
 	setup_pager();
 	if (perf_sched__read_events(sched))
-		return -1;
+		goto out_put_color_cpus;
+
+	rc = 0;
 	print_bad_events(sched);
-	return 0;
+
+out_put_color_cpus:
+	perf_cpu_map__put(sched->map.color_cpus);
+
+out_put_color_pids:
+	perf_thread_map__put(sched->map.color_pids);
+
+out_put_map_cpus:
+	zfree(&sched->map.comp_cpus);
+	perf_cpu_map__put(sched->map.cpus);
+	return rc;
 }
 
 static int perf_sched__replay(struct perf_sched *sched)
-- 
2.34.1


