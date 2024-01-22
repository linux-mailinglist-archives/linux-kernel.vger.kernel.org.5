Return-Path: <linux-kernel+bounces-33329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752F836872
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47307287690
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE860EDE;
	Mon, 22 Jan 2024 15:05:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B373D981
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935904; cv=none; b=JPdJM5Q/INdC1bbUqWO+ZF1LEQFPzS9nH4dZrS22XeA7tD7iFjGU4vi4Q9HLdOrk72vZolJHJ22TOs2GYsYwGlzvPmKIJcxL1FzOCF2gtoskP9DoGf/0XClV1LLRLlWiBZI54PHzhjheagiy31Hak1vnviun755jVOftMG1Koec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935904; c=relaxed/simple;
	bh=3lfCvPhZrkU82LwCUZZgALjuBUjL/R+aLt6h+1xcMls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gvd33FCeaqTCnOSsGjwpE2BuGB1pItdJRenCphGFZXlRm0ZXf9oKo9fdPHlEfn1cjnPpofUlMr1kRlqRbDrcNUuizcIHh6vmatmM6Q8VzVoBB4uOvHKfCWUFOi8XkOQfUOZcVuy+SbGkBP8Ke82wIPJkdhMvohWGEI+vuq90ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F17C43390;
	Mon, 22 Jan 2024 15:05:02 +0000 (UTC)
Date: Mon, 22 Jan 2024 10:06:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240122100630.6a400dd3@gandalf.local.home>
In-Reply-To: <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 11:38:52 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Stephen,

I don't know who "Stephen" is, but I'll reply to this message.

>=20
> On Wed, Jan 17, 2024 at 3:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > The dentries and inodes are created in the readdir for the sole purpose=
 of
> > getting a consistent inode number. Linus stated that is unnecessary, and
> > that all inodes can have the same inode number. For a virtual file syst=
em
> > they are pretty meaningless.
> >
> > Instead use a single unique inode number for all files and one for all
> > directories.
> >
> > Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.local=
home/

Yeah, Linus wanted me to try this first and see if there's any regressions.
Well, I guess you just answered that.

The above link has me saying to Linus:

  It was me being paranoid that using the same inode number would break user
  space. If that is not a concern, then I'm happy to just make it either the
  same, or maybe just hash the ei and name that it is associated with.

> > Link: https://lore.kernel.org/linux-trace-kernel/20240116211353.4121803=
63@goodmis.org
> >
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Al  Viro <viro@ZenIV.linux.org.uk>
> > Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org> =20
>=20
> Thanks for your patch, which is now commit 53c41052ba312176 ("eventfs:
> Have the inodes all for files and directories all be the same") in
> v6.8-rc1, to which I have bisected the issue below.
>=20
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> > @@ -32,6 +32,10 @@
> >   */
> >  static DEFINE_MUTEX(eventfs_mutex);
> >
> > +/* Choose something "unique" ;-) */
> > +#define EVENTFS_FILE_INODE_INO         0x12c4e37
> > +#define EVENTFS_DIR_INODE_INO          0x134b2f5
> > +
> >  /*
> >   * The eventfs_inode (ei) itself is protected by SRCU. It is released =
from
> >   * its parent's list and will have is_freed set (under eventfs_mutex).
> > @@ -352,6 +356,9 @@ static struct dentry *create_file(const char *name,=
 umode_t mode,
> >         inode->i_fop =3D fop;
> >         inode->i_private =3D data;
> >
> > +       /* All files will have the same inode number */
> > +       inode->i_ino =3D EVENTFS_FILE_INODE_INO;
> > +
> >         ti =3D get_tracefs(inode);
> >         ti->flags |=3D TRACEFS_EVENT_INODE;
> >         d_instantiate(dentry, inode);
> > @@ -388,6 +395,9 @@ static struct dentry *create_dir(struct eventfs_ino=
de *ei, struct dentry *parent
> >         inode->i_op =3D &eventfs_root_dir_inode_operations;
> >         inode->i_fop =3D &eventfs_file_operations;
> >
> > +       /* All directories will have the same inode number */
> > +       inode->i_ino =3D EVENTFS_DIR_INODE_INO;
> > +
> >         ti =3D get_tracefs(inode);
> >         ti->flags |=3D TRACEFS_EVENT_INODE; =20
>=20
> This confuses "find".
> Running "find /sys/" now prints lots of error messages to stderr:
>=20
> find: File system loop detected;
> =E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_finish=E2=80=
=99 is part of
> the same file system loop as
> =E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.

So at a minimum, the directories need to have unique inode numbers.


> find: File system loop detected;
> =E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_start=E2=80=
=99 is part of
> the same file system loop as
> =E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
> find: File system loop detected;
> =E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_level=E2=80=
=99 is part of
> the same file system loop as
> =E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
> [...]

Does this fix it for you? It hashes the eventfs_inode data structure after
adding some salt to it.

Kees,=20

I'm using the eventfs_inode pointer to create a unique value for the inode.
But it's being salted, hashed and then truncated. As it is very easy to
read inodes (although by default, only root has access to read these
inodes), the inode numbers themselves shouldn't be able to leak kernel
addresses via the results of these inode numbers, would it?

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6795fda2af19..d54897b84596 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -19,6 +19,7 @@
 #include <linux/namei.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#include <linux/siphash.h>
 #include <linux/tracefs.h>
 #include <linux/kref.h>
 #include <linux/delay.h>
@@ -36,6 +37,31 @@ static DEFINE_MUTEX(eventfs_mutex);
 #define EVENTFS_FILE_INODE_INO		0x12c4e37
 #define EVENTFS_DIR_INODE_INO		0x134b2f5
=20
+/* Used for making inode numbers */
+static siphash_key_t inode_key;
+
+/* Copied from scripts/kconfig/symbol.c */
+static unsigned strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned hash =3D 2166136261U;
+	for (; *s; s++)
+		hash =3D (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+/* Just try to make something consistent and unique */
+static int eventfs_dir_ino(struct event_inode *ei, const char *name)
+{
+	unsigned long sip =3D (unsigned long)ei;
+
+	sip +=3D strhash(name) + EVENTFS_DIR_INODE_INO;
+	sip =3D siphash_1u32((int)sip, &inode_key);
+
+	/* keep it positive */
+	return sip & ((1U << 31) - 1);
+}
+
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
@@ -396,7 +422,7 @@ static struct dentry *create_dir(struct eventfs_inode *=
ei, struct dentry *parent
 	inode->i_fop =3D &eventfs_file_operations;
=20
 	/* All directories will have the same inode number */
-	inode->i_ino =3D EVENTFS_DIR_INODE_INO;
+	inode->i_ino =3D eventfs_dir_ino(ei, ei->name);
=20
 	ti =3D get_tracefs(inode);
 	ti->flags |=3D TRACEFS_EVENT_INODE;
@@ -802,7 +828,7 @@ static int eventfs_iterate(struct file *file, struct di=
r_context *ctx)
=20
 		name =3D ei_child->name;
=20
-		ino =3D EVENTFS_DIR_INODE_INO;
+		ino =3D eventfs_dir_ino(ei_child, name);
=20
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
@@ -932,6 +958,9 @@ struct eventfs_inode *eventfs_create_events_dir(const c=
har *name, struct dentry
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
=20
+	if (siphash_key_is_zero(&inode_key))
+		get_random_bytes(&inode_key, sizeof(inode_key));
+
 	ei =3D kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
 		goto fail_ei;


