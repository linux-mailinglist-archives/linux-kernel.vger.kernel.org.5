Return-Path: <linux-kernel+bounces-46446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D33843FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5EC1F2C798
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE97AE65;
	Wed, 31 Jan 2024 12:57:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F15A7A1;
	Wed, 31 Jan 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705863; cv=none; b=dCSKNJbr7QuTO+qVKwObT5WnRKJm8LOkQW1P2pUIgMyvYo08KSGi/NygtpPzFRHzMvU1Y8rLFD0IIV1Gaf39Z+K4rbKiX1Pw6yOYtgo0mhg4uDo2kpjDSfQCe7Om84fCJ1cwulInMJrg/SQVfGQtc6cawTY1kQHxTDDEF5UErMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705863; c=relaxed/simple;
	bh=adrEc5ycfvBXd5A/G1QblPRi/8rVFlhF8UA3Djg+zTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnxC7swThpGC1q38hYyKoZdUXJbabLoU5Q8dCijvgGqwbfXiexqCoTewcymVREO5HylsouDXpi4+RZw/I3ND/8vzN1ikL7lPSjAUm+LqCcVXradtsMj+o6UQSp16vF9SIolu5DYBmx3P2uvmeN4ZfcnlgGzst6Tfuz3pBBN0Dhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA6C433F1;
	Wed, 31 Jan 2024 12:57:41 +0000 (UTC)
Date: Wed, 31 Jan 2024 07:57:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240131075740.660e7634@rorschach.local.home>
In-Reply-To: <CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240131000956.3dbc0fc0@gandalf.local.home>
	<CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
	<20240131003317.7a63e799@gandalf.local.home>
	<CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
	<CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 22:20:24 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 21:57, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ugh.  
> 
> Oh, and double-ugh on that tracefs_syscall_mkdir/rmdir(). I hate how
> it does that "unlock and re-lock inode" thing.

I'd figured you'd like that one.

