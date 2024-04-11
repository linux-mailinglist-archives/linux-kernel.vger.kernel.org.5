Return-Path: <linux-kernel+bounces-140801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E917F8A190A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD64B27F29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F858ACD;
	Thu, 11 Apr 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v8V1cY81"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E351C52
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849562; cv=none; b=fQdTURja3YEYUqxDsnBI0KTrfLiaw6ivJFVKAl/fU+VRke+fZemPpqkpPoX+VBraHak3dU/NptnVPgNCtYVOHf5rGEsoQDWd16hMfR5Ay0BrWq+vofzRtKvWB1zBOs3alszbwVPEZ0BSBIvp/Cxr7ZQ/MuiRLx4OMyVXoteM2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849562; c=relaxed/simple;
	bh=J+WmHATCp14kKHUEy0eX+FtmZxga0kJQhTadbxIyiRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfsgEYwJdelFLKYTidfkWrF75pWt7fFKWTBnMQ5dE01fS7/S1YWDyYSKJyNz4Q3JwmW3MQC5VZqRQtQ40nxqpx8RxP1BLyyo6KzLoGKhArIcF7Al36c/mVIrnpehUe4cJU57deprVWyShTyV/tpxuOPeT4pLlcCzwaPMNvhIMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v8V1cY81; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16105139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849558; x=1713454358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMefPYkEf8my1jLSvMn4cpZU1c9njZA6L4Oy07dUl70=;
        b=v8V1cY81U3b4SMjA4ehzMm87TCSeROy/eHj0u6WoZPDuduYhw1Xju+YE1YkkLvv5di
         tNIkHITVD6IVfAWbBNnTaSaPMgZlhotkOwiTr9BJWbqsFZ+P2TX0okarXWbGwUUIKM43
         57u1JuYpSZSWwnxIBuPFsR1oNhuP3ayX3xXC52WMWZSZPe4ssz2zml+XPAF/QGt5hy00
         PtCexkeh+9KG5QXcq43zZWuqEpxgpKu45xqw+dyeRWQqB+KoBzEggbkOOuj3Q2iw/yoK
         Qb/EOTrydlrttUyMV12ExDG1aiU+kS13oml7lskLhZKCuFiMZTy8IY9/uocvICykCnC9
         cCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849558; x=1713454358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMefPYkEf8my1jLSvMn4cpZU1c9njZA6L4Oy07dUl70=;
        b=hLTiEfF39Hl76qQP/04KrEuZojspFj39zRqgD7x9Dq07yz7tB2paQvIol03O9PagtH
         nmLCGsGdJhlr4NZOSJn5qGzxLGF/5eroC/8ZqOclDjB12uRtcudclMzAfVnM8nUGtZ0J
         84G5Ip6xg8CRfsHoF76U2/+Z5qOyYV0C0uJpdZ5169RaG6gN+WlwymzRfOmXmwMz840Z
         iiHgjPEyg57x8rk8svgyfr6wmVnz43hsjqnPoGwNAug/j/B0daeZWYe0y82dSP3pLqig
         xoOqGa/m/S94FVcWa63bEIYrml2YuKeTC4h2jKJz42sOLfVm3eU9ZdSzi53DftPC+EcZ
         FEhw==
X-Gm-Message-State: AOJu0Yx7fm3hlpAmJlz+BtDNnp3KLKzxYVdvpVLDfLAvdbqneWHvZ/aN
	i/LeGzZzcfo4syw6fgIhdz/aQB6VAW9MBo8VYVAuNgeMfKKu96O9rYqloXHjTHd0cjk0obwN+nU
	B
X-Google-Smtp-Source: AGHT+IFH8AxSAfiSP7b7w1CWrByLwkWM3SDRFWuDm9Nbj+dK1q9Ut2B30l3Ehf1wpsd5uYRjZANpRg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr199234iog.0.1712849558000;
        Thu, 11 Apr 2024 08:32:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 040/437] fs: convert generic_read_dir() to ->read_iter()
