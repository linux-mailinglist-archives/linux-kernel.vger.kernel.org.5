Return-Path: <linux-kernel+bounces-100863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD79879E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EE21F23169
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB389144032;
	Tue, 12 Mar 2024 22:20:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFED143C55;
	Tue, 12 Mar 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282016; cv=none; b=WZTR6+8hR+bZoGvtsC6cmoR3t3HTaGu4cfMIIPm8zHrZK3sx5waAnfftuR4albekoftcO51RmuViq+xu+46ZJ2AgubLUI2Nko3+3PIHjQDM8AGiZ0teHhNhXPnMmO6RDCpAO/YNgVoZ8vcxUd/2Flx59cHYvg+Jg4CWyGfMqyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282016; c=relaxed/simple;
	bh=TSBRmWHLr0SGqUGFd2L8+MAp2CKujDiQ/g+2if5GuIU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=swNvxrLxpkPawv/BjK1+coaFD0qK1xU5E8lqzsXlC+zje7HJxecOk2c7S2klb6IO+Jt4BKVdtTEsY/fQoo12YtqqZ5Hvi0dSgrEUPxMF1z3oEkF7kevdD9K4hFf8LKGKro9nrJskk3V7CRrxH/bW4cSrl/fgFp2+ux+Nyd4V710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD089C43390;
	Tue, 12 Mar 2024 22:20:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rkAVr-000000022K1-1Jhj;
	Tue, 12 Mar 2024 18:22:23 -0400
Message-ID: <20240312222223.172849855@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 18:21:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 1/5] ring-buffer: Do not set shortest_full when full target is hit
References: <20240312222059.823191689@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The rb_watermark_hit() checks if the amount of data in the ring buffer is
above the percentage level passed in by the "full" variable. If it is, it
returns true.

But it also sets the "shortest_full" field of the cpu_buffer that informs
writers that it needs to call the irq_work if the amount of data on the
ring buffer is above the requested amount.

The rb_watermark_hit() always sets the shortest_full even if the amount in
the ring buffer is what it wants. As it is not going to wait, because it
has what it wants, there's no reason to set shortest_full.

Link: https://lore.kernel.org/linux-trace-kernel/20240312115641.6aa8ba08@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aa332ace108b..6ffbccb9bcf0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -834,9 +834,10 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
 		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
 		ret = !pagebusy && full_hit(buffer, cpu, full);
 
-		if (!cpu_buffer->shortest_full ||
-		    cpu_buffer->shortest_full > full)
-			cpu_buffer->shortest_full = full;
+		if (!ret && (!cpu_buffer->shortest_full ||
+			     cpu_buffer->shortest_full > full)) {
+		    cpu_buffer->shortest_full = full;
+		}
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
 	return ret;
-- 
2.43.0



