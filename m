Return-Path: <linux-kernel+bounces-17117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A782487F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1164B2217E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7228E2A;
	Thu,  4 Jan 2024 19:01:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112C28E1F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D31CC433C7;
	Thu,  4 Jan 2024 19:01:41 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:02:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [for-next][PATCH 2/3] eventfs: Stop using dcache_readdir() for
 getdents()
Message-ID: <20240104140246.688a3966@gandalf.local.home>
In-Reply-To: <CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
References: <20240104164703.808999991@goodmis.org>
	<20240104164738.483305222@goodmis.org>
	<CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 10:46:04 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And that very fact actually makes me wonder:
> 
> >         for (i = 0; i < ei->nr_entries; i++) {
> > +               void *cdata = ei->data;
> > +
> > +               if (c > 0) {
> > +                       c--;
> > +                       continue;
> > +               }  
> 
> The 'ei->nr_entries' things are in a stable array, so the indexing for
> them cannot change (ie even if "is_freed" were to be set the array is
> still stable).

Yeah, the entries is fixed. If the ei itself gets freed, so does all the
entries at the same time. The individual entries should too.

Hmm, it probably doesn't even make sense to continue the loop if is_freed
is set as the same variable will be checked every time. :-/  Should just be
a "break;" not a "continue;"

> 
> So I wonder if - just from a 'pos' iterator stability standpoint - you
> should change the tracefs directory iterator to always start with the
> non-directory entries in ei->entries[]?

Sure I can do that. I only did it this way because I followed the way the
other functions did the child directories first and then the files (the
entries array represents the files, as the eventfs_inode represents
directories).

> 
> That way, even if concurrent dynamic add/remove events might change
> the 'ei->children' list, it could never cause an 'ei->entry[]' to
> disappear (or be returned twice).
> 
> This is very nitpicky and I doubt it matters, because I doubt the
> whole "ls on a tracefs directory while changing it" case matters, but
> I thought I'd mention it.

I may add this update, but as a separate patch.

-- Steve