Date: Thu, 11 Apr 2024 09:13:00 -0600
Message-ID: <20240411153126.16201-41-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes here, just a straight forward mechanical
conversion.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/powerpc/platforms/cell/spufs/inode.c |  2 +-
 fs/9p/vfs_dir.c                           |  4 ++--
 fs/adfs/dir.c                             |  2 +-
 fs/affs/dir.c                             |  2 +-
 fs/autofs/root.c                          |  4 ++--
 fs/bcachefs/fs.c                          |  2 +-
 fs/befs/linuxvfs.c                        |  2 +-
 fs/bfs/dir.c                              |  2 +-
 fs/btrfs/inode.c                          |  2 +-
 fs/coda/dir.c                             |  2 +-
 fs/configfs/dir.c                         |  2 +-
 fs/cramfs/inode.c                         |  2 +-
 fs/ecryptfs/file.c                        |  2 +-
 fs/efs/dir.c                              |  2 +-
 fs/erofs/dir.c                            |  2 +-
 fs/exfat/dir.c                            |  2 +-
 fs/ext2/dir.c                             |  2 +-
 fs/ext4/dir.c                             |  2 +-
 fs/f2fs/dir.c                             |  2 +-
 fs/fat/dir.c                              |  2 +-
 fs/freevxfs/vxfs_lookup.c                 |  2 +-
 fs/fuse/dir.c                             |  2 +-
 fs/hfs/dir.c                              |  2 +-
 fs/hfsplus/dir.c                          |  2 +-
 fs/hostfs/hostfs_kern.c                   |  2 +-
 fs/hpfs/dir.c                             |  2 +-
 fs/isofs/dir.c                            |  2 +-
 fs/jffs2/dir.c                            |  2 +-
 fs/jfs/namei.c                            |  2 +-
 fs/kernfs/dir.c                           |  2 +-
 fs/libfs.c                                |  8 ++++----
 fs/minix/dir.c                            |  2 +-
 fs/nfs/dir.c                              |  2 +-
 fs/nilfs2/dir.c                           |  2 +-
 fs/ntfs3/dir.c                            |  2 +-
 fs/ocfs2/file.c                           |  4 ++--
 fs/omfs/dir.c                             |  2 +-
 fs/openpromfs/inode.c                     |  2 +-
 fs/orangefs/dir.c                         |  2 +-
 fs/overlayfs/readdir.c                    |  2 +-
 fs/proc/base.c                            | 12 ++++++------
 fs/proc/fd.c                              |  4 ++--
 fs/proc/generic.c                         |  2 +-
 fs/proc/namespaces.c                      |  2 +-
 fs/proc/proc_net.c                        |  2 +-
 fs/proc/proc_sysctl.c                     |  2 +-
 fs/proc/root.c                            |  2 +-
 fs/qnx4/dir.c                             |  2 +-
 fs/qnx6/dir.c                             |  2 +-
 fs/reiserfs/dir.c                         |  2 +-
 fs/romfs/super.c                          |  2 +-
 fs/smb/client/cifsfs.c                    |  2 +-
 fs/squashfs/dir.c                         |  2 +-
 fs/sysv/dir.c                             |  2 +-
 fs/tracefs/event_inode.c                  |  2 +-
 fs/ubifs/dir.c                            |  2 +-
 fs/udf/dir.c                              |  2 +-
 fs/ufs/dir.c                              |  2 +-
 fs/vboxsf/dir.c                           |  2 +-
 fs/xfs/xfs_file.c                         |  2 +-
 fs/zonefs/super.c                         |  2 +-
 include/linux/fs.h                        |  2 +-
 62 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 030de2b8c145..cdb3cc344eb4 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -220,7 +220,7 @@ const struct file_operations spufs_context_fops = {
 	.open		= dcache_dir_open,
 	.release	= spufs_dir_close,
 	.llseek		= dcache_dir_lseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= dcache_readdir,
 	.fsync		= noop_fsync,
 };
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..b1e2a8b7b289 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -237,7 +237,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 }
 
 const struct file_operations v9fs_dir_operations = {
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.llseek = generic_file_llseek,
 	.iterate_shared = v9fs_dir_readdir,
 	.open = v9fs_file_open,
@@ -245,7 +245,7 @@ const struct file_operations v9fs_dir_operations = {
 };
 
 const struct file_operations v9fs_dir_operations_dotl = {
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.llseek = generic_file_llseek,
 	.iterate_shared = v9fs_dir_readdir_dotl,
 	.open = v9fs_file_open,
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 77fbd196008f..22b93599d4bb 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -385,7 +385,7 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 }
 
 const struct file_operations adfs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.llseek		= generic_file_llseek,
 	.iterate_shared	= adfs_iterate,
 	.fsync		= generic_file_fsync,
diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index b2bf7016e1b3..dc51f7bfbb27 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -20,7 +20,7 @@
 static int affs_readdir(struct file *, struct dir_context *);
 
 const struct file_operations affs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.llseek		= generic_file_llseek,
 	.iterate_shared	= affs_readdir,
 	.fsync		= affs_file_fsync,
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 530d18827e35..eb69ab79633d 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -32,7 +32,7 @@ static void autofs_dentry_release(struct dentry *);
 const struct file_operations autofs_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= dcache_readdir,
 	.llseek		= dcache_dir_lseek,
 	.unlocked_ioctl	= autofs_root_ioctl,
@@ -44,7 +44,7 @@ const struct file_operations autofs_root_operations = {
 const struct file_operations autofs_dir_operations = {
 	.open		= autofs_dir_open,
 	.release	= dcache_dir_close,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= dcache_readdir,
 	.llseek		= dcache_dir_lseek,
 };
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index b5ea9fa1259d..a804e1a898f2 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1156,7 +1156,7 @@ static const struct inode_operations bch_dir_inode_operations = {
 
 static const struct file_operations bch_dir_file_operations = {
 	.llseek		= bch2_dir_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= bch2_vfs_readdir,
 	.fsync		= bch2_fsync,
 	.unlocked_ioctl = bch2_fs_file_ioctl,
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index d76f406d3b2e..24af5f365539 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -77,7 +77,7 @@ static const struct super_operations befs_sops = {
 static struct kmem_cache *befs_inode_cachep;
 
 static const struct file_operations befs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= befs_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index c375e22c4c0c..d646e597402b 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -69,7 +69,7 @@ static int bfs_readdir(struct file *f, struct dir_context *ctx)
 }
 
 const struct file_operations bfs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= bfs_readdir,
 	.fsync		= generic_file_fsync,
 	.llseek		= generic_file_llseek,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c65fe5de4022..2aa1bb9977e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11029,7 +11029,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 
 static const struct file_operations btrfs_dir_file_operations = {
 	.llseek		= btrfs_dir_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,
 	.unlocked_ioctl	= btrfs_ioctl,
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 4e552ba7bd43..b0f80d6324fa 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -581,7 +581,7 @@ const struct inode_operations coda_dir_inode_operations = {
 WRAP_DIR_ITER(coda_readdir) // FIXME!
 const struct file_operations coda_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= shared_coda_readdir,
 	.open		= coda_open,
 	.release	= coda_release,
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 18677cd4e62f..3bfee6589f77 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1706,7 +1706,7 @@ const struct file_operations configfs_dir_operations = {
 	.open		= configfs_dir_open,
 	.release	= configfs_dir_close,
 	.llseek		= configfs_dir_lseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= configfs_readdir,
 };
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9901057a15ba..fd73b433a5ad 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -933,7 +933,7 @@ static const struct address_space_operations cramfs_aops = {
  */
 static const struct file_operations cramfs_directory_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= cramfs_readdir,
 };
 
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index ce0a3c5ed0ca..96e24760f1c6 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -414,7 +414,7 @@ ecryptfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 const struct file_operations ecryptfs_dir_fops = {
 	.iterate_shared = ecryptfs_readdir,
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.unlocked_ioctl = ecryptfs_unlocked_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = ecryptfs_compat_ioctl,
diff --git a/fs/efs/dir.c b/fs/efs/dir.c
index f892ac7c2a35..4071a68d31a8 100644
--- a/fs/efs/dir.c
+++ b/fs/efs/dir.c
@@ -12,7 +12,7 @@ static int efs_readdir(struct file *, struct dir_context *);
 
 const struct file_operations efs_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= efs_readdir,
 };
 
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index b80abec0531a..0241036883e2 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -106,6 +106,6 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 const struct file_operations erofs_dir_fops = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= erofs_readdir,
 };
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 077944d3c2c0..90482fcca07a 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -309,7 +309,7 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 WRAP_DIR_ITER(exfat_iterate) // FIXME!
 const struct file_operations exfat_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= shared_exfat_iterate,
 	.unlocked_ioctl = exfat_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 4fb155b5a958..93fa6c54286d 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -706,7 +706,7 @@ int ext2_empty_dir(struct inode *inode)
 
 const struct file_operations ext2_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= ext2_readdir,
 	.unlocked_ioctl = ext2_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..955679a8f6b3 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -666,7 +666,7 @@ int ext4_check_all_de(struct inode *dir, struct buffer_head *bh, void *buf,
 
 const struct file_operations ext4_dir_operations = {
 	.llseek		= ext4_dir_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= ext4_readdir,
 	.unlocked_ioctl = ext4_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 02c9355176d3..1338883797bd 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1133,7 +1133,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 const struct file_operations f2fs_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= f2fs_readdir,
 	.fsync		= f2fs_sync_file,
 	.unlocked_ioctl	= f2fs_ioctl,
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 00235b8a1823..79b569cf2ea3 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -857,7 +857,7 @@ static long fat_compat_dir_ioctl(struct file *filp, unsigned cmd,
 
 const struct file_operations fat_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= fat_readdir,
 	.unlocked_ioctl	= fat_dir_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 1b0bca8b4cc6..cf4dd54adc9c 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -34,7 +34,7 @@ const struct inode_operations vxfs_dir_inode_ops = {
 
 const struct file_operations vxfs_dir_operations = {
 	.llseek =		generic_file_llseek,
-	.read =			generic_read_dir,
+	.read_iter =		generic_read_dir,
 	.iterate_shared =	vxfs_readdir,
 };
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4a6df591add6..b59420d3284b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2149,7 +2149,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
 
 static const struct file_operations fuse_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= fuse_readdir,
 	.open		= fuse_dir_open,
 	.release	= fuse_dir_release,
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index b75c26045df4..cb20b9419a1b 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -307,7 +307,7 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 }
 
 const struct file_operations hfs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= hfs_readdir,
 	.llseek		= generic_file_llseek,
 	.release	= hfs_dir_release,
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..6910ed8a0f54 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -575,7 +575,7 @@ const struct inode_operations hfsplus_dir_inode_operations = {
 
 const struct file_operations hfsplus_dir_operations = {
 	.fsync		= hfsplus_file_fsync,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= hfsplus_readdir,
 	.unlocked_ioctl = hfsplus_ioctl,
 	.llseek		= generic_file_llseek,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..4f3a7d9d8949 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -390,7 +390,7 @@ static const struct file_operations hostfs_file_fops = {
 static const struct file_operations hostfs_dir_fops = {
 	.llseek		= generic_file_llseek,
 	.iterate_shared	= hostfs_readdir,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.open		= hostfs_open,
 	.fsync		= hostfs_fsync,
 };
diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index 49dd585c2b17..2672f123cbda 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -322,7 +322,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 const struct file_operations hpfs_dir_ops =
 {
 	.llseek		= hpfs_dir_lseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= hpfs_readdir,
 	.release	= hpfs_dir_release,
 	.fsync		= hpfs_file_fsync,
diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index eb2f8273e6f1..278f5111feb3 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -268,7 +268,7 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.iterate_shared = isofs_readdir,
 };
 
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 2b2938970da3..6b6a8228d75c 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -43,7 +43,7 @@ static int jffs2_rename (struct mnt_idmap *, struct inode *,
 
 const struct file_operations jffs2_dir_operations =
 {
-	.read =		generic_read_dir,
+	.read_iter =	generic_read_dir,
 	.iterate_shared=jffs2_readdir,
 	.unlocked_ioctl=jffs2_ioctl,
 	.fsync =	jffs2_fsync,
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..e6d27d7b9636 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1539,7 +1539,7 @@ const struct inode_operations jfs_dir_inode_operations = {
 
 WRAP_DIR_ITER(jfs_readdir) // FIXME!
 const struct file_operations jfs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= shared_jfs_readdir,
 	.fsync		= jfs_fsync,
 	.unlocked_ioctl = jfs_ioctl,
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe..12f57e4d8664 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1880,7 +1880,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 }
 
 const struct file_operations kernfs_dir_fops = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= kernfs_fop_readdir,
 	.release	= kernfs_dir_fop_release,
 	.llseek		= generic_file_llseek,
diff --git a/fs/libfs.c b/fs/libfs.c
index 90f79113e48b..3280d02fc385 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -220,7 +220,7 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
 }
 EXPORT_SYMBOL(dcache_readdir);
 
-ssize_t generic_read_dir(struct file *filp, char __user *buf, size_t siz, loff_t *ppos)
+ssize_t generic_read_dir(struct kiocb *iocb, struct iov_iter *to)
 {
 	return -EISDIR;
 }
@@ -230,7 +230,7 @@ const struct file_operations simple_dir_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
 	.llseek		= dcache_dir_lseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= dcache_readdir,
 	.fsync		= noop_fsync,
 };
@@ -527,7 +527,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 const struct file_operations simple_offset_dir_operations = {
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.fsync		= noop_fsync,
 };
 
@@ -1856,7 +1856,7 @@ static int empty_dir_readdir(struct file *file, struct dir_context *ctx)
 
 static const struct file_operations empty_dir_operations = {
 	.llseek		= empty_dir_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= empty_dir_readdir,
 	.fsync		= noop_fsync,
 };
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index a224cf222570..4cd7f7a0b412 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -21,7 +21,7 @@ static int minix_readdir(struct file *, struct dir_context *);
 
 const struct file_operations minix_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= minix_readdir,
 	.fsync		= generic_file_fsync,
 };
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..bb746c6fa8eb 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -59,7 +59,7 @@ static void nfs_readdir_clear_array(struct folio *);
 
 const struct file_operations nfs_dir_operations = {
 	.llseek		= nfs_llseek_dir,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= nfs_readdir,
 	.open		= nfs_opendir,
 	.release	= nfs_closedir,
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index bc846b904b68..9aea991801af 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -646,7 +646,7 @@ int nilfs_empty_dir(struct inode *inode)
 
 const struct file_operations nilfs_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= nilfs_readdir,
 	.unlocked_ioctl	= nilfs_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 5cf3d9decf64..c7913821c238 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -607,7 +607,7 @@ bool dir_is_empty(struct inode *dir)
 // clang-format off
 const struct file_operations ntfs_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= ntfs_readdir,
 	.fsync		= generic_file_fsync,
 	.open		= ntfs_file_open,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 0da8e7bd3261..dc55dc87af7a 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2796,7 +2796,7 @@ const struct file_operations ocfs2_fops = {
 WRAP_DIR_ITER(ocfs2_readdir) // FIXME!
 const struct file_operations ocfs2_dops = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= shared_ocfs2_readdir,
 	.fsync		= ocfs2_sync_file,
 	.release	= ocfs2_dir_release,
@@ -2842,7 +2842,7 @@ const struct file_operations ocfs2_fops_no_plocks = {
 
 const struct file_operations ocfs2_dops_no_plocks = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= shared_ocfs2_readdir,
 	.fsync		= ocfs2_sync_file,
 	.release	= ocfs2_dir_release,
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 6bda275826d6..9cfc68191917 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -455,7 +455,7 @@ const struct inode_operations omfs_dir_inops = {
 };
 
 const struct file_operations omfs_dir_operations = {
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.iterate_shared = omfs_readdir,
 	.llseek = generic_file_llseek,
 };
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 4a0779e3ef79..e25eceac86f4 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -167,7 +167,7 @@ static const struct file_operations openpromfs_prop_ops = {
 static int openpromfs_readdir(struct file *, struct dir_context *);
 
 static const struct file_operations openprom_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= openpromfs_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/orangefs/dir.c b/fs/orangefs/dir.c
index 6d1fbeca9d81..e28d41f0d1e2 100644
--- a/fs/orangefs/dir.c
+++ b/fs/orangefs/dir.c
@@ -389,7 +389,7 @@ static int orangefs_dir_release(struct inode *inode, struct file *file)
 
 const struct file_operations orangefs_dir_operations = {
 	.llseek = orangefs_dir_llseek,
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.iterate_shared = orangefs_dir_iterate,
 	.open = orangefs_dir_open,
 	.release = orangefs_dir_release
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 0ca8af060b0c..cfd6995e67bd 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -970,7 +970,7 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 
 WRAP_DIR_ITER(ovl_iterate) // FIXME!
 const struct file_operations ovl_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.open		= ovl_dir_open,
 	.iterate_shared	= shared_ovl_iterate,
 	.llseek		= ovl_dir_llseek,
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..4c6a7aafe66a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2430,7 +2430,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 }
 
 static const struct file_operations proc_map_files_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_map_files_readdir,
 	.llseek		= generic_file_llseek,
 };
@@ -2811,7 +2811,7 @@ static int proc_##LSM##_attr_dir_iterate(struct file *filp, \
 } \
 \
 static const struct file_operations proc_##LSM##_attr_dir_ops = { \
-	.read		= generic_read_dir, \
+	.read_iter	= generic_read_dir, \
 	.iterate_shared	= proc_##LSM##_attr_dir_iterate, \
 	.llseek		= default_llseek, \
 }; \
@@ -2870,7 +2870,7 @@ static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
 }
 
 static const struct file_operations proc_attr_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_attr_dir_readdir,
 	.llseek		= generic_file_llseek,
 };
@@ -3368,7 +3368,7 @@ static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
 }
 
 static const struct file_operations proc_tgid_base_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_tgid_base_readdir,
 	.llseek		= generic_file_llseek,
 };
@@ -3714,7 +3714,7 @@ static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *den
 }
 
 static const struct file_operations proc_tid_base_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_tid_base_readdir,
 	.llseek		= generic_file_llseek,
 };
@@ -3923,7 +3923,7 @@ static const struct inode_operations proc_task_inode_operations = {
 };
 
 static const struct file_operations proc_task_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_task_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6e72e5ad42bc..63a3aebdf223 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -314,7 +314,7 @@ static int proc_readfd(struct file *file, struct dir_context *ctx)
 }
 
 const struct file_operations proc_fd_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_readfd,
 	.llseek		= generic_file_llseek,
 };
@@ -424,7 +424,7 @@ const struct inode_operations proc_fdinfo_inode_operations = {
 
 const struct file_operations proc_fdinfo_operations = {
 	.open		= proc_open_fdinfo,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 775ce0bcf08c..ec5d7ebc8576 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -339,7 +339,7 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
  */
 static const struct file_operations proc_dir_operations = {
 	.llseek			= generic_file_llseek,
-	.read			= generic_read_dir,
+	.read_iter		= generic_read_dir,
 	.iterate_shared		= proc_readdir,
 };
 
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..fdd3452ad990 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -143,7 +143,7 @@ static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
 }
 
 const struct file_operations proc_ns_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_ns_dir_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 2ba31b6d68c0..0779fc13ae17 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -340,7 +340,7 @@ static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
 
 const struct file_operations proc_net_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_tgid_net_readdir,
 };
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 37cde0efee57..72939941686b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -860,7 +860,7 @@ static const struct file_operations proc_sys_file_operations = {
 };
 
 static const struct file_operations proc_sys_dir_file_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= proc_sys_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 06a297a27ba3..579a204fec8b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -346,7 +346,7 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
  * directory handling functions for that..
  */
 static const struct file_operations proc_root_operations = {
-	.read		 = generic_read_dir,
+	.read_iter	 = generic_read_dir,
 	.iterate_shared	 = proc_root_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index 42a529e26bd6..55ff69c5a6bb 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -68,7 +68,7 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 const struct file_operations qnx4_dir_operations =
 {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= qnx4_readdir,
 	.fsync		= generic_file_fsync,
 };
diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index c1cfb8a19e9d..e678486d737a 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -272,7 +272,7 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 
 const struct file_operations qnx6_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= qnx6_readdir,
 	.fsync		= generic_file_fsync,
 };
diff --git a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
index 79ee2b436685..c1a01dd186b3 100644
--- a/fs/reiserfs/dir.c
+++ b/fs/reiserfs/dir.c
@@ -19,7 +19,7 @@ static int reiserfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 
 const struct file_operations reiserfs_dir_operations = {
 	.llseek = generic_file_llseek,
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.iterate_shared = reiserfs_readdir,
 	.fsync = reiserfs_dir_fsync,
 	.unlocked_ioctl = reiserfs_ioctl,
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 2cbb92462074..48780a2dd12c 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -263,7 +263,7 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 }
 
 static const struct file_operations romfs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= romfs_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d41eedbff674..c6515979b8f2 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1640,7 +1640,7 @@ const struct file_operations cifs_file_direct_nobrl_ops = {
 const struct file_operations cifs_dir_ops = {
 	.iterate_shared = cifs_readdir,
 	.release = cifs_closedir,
-	.read    = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
 	.remap_file_range = cifs_remap_file_range,
diff --git a/fs/squashfs/dir.c b/fs/squashfs/dir.c
index a2ade63eccdf..c2d7d29a2a0d 100644
--- a/fs/squashfs/dir.c
+++ b/fs/squashfs/dir.c
@@ -217,7 +217,7 @@ static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 
 
 const struct file_operations squashfs_dir_ops = {
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.iterate_shared = squashfs_readdir,
 	.llseek = generic_file_llseek,
 };
diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 2e126d72d619..7a68d075e95d 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -23,7 +23,7 @@ static int sysv_readdir(struct file *, struct dir_context *);
 
 const struct file_operations sysv_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= sysv_readdir,
 	.fsync		= generic_file_fsync,
 };
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index dc067eeb6387..4dfec30b2228 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -277,7 +277,7 @@ static const struct inode_operations eventfs_file_inode_operations = {
 };
 
 static const struct file_operations eventfs_file_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= eventfs_iterate,
 	.llseek		= generic_file_llseek,
 };
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index eac0fef801f1..3f70d4edd0ee 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1719,7 +1719,7 @@ const struct inode_operations ubifs_dir_inode_operations = {
 const struct file_operations ubifs_dir_operations = {
 	.llseek         = generic_file_llseek,
 	.release        = ubifs_dir_release,
-	.read           = generic_read_dir,
+	.read_iter      = generic_read_dir,
 	.iterate_shared = ubifs_readdir,
 	.fsync          = ubifs_fsync,
 	.unlocked_ioctl = ubifs_ioctl,
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index f94f45fe2c91..309dbe1a62e5 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -131,7 +131,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 /* readdir and lookup functions */
 const struct file_operations udf_dir_operations = {
 	.llseek			= generic_file_llseek,
-	.read			= generic_read_dir,
+	.read_iter		= generic_read_dir,
 	.iterate_shared		= udf_readdir,
 	.unlocked_ioctl		= udf_ioctl,
 	.fsync			= generic_file_fsync,
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 27c85d92d1dc..8656f264b3be 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -648,7 +648,7 @@ int ufs_empty_dir(struct inode * inode)
 }
 
 const struct file_operations ufs_dir_operations = {
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= ufs_readdir,
 	.fsync		= generic_file_fsync,
 	.llseek		= generic_file_llseek,
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 5f1a14d5b927..917cfbcc75f2 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -184,7 +184,7 @@ const struct file_operations vboxsf_dir_fops = {
 	.open = vboxsf_dir_open,
 	.iterate_shared = shared_vboxsf_dir_iterate,
 	.release = vboxsf_dir_release,
-	.read = generic_read_dir,
+	.read_iter = generic_read_dir,
 	.llseek = generic_file_llseek,
 };
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 632653e00906..24ce652bd1f8 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1502,7 +1502,7 @@ const struct file_operations xfs_file_operations = {
 
 const struct file_operations xfs_dir_file_operations = {
 	.open		= xfs_dir_open,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= xfs_file_readdir,
 	.llseek		= generic_file_llseek,
 	.unlocked_ioctl	= xfs_file_ioctl,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index c6a124e8d565..d0460b2bf4f5 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -838,7 +838,7 @@ const struct inode_operations zonefs_dir_inode_operations = {
 
 const struct file_operations zonefs_dir_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
+	.read_iter	= generic_read_dir,
 	.iterate_shared	= zonefs_readdir,
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d15a79020efa..483c70d3941e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3337,7 +3337,7 @@ extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
-extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
+extern ssize_t generic_read_dir(struct kiocb *, struct iov_iter *);
 extern const struct file_operations simple_dir_operations;
 extern const struct inode_operations simple_dir_inode_operations;
 extern void make_empty_dir_inode(struct inode *inode);
-- 
2.43.0


