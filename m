Return-Path: <linux-kernel+bounces-100437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91A87978D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D765A1F263DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0697C6D2;
	Tue, 12 Mar 2024 15:30:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFABF7B3EF;
	Tue, 12 Mar 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257450; cv=none; b=rpsz8pZ9xFO0XANOKFs89O7ixgP7CWREtD+5UANdPLRLvNfs7pZ8t202DjlIsMahYP3iFGrBhlk38MCTpAwiZsOAoj52GARFY2ykZk4mKDrTEippn2VClRjwuoo1+EFIVjcyKG70Fm21Dxi58Zz4WrMzcivNX6hMl+KEtcmLRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257450; c=relaxed/simple;
	bh=Z2McJvRwMphtzX4Zb63W7c5mKRkPIJErF1gDpAxflBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDUgVDVFZK+4wvnQbAKpkP41e6jtzG1NY/qJ0Ior+zE1zHCFZezp5EcNBjb/sLCDN5HZVvpMguPKsUGEZADsC4pT5mx9R2mWLqCWX2UYbc4rhUBsfrTAxYaNzHCT8a9JA2YtNfu8ASf65m9SBvS9FPR0g/bp0Mz/4OMXgrNiaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E3C43390;
	Tue, 12 Mar 2024 15:30:48 +0000 (UTC)
Date: Tue, 12 Mar 2024 11:32:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ring-buffer: Fix full_waiters_pending in poll
Message-ID: <20240312113254.78455352@gandalf.local.home>
In-Reply-To: <20240313002210.d89600218f78a4c55f56b998@kernel.org>
References: <20240312131919.314231457@goodmis.org>
	<20240312131952.630922155@goodmis.org>
	<20240313002210.d89600218f78a4c55f56b998@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 00:22:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Mar 2024 09:19:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > If a reader of the ring buffer is doing a poll, and waiting for the ring
> > buffer to hit a specific watermark, there could be a case where it gets
> > into an infinite ping-pong loop.
> > 
> > The poll code has:
> > 
> >   rbwork->full_waiters_pending = true;
> >   if (!cpu_buffer->shortest_full ||
> >       cpu_buffer->shortest_full > full)
> >          cpu_buffer->shortest_full = full;
> > 
> > The writer will see full_waiters_pending and check if the ring buffer is
> > filled over the percentage of the shortest_full value. If it is, it calls
> > an irq_work to wake up all the waiters.
> > 
> > But the code could get into a circular loop:
> > 
> > 	CPU 0					CPU 1
> > 	-----					-----
> >  [ Poll ]
> >    [ shortest_full = 0 ]
> >    rbwork->full_waiters_pending = true;
> > 					  if (rbwork->full_waiters_pending &&
> > 					      [ buffer percent ] > shortest_full) {
> > 					         rbwork->wakeup_full = true;
> > 					         [ queue_irqwork ]  
> 
> Oh, so `[ buffer percent ] > shortest_full` does not work because
> if this happens in this order, shortest_full may be 0.

Exactly!

> 
> > 
> >    cpu_buffer->shortest_full = full;
> > 
> > 					  [ IRQ work ]
> > 					  if (rbwork->wakeup_full) {
> > 					        cpu_buffer->shortest_full = 0;

And here shortest_full gets set back to zero! (But that's not the bug).

> > 					        wakeup poll waiters;
> >   [woken]
> >    if ([ buffer percent ] > full)
> >       break;
> >    rbwork->full_waiters_pending = true;

The bug is setting full_waiters_pending before updating the shortest_full.

> > 					  if (rbwork->full_waiters_pending &&
> > 					      [ buffer percent ] > shortest_full) {
> > 					         rbwork->wakeup_full = true;
> > 					         [ queue_irqwork ]
> > 
> >    cpu_buffer->shortest_full = full;
> > 
> > 					  [ IRQ work ]
> > 					  if (rbwork->wakeup_full) {
> > 					        cpu_buffer->shortest_full = 0;
> > 					        wakeup poll waiters;
> >   [woken]
> > 
> >  [ Wash, rinse, repeat! ]
> > 
> > In the poll, the shortest_full needs to be set before the
> > full_pending_waiters, as once that is set, the writer will compare the
> > current shortest_full (which is incorrect) to decide to call the irq_work,
> > which will reset the shortest_full (expecting the readers to update it).
> > 
> > Also move the setting of full_waiters_pending after the check if the ring
> > buffer has the required percentage filled. There's no reason to tell the
> > writer to wake up waiters if there are no waiters.
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

I'm running it through my tests and when they finish, I'll be posting the
for-linus patches.

-- Steve

