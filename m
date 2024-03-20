Return-Path: <linux-kernel+bounces-108946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83C881253
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58F9B24B50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB56848CCD;
	Wed, 20 Mar 2024 13:28:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6140BFD;
	Wed, 20 Mar 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941303; cv=none; b=VUZQ7ovE3q+SMKQSSNzZ8PwhfLbN56EfQrUcRx3Ba++wIp5xTnZLf1xkIRkENCFTZIjaVLuQa48EjhE/KlemHobzUgyVOyAR2MH96veV4sGbll6u/pmxx1hR9otHGxFhIthqbwdKX8pK+xoS+t8eWWcxANOBj7LJWM/fQTwKSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941303; c=relaxed/simple;
	bh=gvy8zKYkHQrm2onFaLP191TLnQ4xoumRxMNImZv0AyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxoy7+9rkGwDtwK+EZfDReZZ/7u0K7qErKRcJuvi4XPGkx/VfcsVHBSRMmgWser4p4ordRhqsyhPfqMbIV8peeOjzxwPXdMeoVNqEvn8KkOVklgbmsYNv6z4rWVgKHYWRFIF5oCCjTRo42tIDja0vCg2h/7A3EFXWaTvckJA8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V08VB614xzwPgR;
	Wed, 20 Mar 2024 21:25:38 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id A237C14040D;
	Wed, 20 Mar 2024 21:28:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 21:28:11 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v7 2/5] tracing/probes: support '%pD' type for print struct file's name
Date: Wed, 20 Mar 2024 21:29:21 +0800
Message-ID: <20240320132924.2802187-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240320132924.2802187-1-yebin10@huawei.com>
References: <20240320132924.2802187-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)

Similar to '%pD' for printk, use '%pD' for print struct file's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace.c       |  2 +-
 kernel/trace/trace_probe.c | 57 +++++++++++++++++++++++---------------
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ac26b8446337..831dfd0773a4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5510,7 +5510,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           symstr, %pd, <type>\\[<array-size>\\]\n"
+	"\t           symstr, %pd/%pD, <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
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


