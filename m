Return-Path: <linux-kernel+bounces-154408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8298ADBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9213EB23479
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D213AD8;
	Tue, 23 Apr 2024 01:53:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292F1947D;
	Tue, 23 Apr 2024 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837230; cv=none; b=X4/iB4y45/HzU/NeG4qvkLnKyt+47GO9PH8Jc37WTE9j0klQbGh/Eq3D3epY2vTu6xjkXLYKfKafdK/2NaWBQxF6OFLzMyn0d9GjFMx1U0TAO3nJBHD8DCxJKVtzS3kXN4MC6EnHuig9C9HJAAWTczknFtXC4yDJnWwZS0LadKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837230; c=relaxed/simple;
	bh=686Nk4Ui0iCP2dvu4CE6nvTnMNWhH+HUW0Ag95Z7vHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcMrJwPz6xbMY/KongcTdHchthN3kl7lHbr+/wKJ4A/OQA2sPML4fl1wZDTfTHo3G21zUW78IlhqIOzfxVS8eyIqHDF3k7aXp0rbbTc9koC58mSYc+7j1I+fnXbq8bFcZ+kv/pcUa8//Ne8C4O0QYmsVcB286EX8T4LyaPKWLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VNlTB3WCYz1ypGN;
	Tue, 23 Apr 2024 09:51:10 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id ED9031A0188;
	Tue, 23 Apr 2024 09:53:39 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 09:53:38 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH v2 2/2] perf trace beauty: Always show mmap prot even though PROT_NONE
Date: Tue, 23 Apr 2024 09:53:30 +0800
Message-ID: <20240423015330.2206892-3-changbin.du@huawei.com>
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

PROT_NONE is also useful information, so do not omit the mmap prot even
though it is 0. syscall_arg__scnprintf_mmap_prot() could print PROT_NONE
for prot 0.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a8407eee58a3..e82ed002890f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1033,7 +1033,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 #if defined(__s390x__)
 	.alias = "old_mmap",
 #endif
-	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */
 			   .strtoul   = STUL_STRARRAY_FLAGS,
 			   .parm      = &strarray__mmap_flags, },
@@ -1050,7 +1050,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 		   [4] = { .scnprintf = SCA_MOVE_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
+		   [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ }, }, },
 	{ .name	    = "mq_unlink",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
@@ -1084,7 +1084,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_INT,	/* key */ }, }, },
 	{ .name	    = "pkey_mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+		   [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ },
 		   [3] = { .scnprintf = SCA_INT,	/* pkey */ }, }, },
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
-- 
2.34.1


