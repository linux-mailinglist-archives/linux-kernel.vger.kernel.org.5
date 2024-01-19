Return-Path: <linux-kernel+bounces-30686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD7832307
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144B11C220FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D017F0;
	Fri, 19 Jan 2024 01:36:20 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54BECE;
	Fri, 19 Jan 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628180; cv=none; b=mL2Aa8oGG7Arg+B0ODLwYrGtZJXlxv9fwVpFPiMmruRUkeDqwKRygUsNhiCorU5DZZcpExd2Pr5GMaxZVbknr71jOl3OeD0evrtmpulhPQYevEjx7VfmlVvQEwOJ7WHYM+y+FXW/WevKdwWePemDr8UWtYvmsiSAgFhczS0226s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628180; c=relaxed/simple;
	bh=K1XydoNo9p2aYOEQJT2vpbYUCm3g6AGCAQTIxql3fBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEkXP+1dDjuZRGFsfXGu3/xrYkkp2DFCY7hDozlfcTV33egpVDWFCCT9X/IeLDOmgmen9Ilau/h+rHfR0cScZAsmwcfQDpJAfH1GYsZF4S49DKdiBwrVgavCDjsLIICtUoya91a9SVaK9hyq1t0/wd8apPc6NowBngX++FWcMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TGMbv5TBDz29kHW;
	Fri, 19 Jan 2024 09:34:35 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 566181404F1;
	Fri, 19 Jan 2024 09:36:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 09:36:14 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH 1/3] tracing/probes: support '%pd' type for print struct dentry's name
Date: Fri, 19 Jan 2024 09:38:46 +0800
Message-ID: <20240119013848.3111364-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240119013848.3111364-1-yebin10@huawei.com>
References: <20240119013848.3111364-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)

Similar to '%pd' for printk, use 'pd' for print struct dentry's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..460f98b85b1c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
+#include <linux/dcache.h>
 #include <linux/bpf.h>
 #include "trace_btf.h"
 
@@ -86,6 +87,8 @@ static const struct fetch_type probe_fetch_types[] = {
 			    "__data_loc char[]"),
 	__ASSIGN_FETCH_TYPE("symstr", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("pd", string, string, sizeof(u32), 1, 1,
+			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
 	ASSIGN_FETCH_TYPE(u16, u16, 0),
@@ -1090,6 +1093,25 @@ static int __parse_bitfield_probe_arg(const char *bf,
 	return (BYTES_TO_BITS(t->size) < (bw + bo)) ? -EINVAL : 0;
 }
 
+static char* traceprobe_expand_dentry(const char *argv)
+{
+	#define DENTRY_EXPAND_LEN 7  /* +0xXX() */
+	char *new_argv;
+	int len = strlen(argv) + 1 + DENTRY_EXPAND_LEN;
+
+	new_argv = kmalloc(len, GFP_KERNEL);
+	if (!new_argv)
+		return NULL;
+
+	if (snprintf(new_argv, len, "+0x%lx(%s)",
+		     offsetof(struct dentry, d_name.name), argv) >= len) {
+		kfree(new_argv);
+		return NULL;
+	}
+
+	return new_argv;
+}
+
 /* String length checking wrapper */
 static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 					   struct probe_arg *parg,
@@ -1099,6 +1121,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	char *t, *t2, *t3;
 	int ret, len;
 	char *arg;
+	char *org_arg = NULL;
 
 	arg = kstrdup(argv, GFP_KERNEL);
 	if (!arg)
@@ -1182,6 +1205,16 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 parg->count);
 	}
 
+	if (!strcmp("pd", parg->type->name)) {
+		char *temp;
+
+		temp = traceprobe_expand_dentry(arg);
+		if (!temp)
+			goto out;
+		org_arg = arg;
+		arg = temp;
+	}
+
 	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
 	if (!code)
 		goto out;
@@ -1243,6 +1276,10 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 				goto fail;
 			}
 		}
+
+		if (!strcmp(parg->type->name, "pd"))
+			code++;
+
 		/* If op == DEREF, replace it with STRING */
 		if (!strcmp(parg->type->name, "ustring") ||
 		    code->op == FETCH_OP_UDEREF)
@@ -1321,6 +1358,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	kfree(tmp);
 out:
 	kfree(arg);
+	kfree(org_arg);
 
 	return ret;
 }
-- 
2.31.1


