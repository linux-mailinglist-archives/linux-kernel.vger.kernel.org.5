Return-Path: <linux-kernel+bounces-82157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE441868004
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83665B23A81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2D12FB2D;
	Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5812F366
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973271; cv=none; b=CntxigCjstfrleyTmRQ+4l0m6V7eMxvOTLXC8FqYElq15qK5oJ8iuwClY2FCO5Jb6ouxi/ZEl8OXNzdUY7CGIMflWIBOmBqdIGjaw5eFm038ZkSETSZqqCV6R3Oyg/rMU8AQqKpmBS1DQvsGPFji/haCTk/zgEdMoBfyCiWy8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973271; c=relaxed/simple;
	bh=HhCGbYUvJpsjVhZrwqg9MzrWJrNfc26aXG/vEKAtQdY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UgKO3uSo6fOVmK9NpkRbl0sl2jd8jCl8WPSDlLEJi3uao6Y2wnOdhniYtUg4x+NXQsMM+GkfFIqQmajCjx4sYMImSjdfXov5t700U+tEcAXXytBqD2RADHfxZc1efhK50IQQAZpSEkTsn7zOm2FDIe6+iAFwO+yvkHVwK3qVp+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1F1C43394;
	Mon, 26 Feb 2024 18:47:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1reg2x-000000090aR-1AML;
	Mon, 26 Feb 2024 13:49:51 -0500
Message-ID: <20240226184951.137652037@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 26 Feb 2024 13:49:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/5] tracing: Add __string_len() example
References: <20240226184932.303400070@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's no example code that uses __string_len(), and since the sample
code is used for testing the event logic, add a use case.

Link: https://lore.kernel.org/linux-trace-kernel/20240223152827.5f9f78e2@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/trace_events/trace-events-sample.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index f2d2d56ce8e2..2dfaf7fc7bfa 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -303,6 +303,7 @@ TRACE_EVENT(foo_bar,
 		__bitmask(	cpus,	num_possible_cpus()	)
 		__cpumask(	cpum				)
 		__vstring(	vstr,	fmt,	va		)
+		__string_len(	lstr,	foo,	bar / 2 < strlen(foo) ? bar / 2 : strlen(foo) )
 	),
 
 	TP_fast_assign(
@@ -311,12 +312,13 @@ TRACE_EVENT(foo_bar,
 		memcpy(__get_dynamic_array(list), lst,
 		       __length_of(lst) * sizeof(int));
 		__assign_str(str, string);
+		__assign_str(lstr, foo);
 		__assign_vstr(vstr, fmt, va);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -360,7 +362,8 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
-		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpum),
+		  __get_str(str), __get_str(lstr),
+		  __get_bitmask(cpus), __get_cpumask(cpum),
 		  __get_str(vstr))
 );
 
-- 
2.43.0



