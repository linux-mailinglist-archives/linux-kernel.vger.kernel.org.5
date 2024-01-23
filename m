Return-Path: <linux-kernel+bounces-34977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA9838A20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ECF1C247D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3858ABA;
	Tue, 23 Jan 2024 09:19:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE75820F;
	Tue, 23 Jan 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001555; cv=none; b=ffRAsv5+If3ukNTRxzew/9XUkOLkwyfSqCaONgy9CMeFmrihe3D8DgPCaTma9Vqe2ivlCXAIPOHXl9pvUy0Inj6S67lv2Rk8K+Em9+5KBSF/lyU7Lp72Qi3ifUtvKBh577Dtwc6LT73WW9fEBSK7t3U0Jyj8jzHWoyfcU0YtqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001555; c=relaxed/simple;
	bh=jUHVuIs/UapfTOlXV8cUELrTxUQ8NolJD73xVsvPNbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKXwloVVH875iUmLMRox2H3jb3ymG9cy0DfIXkkAADnAL7YEWImMUOMWrbJy1edQh6fsqdAg3KAWILFOHNKQrAQkEs91aKwA/z/+4ZfUsDDvkL2kLjtKbyk5I7Ey9Br+nuMbGMy2FM18yl9zdZdtXIpKF9FKFVh+POHW0MDfjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TK1hv3qXMz18KL3;
	Tue, 23 Jan 2024 17:18:07 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id D35EC1404FD;
	Tue, 23 Jan 2024 17:19:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 17:19:03 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v4 0/7] support '%pd' and '%pD' for print file name
Date: Tue, 23 Jan 2024 17:21:32 +0800
Message-ID: <20240123092139.3698375-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

During fault locating, the file name needs to be printed based on the
dentry/file address. The offset needs to be calculated each time, which
is troublesome. Similar to printk, kprobe supports printing file names
for dentry/file addresses.

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

Ye Bin (7):
  string.h: add str_has_suffix() helper for test string ends with
    specify string
  tracing/probes: add traceprobe_expand_dentry_args() helper
  tracing/probes: support '%pd' type for print struct dentry's name
  tracing/probes: support '%pD' type for print struct file's name
  tracing: add new type "%pd/%pD" in readme_msg[]
  Documentation: tracing: add new type '%pd' and '%pD' for kprobe
  selftests/ftrace: add test cases for VFS type "%pd" and "%pD"

 Documentation/trace/kprobetrace.rst           |  6 +-
 include/linux/string.h                        | 28 +++++++
 kernel/trace/trace.c                          |  2 +-
 kernel/trace/trace_kprobe.c                   |  6 ++
 kernel/trace/trace_probe.c                    | 47 +++++++++++
 kernel/trace/trace_probe.h                    |  3 +
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 79 +++++++++++++++++++
 7 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc

-- 
2.31.1


