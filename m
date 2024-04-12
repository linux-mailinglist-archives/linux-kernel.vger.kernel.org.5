Return-Path: <linux-kernel+bounces-142726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB6E8A2F69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356DC282DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C582D91;
	Fri, 12 Apr 2024 13:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EB824AD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928572; cv=none; b=um5pHqbknU1XRa8Wh6TtKPK7HyNowDGIl9xfKKn2HCCEfucqzKk9kN73UscDAqkkB/ov99YwGATZVsGqcMXME+VRy9OSel9N7Lf9PH5mr3qEL5n9a6Yu+J9x70Oq/TmKShERSpxCSXLTZhCMrLuw5JA+UfK/tddkrmQNwwhAhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928572; c=relaxed/simple;
	bh=s92Y7fSnYxp/hAB13hJr+ejV7YBDYEZNITD0UOK91uE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DaqwizNwwrpRfQc3wWRjF2yg9dnExiY9okh+l0bu/nhh/wczuv/sryDjnCeYLddz3UMTw5cKesihN+CR1Wv7t27ORtlWzidb8H8jGdGupiy0NFxqGtZ4+nugfkGej979hT3+uefFbdOZih53a508CPzGZrKdfOvzYRcrFjdG7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633EFC32786;
	Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rvH0o-000000012qQ-1Czq;
	Fri, 12 Apr 2024 09:32:14 -0400
Message-ID: <20240412133214.151885304@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 12 Apr 2024 09:31:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Kees Cook <keescook@chromium.org>,
 Ajay Kaher <akaher@vmware.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [for-linus][PATCH 3/4] tracing: hide unused ftrace_event_id_fops
References: <20240412133152.723632549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_PERF_EVENTS, a 'make W=1' build produces a warning about the
unused ftrace_event_id_fops variable:

kernel/trace/trace_events.c:2155:37: error: 'ftrace_event_id_fops' defined but not used [-Werror=unused-const-variable=]
 2155 | static const struct file_operations ftrace_event_id_fops = {

Hide this in the same #ifdef as the reference to it.

Link: https://lore.kernel.org/linux-trace-kernel/20240403080702.3509288-7-arnd@kernel.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Clément Léger <cleger@rivosinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Fixes: 620a30e97feb ("tracing: Don't pass file_operations array to event_create_dir()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.43.0



