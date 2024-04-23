Return-Path: <linux-kernel+bounces-154407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8718ADBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC69B23149
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DD17BA8;
	Tue, 23 Apr 2024 01:53:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1418AED;
	Tue, 23 Apr 2024 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837224; cv=none; b=uiNAlQWq4job+RXFIFr87r9JouSXGOXVIIUj5kd6FCb5QMDnwOOslAyqe6G2ZHjHg0p7ux0wdfyTj/v2+Mwxt0vGwe02wlPO79XW+RXGP4vCQoLL6lbRNWBVS1Z9bgvTCE4JMm3yKmU9O6h8BxZnA0AWjz+oUpp1if1/xhgPtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837224; c=relaxed/simple;
	bh=ZfEsMl1qaCfp5Oza49PubsjnVa19yJNc6RtRjNl/eTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJl0wC3XvwYwbsydAVKQ6JpVZtLDavoCa2DywoB2PCWd2p5KOleCc5s53wN+SlLpuGkYB3aZncsJOpay6MQJGCpPK0VJ9wfX5maKY8S+SSgK3EG1D4FJbH6wCAnXKa/3mDGee4vYN8ABUWjKdZoV2N3Jru+Snb6WXZ4mYElaqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VNlT907c8zNtRB;
	Tue, 23 Apr 2024 09:51:09 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id E076318007F;
	Tue, 23 Apr 2024 09:53:38 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 09:53:37 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH v2 1/2] perf trace beauty: Always show param if show_zero is set
Date: Tue, 23 Apr 2024 09:53:29 +0800
Message-ID: <20240423015330.2206892-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423015330.2206892-1-changbin.du@huawei.com>
References: <20240423015330.2206892-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100011.china.huawei.com (7.221.188.204)

For some parameters, it is best to also display them when they are 0,
e.g. flags.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e5fef39c34bf..a8407eee58a3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2099,9 +2099,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			    !trace->show_zeros &&
 			    !(sc->arg_fmt &&
 			      (sc->arg_fmt[arg.idx].show_zero ||
-			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
-			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
-			      sc->arg_fmt[arg.idx].parm))
+			        ((sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
+			          sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
+			         sc->arg_fmt[arg.idx].parm))))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2803,8 +2803,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		 */
 		if (val == 0 &&
 		    !trace->show_zeros &&
-		    !((arg->show_zero ||
-		       arg->scnprintf == SCA_STRARRAY ||
+		    !arg->show_zero &&
+		    !((arg->scnprintf == SCA_STRARRAY ||
 		       arg->scnprintf == SCA_STRARRAYS) &&
 		      arg->parm))
 			continue;
-- 
2.34.1


