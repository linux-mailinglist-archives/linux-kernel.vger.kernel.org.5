Return-Path: <linux-kernel+bounces-34658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679B8385C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F305528F86C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C65CBE;
	Tue, 23 Jan 2024 02:55:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8D810;
	Tue, 23 Jan 2024 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978518; cv=none; b=UU1OZqX7yEK+vzHwUnoYUKBeuA6z+lu63etSshLqvSHV6Hh4WZ9Doqf46z6EwtQQQsSK+0K1reupjU0jEf1KdVuiVaXrLBGcaxMdA2rJ3N0ybLsUvfMAaaZcE+Aw5ftiuO8fq9Bh0jxSvB1khDN3CZRFDFD4QpdKBvO619vKDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978518; c=relaxed/simple;
	bh=R+0EqFIiGaBBpGCVcH0I4eW51HMRsop2Clw0T8UHkPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L09IB/9inknovOEqUAsxR4hj0zbudwhcJLH9w8RCv1ZjftQa5rrONIDX8u3LoTCuZBs8ppJxl83ZCpZkxViWWhFCXLPv8Mb6u9TcMvFDm0M6TXT8k1OuXlMVSWUOJSmEPprPOEryEgSzpOyNbA2OFjdJPp4FuTW08+r9mjz4gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TJs644c3pz1FJcM;
	Tue, 23 Jan 2024 10:50:52 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id C28B91404F9;
	Tue, 23 Jan 2024 10:55:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:53:33 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v3 3/7] tracing/probes: support '%pd' type for print struct dentry's name
Date: Tue, 23 Jan 2024 10:56:04 +0800
Message-ID: <20240123025608.2370978-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240123025608.2370978-1-yebin10@huawei.com>
References: <20240123025608.2370978-1-yebin10@huawei.com>
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

Similar to '%pd' for printk, use '%pd' for print struct dentry's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_kprobe.c | 6 ++++++
 kernel/trace/trace_probe.h  | 1 +
 2 files changed, 7 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..00b74530fbad 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -779,6 +779,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
+	char dbuf[MAX_DENTRY_ARGS_LEN];
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -930,6 +931,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		argv = new_argv;
 	}
 
+	ret = traceprobe_expand_dentry_args(argc, argv, dbuf,
+					    MAX_DENTRY_ARGS_LEN);
+	if (ret)
+		goto out;
+
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
 				argc, is_return);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 553371a4e0b1..d9c053824975 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -34,6 +34,7 @@
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_BTF_ARGS_LEN	128
+#define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
 #define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
-- 
2.31.1


