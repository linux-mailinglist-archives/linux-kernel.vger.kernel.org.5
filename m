Return-Path: <linux-kernel+bounces-150171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED38A9B45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9DF286217
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099316078D;
	Thu, 18 Apr 2024 13:29:04 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2615FA9F;
	Thu, 18 Apr 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446943; cv=none; b=f46uYa+B2xQAOIYIko6xk8l5lizhpmDVKfZEcIJxkgSydx9vkKYEfcsY1FEvlXRTSs+Fx6QsL83ZEN11PrcafHhdWFT5kI2e4YvHV0JgSYo/WCBslvFywk1arVjK8OnDxzUf923n+lqsc5ssRe4j6h8O//K/UznLxPAJ3hg1wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446943; c=relaxed/simple;
	bh=C3BIxOYSx6Edn78b6t4WlyI2Ut5N1AqMlgcYCcsxom4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPB97QaFehb3Mpa25yRana94Fp4zjXPxcz2eaZsBAnL067+us8tnkH2RGXcViPif4NYeKRkXRk/sDJjJz6EDtPtsAyMjM+/NQSHxNNqZY4SqR2OOf2sAhOqdz9bL5r5OEznmPCuTl5VOuy5Wlye0e6tqjQjMFE8i5g7tAQYb08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKyqK5btzzJsf9;
	Thu, 18 Apr 2024 21:12:13 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id A23681800C3;
	Thu, 18 Apr 2024 21:13:15 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 21:13:14 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH 1/4] perf trace beauty: Fix statx flags printing
Date: Thu, 18 Apr 2024 21:13:01 +0800
Message-ID: <20240418131304.3188385-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418131304.3188385-1-changbin.du@huawei.com>
References: <20240418131304.3188385-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Missed a string specifier '%s' in format string.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/trace/beauty/statx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index dc5943a6352d..c61f2be53bda 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -21,7 +21,7 @@ size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_
 		return scnprintf(bf, size, "%s%s", show_prefix ? "AT_STATX_" : "", "SYNC_AS_STAT");
 #define	P_FLAG(n) \
 	if (flags & AT_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
 		flags &= ~AT_##n; \
 	}
 
-- 
2.34.1


