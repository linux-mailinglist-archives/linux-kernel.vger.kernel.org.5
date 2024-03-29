Return-Path: <linux-kernel+bounces-123998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110C8910EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4590E28C54E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A24F887;
	Fri, 29 Mar 2024 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xjNF1C5Y"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFB4F896
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677281; cv=none; b=itTJ0tEeQ7cYE1LIv7eOMojsXRcZ91mG/rgK1WvmY6w158QUi4zACWadK85hP/THFm8vbsi4rzyl2OKUPpF++Hlqt8XSA3VYfXielGwYjFavEBNS+sGhu3tIlxuTX6kGH8YLzqHN5nWfTbRXK5Y4aetXkU/LQPytRgwKjH2GU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677281; c=relaxed/simple;
	bh=VDSeOrmRZ4SYUgVp5dmLfIcaprrVde6t7qHG+s7E0hM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OzNqwlgxQZPavdlgh9bRTFr1m6kKvAKa6f6StvO22qgv6GklVb3SQ1Wj0aqDxOGCJuCSxWQY37UyHpB8DnOf6lXCAQVbMDUlH2LAX/0Nc9Xd2pR+dUDn2V6vArO9fTIoWF3zS1kSQY1Oo+ncpIF6qAsOLNwurQ6ZRgumrn7Z+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xjNF1C5Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so2835665276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677279; x=1712282079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MD93gZe61lT3bi7JodQUSrve0t6PielHvOmvulo6VTY=;
        b=xjNF1C5YPXePjkco0M80fBcxpb+MmIATViMfO03Q2/jEL8D8O3Ju61ojnbD8Jfr1pk
         /LquOyMrFOhHEg18gs6Al6S4a2ejuGaNnU5mQxKsMJzU6MVp4tJ67ILdanewwzlhhsoW
         EKh1hm4/ZTbt8cS8r0Od4xMG3Blkz5LmD+24ErHVbHVp/iqaP8JFSsjSxzAJ+4e9ABwB
         dAzeUcDsS3xvgQHr2lQuW7lYqDHnSJ6K0ViojESwwR+W1wSGsxlwjeh1V+HDz92oTHsG
         1YIOHPmlXzZSiQL+P5XaG/XOxAVBUoRGUy7KI+SmW/k70Rcb6232G0ixdQiyNB2lY5aG
         2VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677279; x=1712282079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD93gZe61lT3bi7JodQUSrve0t6PielHvOmvulo6VTY=;
        b=RfmQGxyqqcBcC7BI1Ygijz0IY3vhhaKHUKbZG327Y2HcbCStMoFpdkWuR+XlGkOmb+
         AQ46yBt+MwoRHOte+fBTP3O/rOwsxEPT/BwUnbTK65SZr11mV7LExq/uLN2j2iDLpQuC
         kiwMLyU056/DGN+yhtaV+vqo59LK7o6lNWIlQ0dx45voq3rIpZa6OOTDJ1CanEKz08q/
         5PsOfE2Hkmjh7NWY4XbIT3V+5yavMs1V773Nmla3alyQ0U7vZw52bUIL59a6zRzzT0Ft
         +COs8C9ra0cSALl5f9MNTfcdCJBVF58VSWlsNZHYI8Ak+G0fmrsVq9dHcJGzuktlfZOC
         wwUw==
X-Forwarded-Encrypted: i=1; AJvYcCVfNxGhfb3hwcRW1BuvWUxHspyccBxwm9U+jKLj16DJZjGd/xkan8kp041n8UrAR6f/RS3h1GeoRUMXKFvBFJgHHrXBYeRkLRxlCfMa
X-Gm-Message-State: AOJu0YwjUXujJ8b3L/mSo2REhsOSfwctBZCfH4ea6TN/LJrmzEwHNJXV
	6TaWicSC7fEvf4s8kA3fdAJCbVtp74EJ2tq7KPJoCz16D8nE+f4QIRNrhgT3ouQIWwsQtmhxmon
	G1g==
X-Google-Smtp-Source: AGHT+IGhQUHEXr/GrzTbtSCdL1hqHgZVQAU0Jz8rAd+h7Sr956bHJaSbQ8HK4gIpji8SRFQsstttWqHj/A8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:1884:b0:dc6:cafd:dce5 with SMTP id
 cj4-20020a056902188400b00dc6cafddce5mr296080ybb.12.1711677279199; Thu, 28 Mar
 2024 18:54:39 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:33 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-19-drosen@google.com>
