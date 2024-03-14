Return-Path: <linux-kernel+bounces-103383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC8D87BEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4794F287C61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7270CA3;
	Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF46FE0D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426084; cv=none; b=Ip6k00wM/pNONuzfDJkmNMKfMpJmM59WelPQAlrPGlmGx2pYbzHEXKQ/4hC2eFZ1zjp+8JQ4YRWB38u+0Ib92/qWkb/w9Eqdy4WsxyCrF9CkQbZ7YopIU5reqkN2r8L/WLc0dUoK8F205uy64pwiB6QvPq2X5rEndWxhUGcaF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426084; c=relaxed/simple;
	bh=6FabPEmpFyErLk7bCi4d6jupuxTDRYUNdQe7UwgjFms=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K/eYb0c2AYXj4Ux9GJXdAnkl1A4ElUNPrCW+c8oLLBN9RV1gOg3m+QbEZnBXSLzI8TRuPUJmMNv/F+LrL1UGzJY+ND/1qmA7bcziA5hTiy65+UHyJx72byANGDKgVVkg7sGHLq/u9C7QLQcd1usqcecnJZ+kDyObe+n3NBdKf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5CEC43399;
	Thu, 14 Mar 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rklzb-00000002ddy-0ftb;
	Thu, 14 Mar 2024 10:23:35 -0400
Message-ID: <20240314142335.022580885@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 14 Mar 2024 10:23:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
Subject: [for-next][PATCH 3/8] tracing: Use div64_u64() instead of do_div()
References: <20240314142301.170713485@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@toblux.com>

Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.

Compared to do_div(), div64_u64() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Link: https://lore.kernel.org/linux-trace-kernel/20240225164507.232942-2-thorsten.blum@toblux.com

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_benchmark.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 54d5fa35c90a..811b08439406 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -92,7 +92,6 @@ static void trace_do_benchmark(void)
 	bm_total += delta;
 	bm_totalsq += delta * delta;
 
-
 	if (bm_cnt > 1) {
 		/*
 		 * Apply Welford's method to calculate standard deviation:
@@ -105,7 +104,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	do_div(delta, bm_cnt);
+	delta = div64_u64(delta, bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {
@@ -127,7 +126,7 @@ static void trace_do_benchmark(void)
 			seed = stddev;
 			if (!last_seed)
 				break;
-			do_div(seed, last_seed);
+			seed = div64_u64(seed, last_seed);
 			seed += last_seed;
 			do_div(seed, 2);
 		} while (i++ < 10 && last_seed != seed);
-- 
2.43.0



