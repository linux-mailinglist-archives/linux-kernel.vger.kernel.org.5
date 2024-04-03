Return-Path: <linux-kernel+bounces-129283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1E896836
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7463328B2E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F184D05;
	Wed,  3 Apr 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MND/xHM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACD823DF;
	Wed,  3 Apr 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131712; cv=none; b=S48V1bhV10+i7NqaZpvu9nx4CTPU8/FzLEP0XRiIwIS0b+q8ZfU7D49T7/qLpjbFdSUikZIRRLCa/yE6KsLCW8jQfcVJliO3mUx84DyhcnAwPaGcoVGx6I9evQO1Hinifc7BD/67I1Fs3aU1tajk1R0QPdZ1V5tQPpoCcM84DKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131712; c=relaxed/simple;
	bh=l8thGNKJJbETb0CvQ4KQ0CUGk7po5gBhYYwAGbPFY2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9FctXtTzcjzNiKIHsMqVuTU+DRBedbizp3VzJJSdAS2PJNgTIfqJvmeS9og7B9YmGN3FFemBZfQIHBUKEOX3Zq8VWOt0xq0pyotP0EJnxhBokmsA+sZkK5GfMHGK/51CXAFPgD7X1XwtoyoHfL4n/McXQJ0U+L9ugCqx90biNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MND/xHM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4245AC433C7;
	Wed,  3 Apr 2024 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131712;
	bh=l8thGNKJJbETb0CvQ4KQ0CUGk7po5gBhYYwAGbPFY2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MND/xHM6qa2MiY9G7TJkiu2MvxTqZkG72ygQajBZtSk5mFy4ofP3WGbUTtdwp8qK1
	 UGLOouFC0JA6sgN3lgR6X1zdD3e+EjwLhuqnzPAn1lLtkxREZqOBYdz12TTokECuLE
	 D0DZwJj0vWebcFS679BeDWzLOr8p4VEI1DNWcat81AK7BdJMSgYJWvHZz2nPdKCf2f
	 2ErVqjTKG647fLlxfy7JOGODAQWrLsByzOc2FlmGnzGm6lYNJ0fW16Sf+DZBxEsjl+
	 IXFdaCXcVAVMSR7l1/kjYCSAjOmDvnLCN5BzOKCvRFDx7x2lzvsz6eKHHWieOUMsUA
	 lFZD2M2Ec4kqQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Ajay Kaher <akaher@vmware.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 06/34] tracing: hide unused ftrace_event_id_fops
Date: Wed,  3 Apr 2024 10:06:24 +0200
Message-Id: <20240403080702.3509288-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_PERF_EVENTS, a 'make W=1' build produces a warning about the
unused ftrace_event_id_fops variable:

kernel/trace/trace_events.c:2155:37: error: 'ftrace_event_id_fops' defined but not used [-Werror=unused-const-variable=]
 2155 | static const struct file_operations ftrace_event_id_fops = {

Hide this in the same #ifdef as the reference to it.

Fixes: 620a30e97feb ("tracing: Don't pass file_operations array to event_create_dir()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace_events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7c364b87352e..52f75c36bbca 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1670,6 +1670,7 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -1684,6 +1685,7 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
 }
+#endif
 
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
@@ -2152,10 +2154,12 @@ static const struct file_operations ftrace_event_format_fops = {
 	.release = seq_release,
 };
 
+#ifdef CONFIG_PERF_EVENTS
 static const struct file_operations ftrace_event_id_fops = {
 	.read = event_id_read,
 	.llseek = default_llseek,
 };
+#endif
 
 static const struct file_operations ftrace_event_filter_fops = {
 	.open = tracing_open_file_tr,
-- 
2.39.2


