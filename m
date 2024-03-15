Return-Path: <linux-kernel+bounces-104095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B087C8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484FD1C21690
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935B175BC;
	Fri, 15 Mar 2024 06:54:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254DDDA6;
	Fri, 15 Mar 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485663; cv=none; b=VctCWhAMSgZHglGT1dG3Jap7SRc113sROt+0YcCdt644mzDB/dDbV1s08X1HAV5tgCe6xlcqeQDYMQGCxJ/GLscSGDg9UtQ9LXmLM7nHB9WpCySyMBHxAOxwPiNxMk3Ds/yavUqEWai5qGJQo68nf0ciRzGgkStpriSvchlGWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485663; c=relaxed/simple;
	bh=GjRxippzJ1yVsG3/oTdISeBTK/MJfco3wGa3k6U3Uco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoAvUaMGpxGd1STkCPjBrZetKPx3PuX3XWERWNPaYLZEWmGo85MZT83zW515Wsft16FK483spZbkOH0aVnt2N2rhABhVAcv+wTkRq+nzNh7B4+aeDaBCUp0UsAMVpGCfTuN98orbwBXVvWcMUW68cI936qyhxbyOali+7l1KRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tww065wvKz2BgNP;
	Fri, 15 Mar 2024 14:51:50 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B524B140485;
	Fri, 15 Mar 2024 14:54:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:19 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 4/8] tracing/probes: support '%pD' type for print struct file's name
Date: Fri, 15 Mar 2024 14:55:36 +0800
Message-ID: <20240315065540.1181879-5-yebin10@huawei.com>
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

Similar to '%pD' for printk, use '%pD' for print struct file's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 57 +++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index a27567e16c36..7bfc6c0d5436 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
+#include <linux/fs.h>
 #include "trace_btf.h"
 
 #include "trace_probe.h"
@@ -1581,35 +1582,47 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 
 	used = 0;
 	for (i = 0; i < argc; i++) {
-		if (glob_match("*:%pd", argv[i])) {
-			char *tmp;
-			char *equal;
-
-			if (!tmpbuf) {
-				tmpbuf = kmalloc(bufsize, GFP_KERNEL);
-				if (!tmpbuf)
-					return -ENOMEM;
-			}
+		char *tmp;
+		char *equal;
+		size_t arg_len;
 
-			tmp = kstrdup(argv[i], GFP_KERNEL);
-			if (!tmp)
-				goto nomem;
+		if (!glob_match("*:%p[dD]", argv[i]))
+			continue;
 
-			equal = strchr(tmp, '=');
-			if (equal)
-				*equal = '\0';
-			tmp[strlen(argv[i]) - 4] = '\0';
+		if (!tmpbuf) {
+			tmpbuf = kmalloc(bufsize, GFP_KERNEL);
+			if (!tmpbuf)
+				return -ENOMEM;
+		}
+
+		tmp = kstrdup(argv[i], GFP_KERNEL);
+		if (!tmp)
+			goto nomem;
+
+		equal = strchr(tmp, '=');
+		if (equal)
+			*equal = '\0';
+		arg_len = strlen(argv[i]);
+		tmp[arg_len - 4] = '\0';
+		if (argv[i][arg_len - 1] == 'd')
 			ret = snprintf(tmpbuf + used, bufsize - used,
 				       "%s%s+0x0(+0x%zx(%s)):string",
 				       equal ? tmp : "", equal ? "=" : "",
 				       offsetof(struct dentry, d_name.name),
 				       equal ? equal + 1 : tmp);
-			kfree(tmp);
-			if (ret >= bufsize - used)
-				goto nomem;
-			argv[i] = tmpbuf + used;
-			used += ret + 1;
-		}
+		else
+			ret = snprintf(tmpbuf + used, bufsize - used,
+				       "%s%s+0x0(+0x%zx(+0x%zx(%s))):string",
+				       equal ? tmp : "", equal ? "=" : "",
+				       offsetof(struct dentry, d_name.name),
+				       offsetof(struct file, f_path.dentry),
+				       equal ? equal + 1 : tmp);
+
+		kfree(tmp);
+		if (ret >= bufsize - used)
+			goto nomem;
+		argv[i] = tmpbuf + used;
+		used += ret + 1;
 	}
 
 	*buf = tmpbuf;
-- 
2.31.1


