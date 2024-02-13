Return-Path: <linux-kernel+bounces-64517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB9853FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC241C27D96
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6F634E4;
	Tue, 13 Feb 2024 23:13:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F856340A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865989; cv=none; b=Zl1ztmwWuBDx0qTqwoaeDt5iVDISwnd89sDkHSPWzRzbhBfF/K1UhkcBFrRAxc2oPTjKyPud20gnObAvuPI70xrDScqAYtQcz8gcRdVYBLnpW4hJm5b9DfUjJBCKsVS8Ut/SVuzOIXL7oXh9M5VNVWRtdjl6VEKDyh+RHRbpnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865989; c=relaxed/simple;
	bh=yLo7Vk9hD2t0eJ/1xt7wIqizBwtv5M+HWIQZsobPz2U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aV/RA/LhegAYODomSh4Pbd9ibLp7Crp70Jb2B7PFykFZk98DLgyXouzEIzShVrRjiiiXqHOvRLYHe9KDEHsV9RdyHjXgG4C8g0l7CjrsvzQ1uxWYIhTESe3on9fCqv1ajPO95/JeaNMzbX7yQP5CBV9W8FyOxUGvKjJ9dj2OVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B1C433C7;
	Tue, 13 Feb 2024 23:13:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1ra1z5-000000009EN-382x;
	Tue, 13 Feb 2024 18:14:39 -0500
Message-ID: <20240213231439.611753281@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 13 Feb 2024 18:14:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 1/2] tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef
References: <20240213231413.726507543@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Petr Pavlu <petr.pavlu@suse.com>

Commit a8b9cf62ade1 ("ftrace: Fix DIRECT_CALLS to use SAVE_REGS by
default") attempted to fix an issue with direct trampolines on x86, see
its description for details. However, it wrongly referenced the
HAVE_DYNAMIC_FTRACE_WITH_REGS config option and the problem is still
present.

Add the missing "CONFIG_" prefix for the logic to work as intended.

Link: https://lore.kernel.org/linux-trace-kernel/20240213132434.22537-1-petr.pavlu@suse.com

Fixes: a8b9cf62ade1 ("ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c060d5b47910..83ba342aef31 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5331,7 +5331,7 @@ static int register_ftrace_function_nolock(struct ftrace_ops *ops);
  * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
  * jumps from ftrace_caller for multiple ftrace_ops.
  */
-#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 #else
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
-- 
2.43.0



