Return-Path: <linux-kernel+bounces-157088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998998B0CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EF11F23EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6AD15EFB0;
	Wed, 24 Apr 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+F1XyJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B215ECF3;
	Wed, 24 Apr 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969427; cv=none; b=oBg/GNpqGpzv4Ec5kMZB65KFWIKTl5krfQJA2sX8zoAy2ly35S0w2hokKgdopU+QRdaH7fX4oj38fLVmscernjJINDrA9/8m5io1/T69omzUKscsvwL73i1W41Pajn7TAX3+E8m1uvbfo7SfDVdErTL/PWwFkErhT4hCvjdPhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969427; c=relaxed/simple;
	bh=k6zY+8OIqG3hvgbnxVfHVa3Ek+C1GSXe4a2L4RdgdEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4p/RcWZ1zCAN8/6K8+1ZXT88uax8P6zRTd8D19oH7cVci5oo0B60WzLqC8ppr1Jd0SEqbiDldnn7IJNhaHs+UMXFAb2SJv5Bdsgd8Ssvb/7Dn8W3hT+e6AFutJbXkDKji97u1mg1ZRX2UnFcjsYxXiaBFNPxqq+JmiOi+21sn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+F1XyJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08FC113CD;
	Wed, 24 Apr 2024 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969427;
	bh=k6zY+8OIqG3hvgbnxVfHVa3Ek+C1GSXe4a2L4RdgdEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+F1XyJnBAnkc7gMGRYlCJFwpBgbkGE0SW36ugHTAwN/bG8lgwRhTmdfnTGyVdupS
	 THlpUvl3MZVQJ0vnc+mjzkKT30t9vfj7vc3mHA7GZV4cLlGSBA5Nlk0lCGuzPynoMA
	 lc28IawaXFrOl9rm1vOA68HUUEW4d2+F3FHLIGKiK6uLigTWvPvWiHnaw5pP0yHAoP
	 IWPua28+RGj6IvY1W8UZ4sqzpofBmorsbPcnvYEkp+6W0C9FD4OuSkXbxRS/Qls8Px
	 yhePsHLxoB30PP2WZJ2P7yhKuGejQZtyClOMmSbU3Lz6apmPfQ7fas5wNw0ZIuOSXH
	 tC7Tv0Ju+AQqQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/8] rtla/timerlat: Simplify "no value" printing on top
Date: Wed, 24 Apr 2024 16:36:50 +0200
Message-ID: <0a4d8085e7cd706733a5dc10a81ca38b82bd4992.1713968967.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713968967.git.bristot@kernel.org>
References: <cover.1713968967.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of printing three times the same output, print it only once,
reducing lines and being sure that all no values have the same length.

It also fixes an extra '\n' when running the with kernel threads, like
here:

     =============== %< ==============
                                      Timer Latency

   0 00:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
 CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
   2 #0         |        -         -         -         - |      161       161       161       161
   3 #0         |        -         -         -         - |      161       161       161       161
   8 #1         |       54        54        54        54 |        -         -         -         -'\n'

 ---------------|----------------------------------------|---------------------------------------
 ALL #1      e0 |                 54        54        54 |                161       161       161
     =============== %< ==============

This '\n' should have been removed with the user-space support that
added another '\n' if not running with kernel threads.

Cc: stable@vger.kernel.org
Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8a3fa64319c6..2665e0bb5f1e 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -212,6 +212,8 @@ static void timerlat_top_header(struct osnoise_tool *top)
 	trace_seq_printf(s, "\n");
 }
 
+static const char *no_value = "        -";
+
 /*
  * timerlat_top_print - prints the output of a given CPU
  */
@@ -239,10 +241,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
 
 	if (!cpu_data->irq_count) {
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - |");
+		trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, no_value, no_value);
 	} else {
 		trace_seq_printf(s, "%9llu ", cpu_data->cur_irq / params->output_divisor);
 		trace_seq_printf(s, "%9llu ", cpu_data->min_irq / params->output_divisor);
@@ -251,10 +250,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	}
 
 	if (!cpu_data->thread_count) {
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        -\n");
+		trace_seq_printf(s, "%s %s %s %s", no_value, no_value, no_value, no_value);
 	} else {
 		trace_seq_printf(s, "%9llu ", cpu_data->cur_thread / divisor);
 		trace_seq_printf(s, "%9llu ", cpu_data->min_thread / divisor);
@@ -271,10 +267,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	trace_seq_printf(s, " |");
 
 	if (!cpu_data->user_count) {
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        - ");
-		trace_seq_printf(s, "        -\n");
+		trace_seq_printf(s, "%s %s %s %s\n", no_value, no_value, no_value, no_value);
 	} else {
 		trace_seq_printf(s, "%9llu ", cpu_data->cur_user / divisor);
 		trace_seq_printf(s, "%9llu ", cpu_data->min_user / divisor);
-- 
2.44.0


