Return-Path: <linux-kernel+bounces-150143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51528A9AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911B128608C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18E15FA96;
	Thu, 18 Apr 2024 13:13:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEB2C68C;
	Thu, 18 Apr 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446005; cv=none; b=XIiLUDgHLZ6ll11HSWapdY6EgL9hFb+LJ9cpm5b0EQLT5gg0AeKmsk7nRcIAjR/OFF8iDUjJw2LzR1lYfrskWSfk0Sxikam9XpgHIZYLjAwUDriU7S7Y4JNHXLxE8hlxOInYKxM5zzqN+BDP2Lo3p4V12odDFioDAPSeSmBLxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446005; c=relaxed/simple;
	bh=vI/bactSSihewyPgC9byNk05aRJzbjeiW+DD9zyu6y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNMzXWUyA0Cg5jZxlmkcq64d0Huog9K3zKFf6S8az71OCY5dve2ZWXjCJvutS9sTgj5SZRyMVc30xBAAXYNxW96guaALX8zJZduSTL7PX33fci5iFgJAIQsLGYhcWArsP4VDnzz1mS/k0psL178RgB0B8CrICf7j2MuVO1Q9AtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKynl6GkxzNsWY;
	Thu, 18 Apr 2024 21:10:51 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id C1E2518006B;
	Thu, 18 Apr 2024 21:13:16 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 21:13:15 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH 2/4] perf trace beauty: Beautify newfstatat flags
Date: Thu, 18 Apr 2024 21:13:02 +0800
Message-ID: <20240418131304.3188385-3-changbin.du@huawei.com>
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

Beautify the flags argument of newfstatat() using the same scnprintf
of statx().

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c      | 3 ++-
 tools/perf/trace/beauty/statx.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 90eaff8c0f6e..19e81a467d6a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1050,7 +1050,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "name_to_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "newfstatat",
-	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ },
+		   [3] = { .scnprintf = SCA_STATX_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open",
 	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open_by_handle_at",
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index c61f2be53bda..dd83a2a95d89 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -30,6 +30,7 @@ size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_
 	P_FLAG(SYMLINK_FOLLOW);
 	P_FLAG(NO_AUTOMOUNT);
 	P_FLAG(EMPTY_PATH);
+	P_FLAG(STATX_SYNC_AS_STAT);
 	P_FLAG(STATX_FORCE_SYNC);
 	P_FLAG(STATX_DONT_SYNC);
 
-- 
2.34.1


