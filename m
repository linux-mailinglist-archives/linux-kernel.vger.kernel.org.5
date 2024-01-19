Return-Path: <linux-kernel+bounces-30688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45983230A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407C7B22884
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9E46A8;
	Fri, 19 Jan 2024 01:36:21 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B24ED9;
	Fri, 19 Jan 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628181; cv=none; b=IcLK54/OOoCcLycL+qf+i3rF+eABVCAjG03V1lpg8W/83nQLGcrM7q9c+NbVSUOjGJ7+YDvKf2mp3P/OvrAwt5UcTx5T8LqX3raogkQdOox8q60+qLSezbH9SGzEr/XuaUqB3EXD38+g2EVgklPFW055Jzm2hroae1owk8wJZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628181; c=relaxed/simple;
	bh=9v9m7nPcfnEvdIhqDenml4Or78lsJCXEaQSzOCTjMqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKhtvSkchW48cYhzLHdf6tbnioT54wMRkc+YbCP8TtRMl7KMmT0Uo1jw7E0lo6gTY0Tf170ABdxi7NX9uPBltX4xRTBb+HfuT8KYVmqXW3px82ObpkfJQFqvMXnk/ZF1pWGQ/PDZ/4CsS36pTFMZOLcmn4/YDrUe6OtGFe2OuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TGMcx0wGTz1xmR9;
	Fri, 19 Jan 2024 09:35:29 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id C0304140113;
	Fri, 19 Jan 2024 09:36:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 09:36:15 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH 2/3] tracing/probes: support '%pD' type for print struct file's name
Date: Fri, 19 Jan 2024 09:38:47 +0800
Message-ID: <20240119013848.3111364-3-yebin10@huawei.com>
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

Similar to '%pD' for printk, use 'pD' for print struct file's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 460f98b85b1c..400a1dd52c39 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/dcache.h>
+#include <linux/fs.h>
 #include <linux/bpf.h>
 #include "trace_btf.h"
 
@@ -89,6 +90,8 @@ static const struct fetch_type probe_fetch_types[] = {
 			    "__data_loc char[]"),
 	__ASSIGN_FETCH_TYPE("pd", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("pD", string, string, sizeof(u32), 1, 1,
+			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
 	ASSIGN_FETCH_TYPE(u16, u16, 0),
@@ -1093,18 +1096,26 @@ static int __parse_bitfield_probe_arg(const char *bf,
 	return (BYTES_TO_BITS(t->size) < (bw + bo)) ? -EINVAL : 0;
 }
 
-static char* traceprobe_expand_dentry(const char *argv)
+static char* traceprobe_expand_dentry_file(const char *argv, bool is_dentry)
 {
 	#define DENTRY_EXPAND_LEN 7  /* +0xXX() */
+	#define FILE_EXPAND_LEN   15 /* +0xXX(+0xXXX()) */
 	char *new_argv;
-	int len = strlen(argv) + 1 + DENTRY_EXPAND_LEN;
+	int len, ret;
 
+	len = strlen(argv) + 1 + (is_dentry ? DENTRY_EXPAND_LEN : FILE_EXPAND_LEN);
 	new_argv = kmalloc(len, GFP_KERNEL);
 	if (!new_argv)
 		return NULL;
 
-	if (snprintf(new_argv, len, "+0x%lx(%s)",
-		     offsetof(struct dentry, d_name.name), argv) >= len) {
+	if (is_dentry)
+		ret = snprintf(new_argv, len, "+0x%lx(%s)",
+			       offsetof(struct dentry, d_name.name), argv);
+	else
+		ret = snprintf(new_argv, len, "+0x%lx(+0x%lx(%s))",
+			       offsetof(struct dentry, d_name.name),
+			       offsetof(struct file, f_path.dentry), argv);
+	if (ret >= len) {
 		kfree(new_argv);
 		return NULL;
 	}
@@ -1205,10 +1216,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 parg->count);
 	}
 
-	if (!strcmp("pd", parg->type->name)) {
+	if (!strcasecmp("pd", parg->type->name)) {
 		char *temp;
 
-		temp = traceprobe_expand_dentry(arg);
+		temp = traceprobe_expand_dentry_file(arg,
+						     parg->type->name[1] == 'd');
 		if (!temp)
 			goto out;
 		org_arg = arg;
@@ -1277,7 +1289,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			}
 		}
 
-		if (!strcmp(parg->type->name, "pd"))
+		if (!strcasecmp(parg->type->name, "pd"))
 			code++;
 
 		/* If op == DEREF, replace it with STRING */
-- 
2.31.1


