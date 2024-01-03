Return-Path: <linux-kernel+bounces-15864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798A82346F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB451F2446E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07051C6A6;
	Wed,  3 Jan 2024 18:26:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644911D52D;
	Wed,  3 Jan 2024 18:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E3C433C8;
	Wed,  3 Jan 2024 18:26:07 +0000 (UTC)
Date: Wed, 3 Jan 2024 13:27:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
Message-ID: <20240103132710.443f227f@gandalf.local.home>
In-Reply-To: <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
References: <20240103102553.17a19cea@gandalf.local.home>
	<CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 10:12:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 3 Jan 2024 at 07:24, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Instead, just have eventfs have its own iterate_shared callback function
> > that will fill in the dent entries. This simplifies the code quite a bit.  
> 
> Much better. Now eventfs looks more like a real filesystem, and less
> like an eldritch horror monster that is parts of dcache tackled onto a
> pseudo-filesystem.

Thanks.

> 
> However, one request, and one nit:
> 
> > Also, remove the "lookup" parameter to the create_file/dir_dentry() and
> > always have it return a dentry that has its ref count incremented, and
> > have the caller call the dput. This simplifies that code as well.  
> 
> Can you please do that as a separate patch, where the first patch just
> cleans up the directory iteration, and the second patch then goes "now
> there are no more callers that have the 'lookup' argument set to
> false".

Yeah, I was thinking of doing it as two patches and figured I'd merge them
into one because I deleted one of the users of it. As I was on the fence
with doing two patches, I'm happy to change that.

> 
> Because as-is, the patch is kind of two things mixed up.
> 
> The small nit is this:
> 
> > +static int eventfs_iterate(struct file *file, struct dir_context *ctx)
> >  {
> > +       /*
> > +        * Need to create the dentries and inodes to have a consistent
> > +        * inode number.
> > +        */
> >         list_for_each_entry_srcu(ei_child, &ei->children, list,
> >                                  srcu_read_lock_held(&eventfs_srcu)) {
> > -               d = create_dir_dentry(ei, ei_child, parent, false);
> > -               if (d) {
> > -                       ret = add_dentries(&dentries, d, cnt);
> > -                       if (ret < 0)
> > -                               break;
> > -                       cnt++;
> > +
> > +               if (ei_child->is_freed)
> > +                       continue;
> > +
> > +               name = ei_child->name;
> > +
> > +               dentry = create_dir_dentry(ei, ei_child, ei_dentry);
> > +               if (!dentry)
> > +                       goto out;
> > +               ino = dentry->d_inode->i_ino;
> > +               dput(dentry);
> > +
> > +               if (c > 0) {
> > +                       c--;
> > +                       continue;
> >                 }  
> 
> Just move this "is the position before this name" up to the top of the
> loop. Even above the "is_freed" part.
> 
> Let's just always count all the entries in the child list.
> 
> And same for the ei->nr_entries loop:
> 
> >         for (i = 0; i < ei->nr_entries; i++) {  
> 
> where there's no point in creating that dentry just to look up the
> inode number, only to then decide "Oh, we already iterated past this
> part, so let's not do anything with it".
> 
> This wouldn't seem to matter much with a big enough getdents buffer
> (which is the normal user level behavior), but it actually does,
> because we don't keep track of "we have read to the end of the
> directory".
> 
> So every readdir ends up effectively doing getdents at least twice:
> once to read the directory entries, and then once to just be told
> "that was all".
> 
> End result: you should strive very hard to *not* waste time on the
> directory entries that have already been read, and are less than
> 'ctx->pos'.

My patch originally did that, but then I was worried about counting something
that doesn't exist.

If it is done twice, there's a good chance the dentry will still be around
anyway, so it doesn't slow it down that much. The dput() only decrements
the entry and doesn't free it. I added back my "show_events_dentries" file
to test this. They sit with refcount equal to zero waiting to be reclaimed.
But if they get referenced again, the refcount goes up again.

That is, the first time it is called, where ctx->pos is likely zero, it
creates the dentry, but that is also added to the list. The next time, with
ctx->pos greater than zero, the create_dir_dentry() starts with:

static struct dentry *
create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
		  struct dentry *parent)
{
	struct dentry *dentry = NULL;

	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));

	mutex_lock(&eventfs_mutex);
	if (pei->is_freed || ei->is_freed) {
		mutex_unlock(&eventfs_mutex);
		return NULL;
	}
	if (ei->dentry) {
		/* If the dentry already has a dentry, use it */
		dentry = ei->dentry;
		dget(dentry);
		mutex_unlock(&eventfs_mutex);
		return dentry;
	}
	mutex_unlock(&eventfs_mutex);

Where the already created dentry is returned. (hmm, I just noticed that
comment should be "if the eventfs_inode already has a dentry" and not "If
the dentry already has a dentry" :-p ).

It does require taking a mutex, but that's actually quite fast too.

If you don't think it will cause any inconsistencies to count something
that perhaps doesn't exist anymore, then I can move the ctx->pos check up.

-- Steve


