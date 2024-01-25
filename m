Return-Path: <linux-kernel+bounces-38086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3F83BAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C071C2291C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3E134CE;
	Thu, 25 Jan 2024 07:39:23 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C558134B4;
	Thu, 25 Jan 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168363; cv=none; b=Y6Cjqp92kvKvH5uknOVrU2kfrQazKETjo524QBLh+o5c1BC+qX5JexM4JyO2XNW+lawZhCmZMD60Cgev11BRUHc97R938SX2x2muHGNB76c/oyHBg/ow6dQbVrjONqY3EKh/ktNqBD99jF37TOKhlVt+jqNB1qScb7fncp09geo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168363; c=relaxed/simple;
	bh=DTWWED3utzA+ZuMoccKiNwpAtso/EWOE5CANqtTsna8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvkfkcVdki2uTkx0SizxDeIC9xsIKrvZEzR5ky7ouPDTzzFxxrBsACNoHxo8Nuh6P6oI0Vk48sr1/BAeirL9LEMolTGMJ0N/kQTIcO/v/m6JStP++5rKvyXgiN/KDPjHpgZabns6IiRir6il7iZUNzxPsLl4KLaI8LZ70DRY3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TLCPR1NHNz1vsVX;
	Thu, 25 Jan 2024 15:38:51 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id A086E140667;
	Thu, 25 Jan 2024 15:38:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Jan
 2024 15:36:51 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v5 2/8] tracing/probes: support '%pd' type for print struct dentry's name
Date: Thu, 25 Jan 2024 15:39:17 +0800
Message-ID: <20240125073923.2252057-3-yebin10@huawei.com>
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

Similar to '%pd' for printk, use '%pd' for print struct dentry's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_kprobe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..7cbb43740b4f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -779,6 +779,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
+	char *dbuf = NULL;
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -930,6 +931,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		argv = new_argv;
 	}
 
+	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
+	if (ret)
+		goto out;
+
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
 				argc, is_return);
@@ -971,6 +976,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	trace_probe_log_clear();
 	kfree(new_argv);
 	kfree(symbol);
+	kfree(dbuf);
 	return ret;
 
 parse_error:
-- 
2.31.1


