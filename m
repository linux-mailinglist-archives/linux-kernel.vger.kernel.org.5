Return-Path: <linux-kernel+bounces-73899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CA85CD60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078572848F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768843FE0;
	Wed, 21 Feb 2024 01:18:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E91FBF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478298; cv=none; b=BkBi8UUW6ehOPQVbf6bckzAM5SI1GO/RdzA4uPrVkweYR1/5zYplkwjMV+YPHnxOUK0UvYuYGE7aN9DA7H8HshlB7ORX+VEkCLWPknSek4qJvrrHU2KmEMSWLg63z8mvNGHaVKnVpUJBBUjksk2CK0YCujHYA2B71ks7H6BISW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478298; c=relaxed/simple;
	bh=iEm71T6gEzS4iOJpNt3i4b/pIzZx55+2d+g9DQ+IKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XGefX2ef3KNQCxfFWVz/8Ls94xF2PFwd8JanZaXB+NidI9s1faAc8OqHVQTGcDp7JaWzAg+LcBiCHCY4grN2euIHv0uzfwDUH+qXDPqyoThrVCdCW2ZcK0yNzkwUrHeF6ObHgOPHFlZ0X0nErCre1ySZpKFIO5nImFYKjsuoMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99760C43390;
	Wed, 21 Feb 2024 01:18:16 +0000 (UTC)
Date: Tue, 20 Feb 2024 20:20:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri
 Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/clock: Make local_clock() notrace
Message-ID: <20240220202002.38fec245@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The "perf" clock in /sys/kernel/tracing/trace_clock enables local_clock(),
where on machines that have CONFIG_HAVE_UNSTABLE_SCHED_CLOCK set is a
normal function. This function can be traced.

I found that enabling the "perf" clock on some debug configs and running
function tracer can live lock the machine. That is, it goes so slow that
nothing moves forward.

Cc: stable@vger.kernel.org
Fixes: fb7d4948c4da2 ("sched/clock: Provide local_clock_noinstr()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/sched/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 3c6193de9cde..af8b698dee8c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -308,7 +308,7 @@ noinstr u64 local_clock_noinstr(void)
 	return clock;
 }
 
-u64 local_clock(void)
+notrace u64 local_clock(void)
 {
 	u64 now;
 	preempt_disable_notrace();
-- 
2.43.0


