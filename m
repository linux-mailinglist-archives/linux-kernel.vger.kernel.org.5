Return-Path: <linux-kernel+bounces-38087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88983BAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB981C22BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE112B8C;
	Thu, 25 Jan 2024 07:39:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E2171AC;
	Thu, 25 Jan 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168374; cv=none; b=X7sW7TjcoWqn4MuQt5w8nDcknvHpSVPkLSjr1+FxLzQXOsGnpqshXt5PE8esZo+DkRhCaQnoUBvExqLKaTYnIDfOlEBtYMHZnieer1JO1K/htuw45kCmqDhupnbhxF+4RdyP/BD7gW8SNB6EPJ9YNzvs0bmMi+qkraE2YpPzdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168374; c=relaxed/simple;
	bh=fL+61EE8VfS7TSQ3fjCfD78Ystne/UYrNzobZfLfpQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7ssflh9J/LTKlZ0FTBUuatS0ppFW60ivAk/+EToq3Fnnzk4YhukQJ05LGtNbMQifEdIMMdHXJ5z2pHvPmF/IDLemtoMnC4isSUs+G28NslxMpJkaNewTD5do0dgNd3YRRNXhB9JhxswBC9+28O9O44jzpVIu5GtkOgpuiiT46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TLCNx2BYvzsWJS;
	Thu, 25 Jan 2024 15:38:25 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ED5E180080;
	Thu, 25 Jan 2024 15:39:14 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Jan
 2024 15:36:52 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v5 4/8] tracing/probes: support '%pd/%pD' type for fprobe
Date: Thu, 25 Jan 2024 15:39:19 +0800
Message-ID: <20240125073923.2252057-5-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240125073923.2252057-1-yebin10@huawei.com>
References: <20240125073923.2252057-1-yebin10@huawei.com>
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

Support print type '%pd/%pD' for print dentry's or file's name.

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


