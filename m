Return-Path: <linux-kernel+bounces-111010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E18866EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4201C237E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD77D30B;
	Fri, 22 Mar 2024 06:42:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009912E4E;
	Fri, 22 Mar 2024 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089722; cv=none; b=D0cfg3sLuy3QZZ39oxRUdcFuXE9jejnmP4r51cxc7XWdITYotwOgvmgjI04DsezUPhGiI9IzaceJwkVbD7j6AqTD1udZ9N6SjWuIx1fI/Qc14rifa3ObQrEivLzVzTk136hMeD328S5wEg0FAm4ua3Jgw7hwiJfNR16vxUehJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089722; c=relaxed/simple;
	bh=ABUHxKws4avAJz+YGWjTdqpUD07z3KyEgfMh8LEm8rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFia2xjV7YxubNOnojJjhixfW+DQ6qw7E7IOn2rQ0yLhzAn/y9/Gb64TICFtwd7VAv3YoAbaY6UVm5NgS4rTiAnrKSbihFq+vB/5I2UyIW3WM6uSra8kTMVHuXoF/SifDJ829jijHD3Oj7LtbJ62qFOZiood7pBlu1m5KZaXOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V1CNQ3994zXjTV;
	Fri, 22 Mar 2024 14:39:18 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id BDADC140336;
	Fri, 22 Mar 2024 14:41:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 14:41:57 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v8 2/5] tracing/probes: support '%pD' type for print struct file's name
Date: Fri, 22 Mar 2024 14:43:05 +0800
Message-ID: <20240322064308.284457-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240322064308.284457-1-yebin10@huawei.com>
References: <20240322064308.284457-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)

As like previous patch, this patch support print type '%pD' for print file's
name. For example "name=$arg1:%pD" casts the `$arg1` as (struct file*),
dereferences the "file.f_path.dentry.d_name.name" field and stores it to
"name" argument as a kernel string.
Here is an example:
[tracing]# echo 'p:testprobe vfs_read name=$arg1:%pD' > kprobe_event
[tracing]# echo 1 > events/kprobes/testprobe/enable
[tracing]# grep -q "1" events/kprobes/testprobe/enable
[tracing]# echo 0 > events/kprobes/testprobe/enable
[tracing]# grep "vfs_read" trace | grep "enable"
            grep-15108   [003] .....  5228.328609: testprobe: (vfs_read+0x4/0xbb0) name="enable"

Note that this expects the given argument (e.g. $arg1) is an address of struct
file. User must ensure it.

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


