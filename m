Return-Path: <linux-kernel+bounces-8998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7783E81BF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187831F21EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539F9651AD;
	Thu, 21 Dec 2023 19:27:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06F651A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA91FC433C8;
	Thu, 21 Dec 2023 19:27:38 +0000 (UTC)
Date: Thu, 21 Dec 2023 14:28:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Graf <graf@amazon.com>
Subject: Re: [GIT PULL] tracing: A few more fixes for 6.7
Message-ID: <20231221142841.48b13ba4@gandalf.local.home>
In-Reply-To: <CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com>
References: <20231221102703.08dc1273@gandalf.local.home>
	<CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 09:45:43 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 21 Dec 2023 at 07:26, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Fix eventfs files to inherit the ownership of its parent directory.
> >   The dynamic creating of dentries in eventfs did not take into
> >   account if the tracefs file system was mounted with a gid/uid,
> >   and would still default to the gid/uid of root. This is a regression.  
> 
> Honestly, this seems to still be entirely buggy. In fact, it looks
> buggy in two different ways:
> 
>  (a) if 'attr' is NULL, none of this logic is triggered, and uid/gid
> is still left as root despite the explicit mount options
> 
>  (b) if somebody has done a chown/gid on the directory, the new
> dynamic creation logic seems to create any files inside that directory
> with the new uid/gid.
> 
> Maybe (a) cannot happen, but that code in update_inode_attr() does
> have a check for a NULL attr, so either it can happen, or that check
> is bogus.
> 
> And (b) just looks messy.  Maybe you've disallowed chown/chgid on
> tracefs, I didn't check. But why would it inherit the parent uid/gid?
> That just doesn't seem to make any sense at all.

I see you pulled the change already, but you are correct with the above two
points.

(a) can happen for files, I only tested directories and forgot to check the
    files. I verified that it's still broken for them:

 # umount /sys/kernel/tracing
 # mount -o rw,seclabel,relatime,gid=1000 -t tracefs nodev /mnt

 # ls -ld /mnt/events/sched
drwxr-xr-x 28 root rostedt 0 Dec 21 13:12 /mnt/events/sched/

 # ls -ld /mnt/events/sched/sched_switch
drwxr-xr-x 2 root rostedt 0 Dec 21 13:12 /mnt/events/sched/sched_switch/

But when checking the files:

 # ls -l /mnt/events/sched/sched_switch
total 0
-rw-r----- 1 root root 0 Dec 21 13:12 enable
-rw-r----- 1 root root 0 Dec 21 13:12 filter
-r--r----- 1 root root 0 Dec 21 13:12 format
-r--r----- 1 root root 0 Dec 21 13:12 hist
-r--r----- 1 root root 0 Dec 21 13:12 id
-rw-r----- 1 root root 0 Dec 21 13:12 trigger

so the files still need to be fixed.

And I agree, that using the directory parent was not a good idea. I took
that from the normal creation of the tracefs files which copy the parent
uid/gid, which makes sense as they are all created together, but does not
make sense when created dynamically. In that case, it needs to default to
what the superblock was mounted as.

Luckily, that's easy to get to. All I need to do is:

static void update_inode_attr(struct dentry *dentry, struct inode *inode,
			      struct eventfs_attr *attr, umode_t mode)
{
	struct tracefs_fs_info *fsi = dentry->d_sb->s_fs_info;
	struct tracefs_mount_opts *opts = &fsi->mount_opts;

	/* Default the ownership to what it was mounted as */
	inode->i_uid = opts->uid;
	inode->i_gid = opts->gid;

	if (!attr) {
		inode->i_mode = mode;
		return;
	}

	if (attr->mode & EVENTFS_SAVE_MODE)
		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
	else
		inode->i_mode = mode;

	if (attr->mode & EVENTFS_SAVE_UID)
		inode->i_uid = attr->uid;

	if (attr->mode & EVENTFS_SAVE_GID)
		inode->i_gid = attr->gid;
}

And that would solve both issues.

 # umount /sys/kernel/tracing
 # mount -o rw,seclabel,relatime,gid=1000 -t tracefs nodev /mnt

 # ls -ld /mnt/events/sched
drwxr-xr-x 28 root rostedt 0 Dec 21 13:12 /mnt/events/sched/

 # ls -ld /mnt/events/sched/sched_switch
drwxr-xr-x 2 root rostedt 0 Dec 21 13:12 /mnt/events/sched/sched_switch/

 # ls -l /mnt/events/sched/sched_switch
total 0
-rw-r----- 1 root rostedt 0 Dec 21 14:15 enable
-rw-r----- 1 root rostedt 0 Dec 21 14:15 filter
-r--r----- 1 root rostedt 0 Dec 21 14:15 format
-r--r----- 1 root rostedt 0 Dec 21 14:15 hist
-r--r----- 1 root rostedt 0 Dec 21 14:15 hist_debug
-r--r----- 1 root rostedt 0 Dec 21 14:15 id
--w------- 1 root rostedt 0 Dec 21 14:15 inject
-rw-r----- 1 root rostedt 0 Dec 21 14:15 trigger

And:

 # chgrp tracing /mnt/events/irq/softirq_entry
 # ls -l /mnt/events/irq/softirq_entry
total 0
-rw-r----- 1 root rostedt 0 Dec 21 14:16 enable
-rw-r----- 1 root rostedt 0 Dec 21 14:16 filter
-r--r----- 1 root rostedt 0 Dec 21 14:16 format
-r--r----- 1 root rostedt 0 Dec 21 14:16 hist
-r--r----- 1 root rostedt 0 Dec 21 14:16 hist_debug
-r--r----- 1 root rostedt 0 Dec 21 14:16 id
--w------- 1 root rostedt 0 Dec 21 14:16 inject
-rw-r----- 1 root rostedt 0 Dec 21 14:16 trigger


> 
> I still claim that the whole dynamic ftrace stuff was a huge mistake,
> and that the real solution should always have been to just use one
> single inode for every file (and use that 'attr' that you track and
> the '->getattr()' callback to make them all *look* different to
> users).

Files now do not even have meta-data, and that saved 2 megs per trace
instance. I only keep meta data for the directories. The files themselves
are created via callback functions.

The files in an event directory are all the same for each event. But the
events themselves need to maintain state per instance. A sched_switch event
may be enabled in one instance and not another. That's stored in the
trace_event_file structure that's allocated per event per instance.

The dentry and inodes are allocated when the files are referenced, via
callback functions that pass a descriptor that maps the director to the
trace_event_file to give the attributes needed.

I'm not sure a single inode would have prevented this bug, as it would
still need to have this type of accounting.

Anyway, what I have to do next after fixing this, is to add a selftest that
tests the chown/chgrp on eventfs directories and files.

Thanks for catching this!

-- Steve