> 
> It's a disease, and no, it's not an acceptable response to "lockdep
> shows there's a locking problem".
> 
> The comment says "It is up to the individual mkdir routine to handle
> races" but that's *completely* bogus and shows a fundamental
> misunderstanding of locking.
> 
> Dropping the lock in the middle of a locked section does NOT affect
> just the section that you dropped the lock around.
> 
> It affects the *caller*, who took the lock in the first place, and who
> may well assume that the lock protects things for the whole duration
> of the lock.
> 
> And so dropping the lock in the middle of an operation is a bad BAD
> *BAD* thing to do.
> 
> Honestly, I had only been looking at the eventfs_inode.c lookup code.
> But now that I started looking at mkdir/rmdir, I'm seeing the same
> signs of horrible mistakes there too.
> 
> And yes, it might be a real problem. For example, for the rmdir case,
> the actual lock was taken by 'vfs_rmdir()', and it does *not* protect
> only the ->rmdir() call itself.
> 
> It also, for example, is supposed to make the ->rmdir be atomic wrt things like
> 
>         dentry->d_inode->i_flags |= S_DEAD;
> 
> and
> 
>         dont_mount(dentry);
>         detach_mounts(dentry);
> 
> but now because the inode lock was dropped in the middle, for all we
> know a "mkdir()" could come in on the same name, and make a mockery of
> the whole inode locking.
> 
> The inode lock on that directory that is getting removed is also what
> is supposed to make it impossible to add new files to the directory
> while the rmdir is going on.
> 
> Again, dropping the lock violates those kinds of guarantees.
> 
> "git blame" actually fingers Al for that "unlock and relock", but
> that's because Al did a search-and-replace on
> "mutex_[un]lock(&inode->i_mutex)" and replaced it with
> "inode_[un]lock(inode)" back in 2016.
> 
> The real culprit is you, and that sh*t-show goes back to commit
> 277ba04461c2 ("tracing: Add interface to allow multiple trace
> buffers").
> 
> Christ. Now I guess I need to start looking if there is anything else
> horrid lurking in that mkdir/rmdir path.
> 
> I doubt the inode locking problem ends up mattering in this situation.
> Mostly since this is only tracefs, and normal users shouldn't be able
> to access these things anyway. And I think (hope?) that you only
> accept mkdir/rmdir in specific places.

Yes, this was very deliberate. It was for a very "special" feature, and
thus very limited.

> 
> But this really is another case of "This code smells *fundamentally* wrong".
> 
> Adding Al, in the hopes that he will take a look at this too.

This is something I asked Al about when I wrote it. This isn't a normal
rmdir. I remember telling Al what this was doing. Basically, it's just
a way to tell the tracing infrastructure to create a new instance. It
doesn't actually create a normal directory. It's similar to the
kprobe_events interface, where writing to a file would create
directories and files. Ideally I wanted a mkdir interface as it felt
more realistic, and I was ready to have another "echo foo > make_instance"
if this didn't work. But after talking with Al, I felt that it could
work. The main issue is that mkdir doesn't just make a directory, it
creates the entire tree (like what is done in /sys/fs/cgroup). If this
was more like kernfs instead of debugfs, I may not have had this
problem. That was another time I tried to understand how krenfs worked.

This is the reason all the opens in the tracing code has:

        struct trace_array *tr = inode->i_private;
        int ret;

        ret = tracing_check_open_get_tr(tr);
	if (ret)
		return ret;


In kernel/trace/trace.c:

LIST_HEAD(ftrace_trace_arrays);

int trace_array_get(struct trace_array *this_tr)
{
        struct trace_array *tr;
        int ret = -ENODEV;
        
        mutex_lock(&trace_types_lock);
        list_for_each_entry(tr, &ftrace_trace_arrays, list) {
                if (tr == this_tr) {
                        tr->ref++;
                        ret = 0;
                        break;
                }
        }
        mutex_unlock(&trace_types_lock);
                
        return ret;
}       

static void __trace_array_put(struct trace_array *this_tr)
{
        WARN_ON(!this_tr->ref);
        this_tr->ref--;       
}

void trace_array_put(struct trace_array *this_tr)
{
        if (!this_tr)
                return;

        mutex_lock(&trace_types_lock);
        __trace_array_put(this_tr);
        mutex_unlock(&trace_types_lock);
}

int tracing_check_open_get_tr(struct trace_array *tr)
{
        int ret;

        ret = security_locked_down(LOCKDOWN_TRACEFS);
        if (ret)
                return ret;

        if (tracing_disabled)
                return -ENODEV;

        if (tr && trace_array_get(tr) < 0)
                return -ENODEV;

        return 0;
}

The rmdir code that tracefs calls is also in kernel/trace/trace.c:

static int instance_rmdir(const char *name)
{
        struct trace_array *tr;
        int ret;

        mutex_lock(&event_mutex);
        mutex_lock(&trace_types_lock);

        ret = -ENODEV;
        tr = trace_array_find(name);
        if (tr)
                ret = __remove_instance(tr);

        mutex_unlock(&trace_types_lock);
        mutex_unlock(&event_mutex);

        return ret;
}

The mkdir creates a new trace_array (tr) and rmdir destroys it. If
there's any reference on a trace array the rmdir fails. On every open,
a check is made to see if the trace array that was added to the inode
still exists, and if it does, it ups its ref count to prevent a rmdir
from happening.

It's a very limited mkdir and rmdir. I remember Al asking me questions
about what it can and can't do, and me telling him to make sure the
lock release wasn't going to cause problems.

I wrote several fuzzers on this code that perform mkdir and rmdir on the
instances while other tasks are trying to access them (reading and
writing). In the beginning, it found a few bugs. But I was finally able
to get my fuzzers to work non-stop for over a month and that's when I
felt that this is fine.

I was always weary of this code because of the locking situation. The
kernel selftests has a stress test on this code too.

  tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
  tools/testing/selftests/ftrace/test.d/instances/instance.tc

Which is run as part of the selftest suite, which is run by most people
testing the kernel, including KernelCI.

I haven't had a problem with this code in years, and unless we find a
real bug that needs to be fixed, I'm afraid to touch it.

-- Steve

