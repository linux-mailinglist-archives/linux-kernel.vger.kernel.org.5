Return-Path: <linux-kernel+bounces-78465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FE8613CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6553DB21AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0184A32;
	Fri, 23 Feb 2024 14:17:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3B823D9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697830; cv=none; b=PkyqrRVIRGLfQqMOmEhw8l/8bVL7/PrhzfZ2c7hkUiQuXZbSgMpgy6MAWeuBuw7MwwjtDE7mCtmNWU2VDpoqsXeM6OROOuNQy2thyjdL4p2GAeX40DOSfFqzcQQyBcQzob73/tJfoApaI5/jnMjMyrUCTlzGN37PPwxX20bRuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697830; c=relaxed/simple;
	bh=SSAkBsKZDXS3J7H5zDJ3fM4StROONFq7WOqxGyruuNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JlqaSG1tA/xd47yOlaOmX2UFbXGjNm92lgBga0dgbp8WFFNVrSLccWhZfZhaKL38tVJ9efe0YsPgn68Q1HImqUiY7j0X3H7Sz1fYc4VdYtEx+VzZVHqMm1/goLW+yhYUCfgR/4CQGwthXahSBt0AARjPdXXPODzp1jA9xT0c4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E06C43142;
	Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOF-000000077Qf-23xN;
	Fri, 23 Feb 2024 09:19:03 -0500
Message-ID: <20240223141903.347912102@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 12/13] tracing: Fix snapshot counter going between two tracers that use it
References: <20240223141838.985298316@goodmis.org>
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

Link: https://lore.kernel.org/linux-trace-kernel/20240223013344.570525723@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Fixes: 16f7e48ffc53a ("tracing: Add snapshot refcount")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f56b3275c676..1bcfbc21fb3e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6148,7 +6148,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		tracing_disarm_snapshot(tr);
 	}
 
-	if (t->use_max_tr) {
+	if (!had_max_tr && t->use_max_tr) {
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
 			goto out;
-- 
2.43.0



