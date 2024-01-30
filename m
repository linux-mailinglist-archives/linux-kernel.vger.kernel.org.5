Return-Path: <linux-kernel+bounces-45013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DE842A72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62043B298BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A46129A86;
	Tue, 30 Jan 2024 17:06:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95382D8C;
	Tue, 30 Jan 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634384; cv=none; b=GbkUxyb/fprkmLjo4LbTnB8nP9EPvzUndoReeTiYPHjUOgyvkG2JO7Bge49Rh8RS6SKiMq29HWVgEGalZsNEuLxoPRgkKPWpjUI6r4pQba1C4Mxhj4EEZ8nM54oRzGtceozu/Et7F37879oGlROtUQ+ZhimDHUdEO0nmdziCauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634384; c=relaxed/simple;
	bh=vVyCpFktMjWYkykzwu/C1HFeuytaQchuFkffsMGX0yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY8uhQge305ujGY2OVGAc7JOVCzkS48dsPtbioQolGv5IjBQImFz8oljcmNDwtLen/1oh7g0CDgTzT1Nce/XFnMHi2y4SeAOcRAz0KAdzHDCf9sSALd8GA9Xw55g8Y3HID5vq/VKQikC+e5eaG5hg/zAUzSPpfsruhlUUzYCFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF86C433F1;
	Tue, 30 Jan 2024 17:06:22 +0000 (UTC)
Date: Tue, 30 Jan 2024 12:06:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240130120634.2f0ecd0a@gandalf.local.home>
In-Reply-To: <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
	<CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
	<20240130093942.56206ff1@gandalf.local.home>
	<20240130114947.5bc856b0@gandalf.local.home>
	<CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 08:55:51 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 08:49, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - On removal, I got rid of the SRCU callback and the work queue.
> >   Instead, I find the dentry of the current eventfs_inode that is being
> >   deleted by walking the ei->parent until I find the events inode that has
> >   a dentry. I then use that to do a lookup walking back down to the
> >   eventfs_inode I want to delete. This gives me the dentry that I can call
> >   d_invalidate() on.  
> 
> Yes, that works.
> 
> However, I have a patch that is *much* smaller and simpler, and
> doesn't need that walk.
> 
> The VFS layer already has a good interface for "should I still use
> this dentry", which is needed for various network filesystems etc that
> want to time out caches (or check explicitly whether the file still
> exists etc): it's the dentry d_revalidate() check.
> 
> Let me just reboot into it to test that I got all the cases.
> 
> It makes the code even more obvious, and avoids all the complexity.


I actually had this before, but it wasn't working (likely to something else
that wasn't working or I did it wrong) so I reverted it.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 49d4630d5d70..9867b39ae24c 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -451,6 +451,13 @@ lookup_file_dentry(struct dentry *dentry,
 	return dentry;
 }
 
+int eventfs_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct eventfs_inode *ei = dentry->d_fsdata;
+
+	return ei && !ei->is_freed;
+}
+
 /**
  * eventfs_root_lookup - lookup routine to create file/dir
  * @dir: in which a lookup is being done
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..0395459d919e 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -392,8 +392,24 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
 	iput(inode);
 }
 
+static int tracefs_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct tracefs_inode *ti;
+
+	if (!dentry || !inode)
+		return 0;
+
+	ti = get_tracefs(inode);
+	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
+		return 1;
+
+	return eventfs_revalidate(dentry, flags);
+}
+
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_dentry_iput,
+	.d_iput		= tracefs_dentry_iput,
+	.d_revalidate	= tracefs_revalidate,
 };
 
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 2af78fd95c93..a1024202c4e5 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -80,5 +80,6 @@ struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
+int eventfs_revalidate(struct dentry *dentry, unsigned int flags);
 
 #endif /* _TRACEFS_INTERNAL_H */


