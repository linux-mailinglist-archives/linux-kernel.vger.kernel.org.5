Return-Path: <linux-kernel+bounces-40162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381A83DB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987001C23FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAD1BDE3;
	Fri, 26 Jan 2024 14:06:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC561B97B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277964; cv=none; b=S0nUv9zGo0P6DhlUUbPHMLclS7YHp5qET8QfcBp8lUCI8FL8vEQ8cL9KpOB2t+4Xy2SSGsz9HM7lo3N405MUktZu1GuQXdozdh/ISex6XdviXmGukF3nkY3NL13g0t5Q3f8KS6iMFU+4fDo09UtTaWRH7CrFmEmf7DcQXMR0LIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277964; c=relaxed/simple;
	bh=pB4aTR0H8GSp+J4w+t4Fc/k6+B8Y0W5PB1c6YGk7qPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXB3R9qrb09DsGfeiNouppAd/PkTibVibV/jT0vUUgmDri/u3ZSlk0cgLfrCKwUTT2cggW0n4RZmHROp066ergFz0B/yfBBXwWzyT3VMvTeyToxSS1bG80VeOfGGMTqHS8bof5uv40PIZ5ifcz9dvqxreDjqMdSD4tD+FruEIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E360C43141;
	Fri, 26 Jan 2024 14:06:02 +0000 (UTC)
Date: Fri, 26 Jan 2024 09:06:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240126090604.3cbbfe72@gandalf.local.home>
In-Reply-To: <20240126081616.28c02f10@gandalf.local.home>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
	<20240122144443.0f9cf5b9@gandalf.local.home>
	<20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
	<20240125130731.3b0e2a42@gandalf.local.home>
	<20240125130821.0a1cd3a7@gandalf.local.home>
	<CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
	<20240126081616.28c02f10@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jan 2024 08:16:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 26 Jan 2024 09:07:06 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>=20
> > Hi Steven.
> >=20
> > On Thu, Jan 25, 2024 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
org> wrote: =20
> > > On Thu, 25 Jan 2024 13:07:31 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:   =20
> > > > Actually, inodes isn't the biggest issue of tar, as tar *is* a comm=
on
> > > > operation on tracefs.   =20
> > >
> > > Correction. tar would be a common operation if it worked ;-)   =20
> >=20
> > What would be needed to fix that?  I regularly use tar on other virtual
> > file systems (e.g. /sys/firmware/devicetree/), which works fine. =20
>=20
> Looks like all /sys files have one page in size. I could change the defau=
lt
> file size to one page and it might work (if the inodes had different
> numbers), as I don't see any format file greater than 4k.
>=20
> This would fix the events for tar, but it couldn't do the same for tracin=
g.
> As some files don't actually have a size.

And this patch makes a unique inode number for files too.

I also found a slight bug where the inode number is generated twice. Once
to create the inode, and then again overwriting it with the eventfs inode
logic. That just makes it more likely for the inode numbers to overflow.

This fixes that too.

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6b211522a13e..7be7a694b106 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -32,14 +32,11 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
=20
-/* Choose something "unique" ;-) */
-#define EVENTFS_FILE_INODE_INO		0x12c4e37
-
 /* Just try to make something consistent and unique */
-static int eventfs_dir_ino(struct eventfs_inode *ei)
+static int eventfs_dir_ino(struct eventfs_inode *ei, int nr_files)
 {
 	if (!ei->ino)
-		ei->ino =3D get_next_ino();
+		ei->ino =3D tracefs_get_next_ino(nr_files);
=20
 	return ei->ino;
 }
@@ -327,6 +324,7 @@ void eventfs_update_gid(struct dentry *dentry, kgid_t g=
id)
  * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
+ * @ino: inode number for this file
  *
  * This function creates a dentry that represents a file in the eventsfs_i=
node
  * directory. The inode.i_private pointer will point to @data in the open()
