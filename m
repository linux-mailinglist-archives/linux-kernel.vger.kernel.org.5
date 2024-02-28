Return-Path: <linux-kernel+bounces-85628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15586B86E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119D91F27D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A165E06B;
	Wed, 28 Feb 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1iFGEj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F55E074;
	Wed, 28 Feb 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149110; cv=none; b=ixqUwtTl2ml/mM8JNU5ovjJX+35XW81gmD8QYFWfc0B9xZAb8YIbLL0S17Us4gHT0BpqyX2t4Gi7HMZb+9v0E4N5wW0g2laCetpq/frD4AnT5y3STD8YbpDVGtc9IxgT5Fxrfccsp4WK8PSV6S+sbjs8WbgfKOsKPsbgv2q05OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149110; c=relaxed/simple;
	bh=HKsFoZKnJ34YSBFn9vTGSnBy8Xop5g9WIhcVbvX1B6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PlLGcavv2I/hTYDkl/aDk6B7vHhQVQzPFCP3omfDXkgF5o2V9H3S8v72FbpplNEjAXvVAqAKR5qLkfOi2BcFUeNCVx4sTqZRj/IeHS059FTACkYCY/9DauiT0bM+zuIMi/+I6aseNuqEswKyCUdZ58HXssSgaCYPfiRKupOfao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1iFGEj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1245C433C7;
	Wed, 28 Feb 2024 19:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709149109;
	bh=HKsFoZKnJ34YSBFn9vTGSnBy8Xop5g9WIhcVbvX1B6E=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=b1iFGEj+idZwyXYGELoyOx0I31GFrOItcdTvZYjxdyO8tk9y57qABVza2+j3QCN0H
	 A29rheh2pPAOD49LuBeKJpJIqBBsYQa97eta4qmyyyfNyNhFvTXmL1NiL27dQpYkeG
	 FpR0WCG3KxMCRt9W3nG2R9CiBg5Rb7P7Sc7cgRW6Iy+mfGbB8MqdrCj2FFyqzbT6lj
	 rDOscHOOnD6zgn+kJIvDlbEu+cxpOlQlplajPzfJvhTud8avA79bTKBaafKxVcxPVt
	 i7k/NQc6vs8sA+USwz3sxgYWDkBsxqpEl7RKPqFcc8uqzEk1GRqzCp/XkOGbYlQz34
	 BbIKnWc2aq51Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F340CE03F3; Wed, 28 Feb 2024 11:38:29 -0800 (PST)
Date: Wed, 28 Feb 2024 11:38:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@meta.com
Subject: [PATCH RFC ftrace] Chose RCU Tasks based on TASKS_RCU rather than
 PREEMPTION
Message-ID: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
might see the occasional preemption, and that this preemption just might
happen within a trampoline.

Therefore, update ftrace_shutdown() to invoke synchronize_rcu_tasks()
based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.

Only build tested.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <linux-trace-kernel@vger.kernel.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2da4eaa2777d6..c9e6c69cf3446 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3156,7 +3156,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		 * synchronize_rcu_tasks() will wait for those tasks to
 		 * execute and either schedule voluntarily or enter user space.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_TASKS_RCU))
 			synchronize_rcu_tasks();
 
 		ftrace_trampoline_free(ops);

