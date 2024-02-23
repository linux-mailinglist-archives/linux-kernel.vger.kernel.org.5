Return-Path: <linux-kernel+bounces-79103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5D861D98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF681F21ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6B146E9F;
	Fri, 23 Feb 2024 20:26:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5B146E96;
	Fri, 23 Feb 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719995; cv=none; b=j0aX18qISt5sZdjy0G/QPxkmycampUByT3Rn81k807jAQYeVARywstS4aRpzKujX0Qr8D53j9EdVRtiUJ6jp03lGhl2Smrl3jGfRpgJdgFqjr65JxKPKbgYH0HH5kxUgrkpLjHS0lQvptlSMwoU2OWG2zM+0hVlVOM96TRBtU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719995; c=relaxed/simple;
	bh=BKjk2drUibhKGcus9h79n6m+U1rXszg3UpQTrvBjVCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J3bE/IUfKkFC9fyGzFlAYRFs3lE/0Z1LPdI35lhZMt558vRFqnnENp0rEOnFEqmiCICkQRMK9hF8H6BTJnDdygrSsRIyCeQzkPfOOKUSkko/BLDc38IxwnIeKw4pQP2+ThvtTgmhEc7p5iE2CtSIj43jN+tnDlSqbRlRhma6URw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCBFC43399;
	Fri, 23 Feb 2024 20:26:34 +0000 (UTC)
Date: Fri, 23 Feb 2024 15:28:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Add __string_len() example
Message-ID: <20240223152827.5f9f78e2@gandalf.local.home>
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

There's no example code that uses __string_len(), and since the sample
code is used for testing the event logic, add a use case.

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