Subject: [RFC PATCH v4 18/36] fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
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

This adds backing support for FUSE_COPY_FILE_RANGE

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  4 +++
 fs/fuse/fuse_i.h  | 10 ++++++
 3 files changed, 101 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index e426268aa4e6..2363f392e915 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/fs_stack.h>
 #include <linux/namei.h>
+#include <linux/splice.h>
 #include <linux/uio.h>
 
 /*
@@ -778,6 +779,92 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 				file, offset, whence);
 }
 
+struct fuse_copy_file_range_args {
+	struct fuse_copy_file_range_in in;
+	struct fuse_write_out out;
+};
+
+static int fuse_copy_file_range_initialize_in(struct bpf_fuse_args *fa,
+					      struct fuse_copy_file_range_args *args,
+					      struct file *file_in, loff_t pos_in, struct file *file_out,
+					      loff_t pos_out, size_t len, unsigned int flags)
+{
+	struct fuse_file *fuse_file_in = file_in->private_data;
+	struct fuse_file *fuse_file_out = file_out->private_data;
+
+	args->in = (struct fuse_copy_file_range_in) {
+		.fh_in = fuse_file_in->fh,
+		.off_in = pos_in,
+		.nodeid_out = fuse_file_out->nodeid,
+		.fh_out = fuse_file_out->fh,
+		.off_out = pos_out,
+		.len = len,
+		.flags = flags,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(file_in->f_inode),
+			.opcode = FUSE_COPY_FILE_RANGE,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+	};
+
+	return 0;
+}
+
+static int fuse_copy_file_range_initialize_out(struct bpf_fuse_args *fa,
+					       struct fuse_copy_file_range_args *args,
+					       struct file *file_in, loff_t pos_in, struct file *file_out,
+					       loff_t pos_out, size_t len, unsigned int flags)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+static int fuse_copy_file_range_backing(struct bpf_fuse_args *fa, ssize_t *out, struct file *file_in,
+					loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+					unsigned int flags)
+{
+	const struct fuse_copy_file_range_in *fci = fa->in_args[0].value;
+	struct fuse_file *fuse_file_in = file_in->private_data;
+	struct file *backing_file_in = fuse_file_in->backing_file;
+	struct fuse_file *fuse_file_out = file_out->private_data;
+	struct file *backing_file_out = fuse_file_out->backing_file;
+
+	/* TODO: Handle changing of in/out files */
+	if (backing_file_out)
+		*out = vfs_copy_file_range(backing_file_in, fci->off_in, backing_file_out,
+					   fci->off_out, fci->len, fci->flags);
+	else
+		*out = splice_copy_file_range(file_in, pos_in, file_out, pos_out, len);
+	return 0;
+}
+
+static int fuse_copy_file_range_finalize(struct bpf_fuse_args *fa, ssize_t *out, struct file *file_in,
+					 loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+					 unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *file_in,
+			     loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+			     unsigned int flags)
+{
+	return bpf_fuse_backing(inode, struct fuse_copy_file_range_args, out,
+				fuse_copy_file_range_initialize_in,
+				fuse_copy_file_range_initialize_out,
+				fuse_copy_file_range_backing,
+				fuse_copy_file_range_finalize,
+				file_in, pos_in, file_out, pos_out, len, flags);
+}
+
 static int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *in,
 				    struct file *file, loff_t start, loff_t end, int datasync)
 {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5983faf59c1f..46de67810f03 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3168,6 +3168,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	bool is_unstable = (!fc->writeback_cache) &&
 			   ((pos_out + len) > inode_out->i_size);
 
+	if (fuse_bpf_copy_file_range(&err, file_inode(file_in), file_in, pos_in,
+				     file_out, pos_out, len, flags))
+		return err;
+
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 61a17071ab02..a95d543c79ae 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1454,6 +1454,9 @@ int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *file_in, loff_t pos_in,
+			     struct file *file_out, loff_t pos_out,
+			     size_t len, unsigned int flags);
 int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
@@ -1533,6 +1536,13 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
 	return 0;
 }
 
+static inline int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *file_in, loff_t pos_in,
+					   struct file *file_out, loff_t pos_out,
+					   size_t len, unsigned int flags)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


