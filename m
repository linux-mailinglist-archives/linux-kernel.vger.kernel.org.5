Return-Path: <linux-kernel+bounces-78460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4A8613C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DA52851CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D382D67;
	Fri, 23 Feb 2024 14:17:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60C81AAD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697829; cv=none; b=SXCWr/5YIhaJDgPxC3J8fcVPjgLdgdGR1tNmL+/CrC2ygPXtSbF7yc+h/sXQ/U2vGHVKFb/oRi+VX0QTqqAkGmd/XSKsg37oT5XpLJqaQjvwEsy+Rj/sbPm9uJj4NPByoP2xY6RvaaxjJLDuIvkCEGN90CZWCeGdC+NTxYFuyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697829; c=relaxed/simple;
	bh=9g5M/uPrmYOSZQw75hsZotn5/TImjS5Rj6S+jNoXasQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oE/LOKi3rX/Z54CZ1Jm201r+ifv1w55+1rEWsYDM2zxv78o+217jXdg5Dsj9+xxf5loHVu4CKDLZq+459F6nGmb2n8mSBeDyXupUbYWYaMtd+kCW8cjsY9zGHbGmCZnTXVR4YaLlZzvOoqQnYQGyFzHJZo4+kP7Oc+uRVp6mzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7096BC43330;
	Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOE-000000077NC-1ZH5;
	Fri, 23 Feb 2024 09:19:02 -0500
Message-ID: <20240223141902.230675644@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Garry <john.g.garry@oracle.com>
Subject: [for-next][PATCH 05/13] tracing: Use init_utsname()->release
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: John Garry <john.g.garry@oracle.com>

Instead of using UTS_RELEASE, use init_utsname()->release, which means that
we don't need to rebuild the code just for the git head commit changing.

Link: https://lore.kernel.org/linux-trace-kernel/20240222124639.65629-1-john.g.garry@oracle.com

Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8fdd68dbcf6d..f56b3275c676 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -13,7 +13,7 @@
  *  Copyright (C) 2004 Nadia Yvette Chambers
  */
 #include <linux/ring_buffer.h>
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 #include <linux/stacktrace.h>
 #include <linux/writeback.h>
 #include <linux/kallsyms.h>
@@ -4133,7 +4133,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	get_total_entries(buf, &total, &entries);
 
 	seq_printf(m, "# %s latency trace v1.1.5 on %s\n",
-		   name, UTS_RELEASE);
+		   name, init_utsname()->release);
 	seq_puts(m, "# -----------------------------------"
 		 "---------------------------------\n");
 	seq_printf(m, "# latency: %lu us, #%lu/%lu, CPU#%d |"
-- 
2.43.0



