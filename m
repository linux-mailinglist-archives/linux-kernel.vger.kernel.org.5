Return-Path: <linux-kernel+bounces-104092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAC87C8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0141C21334
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F314005;
	Fri, 15 Mar 2024 06:54:23 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA68BEA;
	Fri, 15 Mar 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485662; cv=none; b=Ouch9V04tP2lgfhMyF+oxo5JeZWX6ju1ZwQiBEu7nTJUQPWESIBCSQoF95pbWKobeaK5j8a6MWOEznkIII8d02EqXfVVwQW5JfNr1/8U4E9beV3NZ9a/7/Y35nlXY5xrDw3bgxq+0yrzW78pGSniZgy79vpdhYbr8+LaQXsRSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485662; c=relaxed/simple;
	bh=vrLjDY7iYTglWbIF9byAN3ZdVSQfDDmsDWsXScSYCLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCMVi1a5crw5A23MmwBvvC52v7rpa9E2alQ4zfuYikFCUykNvDC3IUTkygulFAkxmEfDWdx1fG1olcSyguwL1FyDxx9Z7hcF41nfQ2jaCvsGg21o6JWSd6qgQUaL9y6n7n7pwH0dyxxKoKwBzUtRzbCaS+CIBicR91n7LSosUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tww0v14KZz1xqfr;
	Fri, 15 Mar 2024 14:52:31 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CD5D1A016F;
	Fri, 15 Mar 2024 14:54:18 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:17 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 1/8] tracing/probes: add traceprobe_expand_dentry_args() helper
Date: Fri, 15 Mar 2024 14:55:33 +0800
Message-ID: <20240315065540.1181879-2-yebin10@huawei.com>
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

Add traceprobe_expand_dentry_args() to expand dentry args. this API is
prepare to support "%pd" print format for kprobe.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 50 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 34289f9c6707..a27567e16c36 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1569,6 +1569,56 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	return ERR_PTR(ret);
 }
 
+/* @buf: *buf must be equal to NULL. Caller must to free *buf */
+int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
+{
+	int i, used, ret;
+	const int bufsize = MAX_DENTRY_ARGS_LEN;
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
index c1877d018269..3d22fba4b63f 100644
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


