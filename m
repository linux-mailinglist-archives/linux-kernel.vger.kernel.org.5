Return-Path: <linux-kernel+bounces-77628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E813E860840
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D2F1F23D39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FFB666;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB7947A;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651913; cv=none; b=ln4vu36wAu5+SQCI5K3clWmjcb9b6bxw34N/v+loxJudjW5MVOo6r6/DSniul6597bkBEJ/C8PX7wWHKlUsbptiXKiO5IxfL8QaWv/s0ZIGx/yypp7mO84LSHNeHFJRE/xsxhOw2osEtnGqlk7uN7a5wg+R+NL4b78w9ji++eaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651913; c=relaxed/simple;
	bh=2Ho0hHkQMrTftOpqELU+854wFjDx4nQbuKE5ycj4g5g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XMbeaQWxorxEfzszs0UTqjaQIDmXS23Dnsiq++q1QRjDLgiPMGIn6jRpAd3pfXvu0/4fuT31HOCSnt4oghXRvfD4GoXZ8yokAvLKWWnxmYlQky0Q5yFjKNFmyBdBOvw1b7wFxfaiWf0eBD3soj+Yaa8mNxBvrEwuoGPA4AtL5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1382C433F1;
	Fri, 23 Feb 2024 01:31:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdKRc-00000006og7-2y8r;
	Thu, 22 Feb 2024 20:33:44 -0500
Message-ID: <20240223013344.570525723@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 20:33:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH 1/2] tracing: Fix snapshot counter going between two tracers that use it
References: <20240223013323.798805901@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Running the ftrace selftests caused the ring buffer mapping test to fail.
Investigating, I found that the snapshot counter would be incremented
every time a tracer that uses the snapshot is enabled even if the snapshot
was used by the previous tracer.

That is:

 # cd /sys/kernel/tracing
 # echo wakeup_rt > current_tracer
 # echo wakeup_dl > current_tracer
 # echo nop > current_tracer

would leave the snapshot counter at 1 and not zero. That's because the
enabling of wakeup_dl would increment the counter again but the setting
the tracer to nop would only decrement it once.

Do not arm the snapshot for a tracer if the previous tracer already had it
armed.

Fixes: 16f7e48ffc53a ("tracing: Add snapshot refcount")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b7a870c8ae2a..480201c3b36e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6164,7 +6164,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		tracing_disarm_snapshot(tr);
 	}
 
-	if (t->use_max_tr) {
+	if (!had_max_tr && t->use_max_tr) {
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
 			goto out;
-- 
2.43.0



