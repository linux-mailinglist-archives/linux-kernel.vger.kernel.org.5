Return-Path: <linux-kernel+bounces-91437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0387117B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AA6284ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655110F4;
	Tue,  5 Mar 2024 00:16:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1770635;
	Tue,  5 Mar 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597777; cv=none; b=QKMfZU5VomLQgqcUQFOfVRL1BBDbEl8AaIq2yhBdL9AuB7CP/lZn318Xu+34spEt+2uQqAOD71E5LxC7vFIfGtZ2RiZCMUjF3yaP1ibESH0cJQKHUBR1qT3BOLtUodFOyfc/BA9/EAP56JSNIPsrH/ftA8RkR+M0MBa4kWlrvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597777; c=relaxed/simple;
	bh=d4SR0AK9xetH3Xe3+jpjYPazcNT5zbo5KLvk9kueCc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPsOo8TREDrHKv2xkae5heqarWGbSC836URfnoiEu6oTyceFp20ReNBM1fkNjskdYkOKIdYLizyssyVjRBDqIJNovHregrHguCE4gCanzoqXZpra6MZSYfxgxwcwVkWrcMkDtcF9fj+x7f0QUuvODkxArYL41zB7a7kD+HOvlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FA3C433C7;
	Tue,  5 Mar 2024 00:16:16 +0000 (UTC)
Date: Mon, 4 Mar 2024 19:18:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Remove precision vsnprintf() check from print
 event
Message-ID: <20240304191804.0c48e532@gandalf.local.home>
In-Reply-To: <20240304185500.3160ec20@gandalf.local.home>
References: <20240304174341.2a561d9f@gandalf.local.home>
	<b3803989-8465-4656-8ca3-678a92f9a140@efficios.com>
	<20240304185500.3160ec20@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 18:55:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 4 Mar 2024 18:23:41 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > It appears to currently be limited by
> > 
> > #define TRACE_SEQ_BUFFER_SIZE   (PAGE_SIZE * 2 - \
> >          (sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
> > 
> > checked within tracing_mark_write().  
> 
> Yeah, I can hard code this to 8K as it handles output of complete events,
> that can dump a lot of data, and then limit the trace_marker writes to be 4K.

Actually, the trace_marker writes is already limited by
TRACE_SEQ_BUFFER_SIZE, and by making this hard coded to 8K, it limits the
size of the trace_marker writes.

I may make the writes even smaller.

-- Steve


