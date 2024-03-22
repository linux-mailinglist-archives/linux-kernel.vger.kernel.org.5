Return-Path: <linux-kernel+bounces-111013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5008866F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83910286231
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2415AF9;
	Fri, 22 Mar 2024 06:42:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC811CB0;
	Fri, 22 Mar 2024 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089727; cv=none; b=HhcSZtlbavfGLvS6BVKEKkPfPoky7R0gOOCY47YiMSfgiYfsb9Fkt5VOJzIJvNmWDPZeswSnrcgbH6cDGInp+DCZR5+JSXJD0UrYD5KJCMHqJIy23p0wbdESEIMNNagdeJ5W7mzevDasC4UwVW388vCR48nvc1wIg4E5Jum2sLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089727; c=relaxed/simple;
	bh=WeWxr9t3L2GDxhsu9Kirj8pM1yf3pq6KUVC6wBTVrAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWJAAts1QU2GvD6yhli6sJtOcR00BWEsmxloHpYhAXDgOsaWdPJCbq4bYXW0OA+7Mg9BCb8fgjX9LstxaaNPDKug8mbnBaYEZIdY33U4Ds7m2m0Dyl39CpqCuK7rMonJ9jkt0oxtPZ5qqBO86hKZR76mxVrVNpIIZNvHZ/YAybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V1CNV3XSBz1h2k4;
	Fri, 22 Mar 2024 14:39:22 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 572221A016C;
	Fri, 22 Mar 2024 14:41:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 14:41:56 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v8 1/5] tracing/probes: support '%pd' type for print struct dentry's name
Date: Fri, 22 Mar 2024 14:43:04 +0800
Message-ID: <20240322064308.284457-2-yebin10@huawei.com>
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

During fault locating, the file name needs to be printed based on the
dentry  address. The offset needs to be calculated each time, which
is troublesome. Similar to printk, kprobe support print type '%pd' for
print dentry's name. For example "name=$arg1:%pd" casts the `$arg1`
as (struct dentry *), dereferences the "d_name.name" field and stores
it to "name" argument as a kernel string.
Here is an example:
[tracing]# echo 'p:testprobe dput name=$arg1:%pd' > kprobe_events
[tracing]# echo 1 > events/kprobes/testprobe/enable
[tracing]# grep -q "1" events/kprobes/testprobe/enable
[tracing]# echo 0 > events/kprobes/testprobe/enable
[tracing]# cat trace | grep "enable"
	    bash-14844   [002] ..... 16912.889543: testprobe: (dput+0x4/0x30) name="enable"
            grep-15389   [003] ..... 16922.834182: testprobe: (dput+0x4/0x30) name="enable"
            grep-15389   [003] ..... 16922.836103: testprobe: (dput+0x4/0x30) name="enable"
            bash-14844   [001] ..... 16931.820909: testprobe: (dput+0x4/0x30) name="enable"

Note that this expects the given argument (e.g. $arg1) is an address of struct
dentry. User must ensure it.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace_fprobe.c |  6 +++++
 kernel/trace/trace_kprobe.c |  6 +++++
 kernel/trace/trace_probe.c  | 50 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  2 ++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b12f8384a36a..ac26b8446337 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5510,7 +5510,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           symstr, <type>\\[<array-size>\\]\n"
+	"\t           symstr, %pd, <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 7d2ddbcfa377..988d68e906ad 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -976,6 +976,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
+	char *dbuf = NULL;
 	bool is_tracepoint = false;
 	struct tracepoint *tpoint = NULL;
 	struct traceprobe_parse_context ctx = {
@@ -1086,6 +1087,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		argv = new_argv;
 	}
 
+	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
+	if (ret)
+		goto out;
+
 	/* setup a probe */
 	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
 				argc, is_return);
@@ -1131,6 +1136,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	trace_probe_log_clear();
 	kfree(new_argv);
 	kfree(symbol);
+	kfree(dbuf);
 	return ret;
 
 parse_error:
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..7cbb43740b4f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -779,6 +779,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
+	char *dbuf = NULL;
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -930,6 +931,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		argv = new_argv;
 	}
 
+	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
+	if (ret)
+		goto out;
+
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
 				argc, is_return);
@@ -971,6 +976,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	trace_probe_log_clear();
 	kfree(new_argv);
 	kfree(symbol);
+	kfree(dbuf);
 	return ret;
 
 parse_error:
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


