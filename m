Return-Path: <linux-kernel+bounces-124000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F758910F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02E51C266C4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40264CC9;
	Fri, 29 Mar 2024 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSBrSuSY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1D54659
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677287; cv=none; b=SzQ/IxTf5EiC+aweIBxZUIF79fIoUpFPmNQFp1DdVSQAO/9+lO7f70GrGaimJ0qtLadrUGSyaf9d83OQ7rM8rkJ8ivRcsLjS+Jua42qSjs/Tp7UECW5wpWg45CZYtT19IHe8QuN0n0tLGNSwNqYa/tmP9JDyvJF4XOYd152At2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677287; c=relaxed/simple;
	bh=QfML3qc9UJHMHe73CHYhpNf8LXROJQ2njklWSzdnUWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mo1JdJ/WJDRa8lvQyFFhN4/OQG0hQtyZbct3tPPzmS24+RmkqiARzOZdlgQqdrVQJoLAwlc54TJf/cgmbilI4Wnis5f82nHBmR1QAY7pc1E4VIGYJ1TY0Al4fH3gx1CqzK5/Uh+ikcTnZPVoAGeid1ee6AT/a5hEnUCDepOPhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSBrSuSY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so3088200276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677283; x=1712282083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3P1bhmbT6iU17mlNzbCJY7IYTyE6K2uvRKWPaZ4NGDM=;
        b=SSBrSuSYVwJeix6FZq2iwk2avUZOibF9DgBrT5sUJZHioKN3GsGsg5oz4uRE/83+jG
         Wkr5q0k+KDKknTcxIMANKe8oKtjYLr2dOm3SKMQyXc/Lo9CmbVmg+Qfx2nQPK7EhpltW
         htebZfSX/M08Ps5k9VW1dcVupLZ8mdGBcEbDgvrJJLwUpv1smsgqPg+GMUEMPv36Qyh4
         MWzEbILAJ9jw2Fm+50A1nLQJbQPbeJGXct1YAjyj67c+YPNfx1bYhkScq+/x5SWmLZA/
         FV+U3cO6HGIoMadU5ZMkxpSunXJfCxBdcqnY0ZhmukatSmcNP2FD61upZhHDCJNomd/Y
         KAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677283; x=1712282083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3P1bhmbT6iU17mlNzbCJY7IYTyE6K2uvRKWPaZ4NGDM=;
        b=mf3jNAQ/fz+xHK5MdOChKIpoR46DZ9F64RBFfxg2vANCINNXxszSY+oW27cIciW7BL
         9SKYVunPAiUK11LKnZJjYmPW7KkmLvi0RO8hwJa8Kyg1NgAFlfoYyD64RfzgTe844gU4
         pgLBegT9niiFT0SyLnuKAuQTgMUIS/nqgOxJk8lvTDo45kJMuS47jQwbykDla3wm5n+i
         TyWPoK25QnomW5lXMFBGa+5wxtA4kxkA0AWAhTkoH7zz6EAi/liq8S49rj0yTmxTznVy
         p3jqQEcm2EeWuupWMZCygHt+7jrsJgVNULR/b3SwgXANbdDY5yclI9BuT66TAvuYvdE2
         WsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz8EZl77Tq1+Yx+KVPqvzygmncFWSdtz0BtQgKpi08/MkCQnUYaeHQbnj8W4ymZIZSsAVAQ6syLVAbsKLy24HgD0OWPfxU3FFZFixr
X-Gm-Message-State: AOJu0Yz/n4bFFtJE5SaSTaQySgv+z0yfXBwZ5s9/AKWGrAZn4Zpsh1F3
	e+wEgQUAeB96Za2VMFIsGgJgBVfE/I68IC+e2LKBdl6HHdAQRGplr7eZDQbj0S0dTAaXXc83r37
	kvQ==
X-Google-Smtp-Source: AGHT+IHgSug0jzbXQ+VMbPe8iA95JXmQc6vNb8Aqcyo87ghk95a5rdtG5sohFlX0zvcPZBd2OCeTo3AxAyA=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a25:c753:0:b0:dd3:f55f:ff02 with SMTP id
 w80-20020a25c753000000b00dd3f55fff02mr840561ybe.1.1711677283612; Thu, 28 Mar
 2024 18:54:43 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:35 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-21-drosen@google.com>
Subject: [RFC PATCH v4 20/36] fuse-bpf: Add symlink/link support
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds backing support for FUSE_LINK, FUSE_READLINK, and FUSE_SYMLINK

