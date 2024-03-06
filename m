Return-Path: <linux-kernel+bounces-94439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96AC873FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41941C22134
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AA113E7E7;
	Wed,  6 Mar 2024 18:41:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACF13BAF5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750509; cv=none; b=CZ1NFILpvLuU/OJTD14t96odUZ4fO+RWjusEokW8qBs8BfIpTkI5HPYT/kiaengPVeA4VCTfLDMgfDrsspWSEV635lWd1ec3lEuh6x9hoAQJARGPF0eDJrJsdK8latAXHIEmPRHev+U07qRo/CYCpacHz+wd8ZlOs+rIl5+xN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750509; c=relaxed/simple;
	bh=gvvazBn6Ji928ngeVXDVmIWNh1/O7Kz/cGCBfkdeFE8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B8nbq5SVxFLjQne8NeC0+8Pj0gOsMXlWAcbWh3g+DjivRCfjOZPxMtj/DMONvHDZmdBaIYCjI7a+ZfWrzQm/nWHAVNvn3+UmlBLYieE3XN67x5MDkHPIsfKr2lStKoQCD5jd5Zz8sP0y1BAghP4gx9e7hPOIlw/6x01viEzSnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4CC433A6;
	Wed,  6 Mar 2024 18:41:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhwEw-00000000YAE-3DPw;
	Wed, 06 Mar 2024 13:43:42 -0500
Message-ID: <20240306184342.625779901@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 06 Mar 2024 13:42:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: [for-linus][PATCH 2/3] tracing: Limit trace_seq size to just 8K and not depend on
 architecture PAGE_SIZE
References: <20240306184244.754263547@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The trace_seq buffer is used to print out entire events. It's typically
set to PAGE_SIZE * 2 as there's some events that can be quite large.

As a side effect, writes to trace_marker is limited by both the size of the
trace_seq buffer as well as the ring buffer's sub-buffer size (which is a
power of PAGE_SIZE). By limiting the trace_seq size, it also limits the
size of the largest string written to trace_marker.

trace_seq does not need to be dependent on PAGE_SIZE like the ring buffer
sub-buffers need to be. Hard code it to 8K which is PAGE_SIZE * 2 on most
architectures. This will also limit the size of trace_marker on those
architectures with greater than 4K PAGE_SIZE.

Link: https://lore.kernel.org/all/20240302111244.3a1674be@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20240304191342.56fb1087@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_seq.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 9ec229dfddaa..1ef95c0287f0 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -9,9 +9,15 @@
 /*
  * Trace sequences are used to allow a function to call several other functions
  * to create a string of data to use.
+ *
+ * Have the trace seq to be 8K which is typically PAGE_SIZE * 2 on
+ * most architectures. The TRACE_SEQ_BUFFER_SIZE (which is
+ * TRACE_SEQ_SIZE minus the other fields of trace_seq), is the
+ * max size the output of a trace event may be.
  */
 
-#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
+#define TRACE_SEQ_SIZE		8192
+#define TRACE_SEQ_BUFFER_SIZE	(TRACE_SEQ_SIZE - \
 	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
 
 struct trace_seq {
-- 
2.43.0



