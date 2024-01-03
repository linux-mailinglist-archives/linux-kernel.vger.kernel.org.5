Return-Path: <linux-kernel+bounces-15883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE48234EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7CD28277B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA211CA8F;
	Wed,  3 Jan 2024 18:50:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204D1CA82;
	Wed,  3 Jan 2024 18:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16542C433C8;
	Wed,  3 Jan 2024 18:49:58 +0000 (UTC)
Date: Wed, 3 Jan 2024 13:51:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
Message-ID: <20240103135102.38352956@gandalf.local.home>
In-Reply-To: <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
References: <20240103102553.17a19cea@gandalf.local.home>
	<CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
	<CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 10:38:09 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 3 Jan 2024 at 10:12, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Much better. Now eventfs looks more like a real filesystem, and less
> > like an eldritch horror monster that is parts of dcache tackled onto a
> > pseudo-filesystem.  
> 
> Oh, except I think you still need to just remove the 'set_gid()' mess.
> 
> It's disgusting and it's wrong, and it's not even what the 'uid'
> option does (it only sets the root inode uid).
> 
> If you remount the filesystem with different gid values, you get to
> keep both broken pieces. And if it isn't a remount, then setting the
> root uid is sufficient.
> 
> I think the whole thing was triggered by commit 49d67e445742, and
> maybe the fix is to just revert that commit.
> 
> That commit makes no sense in general, since the default mounting
> position for tracefs that the kernel sets up is only accessible to
> root anyway.
> 
> Alternatively, just do the ->permissions() thing, and allow access to
> the group in the mount options.
> 
> Getting rid of set_gid() would be this attached lovely patch:
> 
>  fs/tracefs/inode.c | 83 ++----------------------------------------------------
>  1 file changed, 2 insertions(+), 81 deletions(-)
> 
> and would get rid of the final (?) piece of disgusting dcache hackery
> that tracefs most definitely should not have.
>

I'll look at that and play with it. I understand VFS much better now that I
spent so much time with eventfs. That commit had to do with allowing OTH
read access, which is a security issue as the trace files expose a lot of
the kernel internals.

I think these changes are a bit much for -rc8, don't you? Or do you want
all this in before v6.7 is released. I'd be more comfortable with adding
these changes in the upcoming merge window, where I can have more time
playing with them.

-- Steve

