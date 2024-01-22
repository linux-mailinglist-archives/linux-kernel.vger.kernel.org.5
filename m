Return-Path: <linux-kernel+bounces-32435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE3835BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24532285FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5B17BD3;
	Mon, 22 Jan 2024 07:37:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317D16410;
	Mon, 22 Jan 2024 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909073; cv=none; b=WTJM4q6GYXmG+FokHZIMlJqsaqcrdh0WlurCKV2g8r6g97trtMG+SDHJ2kJb5P1jtjBET/QBQwt9GcwM3pepo5DLKAhX2LwGgo9qAB4YMOpzWGjtB0CjOgVKFIuGelUc5GV/sdqpPZiKC/9fkpMiQqhwsMZRUQWOFdsyo9DD72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909073; c=relaxed/simple;
	bh=dwg7fEKyPCidxs40PwHs/24PyKN/EeAm2a7dSGR0l+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBF3ixqccjF3NI/EO0Oa6zOdQQVjFBGnFh9Yt4oV/8CtSBflGvKVFiyfSY5aJRI1FYI2yyeaK58t6gBHzWTulrAcmUzliZPPs1tre7/kWrsZSCRkqKyprUALN3YE3az6vmCwqfZncRdDcaAcwc6amxU3HHIc6498IxLZRtmyCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TJMW6168HzbcFx;
	Mon, 22 Jan 2024 15:37:22 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 40E80140428;
	Mon, 22 Jan 2024 15:37:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 15:37:38 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v2 0/7] support '%pd' and '%pD' for print file name
Date: Mon, 22 Jan 2024 15:40:08 +0800
Message-ID: <20240122074015.4042575-1-yebin10@huawei.com>
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
 include/linux/string.h                        | 20 +++++
 kernel/trace/trace.c                          |  2 +-
 kernel/trace/trace_kprobe.c                   |  6 ++
 kernel/trace/trace_probe.c                    | 45 +++++++++++
 kernel/trace/trace_probe.h                    |  3 +
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 79 +++++++++++++++++++
 7 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc

-- 
2.31.1


