Return-Path: <linux-kernel+bounces-150173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803A8A9B47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14161F23A32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A461635C4;
	Thu, 18 Apr 2024 13:29:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727E15D5AE;
	Thu, 18 Apr 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446945; cv=none; b=mNgaeMwlBo/fV19B3+9NRU7gX9Vy0ugAVZTYpf4+WZF+wIb3X5zxBPjhFj7iwZMASTAfX0BnHO2b1yxxyE9g7V3lhYL3n6CZHZ4M1yuGmECGCeDqjqgQFkPDfhmaPZYQNoF87uamEyk9fgkGEP4STwNWiH8wXEFoH8VJBOppQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446945; c=relaxed/simple;
	bh=u9rORQi/V386pgsRzfTDjDY7hWfcKdADQPxluxHnPP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKJYi06+kGZWUX/zDb8brx7y6DW11MGB4EUr5cFPjiPhDH5stJ6U/0Y6AyjScYI0BneJDJgJmgPR9xTVDRvqWwwYXRytbnU3iQdEPbMBrnAaTNkqFKnZDWo54ps3IO6xk8OxKEwGkTi5gnUtzKUS1jwcNTYHsSZEm29xbeN/Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKymk39JvzXljn;
	Thu, 18 Apr 2024 21:09:58 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id EAB9D18006D;
	Thu, 18 Apr 2024 21:13:18 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 21:13:17 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH 4/4] perf trace beauty: Always show mprotect prot even though PROT_NONE
Date: Thu, 18 Apr 2024 21:13:04 +0800
Message-ID: <20240418131304.3188385-5-changbin.du@huawei.com>
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

Do not omit the flags even though it is PROT_NONE.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 349550b02f79..7f936f1b5519 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1042,7 +1042,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 		   [4] = { .scnprintf = SCA_MOVE_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
+		   [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ }, }, },
 	{ .name	    = "mq_unlink",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
-- 
2.34.1


