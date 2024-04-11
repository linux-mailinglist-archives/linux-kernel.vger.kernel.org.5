Return-Path: <linux-kernel+bounces-140851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1D8A1933
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F3B1F21D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D3137767;
	Thu, 11 Apr 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lPtJ9Xat"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B0137749
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849656; cv=none; b=Fp9I375jj815MlL+m4+WlMSJt7mJ2ixdrBhFIa1W13RXIpX39abOTKFLAHSDqa9jfgOp18sbHkFlW1DZeWKaMirBKbg+dGs92uK+TM0+luM2STOdGqTQsgfuBF78jK+YSff/4onpXGWx+MTxQvdj4tU3Mt/Wjw2L/X5agGYpYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849656; c=relaxed/simple;
	bh=thFw5qMMqfThnPyR4pNRr4fYK3AXdP6TEVPP9WW/QZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVHpAe8qWEk9KiUDZSefij45fooxHU76C2a9cro0N4khgBSjvOyy+RvStg/hGm6jk6/xm6P42t3K5BA+oHdy53np/CM1UgYvsSCjVletfMAm6dGoJfM2cVbQ9CiOeOvG+v7dH7IUJv58zaWO6eMRZqMu4T62ybffLw9dh/9uP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lPtJ9Xat; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a224d7414so179095ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849653; x=1713454453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWXwVKMGtdRFRsHTO85Me8k9SmVSkwckrfCHalnQuWk=;
        b=lPtJ9XatkSA+cF0tL42qhPFg9haUPqomJHthN/8hM4gL+BVWy8aOZDpW7ena5m21+T
         rVbkwlS7GvMd7ARZhETfKJWkYw4SKsWXKQivTkwP+3NLuUQrLDVnaJa8jGku9OOorzxT
         ds4NnCYWVOdhj5fxhbKMbzVP3FEcR93DATLiUJxEhtlYukY/kT8QjlTz7dIO5/ob4r1M
         RhqyPNzpl7cY3J8pH5edYT/8wr9hEHe8DYmg/eatYWnDxwCPHrmTVPFCH3oIsfnySatE
         7QdbT8QWVWrUDLQlfC6waLpZ8IYIgWAQcelM94kUnx+XKsGXxp8p7Cya4I0UelLnTyLH
         nong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849653; x=1713454453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWXwVKMGtdRFRsHTO85Me8k9SmVSkwckrfCHalnQuWk=;
        b=LCLS7x5gY0fcLIi1DVMkXp/gqo5DrR/dVvradiEpXEKQ6lZyImeQ/t32hafMlJ77Zu
         0QU4Jpx1uliwPS1ebdKnD2AjXmAY0gv27hQB6OynxzogSvLo382SQsaK7FTvgAbjNt1D
         DltpIsZYEEQg0TCQg/ubMj1zWrc7iz23dwWfzAZFZUygh6nwlPue+x9Aa8Pw6Vua2GW/
         RYLAo205d47i8S/UMZLXPSkNHvjKzuhNOhIMHiZp3EwFIB61wsZvfpJXKP25uJF4azPD
         TmZx2+2BT9WqbATS0D77RNImJaFlB8LEtoURkD1LkqtU78nEdycPdnQkrIIokRJbAvCp
         RgfQ==
X-Gm-Message-State: AOJu0Yy4K+rSdmxvek2H+LyJ3dvx6dVTRqiTzoXzXXHzcAw65MsJkD8g
	3B6dx2kQvC8PXkvb9Hsya1r79a4mwwHjfNMEEqdJCxc/pYE7/02df23jvlbpMreiF1uKOdIHg8E
	S
X-Google-Smtp-Source: AGHT+IE79FO5517mpTdyrO/Wo75DVpCBXnd/9gW/DAk0Ch/EVuPSe9vLg/CAef2iYOFXFEfmvyChaA==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr180367iob.1.1712849653268;
        Thu, 11 Apr 2024 08:34:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 089/437] apparmor: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:49 -0600
Message-ID: <20240411153126.16201-90-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 security/apparmor/apparmorfs.c | 55 ++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index bcfea073e3f2..b8d54d54a441 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -450,9 +450,10 @@ static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
 
 	return error;
 }
+FOPS_WRITE_ITER_HELPER(profile_load);
 
 static const struct file_operations aa_fs_profile_load = {
-	.write = profile_load,
+	.write_iter = profile_load_iter,
 	.llseek = default_llseek,
 };
 
@@ -467,9 +468,10 @@ static ssize_t profile_replace(struct file *f, const char __user *buf,
 
 	return error;
 }
+FOPS_WRITE_ITER_HELPER(profile_replace);
 
 static const struct file_operations aa_fs_profile_replace = {
-	.write = profile_replace,
+	.write_iter = profile_replace_iter,
 	.llseek = default_llseek,
 };
 
@@ -508,9 +510,10 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	aa_put_ns(ns);
 	return error;
 }
+FOPS_WRITE_ITER_HELPER(profile_remove);
 
 static const struct file_operations aa_fs_profile_remove = {
-	.write = profile_remove,
+	.write_iter = profile_remove_iter,
 	.llseek = default_llseek,
 };
 
@@ -532,10 +535,11 @@ static int ns_revision_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ns_revision_read(struct file *file, char __user *buf,
-				size_t size, loff_t *ppos)
+static ssize_t ns_revision_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct aa_revision *rev = file->private_data;
+	size_t size = iov_iter_count(to);
 	char buffer[32];
 	long last_read;
 	int avail;
