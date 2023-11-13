Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53C7EA23D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKMRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:42:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71810D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:42:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B062C433C7;
        Mon, 13 Nov 2023 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699897374;
        bh=GvHsZwWFyBbOmgdMIiuY7KVvsqvi0xw6MBF+719M2QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6AuzKKHJ2Ee+MAoLNFYOfSTVlRJqRRy7P83lZ0W0mgnT1md6z4sfMqCO5TpkGyNk
         2LjYo9bDA5C2BnBHycu/inlUZYnz9n/23175Fgkb9zgKsBzNqwRb3PF6Qr/FwLbh/9
         anh7keseTiEBe3pxaPa9y+42Baz9zO+LEHTyw8Xq5F9Ma0+Roo6vKax2fLYi0AgQCc
         8bxZfG8wG6Fi3q8UAVFPHhx9SBo8mYI8NyJjYzz/UH8MwgEHq2YQfprI1qHwKE7Omi
         z+RkQS8IKT7zvYwKSbJBEcBmTmtWvMbXhaJoK6J+OCEusboGIoAYitMtRcDzLmZ7vb
         QSa5F9LHG7f6Q==
Date:   Mon, 13 Nov 2023 18:42:52 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH v1 0/1] fs: Consider capabilities relative to namespace
 for linkat permission check
Message-ID: <20231113-undenkbar-gediegen-efde5f1c34bc@brauner>
References: <20231110170615.2168372-1-cmirabil@redhat.com>
 <20231112-bekriegen-branche-fbc86a9aaa5e@brauner>
 <CABe3_aHqQPjePNPsCu2GEt_uX4dZ0WVrFBQH5p+LCFE9JQxq7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABe3_aHqQPjePNPsCu2GEt_uX4dZ0WVrFBQH5p+LCFE9JQxq7w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 11:15:00PM -0500, Charles Mirabile wrote:
> On Sun, Nov 12, 2023 at 3:14 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Nov 10, 2023 at 12:06:14PM -0500, Charles Mirabile wrote:
> > > This is a one line change that makes `linkat` aware of namespaces when
> > > checking for capabilities.
> > >
> > > As far as I can tell, the call to `capable` in this code dates back to
> > > before the `ns_capable` function existed, so I don't think the author
> > > specifically intended to prefer regular `capable` over `ns_capable`,
> > > and no one has noticed or cared to change it yet... until now!
> > >
> > > It is already hard enough to use `linkat` to link temporarily files
> > > into the filesystem without the `/proc` workaround, and when moving
> > > a program that was working fine on bare metal into a container,
> > > I got hung up on this additional snag due to the lack of namespace
> > > awareness in `linkat`.
> >
> > I agree that it would be nice to relax this a bit to make this play
> > nicer with containers.
> >
> > The current checks want to restrict scenarios where an application is
> > able to create a hardlink for an arbitrary file descriptor it has
> > received via e.g., SCM_RIGHTS or that it has inherited.
> Makes sense.
> >
> > So we want to somehow get a good enough approximation to the question
> > whether the caller would have been able to open the source file.
> >
> > When we check for CAP_DAC_READ_SEARCH in the caller's namespace we
> > presuppose that the file is accessible in the current namespace and that
> > CAP_DAC_READ_SEARCH would have been enough to open it. Both aren't
> > necessarily true. Neither need the file be accessible, e.g., due to a
> > chroot or pivot_root nor need CAP_DAC_READ_SEARCH be enough. For
> > example, the file could be accessible in the caller's namespace but due
> > to uid/gid mapping the {g,u}id of the file doesn't have a mapping in the
> > caller's namespace. So that doesn't really cut it imho.
> Good point.
> >
> > However, if we check for CAP_DAC_READ_SEARCH in the namespace the file
> > was opened in that could work. We know that the file must've been
> > accessible in the namespace the file was opened in and we
> > know that the {g,u}id of the file must have been mapped in the namespace
> > the file was opened in. So if we check that the caller does have
> > CAP_DAC_READ_SEARCH in the opener's namespace we can approximate that
> > the caller could've opened the file.
> Would that be the namespace pointed to by `->f_cred->user_ns`  on the
> struct file corresponding to the fd?

Yes.

