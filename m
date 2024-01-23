Return-Path: <linux-kernel+bounces-34657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B361A8385C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6893928C7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070E290F;
	Tue, 23 Jan 2024 02:55:18 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D1812;
	Tue, 23 Jan 2024 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978517; cv=none; b=glGnWS4U/EmOR1Q9NqGl2P5h9BjMvwLIrLwaPhAWm8OcoOW7sQ78jsCnFmQdTFf6fqDm5aE0057c5gd8ller+g15V2h2/8ZEG51NI/uqjVAluRKwQABaXYwzYzw6v5j6XS8mel8ifpM/vf+qsHs4lkoltGIK2FcTpcdTzAd+D1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978517; c=relaxed/simple;
	bh=LiwWyhM1qtbQeVlD18oSz5aI1Vwll7UcNW8EVujM6uY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6o9KNrFn5VKoaYryu4cQzfVfNskEHoFkgTocO+3X/DO8FmrZv8vUiGo8lgiRCAZLctD2eWrPp6+M73t0fyEZ4iFBR4xFsgBrdHXG/CeTNH6pTAcU7Mj244OGv0r4QHztdyKcZME0qqpK7ugDKKHrzraSAMmHGE435vQAseZS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TJsBg1dDnz1wnDj;
	Tue, 23 Jan 2024 10:54:51 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B30441404D8;
	Tue, 23 Jan 2024 10:55:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:53:32 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v3 0/7] support '%pd' and '%pD' for print file name
Date: Tue, 23 Jan 2024 10:56:01 +0800
Message-ID: <20240123025608.2370978-1-yebin10@huawei.com>
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