@@ -554,13 +558,13 @@ static ssize_t ns_revision_read(struct file *file, char __user *buf,
 	}
 
 	avail = sprintf(buffer, "%ld\n", rev->ns->revision);
-	if (*ppos + size > avail) {
+	if (iocb->ki_pos + size > avail) {
 		rev->last_read = rev->ns->revision;
-		*ppos = 0;
+		iocb->ki_pos = 0;
 	}
 	mutex_unlock(&rev->ns->lock);
 
-	return simple_read_from_buffer(buf, size, ppos, buffer, avail);
+	return simple_copy_to_iter(buffer, &iocb->ki_pos, avail, to);
 }
 
 static int ns_revision_open(struct inode *inode, struct file *file)
@@ -604,7 +608,7 @@ static const struct file_operations aa_fs_ns_revision_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ns_revision_open,
 	.poll		= ns_revision_poll,
-	.read		= ns_revision_read,
+	.read_iter	= ns_revision_read,
 	.llseek		= generic_file_llseek,
 	.release	= ns_revision_release,
 };
@@ -878,9 +882,9 @@ static struct multi_transaction *multi_transaction_new(struct file *file,
 	return t;
 }
 
-static ssize_t multi_transaction_read(struct file *file, char __user *buf,
-				       size_t size, loff_t *pos)
+static ssize_t multi_transaction_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct multi_transaction *t;
 	ssize_t ret;
 
@@ -891,7 +895,7 @@ static ssize_t multi_transaction_read(struct file *file, char __user *buf,
 	if (!t)
 		return 0;
 
-	ret = simple_read_from_buffer(buf, size, pos, t->data, t->size);
+	ret = simple_copy_to_iter(t->data, &iocb->ki_pos, t->size, to);
 	put_multi_transaction(t);
 
 	return ret;
@@ -980,10 +984,11 @@ static ssize_t aa_write_access(struct file *file, const char __user *ubuf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(aa_write_access);
 
 static const struct file_operations aa_sfs_access = {
-	.write		= aa_write_access,
-	.read		= multi_transaction_read,
+	.write_iter	= aa_write_access_iter,
+	.read_iter	= multi_transaction_read,
 	.release	= multi_transaction_release,
 	.llseek		= generic_file_llseek,
 };
@@ -1021,7 +1026,7 @@ static int aa_sfs_seq_open(struct inode *inode, struct file *file)
 const struct file_operations aa_sfs_seq_file_ops = {
 	.owner		= THIS_MODULE,
 	.open		= aa_sfs_seq_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1040,7 +1045,7 @@ static int seq_profile_ ##NAME ##_open(struct inode *inode, struct file *file)\
 static const struct file_operations seq_profile_ ##NAME ##_fops = {	      \
 	.owner		= THIS_MODULE,					      \
 	.open		= seq_profile_ ##NAME ##_open,			      \
-	.read		= seq_read,					      \
+	.read_iter	= seq_read_iter,				      \
 	.llseek		= seq_lseek,					      \
 	.release	= seq_profile_release,				      \
 }									      \
@@ -1142,7 +1147,7 @@ static int seq_ns_ ##NAME ##_open(struct inode *inode, struct file *file)     \
 static const struct file_operations seq_ns_ ##NAME ##_fops = {	      \
 	.owner		= THIS_MODULE,					      \
 	.open		= seq_ns_ ##NAME ##_open,			      \
-	.read		= seq_read,					      \
+	.read_iter	= seq_read_iter,				      \
 	.llseek		= seq_lseek,					      \
 	.release	= single_release,				      \
 }									      \
@@ -1232,7 +1237,7 @@ static int seq_rawdata_ ##NAME ##_open(struct inode *inode, struct file *file)\
 static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
 	.owner		= THIS_MODULE,					      \
 	.open		= seq_rawdata_ ##NAME ##_open,			      \
-	.read		= seq_read,					      \
+	.read_iter	= seq_read_iter,				      \
 	.llseek		= seq_lseek,					      \
 	.release	= seq_rawdata_release,				      \
 }									      \
@@ -1348,14 +1353,12 @@ static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen)
 	return 0;
 }
 
-static ssize_t rawdata_read(struct file *file, char __user *buf, size_t size,
-			    loff_t *ppos)
+static ssize_t rawdata_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rawdata_f_data *private = file->private_data;
+	struct rawdata_f_data *private = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buf, size, ppos,
-				       RAWDATA_F_DATA_BUF(private),
-				       private->loaddata->size);
+	return simple_copy_to_iter(RAWDATA_F_DATA_BUF(private), &iocb->ki_pos,
+				       private->loaddata->size, to);
 }
 
 static int rawdata_release(struct inode *inode, struct file *file)
@@ -1407,7 +1410,7 @@ static int rawdata_open(struct inode *inode, struct file *file)
 
 static const struct file_operations rawdata_fops = {
 	.open = rawdata_open,
-	.read = rawdata_read,
+	.read_iter = rawdata_read,
 	.llseek = generic_file_llseek,
 	.release = rawdata_release,
 };
@@ -2298,7 +2301,7 @@ static int profiles_release(struct inode *inode, struct file *file)
 
 static const struct file_operations aa_sfs_profiles_fops = {
 	.open = profiles_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = profiles_release,
 };
-- 
2.43.0


