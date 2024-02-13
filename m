Return-Path: <linux-kernel+bounces-64519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1639853FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40A11C27CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604FC634F4;
	Tue, 13 Feb 2024 23:13:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DF6340F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865990; cv=none; b=UY0tbgUNxWDzuXvRn1Gq5rwQeSrt6PfgseqeV3czCol5SiK36ul4vx+AIdVgYsdgD2lHVWibTAU/FnU3bUmnLkF+JS586fXWbxMolDANSwFvxVrsElf7hFRhw3mF/HOj/VH3eO+1n3Ldoa2Mtq8rSgacpyK2b7eh9yw5MkkVDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865990; c=relaxed/simple;
	bh=nLoRFPBJnfn59rTSLi0Dv6V2IC37p4t5fbYO1zZOBXk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fFuqMULlFQA5AonNP1Hw+YP9MWg/c/6cUfPB9haOyZecNsnq5Sh51q+tK0HgGJlopFKOC0jtoUxJGlr1IcpFKthzV6G5NO7/c4baNIVDj2LkKiJd15+ibYATl6WX27sqYC9z9wgMntmjykyVC9W/scrtuYApK8V+RmMfNuMKW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88251C433A6;
	Tue, 13 Feb 2024 23:13:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1ra1z5-000000009Er-3nbe;
	Tue, 13 Feb 2024 18:14:39 -0500
Message-ID: <20240213231439.765101665@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 13 Feb 2024 18:14:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mete Durlu <meted@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Subject: [for-linus][PATCH 2/2] tracing: Use ring_buffer_record_is_set_on() in tracer_tracing_is_on()
References: <20240213231413.726507543@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sven Schnelle <svens@linux.ibm.com>

tracer_tracing_is_on() checks whether record_disabled is not zero. This
checks both the record_disabled counter and the RB_BUFFER_OFF flag.
Reading the source it looks like this function should only check for
the RB_BUFFER_OFF flag. Therefore use ring_buffer_record_is_set_on().
This fixes spurious fails in the 'test for function traceon/off triggers'
test from the ftrace testsuite when the system is under load.

Link: https://lore.kernel.org/linux-trace-kernel/20240205065340.2848065-1-svens@linux.ibm.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Tested-By: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9ff8a439d674..aa54810e8b56 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1532,7 +1532,7 @@ void disable_trace_on_warning(void)
 bool tracer_tracing_is_on(struct trace_array *tr)
 {
 	if (tr->array_buffer.buffer)
-		return ring_buffer_record_is_on(tr->array_buffer.buffer);
+		return ring_buffer_record_is_set_on(tr->array_buffer.buffer);
 	return !tr->buffer_disabled;
 }
 
-- 
2.43.0



