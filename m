Return-Path: <linux-kernel+bounces-34656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50238385C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FCA1F2788C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B66210F;
	Tue, 23 Jan 2024 02:55:17 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CFA2D;
	Tue, 23 Jan 2024 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978517; cv=none; b=BsQLWmZ7tt1hJldXvXG+wiD36mXhvyjpCNc64nVSFdms6TNlk7y0gOdS5BFCh7C5AI84YWvSzzupGwZCra7guLKStBXbM3MJ9cqu0Pdlid1Z6+opGgI4Llb5cDNPE0lBxu0BwwdPCDcSR5J5oWY3S5YI8xXLOoBvl8LmkFtoMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978517; c=relaxed/simple;
	bh=kYEzP77hAItk65iHZF+3d1AGqaHOMtv6LJ964mV0QIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsaep/HsbJcps+SXykwRTutaMEW/nb/GGDyAQfagNykSu7mVNurGhc25XfOsGWAoC7wLXpwj7J0YUl/CVZrKzCs/3ZSY8mQH2+SCa8DTMPAvIQ6XggbAFEqJdImzbC6GIUN88gM8C44sYy4l/2sCoY8/tmKVufpXWGtYN7n2b1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJs954MjYz29kgW;
	Tue, 23 Jan 2024 10:53:29 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id BD45C140412;
	Tue, 23 Jan 2024 10:55:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:53:33 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v3 2/7] tracing/probes: add traceprobe_expand_dentry_args() helper
Date: Tue, 23 Jan 2024 10:56:03 +0800
Message-ID: <20240123025608.2370978-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240123025608.2370978-1-yebin10@huawei.com>
References: <20240123025608.2370978-1-yebin10@huawei.com>
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
 kernel/trace/trace_probe.c | 36 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..cc8bd7ea5341 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1565,6 +1565,42 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	return ERR_PTR(ret);
 }
 
+int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
+				  int bufsize)
+{
+	int i, used, ret;
+
+	used = 0;
+	for (i = 0; i < argc; i++) {
+		size_t idx;
+
+		if (str_has_suffix(argv[i], ":%pd", &idx)) {
+			char *tmp = kstrdup(argv[i], GFP_KERNEL);
+			char *equal;
+
+			if (!tmp)
+				return -ENOMEM;
+
+			equal = strchr(tmp, '=');
+			if (equal)
+				*equal = '\0';
+			tmp[idx] = '\0';
+			ret = snprintf(buf + used, bufsize - used,
+				       "%s%s+0x0(+0x%zx(%s)):string",
+				       equal ? tmp : "", equal ? "=" : "",
+				       offsetof(struct dentry, d_name.name),
+				       equal ? equal + 1 : tmp);
+			kfree(tmp);
+			if (ret >= bufsize - used)
+				return -ENOMEM;
+			argv[i] = buf + used;
+			used += ret + 1;
+		}
+	}
+
+	return 0;
+}
+
 void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)
 {
 	clear_btf_context(ctx);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 850d9ecb6765..553371a4e0b1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -402,6 +402,8 @@ extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 					 int *new_argc, char *buf, int bufsize,
 					 struct traceprobe_parse_context *ctx);
+extern int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
+					 int bufsize);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
-- 
2.31.1


