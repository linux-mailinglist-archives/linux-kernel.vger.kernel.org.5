Return-Path: <linux-kernel+bounces-34080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F738372F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C996B1F2AFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB9482D1;
	Mon, 22 Jan 2024 19:43:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516340BFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952596; cv=none; b=b8wkiFQpxA9Nf6xnS5/MZ7MplrR8WVmNqWcorbq8PqMkNJxXfXrFaswG+8qrVVBYuBublAH0UAXZ2k/iGDCmjGeQZZvsS8i66TETWkNARmCQFmBqVfCzRQURVr2NGTt07RX3fFjya5GQD58ADnVVPtxVyPasmp5+EZMoFXjnGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952596; c=relaxed/simple;
	bh=APLT5/CBDphC8mudeBX/2b3K2clsUaZ7Ahhh3sk29lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUnrzGb42wYRr7efjgeHr0RyHlSrLHUL/pbt9mudkBbgs+vZ7UTziZDJthMwMZdum2tiAwLCKkOSESYhNbtyuy8QCm5u8cWDwNDJSdJDBKuEJqPAdNAyfPwUcRoVUsIbBzv9s0xNcIPqTZAri/L+V9s7QkSLdP6Qa3pBr4jNAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89518C43390;
	Mon, 22 Jan 2024 19:43:14 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:44:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <keescook@chromium.org>, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240122144443.0f9cf5b9@gandalf.local.home>
In-Reply-To: <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:19:12 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 22 Jan 2024 at 09:39, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Actually, why not juist add an inode number to your data structures,
> > at least for directories? And just do a static increment on it as they
> > get registered?
> >
> > That avoids the whole issue with possibly leaking kernel address data.  
> 
> The 'nlink = 1' thing doesn't seem to make 'find' any happier for this
> case, sadly.
> 
> But the inode number in the 'struct eventfs_inode' looks trivial. And
> doesn't even grow that structure on 64-bit architectures at least,
> because the struct is already 64-bit aligned, and had only one 32-bit
> entry at the end.
> 
> On 32-bit architectures the structure size grows, but I'm not sure the
> allocation size grows. Our kmalloc() is quantized at odd numbers.
> 
> IOW, this trivial patch seems to be much safer than worrying about
> some pointer exposure.

I originally wanted to avoid the addition of the 4 bytes, but your comment
about it not making a difference on 64bit due to alignment makes sense.

Slightly different version below.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6795fda2af19..6b211522a13e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -34,7 +34,15 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 /* Choose something "unique" ;-) */
 #define EVENTFS_FILE_INODE_INO		0x12c4e37
-#define EVENTFS_DIR_INODE_INO		0x134b2f5
+
+/* Just try to make something consistent and unique */
+static int eventfs_dir_ino(struct eventfs_inode *ei)
+{
+	if (!ei->ino)
+		ei->ino = get_next_ino();
+
+	return ei->ino;
+}
 
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
@@ -396,7 +404,7 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
-	inode->i_ino = EVENTFS_DIR_INODE_INO;
+	inode->i_ino = eventfs_dir_ino(ei);
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
@@ -802,7 +810,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		name = ei_child->name;
 
-		ino = EVENTFS_DIR_INODE_INO;
+		ino = eventfs_dir_ino(ei_child);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 12b7d0150ae9..1a574d306ea9 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -64,6 +64,7 @@ struct eventfs_inode {
 		struct llist_node	llist;
 		struct rcu_head		rcu;
 	};
+	unsigned int			ino;
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
 	unsigned int			nr_entries:30;

