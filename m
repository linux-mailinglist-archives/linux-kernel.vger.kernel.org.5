Return-Path: <linux-kernel+bounces-46976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFD844754
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA47D28FFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A6418B00;
	Wed, 31 Jan 2024 18:39:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604D20DE2;
	Wed, 31 Jan 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726370; cv=none; b=HBVvgzx6w2ymfokYB+c2EQ7pGsvBaCU7j1y31UDtucV53IjGZLYvcMuQYiK963+Whv9vNvASW+8laK7EAUZSHo9Zt+26TS7OUUJ81LSYtnArQgEOJ0+FSCEs4kIgdMvA12k3kb0yzgBwr+IhZjh9mjs7/CR94j4DyuzZLU69lh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726370; c=relaxed/simple;
	bh=wG3Hn51lXiqqGTEQgHWDBCOpRQh7/FE2IhWysyt/Vb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3xua7a8M/7IFJzofivSF7SMi56ddBTDY6Vhyse8R97fMdpnMSk/C4if51Tk1hR/qnu2Z1dHuQT7vZ4q22d7UvaWJ1JhQkUNpi6iczgw7/E5N3IDrK4hKp+zgMUeq9D4wbuLTq9HDIm0pwm/EuXOu4vVUt0htqLTfXbl3YFbal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65216C433F1;
	Wed, 31 Jan 2024 18:39:29 +0000 (UTC)
Date: Wed, 31 Jan 2024 13:39:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240131133943.0a6e0e1d@gandalf.local.home>
In-Reply-To: <CAHk-=whNqOa5rAr4Lq9j=zZgrSxyZwgt6imSydAY3vyeaHm01g@mail.gmail.com>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240131000956.3dbc0fc0@gandalf.local.home>
	<CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
	<20240131003317.7a63e799@gandalf.local.home>
	<CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
	<CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
	<20240131075740.660e7634@rorschach.local.home>
	<20240131081449.6e917b71@rorschach.local.home>
	<CAHk-=whNqOa5rAr4Lq9j=zZgrSxyZwgt6imSydAY3vyeaHm01g@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:08:37 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 31 Jan 2024 at 05:14, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > If you also notice, tracefs only allows mkdir/rmdir to be assigned to
> > one directory. Once it is assigned, no other directories can have mkdir
> > rmdir functionality.  
> 
> I think that does limit the damage, but it's not clear that it is actually safe.
> 
> Because you don't hold the inode lock, somebody could come in and do a
> mkdir inside the other one that is being removed, ie something like
> 
>  - thread 1 does took the inode lock, called ->rmdir
> 
>  - it then drops the inode lock (both parent and the directory that is
> getting removed) and gets the event lock
> 
>  - but thread 2 can come in between that inode lock drop and event lock
> 
> Notice: thread 2 comes in where there is *no* locking. Nada. Zilch.
> 
> This is what worries me.

Yep, and that was my biggest concern too, which is why I have stress tests
that try to hit that above scenario. Well, rmdir and other accesses
including other mkdir's of the same name.

As my knowledge on the inode life time is still limited, my main concern
was just corruption of the dentry/inodes themselves. But the first one to
get the event_mutex determines the state of the file system.

If thread 1 is doing rmdir, what would thread 2 do that can harm it?

The rmdir calls trace_remove() which is basically retrying to remove the
directory again, and hopefully has the proper locking just like removing
the kprobe trace event that deletes directories. It can have references on
it.

Now if something were to get a reference, and a valid dentry, as soon as
the open function is called, the tracing logic will see that the
trace_array no longer exists and returns an error.

All the open functions for files that are created in an instance (and that
includes eventfs files) have a check to see if the inode->i_private data is
still valid. The trace_array structure represents the directory, and
there's a link list of all the trace_array structures that is protected by
the trace_types_lock. It grabs that lock, iterates the array to see if the
passed in trace_array is on it, if it is, it ups the ref count (preventing
a rmdir from succeeding) and returns it. If it is not, it returns NULL and
the open call fails as if it opened a nonexistent file.

> 
> But it does help that it's all only in *one* directory.  At least
> another mkdir cannot happen *inside* the one that is going away while
> the locks are not held. So the good news is that it does mean that
> there's only one point that is being protected.
> 
> But I do worry about things like this (in vfs_rmdir()):
> 
>         inode_lock(dentry->d_inode);
> 
>         error = -EBUSY;
>         if (is_local_mountpoint(dentry) ||
>             (dentry->d_inode->i_flags & S_KERNEL_FILE))
>                 goto out;
> 
>         error = security_inode_rmdir(dir, dentry);
>         if (error)
>                 goto out;
> 
>         error = dir->i_op->rmdir(dir, dentry);
>         if (error)
>                 goto out;
> 
> notice how it does that "is this a mount point" test atomically wrt
> the rmdir before it is allowed to proceed.

You mean if someone did:

 # mkdir instances/foo
 # rmdir instances/foo

and at the same time, someone else did

 # mount -t ext4 /dev/sda instances/foo

?

OK, I never thought of that use case. Although, I think if someone is
trying to mount anything in tracefs, they can keep the pieces. ;-)

> 
> And I do think that the inode lock is what also protects it from
> concurrent mounts. So now what happens when that "thread 2" above
> comes in while there is *no* locking, and mounts something there?
> 
> Now, I'm not saying this is a huge problem. But it's very much an
> example of a thing that *could* be a problem. Dropping locks in the
> middle is just very scary.

No arguments from me. I really didn't like the dropping of the locks, and
tried hard to avoid it. If switching over to kernfs can solve that, I'd let
that conversion happen.

I'm all for someone switching tracefs over to kernfs if it solves all these
unknown bugs, as long as it doesn't hurt the memory savings of eventfs. But
again, I'm also willing to make eventfs its own file system (although I
don't have the time yet to do that) where tracefs isn't burdened by it.

-- Steve

