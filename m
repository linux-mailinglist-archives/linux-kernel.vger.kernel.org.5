Return-Path: <linux-kernel+bounces-62443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD528520C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F307E28260A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC954F1F1;
	Mon, 12 Feb 2024 21:46:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A14F1E0;
	Mon, 12 Feb 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774402; cv=none; b=PhHNbKzloj86sQINgdRIfhRxulxg5f66sJhczWVsHsUFsIRez+eYmcH64JDHGYPhuBrSyPhhrR9ZmekskCUpjkgXlvQlgWH6CAI2RDju1XcCgUxW5bV67hBpS6eVHgVW+cxg6axb69u8+sLSwVzPNBQE38aR/8he7eXGssItR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774402; c=relaxed/simple;
	bh=OWwHJ8PgKLGXLWXwGyPBKHjW/seZqo+nF2xyRUcgZec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrlylrxOawI4WQuPRsqDkf81ruH4o5nfH/D3vcaeINC1lF5avEdfSO31ukz3BAw0NPGI6JQAUR/qXujCqS5fIoAh8ihrYDV5mwwXVYBtfA5djyLEVh7BZxmPlr2Ns3CW9PTQscfkfmXFAvuLVqgVui6e0YSbXHEsQ+x/WZfsSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B4C433F1;
	Mon, 12 Feb 2024 21:46:40 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:47:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v16 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240212164723.55993db2@gandalf.local.home>
In-Reply-To: <Zcn2iotAnIWT4F_O@google.com>
References: <20240209163448.944970-1-vdonnefort@google.com>
	<20240209163448.944970-3-vdonnefort@google.com>
	<20240211171837.6a4ea1a5@rorschach.local.home>
	<Zcn2iotAnIWT4F_O@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 10:44:26 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > >  static void
> > >  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> > >  {
> > > @@ -5204,6 +5227,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> > >  	cpu_buffer->lost_events = 0;
> > >  	cpu_buffer->last_overrun = 0;
> > >  
> > > +	if (READ_ONCE(cpu_buffer->mapped))  
> > 
> > Isn't the buffer_mutex held when we modify mapped? I believe it's held
> > here. I don't think we need a READ_ONCE() here. Is there a reason for it?
> > 
> > Hmm, looking down, it looks like you take the buffer->mutex after
> > setting mapped, is that necessary? If we take the buffer->mutex we can
> > sync the reset with mapping.  
> 
> The idea was to not take any of the buffer mutex, reader lock if the refcount is
> simply inc/dec. Locks are only used if the meta-page is
> installed/uninstalled.

Does it matter? The inc/dec is only done at initial mapping, right? That's
a very slow path.

> 
> The WRITE_ONCE/READ_ONCE is there only to make sure no compiler optimisation
> could lead a reader to wrongly interpret that refcount while it is inc/dec. That
> is probably not necessary and I'm happy to either drop it completely or replace
> it by taking buffer mutex and reader lock whenever the refcount is inc/dec.

Yeah, probably best to drop it and keep updates within the mutex.

-- Steve


