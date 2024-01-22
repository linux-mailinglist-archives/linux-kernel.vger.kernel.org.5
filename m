Return-Path: <linux-kernel+bounces-32437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D275835BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558D1281D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BA16410;
	Mon, 22 Jan 2024 07:38:12 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6320DEB;
	Mon, 22 Jan 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909092; cv=none; b=QGCbOWPwmdFdcta/nVwjTdDYTlf2hLCKYITdeuKLIyKDuSgQMPS+0FXnayJqAyDp0X4eGuwLZLYdww1+gE5lLhyhCtGK8GfoPlm+9dC2FPPxAIr+eOQIwoGocboMGPdtjfB5TklS2CmfL889Px+L9JV//iWo2DPzda9c70jcOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909092; c=relaxed/simple;
	bh=uRi7b/OnTFYE7tce+ThtNtXL9uYhQDA1900RsEUwyxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYJn2o4tGNAsHEab20yi+4Bj2khaofXAdKFOWQEtDlrNXJ3oozQm+P7gtwR3dulFs5+OxX3J0Jk4TcsQv6FptQ5V74Ko67YH5aQKBd/oxIWIpeAVRobippb5Z0o/BHDlNwzrB5ZjjbRASMgT1jN/MHpMVCDJ0rkt0YRD4+1zhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TJMV02SKYz1S5NB;
	Mon, 22 Jan 2024 15:36:24 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DE4C1A0179;
	Mon, 22 Jan 2024 15:37:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 15:37:39 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v2 2/7] tracing/probes: add traceprobe_expand_dentry_args() helper
Date: Mon, 22 Jan 2024 15:40:10 +0800
Message-ID: <20240122074015.4042575-3-yebin10@huawei.com>
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

Add traceprobe_expand_dentry_args() to expand dentry args. this API is
prepare to support "%pd" print format for kprobe.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace_probe.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..1599c0c3e6b7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1565,6 +1565,40 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	return ERR_PTR(ret);
 }
 
+int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
+				  int bufsize)
+{
+	int i, used, ret;
+
+	used = 0;
+	for (i = 0; i < argc; i++) {
+		if (str_has_suffix(argv[i], ":%pd")) {
+			char *tmp = kstrdup(argv[i], GFP_KERNEL);
+			char *equal;
+
+			if (!tmp)
+				return -ENOMEM;
+
+			equal = strchr(tmp, '=');
+			if (equal)
+				*equal = '\0';
+			tmp[strlen(argv[i]) - 4] = '\0';
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


