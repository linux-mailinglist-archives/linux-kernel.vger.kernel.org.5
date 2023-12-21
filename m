Return-Path: <linux-kernel+bounces-9040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85781BF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B51F24230
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2895745CE;
	Thu, 21 Dec 2023 20:18:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F9651BC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3DAC433C7;
	Thu, 21 Dec 2023 20:18:44 +0000 (UTC)
Date: Thu, 21 Dec 2023 15:19:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Graf <graf@amazon.com>
Subject: Re: [GIT PULL] tracing: A few more fixes for 6.7
Message-ID: <20231221151948.423a87b9@gandalf.local.home>
In-Reply-To: <CAHk-=wjmUr93TFgpZ6ew3t5XFO2Cyxb8wnRENCkWvrH8m9XEOA@mail.gmail.com>
References: <20231221102703.08dc1273@gandalf.local.home>
	<CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com>
	<20231221142841.48b13ba4@gandalf.local.home>
	<CAHk-=wjmUr93TFgpZ6ew3t5XFO2Cyxb8wnRENCkWvrH8m9XEOA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 12:01:45 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 21 Dec 2023 at 11:27, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Luckily, that's easy to get to. All I need to do is:

Note, this actually still has a broken corner case. And that would be:

[ No setting of ownership on mount ]

 # chown rostedt:rostedt instances
 # mkdir instance/foo

 # ls -l instances/foo
total 0
-r--r-----  1 rostedt rostedt 0 Dec 21 14:55 available_tracers
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 buffer_percent
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 buffer_size_kb
-r--r-----  1 rostedt rostedt 0 Dec 21 14:55 buffer_total_size_kb
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 current_tracer
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 error_log
drwxr-xr-x  2 root    root    0 Dec 21 14:55 events  <<<---- not updated, nor is the children.
--w-------  1 rostedt rostedt 0 Dec 21 14:55 free_buffer
drwxr-x---  2 rostedt rostedt 0 Dec 21 14:55 options
drwxr-x--- 10 rostedt rostedt 0 Dec 21 14:55 per_cpu
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_event
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_event_notrace_pid
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_event_pid
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_ftrace_filter
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_ftrace_notrace
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_ftrace_notrace_pid
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 set_ftrace_pid
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 snapshot
-r--r-----  1 rostedt rostedt 0 Dec 21 14:55 timestamp_mode
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 trace
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 trace_clock
--w--w----  1 rostedt rostedt 0 Dec 21 14:55 trace_marker
--w--w----  1 rostedt rostedt 0 Dec 21 14:55 trace_marker_raw
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 trace_options
-r--r-----  1 rostedt rostedt 0 Dec 21 14:55 trace_pipe
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 tracing_cpumask
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 tracing_max_latency
-rw-r-----  1 rostedt rostedt 0 Dec 21 14:55 tracing_on

The events directory did not take on the parent.

And even if it did, the files and directories created under it needs to
default to what the events directory was created with, not what the mount.

That's not too hard to fix either. We just need to save that information in
the eventfs_inode of the events directory, and find it when creating other
files and directories.

> >
> > static void update_inode_attr(struct dentry *dentry, struct inode *inode,
> >                               struct eventfs_attr *attr, umode_t mode)
> > {
> >         struct tracefs_fs_info *fsi = dentry->d_sb->s_fs_info;
> >         struct tracefs_mount_opts *opts = &fsi->mount_opts;
> >
> >         /* Default the ownership to what it was mounted as */
> >         inode->i_uid = opts->uid;
> >         inode->i_gid = opts->gid;  
> 
> I think you should add
> 
> >         inode->i_mode = mode;  
> 
> to that "default setup", which not only makes things more consistent,
> it also means that you can then remove it from here:
> 
> >         if (!attr) {
> >                 inode->i_mode = mode;
> >                 return;
> >         }  
> 
> .. and the 'else' side from here:
> 
> >         if (attr->mode & EVENTFS_SAVE_MODE)
> >                 inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
> >         else
> >                 inode->i_mode = mode;  
> 
> and it all looks a lot more clear and obvious.

sure.

> 
> "Set things to default values, then if we have attr and the specific
> fields are set in those attrs, update them".
> 
> Instead of having this odd "do one thing for git/uid, another for mode".
> 
> > > I still claim that the whole dynamic ftrace stuff was a huge mistake,
> > > and that the real solution should always have been to just use one
> > > single inode for every file (and use that 'attr' that you track and
> > > the '->getattr()' callback to make them all *look* different to
> > > users).  
> >
> > Files now do not even have meta-data, and that saved 2 megs per trace
> > instance. I only keep meta data for the directories. The files themselves
> > are created via callback functions.  
> 
> I bet that was basically *all* just the inodes.
> 
> The dentries take up very little space, and the fact that you didn't
> keep the dentries around meant that you instead replaced them with
> that 'struct eventfs_file' which probably takes up as much room as the
> dentries ever did - and now when you use them, you obviously use
> *more* memory since it duplicates the data in the dentries, including
> the name etc.

In 6.7 I got rid of the eventfs_file and friends.

  5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")

> 
> So I bet you use *more* memory than if you just kept the dentry tree
> around, and this dynamic creation has then caused a number of bugs and
> a lot of extra complexity - things like having to re-implement your
> own readdir() etc, much of which has been buggy.

As I'm new to VFS I expected to have a lot of bugs, but those bugs are
settling down now.

> 
> And when you fix the resulting bugs, the end result is often
> disgusting. I'm talking about things like commit ef36b4f92868
> ("eventfs: Remember what dentries were created on dir open"), which
> does things like re-use file->private_data for two entirely different
> things (is it a 'cursor' or a 'dlist'? Who can know? That thing makes
> me gag).

As I stated back then, I could get rid of the re-use of private_data by
creating my own cursor, but then I would need to reimplement the code to
iterate. Ideally, the readdir code should not have touched the
private_data, as now the file system has no private data to use.

> 
> Honestly, that was just one example of "that code does some truly ugly
> things because the whole notion is mis-designed".

I would argue the implementation of readdir that couples itself with the
private_data of the descriptor it is implementing the walk from was a
mis-design. I had no way to pass information from the open to the release
function without re-implementing all of readdir.

-- Steve

