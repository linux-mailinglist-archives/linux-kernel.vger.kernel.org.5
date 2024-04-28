Return-Path: <linux-kernel+bounces-161237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C98B4951
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753E41C20E92
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027C23A0;
	Sun, 28 Apr 2024 03:10:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11438BFC;
	Sun, 28 Apr 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273830; cv=none; b=Y5tfveqi/j91mybssbhMjomC7DHeZyaKWyP5bJ6aD0MNW8CJ3meUyqumix32NwAFu2c91TofWM0pkrmFDJjHCjUbDRXrVmVTy+H7BnjlAoQxSCjGC3KIWTYO9KGsUsM8ao0VrkjltEGPcLGXBXgTdkZifGUpg8RnIchbTxCUkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273830; c=relaxed/simple;
	bh=Xkb858840JSpgt73J/+K8NkWTXhVSsceTUY+W6NiCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbMUhPJprTxSog3bukld70zeAj6ShYnVW+aO+6Syo1hqgQmNd7W6mrhkW2enA9x3MeQq7xRb+PkwO6numLz6X4+4rGWyOwAh0Dwj28aEZJOPHLLYgICnXGFuUu+rivfjcwor8hbSf6ELk0hQK2kU1pNDWQipztfuZg5Hb0/dWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VRryx2PCtzccF1;
	Sun, 28 Apr 2024 11:09:13 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D0FB180080;
	Sun, 28 Apr 2024 11:10:19 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 28 Apr 2024 11:10:18 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH v3 2/2] perf trace beauty: Always show mmap prot even though PROT_NONE
Date: Sun, 28 Apr 2024 11:10:08 +0800
Message-ID: <20240428031008.1535765-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428031008.1535765-1-changbin.du@huawei.com>
References: <20240428031008.1535765-1-changbin.du@huawei.com>
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

Before: PROT_NONE is not shown.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2979231 syscalls:sys_enter_mmap(len: 4220888, flags: PRIVATE|ANONYMOUS)

After: PROT_NONE is displayed.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2975708 syscalls:sys_enter_mmap(len: 4220888, prot: NONE, flags: PRIVATE|ANONYMOUS)

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 915dcd258002..919a462a7cb5 100644
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