@@ -335,7 +333,8 @@ void eventfs_update_gid(struct dentry *dentry, kgid_t g=
id)
 static struct dentry *create_file(const char *name, umode_t mode,
 				  struct eventfs_attr *attr,
 				  struct dentry *parent, void *data,
-				  const struct file_operations *fop)
+				  const struct file_operations *fop,
+				  unsigned int ino)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
@@ -363,9 +362,7 @@ static struct dentry *create_file(const char *name, umo=
de_t mode,
 	inode->i_op =3D &eventfs_file_inode_operations;
 	inode->i_fop =3D fop;
 	inode->i_private =3D data;
-
-	/* All files will have the same inode number */
-	inode->i_ino =3D EVENTFS_FILE_INODE_INO;
+	inode->i_ino =3D ino;
=20
 	ti =3D get_tracefs(inode);
 	ti->flags |=3D TRACEFS_EVENT_INODE;
@@ -377,12 +374,14 @@ static struct dentry *create_file(const char *name, u=
mode_t mode,
 /**
  * create_dir - create a dir in the tracefs filesystem
  * @ei: the eventfs_inode that represents the directory to create
- * @parent: parent dentry for this file.
+ * @parent: parent dentry for this directory.
+ * @nr_files: The number of files (not directories) this directory has
  *
  * This function will create a dentry for a directory represented by
  * a eventfs_inode.
  */
-static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *=
parent)
+static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *=
parent,
+				 int nr_files)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
@@ -404,7 +403,7 @@ static struct dentry *create_dir(struct eventfs_inode *=
ei, struct dentry *parent
 	inode->i_fop =3D &eventfs_file_operations;
=20
 	/* All directories will have the same inode number */
-	inode->i_ino =3D eventfs_dir_ino(ei);
+	inode->i_ino =3D eventfs_dir_ino(ei, nr_files);
=20
 	ti =3D get_tracefs(inode);
 	ti->flags |=3D TRACEFS_EVENT_INODE;
@@ -504,7 +503,7 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
=20
 	mutex_unlock(&eventfs_mutex);
=20
-	dentry =3D create_file(name, mode, attr, parent, data, fops);
+	dentry =3D create_file(name, mode, attr, parent, data, fops, ei->ino + id=
x + 1);
=20
 	mutex_lock(&eventfs_mutex);
=20
@@ -598,7 +597,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eve=
ntfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
=20
-	dentry =3D create_dir(ei, parent);
+	dentry =3D create_dir(ei, parent, ei->nr_entries);
=20
 	mutex_lock(&eventfs_mutex);
=20
@@ -786,7 +785,7 @@ static int eventfs_iterate(struct file *file, struct di=
r_context *ctx)
 		if (r <=3D 0)
 			continue;
=20
-		ino =3D EVENTFS_FILE_INODE_INO;
+		ino =3D ei->ino + i + 1;
=20
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
 			goto out;
@@ -810,7 +809,7 @@ static int eventfs_iterate(struct file *file, struct di=
r_context *ctx)
=20
 		name =3D ei_child->name;
=20
-		ino =3D eventfs_dir_ino(ei_child);
+		ino =3D eventfs_dir_ino(ei_child, ei_child->nr_entries);
=20
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..2187be6d7b23 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -223,13 +223,41 @@ static const struct inode_operations tracefs_file_ino=
de_operations =3D {
 	.setattr	=3D tracefs_setattr,
 };
=20
+/* Copied from get_next_ino() but adds allocation for multiple inodes */
+#define LAST_INO_BATCH 1024
+#define LAST_INO_MASK (~(LAST_INO_BATCH - 1))
+static DEFINE_PER_CPU(unsigned int, last_ino);
+
+unsigned int tracefs_get_next_ino(int files)
+{
+	unsigned int *p =3D &get_cpu_var(last_ino);
+	unsigned int res =3D *p;
+
+#ifdef CONFIG_SMP
+	/* Check if adding files+1 overflows */
+	if (unlikely(!res || (res & LAST_INO_MASK) !=3D ((res + files + 1) & LAST=
_INO_MASK))) {
+		static atomic_t shared_last_ino;
+		int next =3D atomic_add_return(LAST_INO_BATCH, &shared_last_ino);
+
+		res =3D next - LAST_INO_BATCH;
+	}
+#endif
+
+	res++;
+	/* get_next_ino should not provide a 0 inode number */
+	if (unlikely(!res))
+		res++;
+	*p =3D res + files;
+	put_cpu_var(last_ino);
+	return res;
+}
+
 struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode =3D new_inode(sb);
-	if (inode) {
-		inode->i_ino =3D get_next_ino();
+	if (inode)
 		simple_inode_init_ts(inode);
-	}
+
 	return inode;
 }
=20
@@ -644,6 +672,8 @@ struct dentry *tracefs_create_file(const char *name, um=
ode_t mode,
 	inode->i_private =3D data;
 	inode->i_uid =3D d_inode(dentry->d_parent)->i_uid;
 	inode->i_gid =3D d_inode(dentry->d_parent)->i_gid;
+	inode->i_ino =3D tracefs_get_next_ino(0);
+
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
@@ -669,6 +699,7 @@ static struct dentry *__create_dir(const char *name, st=
ruct dentry *parent,
 	inode->i_fop =3D &simple_dir_operations;
 	inode->i_uid =3D d_inode(dentry->d_parent)->i_uid;
 	inode->i_gid =3D d_inode(dentry->d_parent)->i_gid;
+	inode->i_ino =3D tracefs_get_next_ino(0);
=20
 	ti =3D get_tracefs(inode);
 	ti->private =3D instance_inode(parent, inode);
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 45397df9bb65..7dd6678229d0 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -75,6 +75,7 @@ static inline struct tracefs_inode *get_tracefs(const str=
uct inode *inode)
 	return container_of(inode, struct tracefs_inode, vfs_inode);
 }
=20
+unsigned int tracefs_get_next_ino(int files);
 struct dentry *tracefs_start_creating(const char *name, struct dentry *par=
ent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);


