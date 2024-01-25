Return-Path: <linux-kernel+bounces-38083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C883BAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B452B23CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95212E42;
	Thu, 25 Jan 2024 07:38:49 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29312B78;
	Thu, 25 Jan 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168329; cv=none; b=M3hFYQhIC9v4nEUtB+xtkQ5T/3jiNoXejO7545ODtJaad6V0mdsYaH4D5Jpwi04adxY6UynoyqqYVLYuZkfnBk3teCY8/CFaaetegEswQCB+Zr1foNtB+tsN40lty6zHwI8Uhqy+UK0BuVFNI9hZsH6fcFnO2u1uB34CvfiwKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168329; c=relaxed/simple;
	bh=3fYlcljHcBza41tVnauOAqAFF6vQGvbVdY4Eygygshc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyYbNKo/v5RjE3ZQrZlGoXM4kk9aRYHc8qle2+ZFBYDWC8+9uysz7x0aTWTqkXs5JOh5WxbkIpB3wMnYVtNksDq+qSb8dDWk7b0Nb/xkTkI6z8DgNJFQ0f/mBEd6/x1dR9aQqG2gGNGOQcdAYtEBSJGEtSbJjD5Ht/0X6NpnLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TLCNG38WKzNlXN;
	Thu, 25 Jan 2024 15:37:50 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 417AD180079;
	Thu, 25 Jan 2024 15:38:29 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Jan
 2024 15:36:50 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v5 1/8] tracing/probes: add traceprobe_expand_dentry_args() helper
Date: Thu, 25 Jan 2024 15:39:16 +0800
Message-ID: <20240125073923.2252057-2-yebin10@huawei.com>
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

Add traceprobe_expand_dentry_args() to expand dentry args. this API is
prepare to support "%pd" print format for kprobe.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 50 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..0c1caf0f474a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1565,6 +1565,56 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	return ERR_PTR(ret);
 }
 
+/* @buf: *buf must be equal to NULL. Caller must to free *buf */
+int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
+{
+	int i, used, ret;
+	int bufsize = MAX_DENTRY_ARGS_LEN;
+	char *tmpbuf = NULL;
+
+	if (*buf)
+		return -EINVAL;
+
+	used = 0;
+	for (i = 0; i < argc; i++) {
+		if (glob_match("*:%pd", argv[i])) {
+			char *tmp;
+			char *equal;
+
+			if (!tmpbuf) {
+				tmpbuf = kmalloc(bufsize, GFP_KERNEL);
+				if (!tmpbuf)
+					return -ENOMEM;
+			}
+
+			tmp = kstrdup(argv[i], GFP_KERNEL);
+			if (!tmp)
+				goto nomem;
+
+			equal = strchr(tmp, '=');
+			if (equal)
+				*equal = '\0';
+			tmp[strlen(argv[i]) - 4] = '\0';
+			ret = snprintf(tmpbuf + used, bufsize - used,
+				       "%s%s+0x0(+0x%zx(%s)):string",
+				       equal ? tmp : "", equal ? "=" : "",
+				       offsetof(struct dentry, d_name.name),
+				       equal ? equal + 1 : tmp);
+			kfree(tmp);
+			if (ret >= bufsize - used)
+				goto nomem;
+			argv[i] = tmpbuf + used;
+			used += ret + 1;
+		}
+	}
+
+	*buf = tmpbuf;
+	return 0;
+nomem:
+	kfree(tmpbuf);
+	return -ENOMEM;
+}
+
 void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)
 {
 	clear_btf_context(ctx);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 850d9ecb6765..5800513439f3 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -34,6 +34,7 @@
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_BTF_ARGS_LEN	128
+#define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
 #define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
@@ -402,6 +403,7 @@ extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 					 int *new_argc, char *buf, int bufsize,
 					 struct traceprobe_parse_context *ctx);
+extern int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
-- 
2.31.1


