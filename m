Return-Path: <linux-kernel+bounces-38084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47A83BACC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EDE281BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03912B8B;
	Thu, 25 Jan 2024 07:39:18 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B012B72;
	Thu, 25 Jan 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168358; cv=none; b=GbO3EVAAvEpdgnqdZ4dhYspmBhGgXeCNolhMUgBCJjCXN010AHwgTH5BUmMJXsFha1wZ7PMymCsasPG4JI9x9j5An3L0m9Kez2DbhseqLFp24jXdnYaqowIfy4XiulUxBdDvglY2FLD6VEg4uA0dz4MKyWSnidym03nIbwNTioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168358; c=relaxed/simple;
	bh=ZJw2waAhRAaGjGS/x8pJBAD09jJFzOLc+6SEuva6ITo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUHPkiBF/jjSW6Uv7m13QgaTtO8dou1aT8BmGihJAl6YfvW0wA4Q3f0Ox7ZsvYxDCcZn2Xrgl/VBI+PuFw++Vign/csophVpHO62tJMBLGsAMPgw2juZKzSPlMHrRMHE/UexI9cOL5W3KVyNls4dXF5ELIR7/auv/pTZ7RqeDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TLCNr3R49zNlTV;
	Thu, 25 Jan 2024 15:38:20 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AADE18001A;
	Thu, 25 Jan 2024 15:38:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Jan
 2024 15:36:51 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v5 3/8] tracing/probes: support '%pD' type for print struct file's name
Date: Thu, 25 Jan 2024 15:39:18 +0800
Message-ID: <20240125073923.2252057-4-yebin10@huawei.com>
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

Similar to '%pD' for printk, use '%pD' for print struct file's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 57 +++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 0c1caf0f474a..5ac7b0193dd8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
+#include <linux/fs.h>
 #include "trace_btf.h"
 
 #include "trace_probe.h"
@@ -1577,35 +1578,47 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 
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


