Return-Path: <linux-kernel+bounces-108941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A488124E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F54B24486
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868841C8B;
	Wed, 20 Mar 2024 13:28:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0640847;
	Wed, 20 Mar 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941301; cv=none; b=Yg3Txb/B7djIWUNoHEUaXWtzYcOjVe+DMWnBIwJsZUAmQD+jQl5f8+2JVG72QFD82CHybQw8w98xtGMJ8z575DU6fAl82q2i+fMb3XVbZmu4bi1XhOeH+nuV82j9PSpjO8sAvsbMjpXrt4er1+hdSnQUY3ZSiDhu0KTTiskjpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941301; c=relaxed/simple;
	bh=zQ+5z4yVaRw12jlqHXhGReM65NfBvYTIyI0IGWbbO+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVkagOGu2SdhxWRdH/RiN1yBtWSwTP3CaoSfHZNyWwNGx300E4nqkd7F6P9yhKrghKEZsWO5Bhqtt0oQanZ6muIUsnXieyb+SnL0fISK3yL4l9F/wunjPR/S4qHOHtiz5k1U1TXr/t2iWb8grPyh5D1hsH20S9mLHdY1EDvtbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V08V60BkWzXjMG;
	Wed, 20 Mar 2024 21:25:34 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id C029914040D;
	Wed, 20 Mar 2024 21:28:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 21:28:10 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v7 0/5] support '%pd' and '%pD' for print file name
Date: Wed, 20 Mar 2024 21:29:19 +0800
Message-ID: <20240320132924.2802187-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)

During fault locating, the file name needs to be printed based on the
dentry/file address. The offset needs to be calculated each time, which
is troublesome. Similar to printk, kprobe supports printing file names
for dentry/file addresses.

Diff v7 vs v6:
1. Squash [1/8] to [3/8] patches into 1 patch;
2. Split readme_msg[] into each patch;

Diff v6 vs v5:
1. Add const for 'bufsize' in PATCH [1];
2. Move PATCH 'tracing/probes: support '%pd/%pD' type for fprobe' after
PATCH "tracing/probes: support '%pd' type for print struct dentry's name".
3. Add requires '"%pd/%pD":README' for testcase.

Diff v5 vs v4:
1. Use glob_match() instead of str_has_suffix(), so remove the first patch;
2. Allocate buffer from heap for expand dentry;
3. Support "%pd/%pD" print type for fprobe;
4. Use $arg1 instead of origin register in test case;
5. Add test case for fprobe;

Diff v4 vs v3:
1. Use "argv[i][idx + 3] == 'd'" instead of "argv[i][strlen(argv[i]) - 1] == 'd'"
to judge print format in PATCH[4/7];

Diff v3 vs v2:
1. Return the index of where the suffix was found in str_has_suffix();

Diff v2 vs v1:
1. Use "%pd/%pD" print format instead of "pd/pD" print format;
2. Add "%pd/%pD" in README;
3. Expand "%pd/%pD" argument before parameter parsing;
4. Add more detail information in ftrace documentation;
5. Add test cases for new print format in selftests/ftrace;


Ye Bin (5):
  tracing/probes: support '%pd' type for print struct dentry's name
  tracing/probes: support '%pD' type for print struct file's name
  Documentation: tracing: add new type '%pd' and '%pD' for kprobe
  selftests/ftrace: add kprobe test cases for VFS type "%pd" and "%pD"
  selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"

 Documentation/trace/kprobetrace.rst           |  8 ++-
 kernel/trace/trace.c                          |  2 +-
 kernel/trace/trace_fprobe.c                   |  6 ++
 kernel/trace/trace_kprobe.c                   |  6 ++
 kernel/trace/trace_probe.c                    | 63 +++++++++++++++++++
 kernel/trace/trace_probe.h                    |  2 +
 .../ftrace/test.d/dynevent/fprobe_args_vfs.tc | 40 ++++++++++++
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 40 ++++++++++++
 8 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc

-- 
2.31.1


