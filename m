Return-Path: <linux-kernel+bounces-32441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ADF835BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F38EB20A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764720DE1;
	Mon, 22 Jan 2024 07:39:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64A1BC49;
	Mon, 22 Jan 2024 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909142; cv=none; b=SyXAVt/fO1wyfCI7D2+0vEMvvLVMihNFkIks+GJ1DSif1kMDNr4xUs5Bed8QnQUgtROAehDU4rMrajCOkRxNG2Nuz0a8cYf1zlXPvD7swVRWj8Lm+/2JobXCvIx9fyHoz0UrzNGoK3CaJ+4kikanU84zWpNrFvelSHRi1eh7c5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909142; c=relaxed/simple;
	bh=76LvXPCu8lBDHJ52SEwVPpx3KQzmKFwc0Brqv+mwS0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkWuZBMlOMY6PJa/QfCFPg8wRvaevCLJYdrgGwFtq6NYiVgAMqMVVWCeEbaC85e7wEGiO34hjLBtOgUc0t8VhLGzubQVkdcr3EV3F5D2pZTJP4S6X/VzCBa9tXX7vYoE672K3D8BfTad+eONHcYlBirDbLfwpwLVA3tgZ554EwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJMVs57T3z29kf3;
	Mon, 22 Jan 2024 15:37:09 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 297FC1A017F;
	Mon, 22 Jan 2024 15:38:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 15:37:40 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v2 4/7] tracing/probes: support '%pD' type for print struct file's name
Date: Mon, 22 Jan 2024 15:40:12 +0800
Message-ID: <20240122074015.4042575-5-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240122074015.4042575-1-yebin10@huawei.com>
References: <20240122074015.4042575-1-yebin10@huawei.com>
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
index 1599c0c3e6b7..f9819625de58 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
+#include <linux/fs.h>
 #include "trace_btf.h"
 
 #include "trace_probe.h"
@@ -1572,28 +1573,38 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
 
 	used = 0;
 	for (i = 0; i < argc; i++) {
-		if (str_has_suffix(argv[i], ":%pd")) {
-			char *tmp = kstrdup(argv[i], GFP_KERNEL);
-			char *equal;
+		if (!str_has_suffix(argv[i], ":%pd") &&
+		    !str_has_suffix(argv[i], ":%pD"))
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
-			tmp[strlen(argv[i]) - 4] = '\0';
+		equal = strchr(tmp, '=');
+		if (equal)
+			*equal = '\0';
+		tmp[strlen(argv[i]) - 4] = '\0';
+		if (argv[i][strlen(argv[i]) - 1] == 'd')
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


