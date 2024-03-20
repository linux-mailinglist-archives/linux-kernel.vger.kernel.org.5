Return-Path: <linux-kernel+bounces-109258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611878816E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175201F21505
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E96A8C5;
	Wed, 20 Mar 2024 17:55:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E469DE4;
	Wed, 20 Mar 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957356; cv=none; b=ZDkaZDoXxe7LcUfm+Xu7KJk2H43jWzJtNIstlsmb01UJYY3MyzZmdMcg7AqpenjH9kbqoku+3t4HF0h+Gc+HTgw9RcOHAXqLRrur7OMQB/GiZJOdLWNUm/gdqaimzcG5ZqiO6ixaACvOlPLoKQhgQ0QLRCOaqPJkM2J74j49Bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957356; c=relaxed/simple;
	bh=yvxdZcmVH4E1WLSo9+lpEe8WBNOQkbGm6Jg3v9hHgZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPgT/kjpNJ1daMz+NDoZAO7bTVlnVZNPKmQEsZbUKaRmlaFdq25NQet5+p29sm+Wks8GC0y12ZOe2PY9eJfu2SnpBzQqTim3eL4JRoyawRKrRGxPbnEDB/YWljyCScD6042OqP9tqRuvlrVQekqlOKpniBSfItUEaNwlDab/K78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B179C433C7;
	Wed, 20 Mar 2024 17:55:54 +0000 (UTC)
Date: Wed, 20 Mar 2024 13:58:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC][PATCH] tracing: Introduce restart_critical_timings()
Message-ID: <20240320135819.4a25c50f@gandalf.local.home>
In-Reply-To: <0015569b-15dc-4ccd-b322-67c3665c585e@efficios.com>
References: <20240320122012.2c1f461f@gandalf.local.home>
	<0015569b-15dc-4ccd-b322-67c3665c585e@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 13:15:39 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > I would like to introduce restart_critical_timings() and place it in
> > locations that have this behavior.  
> 
> Is there any way you could move this to need_resched() rather than
> sprinkle those everywhere ?

Because need_resched() itself does not mean it's going to schedule
immediately. I looked at a few locations that need_resched() is called.
Most are in idle code where the critical timings are already handled.

I'm not sure I'd add it for places like mm/memory.c or drivers/md/bcache/btree.c.

A lot of places look to use it more for PREEMPT_NONE situations as a open
coded cond_resched().

The main reason this one is particularly an issue, is that it spins as long
as the owner is still running. Which may be some time, as here it was 7ms.

-- Steve

