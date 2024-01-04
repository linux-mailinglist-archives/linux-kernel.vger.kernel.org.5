Return-Path: <linux-kernel+bounces-17199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B79824995
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D694F28741F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B671E491;
	Thu,  4 Jan 2024 20:32:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E51DFD6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C6DC433C7;
	Thu,  4 Jan 2024 20:31:58 +0000 (UTC)
Date: Thu, 4 Jan 2024 15:33:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [for-next][PATCH 2/3] eventfs: Stop using dcache_readdir() for
 getdents()
Message-ID: <20240104153304.79e607c8@gandalf.local.home>
In-Reply-To: <CAHk-=wik=OOYCRSzAA7x485GyxH97ioaPziiF4Ms1kRU8VLkHA@mail.gmail.com>
References: <20240104164703.808999991@goodmis.org>
	<20240104164738.483305222@goodmis.org>
	<CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
	<20240104140246.688a3966@gandalf.local.home>
	<20240104150500.38b15a62@gandalf.local.home>
	<CAHk-=wik=OOYCRSzAA7x485GyxH97ioaPziiF4Ms1kRU8VLkHA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 12:18:06 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 4 Jan 2024 at 12:04, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Also, I just realized it breaks if we update the 'c--' before the callback. :-/
> >
> > I have to put this check *after* the callback check.  
> 
> What? No.
> 
> > Reason being, the callback can say "this event doesn't get this file" and
> > return 0, which tells eventfs to skip this file.  
> 
> So yes, there seems to be a bug there, in that ctx->pos is only
> updated for successful callbacks (and not for "ignored entry").

OK, I wasn't sure if it was OK to update the ctx->pos for something we
didn't add, so I avoided doing so.

> 
> But that just means that you should always update 'ctx->pos' as you
> 'continue' the loop.
> 
> The logical place to do that would be in the for-loop itself, which
> actually is very natural for the simple case, ie you should just do
> 
>         for (i = 0; i < ei->nr_entries; i++, ctx->pos++) {

Well, we don't want to do that and c-- at the same time. But of course, if
we do the shortcut, we can have:

	for (i = c; i < ei->nr_entries; i++, ctx->pos++) {

which would be OK. And better if we move it before the ei->children list walk.

> 
> but in the list_for_each_entry_srcu() case the 'update' part of the
> for-loop isn't actually accessible, so it would have to be at the
> 'continue' point(s).
> 
> Which is admittedly a bit annoying.

But not really an issue as we just have:

	list_for_each_entry_srcu(ei_child, &ei->children, list,
				 srcu_read_lock_held(&eventfs_srcu)) {

		if (c > 0) {
			c--;
			continue;
		}

		ctx->pos++;

> 
> Looking at that I'm actually surprised that I don't recall that we'd
> have hit that issue with our 'for_each_xyz()' loops before.
> 
> The update for our "for_each_xyz()" helpers are all hardcoded to just
> do the "next iterator" thing, and there's no nice way to take
> advantage of the normal for-loop semantics of "do this at the end of
> the loop"

Anyway, if I do count ctx->pos++ for every iteration, whether it added
something or not, it appears to work. I'll write up a couple of patches to
handle this.

Thanks,

-- Steve

