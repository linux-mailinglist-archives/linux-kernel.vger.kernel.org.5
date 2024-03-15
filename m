Return-Path: <linux-kernel+bounces-104099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B337187C8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782361F21FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1A18AF9;
	Fri, 15 Mar 2024 06:54:28 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42118637;
	Fri, 15 Mar 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485668; cv=none; b=AwxyT6X1hcKRNkQ3vJyWP0oOgiyGjl+typHq0JxrLTcxgpXf2/tuXYyM3MscX2nnPCa3CYX9aOItVKjW8WRUSFfLxfk0s6StPrsrInTk4SnfPTkq2BLGUBtwG7Xz5q/ddxCU9EvxjHKWGnHH5mKGOe01elEQyuvfLJhucQGGZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485668; c=relaxed/simple;
	bh=WuzOu1pbLK1l4Mw333eghX00jBYu4yVSy2f2BXI6kRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cO091kP9nJZmBy1tBtU88VEQss6p2YGvZYYFlh7vUjNSpdXWWvaMStOnVOMz7fpvoyictAYyTxZimXFW/TF01dm3CwqON23tUOeioejvNB9f8qX3l4qcwqYDF8HnJow9dleZzWk/bJCKljst/6U9LlJIjETyASmHjBCFfITcl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tww0T74fLz1Q9gW;
	Fri, 15 Mar 2024 14:52:09 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 4858F1404F3;
	Fri, 15 Mar 2024 14:54:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:18 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 3/8] tracing/probes: support '%pd' type for fprobe
Date: Fri, 15 Mar 2024 14:55:35 +0800
Message-ID: <20240315065540.1181879-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240315065540.1181879-1-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
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

Support print type '%pd' for print dentry's or file's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_fprobe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 7d2ddbcfa377..988d68e906ad 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -976,6 +976,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
+	char *dbuf = NULL;
 	bool is_tracepoint = false;
 	struct tracepoint *tpoint = NULL;
 	struct traceprobe_parse_context ctx = {
@@ -1086,6 +1087,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		argv = new_argv;
 	}
 
+	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
+	if (ret)
+		goto out;
+
 	/* setup a probe */
 	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
 				argc, is_return);
@@ -1131,6 +1136,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	trace_probe_log_clear();
 	kfree(new_argv);
 	kfree(symbol);
+	kfree(dbuf);
 	return ret;
 
 parse_error:
-- 
2.31.1


