Return-Path: <linux-kernel+bounces-23357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0782AB89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631F01C21F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94613FFE;
	Thu, 11 Jan 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MxWgyTEi"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB412E4B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AE+YN7mp8tF8D2TsFEMmNTNNM/8+22BnneF03zOJeSI=; b=MxWgyTEibe0nbD8DrPgp9yAtAH
	bVKTEPq1tCLdQWKI1WRnOtkqgM166AITsqWs8tg4V+sL1RIhwLy7C9pQbV5HovfqIs8N0WU5NvWXD
	Tu587/Y9atBTG3mQfotN6D9febysciM59ZBzJOelJxcICJ++lK301szSUoUYPMAMKAUyfqNJG6x0x
	y5X9TO+2AhKokrBlI+xOUSVmgOMeTB054YHtAenrBzxgf8ywjU2r+oa57IkL+WWpGekdjw2SEy6Q+
	babGHgPGHq/VxO9S1EGRuFsM/fE2ALEWthfg2zR+ICBgNiHB7BUKotNjunxGoolFwAvALS+CQVkc0
	fyaAcTag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNrvp-00C8wo-06;
	Thu, 11 Jan 2024 10:05:01 +0000
Date: Thu, 11 Jan 2024 10:05:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Kees Cook <kees@kernel.org>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
Message-ID: <20240111100501.GU1674809@ZenIV>
References: <202401081028.0E908F9E0A@keescook>
 <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
 <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost>
 <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
 <20240111094711.GT1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111094711.GT1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 11, 2024 at 09:47:11AM +0000, Al Viro wrote:
> Doable, but really not pretty, especially since we'd need to massage
> the caller as well...  Less painful variant is
> 	if (error == -ECHILD && (flags & LOOKUP_RCU))
> 		return ERR_PTR(-ECHILD); // keep file for non-rcu pass
> 	*fp = NULL;
> 	fput(file);
> 	...
> on the way out; that won't help with -ESTALE side of things, but if we
> hit *that*, struct file allocation overhead is really noise.

Something like (completely untested) delta below, perhaps?

diff --git a/fs/namei.c b/fs/namei.c
index 5c318d657503..de770be9bb16 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3765,15 +3765,17 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	return error;
 }
 
-static struct file *path_openat(struct nameidata *nd,
+static int path_openat(struct nameidata *nd, struct file **fp,
 			const struct open_flags *op, unsigned flags)
 {
-	struct file *file;
+	struct file *file = *fp;
 	int error;
 
-	file = alloc_empty_file(op->open_flag, current_cred());
-	if (IS_ERR(file))
-		return file;
+	if (!file) {
+		file = alloc_empty_file(op->open_flag, current_cred());
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+	}
 
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
 		error = do_tmpfile(nd, flags, op, file);
@@ -3789,11 +3791,17 @@ static struct file *path_openat(struct nameidata *nd,
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
-		if (likely(file->f_mode & FMODE_OPENED))
-			return file;
+		if (likely(file->f_mode & FMODE_OPENED)) {
+			*fp = file;
+			return 0;
+		}
 		WARN_ON(1);
 		error = -EINVAL;
 	}
+	if (error == -ECHILD && (flags & LOOKUP_RCU)) {
+		*fp = file; // reuse on the next pass
+		return -ECHILD;
+	}
 	fput(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
@@ -3801,7 +3809,7 @@ static struct file *path_openat(struct nameidata *nd,
 		else
 			error = -ESTALE;
 	}
-	return ERR_PTR(error);
+	return error;
 }
 
 struct file *do_filp_open(int dfd, struct filename *pathname,
@@ -3809,25 +3817,27 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 {
 	struct nameidata nd;
 	int flags = op->lookup_flags;
-	struct file *filp;
+	struct file *file = NULL;
+	int err;
 
 	set_nameidata(&nd, dfd, pathname, NULL);
-	filp = path_openat(&nd, op, flags | LOOKUP_RCU);
-	if (unlikely(filp == ERR_PTR(-ECHILD)))
-		filp = path_openat(&nd, op, flags);
-	if (unlikely(filp == ERR_PTR(-ESTALE)))
-		filp = path_openat(&nd, op, flags | LOOKUP_REVAL);
+	err = path_openat(&nd, &file, op, flags | LOOKUP_RCU);
+	if (unlikely(err == -ECHILD))
+		err = path_openat(&nd, &file, op, flags);
+	if (unlikely(err == -ESTALE))
+		err = path_openat(&nd, &file, op, flags | LOOKUP_REVAL);
 	restore_nameidata();
-	return filp;
+	return unlikely(err) ? ERR_PTR(err) : file;
 }
 
 struct file *do_file_open_root(const struct path *root,
 		const char *name, const struct open_flags *op)
 {
 	struct nameidata nd;
-	struct file *file;
+	struct file *file = NULL;
 	struct filename *filename;
 	int flags = op->lookup_flags;
+	int err;
 
 	if (d_is_symlink(root->dentry) && op->intent & LOOKUP_OPEN)
 		return ERR_PTR(-ELOOP);
@@ -3837,14 +3847,14 @@ struct file *do_file_open_root(const struct path *root,
 		return ERR_CAST(filename);
 
 	set_nameidata(&nd, -1, filename, root);
-	file = path_openat(&nd, op, flags | LOOKUP_RCU);
-	if (unlikely(file == ERR_PTR(-ECHILD)))
-		file = path_openat(&nd, op, flags);
-	if (unlikely(file == ERR_PTR(-ESTALE)))
-		file = path_openat(&nd, op, flags | LOOKUP_REVAL);
+	err = path_openat(&nd, &file, op, flags | LOOKUP_RCU);
+	if (unlikely(err == -ECHILD))
+		err = path_openat(&nd, &file, op, flags);
+	if (unlikely(err == -ESTALE))
+		err = path_openat(&nd, &file, op, flags | LOOKUP_REVAL);
 	restore_nameidata();
 	putname(filename);
-	return file;
+	return unlikely(err) ? ERR_PTR(err) : file;
 }
 
 static struct dentry *filename_create(int dfd, struct filename *name,