> 
> If so is there a better way to surface that struct file for checking than this?
> error=-ENOENT;
> if(flags & AT_EMPTY_PATH && !old->name[0]) {
>     struct file *file = fget(oldfd);
>     bool capable = ns_capable(file->f_cred->user_ns, CAP_DAC_READ_SEARCH);
>     fput(file);
>     if(!capable)
>         goto out_putnames;

Two observations:

(1) The current do_linkat() has a bug when the caller passes
    AT_EMPTY_PATH with an absolute path. In that case getname_uflags()
    will handle this fine and ignore AT_EMPTY_PATH but do_linkat() will
    perform the capable() check even though the path isn't empty. 
(2) io_uring uses do_linkat() but doesn't actually support AT_EMPTY_PATH
    because it calls getname(), not getname_flags(). Maybe that's
    intentional. In any case, it would need a separate patch for
    io_uring to enable that functionality.

I think for your case you need something like the below where you bubble
up whether the path is empty from getname_flags() and pass that to
do_linkat() which can then perform the privilege check only for the case
where the source path is actually empty. That will also fix (1).

(not even compile tested)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..6d69d1a9d89e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -61,7 +61,7 @@ int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 int do_mkdirat(int dfd, struct filename *name, umode_t mode);
 int do_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int do_linkat(int olddfd, struct filename *old, int newdfd,
-			struct filename *new, int flags);
+			struct filename *new, int flags, bool is_empty);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..acbadd0a0f74 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4610,11 +4610,11 @@ EXPORT_SYMBOL(vfs_link);
  * and other special files.  --ADM
  */
 int do_linkat(int olddfd, struct filename *old, int newdfd,
-	      struct filename *new, int flags)
+	      struct filename *new, int flags, bool is_empty)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *new_dentry;
-	struct path old_path, new_path;
+	struct path old_path, new_path, old_root;
 	struct inode *delegated_inode = NULL;
 	int how = 0;
 	int error;
@@ -4623,22 +4623,38 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		error = -EINVAL;
 		goto out_putnames;
 	}
-	/*
-	 * To use null names we require CAP_DAC_READ_SEARCH
-	 * This ensures that not everyone will be able to create
-	 * handlink using the passed filedescriptor.
-	 */
-	if (flags & AT_EMPTY_PATH && !capable(CAP_DAC_READ_SEARCH)) {
-		error = -ENOENT;
-		goto out_putnames;
-	}
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
 retry:
-	error = filename_lookup(olddfd, old, how, &old_path, NULL);
-	if (error)
-		goto out_putnames;
+	if (is_empty) {
+		struct fd f;
+
+		f = fdget_raw(olddfd);
+		if (!f.file) {
+			error = -EBADF;
+			goto out_putnames;
+		}
+
+		/*
+		 * To use null names we require CAP_DAC_READ_SEARCH in the
+		 * opener's namespace to verify that the caller does have
+		 * privileges in the openers namespace. This restricts creating
+		 * hardlinks for arbitrary inherited or received file
+		 * descriptors.
+		 */
+		if (!ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
+			fdput(f);
+			error = -ENOENT;
+			goto out_putnames;
+		}
+		old_root = f.file->f_path;
+		path_get(&old_root);
+		error = filename_lookup(olddfd, old, how, &old_path, &old_root);
+		path_put(&old_root);
+	} else {
+		error = filename_lookup(olddfd, old, how, &old_path, NULL);
+	}
 
 	new_dentry = filename_create(newdfd, new, &new_path,
 					(how & LOOKUP_REVAL));
@@ -4684,13 +4700,17 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname, int, flags)
 {
-	return do_linkat(olddfd, getname_uflags(oldname, flags),
-		newdfd, getname(newname), flags);
+	int lflags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	int is_empty = 0;
+	struct filename *ofilename = getname_flags(oldname, lflags, &is_empty);
+	return do_linkat(olddfd, ofilename, newdfd, getname(newname),
+			flags, is_empty);
 }
 
 SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname)
 {
-	return do_linkat(AT_FDCWD, getname(oldname), AT_FDCWD, getname(newname), 0);
+	return do_linkat(AT_FDCWD, getname(oldname), AT_FDCWD,
+		getname(newname), 0, false);
 }
 
 /**
diff --git a/io_uring/fs.c b/io_uring/fs.c
index 08e3b175469c..a9e1e498001a 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -277,7 +277,7 @@ int io_linkat(struct io_kiocb *req, unsigned int issue_flags)
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
 	ret = do_linkat(lnk->old_dfd, lnk->oldpath, lnk->new_dfd,
-				lnk->newpath, lnk->flags);
+				lnk->newpath, lnk->flags, false);
 
 	req->flags &= ~REQ_F_NEED_CLEANUP;
 	io_req_set_res(req, ret, 0);
-- 
2.34.1

