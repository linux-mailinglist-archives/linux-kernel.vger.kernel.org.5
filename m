Return-Path: <linux-kernel+bounces-123990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38648910CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801BA1F23931
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526F40873;
	Fri, 29 Mar 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Q3cKsRZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF433D541
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677265; cv=none; b=Zn/KKGHFxY79XC9rZHtqNK6RixD2yQsDWkh1cxX7WR26r1GYZMTslSaC+XFUosqF8RQag+IPKERjbYBl90/srvdjjROvAqraZfPIrHnAjOXz2VpO4ZyVNVLJPFAfJu+IqkWkZ/wEwrEVOzFG6MX65CBEWUPTeObWfH1688c5UQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677265; c=relaxed/simple;
	bh=fvczagys3eeKlVoeCdtC8aX8ILYO2cwo2aEBbr60QNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZNfw6TCtt+AOX54+XFtTrKvAGhOL+iM+dyEMx7TnRd4Ll9xpF9duE34+iGFT5P1lux3jSEhC6WRYDRcxLGl3vSGffBzJOmjhlZshRTGedmTa46gQlvgAK3P0HAuUJzwYfdEyetV8PkFEQRAMODWx29w9lEE0LgJaq098rorghqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Q3cKsRZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fe93b5cfso24876967b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677261; x=1712282061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN40RVFAgvwoqdUJunI82ty/5fzSZehhGVy3k+SOK50=;
        b=4Q3cKsRZW9AkZtU5EdHpgZ4ObNUKH7d0fjZr4czVLSa+vVY4e1BSdqntdLokO+T+J8
         JA+ZUDp7/qUU3vIXH1IuzUODnp7PFyJtO/0l2tTaiGfQj+OoI6jdal8qNTHlJr4zkspv
         4reQV6kDN4d9cqy9kBzna0vT5Vn6lZIjCyckVQfUmuOEPdnCp6iG8FTMjDyFRdlPIaTJ
         GPbJUn0KsetvsfLFKO2v42y45YAQqCq+icSSsVOBh0AmPBSwQXbevSTVGA+rfZggFTHM
         ZElBdktoNJpCJqauTSiYeaHtR6ATUp9/gziSi9fbUgnWWDoBkOUEyiQnQaHDEo712m5B
         eLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677261; x=1712282061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN40RVFAgvwoqdUJunI82ty/5fzSZehhGVy3k+SOK50=;
        b=k6Fcqxa9ZkphN3YYraUwABmmoV4CNodAwPdavIjW9ioW1CwqNimPb/+LeXW28Ry1aS
         qRjExaZYDuuR/PcUs7euwA/UWKhucz33rDvDtGVl+Rf7ufdTcu+gMR5H44fiIVTLcnoS
         sSrRFejEoXBaT6JXJfyIA1BBHAOO35lqft07sm9xPBiyI+B4s7cMVWzai24K4K1pbVBC
         l2O8zc5WWAzQqi3cJRZgoHwwOKUOmF0y8o+FLjuGIUwvcUNlHB5odfaYWC6yi5Wz2Uw1
         24/bTwmAT5yRtixcvrrA9k8XiMMwUgn+peKepWP6DmxAfSapzrJBbMD3lS1nTJnQLfKE
         VjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXVRfUzFH14zRxinTr3mYoFUWXGQjJyDwmuHbLWhtWnvpHtNFeVyqpq6RPHPfNJTt3wI2Z8jFPMnX7yYcHRgN+3JpQS//LOvMeRcsu
X-Gm-Message-State: AOJu0YwNs9phUO5nepZicGJeuk9t7IoIwpxfhijoTbFhKSMQ77ZUIYpY
	Pu+Oa+ehwOEhFwWqNKEmS3BXxyCDOfCJkcy3kefV4u4uLg19Aj8JXrs8+5OC9bt8h49SKxV8Z/J
	URw==
X-Google-Smtp-Source: AGHT+IGuOQt8Snd/P6ofj2gX/JcTFHrD/nXa6QfIFbIPo49OngK3DoVwSGK+2/UzTDKaYsETWaFnfy3xB1Q=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:efc5:0:b0:614:fa:c912 with SMTP id
 y188-20020a0defc5000000b0061400fac912mr269078ywe.1.1711677261512; Thu, 28 Mar
 2024 18:54:21 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:25 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-11-drosen@google.com>
Subject: [RFC PATCH v4 10/36] fuse-bpf: Add support for fallocate
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

This adds backing support for FUSE_FALLOCATE

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  3 +++
 fs/fuse/fuse_i.h  |  6 +++++
 3 files changed, 69 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 04cb0c0c10b0..4a22465ecdef 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -340,6 +340,66 @@ ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+static int fuse_file_fallocate_initialize_in(struct bpf_fuse_args *fa,
+					     struct fuse_fallocate_in *in,
+					     struct file *file, int mode, loff_t offset, loff_t length)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*in = (struct fuse_fallocate_in) {
+		.fh = ff->fh,
+		.offset = offset,
+		.length = length,
+		.mode = mode,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_FALLOCATE,
+			.nodeid = ff->nodeid,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+	};
+
+	return 0;
+}
+
+static int fuse_file_fallocate_initialize_out(struct bpf_fuse_args *fa,
+					      struct fuse_fallocate_in *in,
+					      struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+static int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
+				       struct file *file, int mode, loff_t offset, loff_t length)
+{
+	const struct fuse_fallocate_in *ffi = fa->in_args[0].value;
+	struct fuse_file *ff = file->private_data;
+
+	*out = vfs_fallocate(ff->backing_file, ffi->mode, ffi->offset,
+			     ffi->length);
+	return 0;
+}
+
+static int fuse_file_fallocate_finalize(struct bpf_fuse_args *fa, int *out,
+					struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return bpf_fuse_backing(inode, struct fuse_fallocate_in, out,
+				fuse_file_fallocate_initialize_in,
+				fuse_file_fallocate_initialize_out,
+				fuse_file_fallocate_backing,
+				fuse_file_fallocate_finalize,
+				file, mode, offset, length);
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b3cae6e677f8..0ab882e1236a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3032,6 +3032,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
 
+	if (fuse_bpf_file_fallocate(&err, inode, file, mode, offset, length))
+		return err;
+
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24f453d162ae..7a6cebecd00f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1439,6 +1439,7 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 #ifdef CONFIG_FUSE_BPF
 
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1449,6 +1450,11 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
 	return 0;
 }
 
+static inline int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


