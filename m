Return-Path: <linux-kernel+bounces-34980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51F838A22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BBB1F27D36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482A59B44;
	Tue, 23 Jan 2024 09:19:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878058218;
	Tue, 23 Jan 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001556; cv=none; b=hwBul+U3ePXlCJ9RS91cfjFKf92qUmiiEOWnXb9ylYOiCy/u9Jp5yHRmzQk5i2/vp1/ao8U/0nkgp4XuyqMXlbSqxwC/5gSKYZ2dFtPi8cZwQ3JFwCQv8fI4oVIHrg/bJXaS2V+63jzsp+mSXN50JNfBScqov+6mNr+Du91fPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001556; c=relaxed/simple;
	bh=pw2vTIuQmODbxC808VglRRN13BkaI7LvfeN3506+b+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcgWNbWgtL4NOauva2Sf1gk6UGad5a4UcwnpqPhtZJr7TIG716XpjSmw62oUSgQF2dX4SMG9n8VRvPZDYUs9a7UHJlPFM3dxIko8e1AlTcr7phN7qLSnU0jORv0YLgZIcJY1R71U1NqEURVibTH3GU86nJACsaegYVWiRlNyxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TK1hv31hXzsWMZ;
	Tue, 23 Jan 2024 17:18:07 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id E479C1404FD;
	Tue, 23 Jan 2024 17:19:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 17:19:05 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v4 4/7] tracing/probes: support '%pD' type for print struct file's name
Date: Tue, 23 Jan 2024 17:21:36 +0800
Message-ID: <20240123092139.3698375-5-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240123092139.3698375-1-yebin10@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
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
 kernel/trace/trace_probe.c | 41 ++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cc8bd7ea5341..a664633137a0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
+#include <linux/fs.h>
 #include "trace_btf.h"
 
 #include "trace_probe.h"
@@ -1574,28 +1575,38 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
 	for (i = 0; i < argc; i++) {
 		size_t idx;
 
-		if (str_has_suffix(argv[i], ":%pd", &idx)) {
-			char *tmp = kstrdup(argv[i], GFP_KERNEL);
-			char *equal;
+		if (!str_has_suffix(argv[i], ":%pd", &idx) &&
+		    !str_has_suffix(argv[i], ":%pD", &idx))
+			continue;
 
-			if (!tmp)
-				return -ENOMEM;
+		char *tmp = kstrdup(argv[i], GFP_KERNEL);
+		char *equal;
+
+		if (!tmp)
+			return -ENOMEM;
 
-			equal = strchr(tmp, '=');
-			if (equal)
-				*equal = '\0';
-			tmp[idx] = '\0';
+		equal = strchr(tmp, '=');
+		if (equal)
+			*equal = '\0';
+		tmp[idx] = '\0';
+		if (argv[i][idx + 3] == 'd')
 			ret = snprintf(buf + used, bufsize - used,
 				       "%s%s+0x0(+0x%zx(%s)):string",
 				       equal ? tmp : "", equal ? "=" : "",
 				       offsetof(struct dentry, d_name.name),
 				       equal ? equal + 1 : tmp);
-			kfree(tmp);
-			if (ret >= bufsize - used)
-				return -ENOMEM;
-			argv[i] = buf + used;
-			used += ret + 1;
-		}
+		else
+			ret = snprintf(buf + used, bufsize - used,
+				       "%s%s+0x0(+0x%zx(+0x%zx(%s))):string",
+				       equal ? tmp : "", equal ? "=" : "",
+				       offsetof(struct dentry, d_name.name),
+				       offsetof(struct file, f_path.dentry),
+				       equal ? equal + 1 : tmp);
+		kfree(tmp);
+		if (ret >= bufsize - used)
+			return -ENOMEM;
+		argv[i] = buf + used;
+		used += ret + 1;
 	}
 
 	return 0;
-- 
2.31.1


