Return-Path: <linux-kernel+bounces-91517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CAB871285
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E831F23528
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B417C9B;
	Tue,  5 Mar 2024 01:55:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9A2F43;
	Tue,  5 Mar 2024 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603743; cv=none; b=fHvNDS28MuMgf50uSd1LNMSPZkY8QsVPmixA2jO+wRR6ronxNEz5X4UXbasirr0NRLGzxdXjBUb6myvHymaWDYITaqrnlbDZyzLBIYikijZ3domNcGdox+K6L/elVOpXN0TW8iO6Qzsp30Q92+FGZGEbFf/qgCH+dQgvJxIsvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603743; c=relaxed/simple;
	bh=FlXtlSeO6cB/ZUPdjYZmayDOEDubCs5O53bxkF5XlEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIt1I8okxX0haWkpoRKPr+Okyvu2611D329v/40cx6EIpfAssTpPwq0Eyg2lP++oKxW1LfAz9X9wV10uF4YEBgBI7b1wKvYGFoQDd6aqA53F14gGf6s+jOjjUHMvNPMZgqjiemMQOyy5pUf+HrgiPYupAd3sDV6yLvhNIdSujh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76BC433F1;
	Tue,  5 Mar 2024 01:55:41 +0000 (UTC)
Date: Mon, 4 Mar 2024 20:57:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304205730.53328530@gandalf.local.home>
In-Reply-To: <e34628b6-fdb3-420f-8563-4cf91ad3a04b@efficios.com>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
	<20240304203516.45b7a551@gandalf.local.home>
	<e34628b6-fdb3-420f-8563-4cf91ad3a04b@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 20:36:28 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >             <...>-999     [001] .....  2296.140373: tracing_mark_write: hello
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >     This is the meta data that is added to trace_seq  
> 
> If this header has a known well-defined upper-limit length, then use
> that in the BUILD_BUG_ON().

Unfortunately there's no set limit. It's built up by different callbacks
and such. The output can be changed by options set by the user and even by
tracers, like the function graph tracer:

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 1)               |  /* hello */


But the worse that will happen if it overflows is that the event is
replaced with:

             <...>-999     [001] .....  2296.140373: [LINE TOO BIG]

But this has never happened outside of development. I guess you could
trigger it if you add a trace_printk() that has a string bigger than
TRACE_SEQ_BUFFER_SIZE. But as Linus says, "Don't do stupid things" ;-)

But in reality, with all the options and everything, I've never seen the
appended text more than 80 bytes (and probably much less).

-- Steve