Signed-off-by: Daniel Rosenberg <drosen@google.com
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 327 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  11 ++
 fs/fuse/fuse_i.h  |  20 +++
 3 files changed, 358 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 3390ce66e393..f18aee297335 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -2490,6 +2490,125 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_link_args {
+	struct fuse_link_in in;
+	struct fuse_buffer name;
+};
+
+static int fuse_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_link_args *args,
+				   struct dentry *entry, struct inode *dir,
+				   struct dentry *newent)
+{
+	struct inode *src_inode = entry->d_inode;
+
+	*args = (struct fuse_link_args) {
+		.in = (struct fuse_link_in) {
+			.oldnodeid = get_node_id(src_inode),
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) newent->d_name.name,
+			.size = newent->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_LINK,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_link_args *args,
+				    struct dentry *entry, struct inode *dir,
+				    struct dentry *newent)
+{
+	return 0;
+}
+
+static int fuse_link_backing(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+			     struct inode *dir, struct dentry *newent)
+{
+	struct path backing_old_path;
+	struct path backing_new_path;
+	struct dentry *backing_dir_dentry;
+	struct inode *fuse_new_inode = NULL;
+	struct fuse_inode *fuse_dir_inode = get_fuse_inode(dir);
+	struct inode *backing_dir_inode = fuse_dir_inode->backing_inode;
+
+	*out = 0;
+	get_fuse_backing_path(entry, &backing_old_path);
+	if (!backing_old_path.dentry)
+		return -EBADF;
+
+	get_fuse_backing_path(newent, &backing_new_path);
+	if (!backing_new_path.dentry) {
+		*out = -EBADF;
+		goto err_dst_path;
+	}
+
+	backing_dir_dentry = dget_parent(backing_new_path.dentry);
+	backing_dir_inode = d_inode(backing_dir_dentry);
+
+	inode_lock_nested(backing_dir_inode, I_MUTEX_PARENT);
+	*out = vfs_link(backing_old_path.dentry, &nop_mnt_idmap,
+		       backing_dir_inode, backing_new_path.dentry, NULL);
+	inode_unlock(backing_dir_inode);
+	if (*out)
+		goto out;
+
+	if (d_really_is_negative(backing_new_path.dentry) ||
+	    unlikely(d_unhashed(backing_new_path.dentry))) {
+		*out = -EINVAL;
+		/**
+		 * TODO: overlayfs responds to this situation with a
+		 * lookupOneLen. Should we do that too?
+		 */
+		goto out;
+	}
+
+	fuse_new_inode = fuse_iget_backing(dir->i_sb, fuse_dir_inode->nodeid, backing_dir_inode);
+	if (IS_ERR(fuse_new_inode)) {
+		*out = PTR_ERR(fuse_new_inode);
+		goto out;
+	}
+	d_instantiate(newent, fuse_new_inode);
+
+out:
+	dput(backing_dir_dentry);
+	path_put(&backing_new_path);
+err_dst_path:
+	path_put(&backing_old_path);
+	return *out;
+}
+
+static int fuse_link_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+			      struct inode *dir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry,
+		  struct inode *newdir, struct dentry *newent)
+{
+	return bpf_fuse_backing(inode, struct fuse_link_args, out,
+				fuse_link_initialize_in, fuse_link_initialize_out,
+				fuse_link_backing, fuse_link_finalize,
+				entry, newdir, newent);
+}
+
 struct fuse_getattr_args {
 	struct fuse_getattr_in in;
 	struct fuse_attr_out out;
@@ -2786,6 +2905,214 @@ int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct
 				dentry, buf);
 }
 
+struct fuse_get_link_args {
+	struct fuse_buffer name;
+	struct fuse_buffer path;
+};
+
+static int fuse_get_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_get_link_args *args,
+				       struct inode *inode, struct dentry *dentry,
+				       struct delayed_call *callback)
+{
+	/*
+	 * TODO
+	 * If we want to handle changing these things, we'll need to copy
+	 * the lower fs's data into our own buffer, and provide our own callback
+	 * to free that buffer.
+	 *
+	 * Pre could change the name we're looking at
+	 * postfilter can change the name we return
+	 *
+	 * We ought to only make that buffer if it's been requested, so leaving
+	 * this unimplemented for the moment
+	 */
+	*args = (struct fuse_get_link_args) {
+		.name = (struct fuse_buffer) {
+			.data =  (void *) dentry->d_name.name,
+			.size = dentry->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_READLINK,
+			.nodeid = get_node_id(inode),
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_get_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_get_link_args *args,
+					struct inode *inode, struct dentry *dentry,
+					struct delayed_call *callback)
+{
+	// TODO
+#if 0
+	args->path = (struct fuse_buffer) {
+		.data =  NULL,
+		.size = 0,
+		.max_size = PATH_MAX,
+		.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+	};
+	fa->out_numargs = 1;
+	fa->out_args[0].is_buffer = true;
+	fa->out_args[0].buffer = &args->path;
+#endif
+
+	return 0;
+}
+
+static int fuse_get_link_backing(struct bpf_fuse_args *fa, const char **out,
+				 struct inode *inode, struct dentry *dentry,
+				 struct delayed_call *callback)
+{
+	struct path backing_path;
+
+	if (!dentry) {
+		*out = ERR_PTR(-ECHILD);
+		return PTR_ERR(*out);
+	}
+
+	get_fuse_backing_path(dentry, &backing_path);
+	if (!backing_path.dentry) {
+		*out = ERR_PTR(-ECHILD);
+		return PTR_ERR(*out);
+	}
+
+	/*
+	 * TODO: If we want to do our own thing, copy the data and then call the
+	 * callback
+	 */
+	*out = vfs_get_link(backing_path.dentry, callback);
+
+	path_put(&backing_path);
+	return 0;
+}
+
+static int fuse_get_link_finalize(struct bpf_fuse_args *fa, const char **out,
+				  struct inode *inode, struct dentry *dentry,
+				  struct delayed_call *callback)
+{
+	return 0;
+}
+
+int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback)
+{
+	return bpf_fuse_backing(inode, struct fuse_get_link_args, out,
+				fuse_get_link_initialize_in, fuse_get_link_initialize_out,
+				fuse_get_link_backing, fuse_get_link_finalize,
+				inode, dentry, callback);
+}
+
+struct fuse_symlink_args {
+	struct fuse_buffer name;
+	struct fuse_buffer path;
+};
+
+static int fuse_symlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_symlink_args *args,
+				      struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	*args = (struct fuse_symlink_args) {
+		.name = (struct fuse_buffer) {
+			.data =  (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+		.path = (struct fuse_buffer) {
+			.data = (void *) link,
+			.size = len,
+			.max_size = PATH_MAX,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_SYMLINK,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->path,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_symlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_symlink_args *args,
+				       struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+static int fuse_symlink_backing(struct bpf_fuse_args *fa, int *out,
+				struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	struct fuse_inode *fuse_inode = get_fuse_inode(dir);
+	struct inode *backing_inode = fuse_inode->backing_inode;
+	struct path backing_path;
+	struct inode *inode = NULL;
+
+	*out = 0;
+	//TODO Actually deal with changing the backing entry in symlink
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	*out = vfs_symlink(&nop_mnt_idmap, backing_inode, backing_path.dentry,
+			  link);
+	inode_unlock(backing_inode);
+	if (*out)
+		goto out;
+	if (d_really_is_negative(backing_path.dentry) ||
+	    unlikely(d_unhashed(backing_path.dentry))) {
+		*out = -EINVAL;
+		/**
+		 * TODO: overlayfs responds to this situation with a
+		 * lookupOneLen. Should we do that too?
+		 */
+		goto out;
+	}
+	inode = fuse_iget_backing(dir->i_sb, fuse_inode->nodeid, backing_inode);
+	if (IS_ERR(inode)) {
+		*out = PTR_ERR(inode);
+		goto out;
+	}
+	d_instantiate(entry, inode);
+out:
+	path_put(&backing_path);
+	return *out;
+}
+
+static int  fuse_symlink_finalize(struct bpf_fuse_args *fa, int *out,
+				  struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+int  fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return bpf_fuse_backing(dir, struct fuse_symlink_args, out,
+				fuse_symlink_initialize_in, fuse_symlink_initialize_out,
+				fuse_symlink_backing, fuse_symlink_finalize,
+				dir, entry, link, len);
+}
+
 struct fuse_read_args {
 	struct fuse_read_in in;
 	struct fuse_read_out out;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 77d231ab1d9c..08f93a981665 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1033,6 +1033,10 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_symlink(&err, dir, entry, link, len))
+		return err;
 
 	args.opcode = FUSE_SYMLINK;
 	args.in_numargs = 2;
@@ -1239,6 +1243,9 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 
+	if (fuse_bpf_link(&err, inode, entry, newdir, newent))
+		return err;
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
 	args.opcode = FUSE_LINK;
@@ -1741,12 +1748,16 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct page *page;
+	const char *out = NULL;
 	int err;
 
 	err = -EIO;
 	if (fuse_is_bad(inode))
 		goto out_err;
 
+	if (fuse_bpf_get_link(&out, inode, dentry, callback))
+		return out;
+
 	if (fc->cache_symlinks)
 		return page_get_link(dentry, inode, callback);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 127758575ddc..8ae6ad967f95 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1450,6 +1450,7 @@ int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
 int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
 		    struct inode *newdir, struct dentry *newent);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry, struct inode *dir, struct dentry *newent);
 int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
@@ -1474,6 +1475,9 @@ int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry,
 		     u32 request_mask, unsigned int flags);
 int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file);
 int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf);
+int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback);
+int fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len);
 int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1523,6 +1527,11 @@ static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *en
 	return 0;
 }
 
+static inline int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry, struct inode *dir, struct dentry *newent)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
 {
 	return 0;
@@ -1619,6 +1628,17 @@ static inline int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *
 	return 0;
 }
 
+static inline int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


