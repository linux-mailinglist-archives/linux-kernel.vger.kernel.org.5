Return-Path: <linux-kernel+bounces-141157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC48A1ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3731C2377D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B21F20EE;
	Thu, 11 Apr 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OunmfneD"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EC1ECE9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850134; cv=none; b=OA3LJODWpWzanJ4S/BWRpnlu6axEcE1UHyMzm6JWb9lCCuMJzuc5NbOMxMjjy8qOllpEbKMyVIZEdbwk5V3bfpEMg3WxqNo5D49/8IXb5i48cVumhSGYtk/fdlUdeLGgIDadqXkqAjRkaeJkbuDxV8HKNF+Afa55RCQ9IrEA8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850134; c=relaxed/simple;
	bh=rgpIRHhn5bda62Hdb4aCHFo5qia/GDBxZWB0weRgOWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJ5eWY9AAuHf7XP2m/oS5cSzwOivr07iCsAWQ1qhfXlGNDe7cPoHJrhQW3jRHOP2cG87Ld7GGjOqRGan9DM9H6MHuz8hRnfR8Fj5TJ0O3kgFXJbEhNuPpPmz9xHX+i4CjkjP0Th5JzjYwpyJ/UVf0n7SZVSf4PCwsyoyn2/b8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OunmfneD; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58254739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850132; x=1713454932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP+1rs2Jbz9YPxFttSpfFlNdjf4iFYzHn3TtRb4Tbdo=;
        b=OunmfneDsbdUI1zyYi3IqqxGHdWQtNUy1Mit2uMffBGRhTYvKDTDukLNMIXQ4u/6l7
         U1CzwdbXQwxA7/aZ3lrABJPeCeK+ZHm0dE8dLLJC6ebbAAkykecTssc6zF4rYpLyNe+0
         9e1bNnKmi5xTh0XwtfQcPv9plw5IGSW/yEiiV7rfRJqZ75Rmc5WN06gL43fHq0FACw3Y
         2NMUbnFKzT+/A2JBaRU4OiQQuyzgaBK3UiKgqUgz4Iq69hAExzySAkCFIfuNFueAnK2E
         mGTNGnMvG1xb00UUg/B9PVn/xvAhV+qG36pKsPtfMLWwowBnJKmiXFUunpo0pmFmskv5
         TF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850132; x=1713454932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP+1rs2Jbz9YPxFttSpfFlNdjf4iFYzHn3TtRb4Tbdo=;
        b=fgTtlgK7Ck2Y/vkrzbvjeqNIDSslwn0cg9p9PWU1bviDzTHRamja0CseL7fZRpuyH8
         KfrXzyQxmWoWVj1DJVje4DHLiXHev7sh7Sq5Sgi47JBK4Bhh7xQmvolHMTfadYe1efh2
         b4trEYOKVQ+BSMnOSBHvsbExAxRfqRyMgn1xBjTjOPJQ1aauRI7nkGli285NlyVKq+F/
         c8+Aik9Jq8bWQbFo8+hsjcsW3dVu92+MJjUL1mgrn/EH9JTXJs/BLyWh2dly8FJTdj2x
         ORUJl8UK8RIM+o7kCNMiyDs4mkqGP95utGULbz+2LbJ86xb+j5HJe4H9H5e0L9Vvy8uh
         1NqQ==
X-Gm-Message-State: AOJu0Yx22T+beT+lQdIoCbxg/5L7oHS1SOV6/POpvrhu0f0RXH/1P4dm
	cw4r/v4ECD9ktBHDH2jA2pnMWAepHUAAh4JHTXJxE6sx01DBsmPLZ1OqIVaX+9JQnNunX5e1iRk
	i
X-Google-Smtp-Source: AGHT+IG84cSQxtESTY27M58hxDu6/QA1FtdQ+SUGa2mFdMWfhHzuVB+SSpui4E1IXWquMx+130hC0w==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr177887ioh.1.1712850131205;
        Thu, 11 Apr 2024 08:42:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 375/437] drivers/vfio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:35 -0600
Message-ID: <20240411153126.16201-376-axboe@kernel.dk>
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
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 31 ++++++++++--------
 drivers/vfio/pci/mlx5/main.c                  |  6 ++--
 drivers/vfio/pci/pds/lm.c                     | 32 +++++++++----------
 drivers/vfio/vfio_main.c                      |  6 ++--
 4 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 9a3e97108ace..8ea4c46a3334 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -676,18 +676,20 @@ static int hisi_acc_vf_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *buf,
-					size_t len, loff_t *pos)
+static ssize_t hisi_acc_vf_resume_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct hisi_acc_vf_migration_file *migf = filp->private_data;
+	struct hisi_acc_vf_migration_file *migf = iocb->ki_filp->private_data;
 	u8 *vf_data = (u8 *)&migf->vf_data;
+	size_t len = iov_iter_count(from);
 	loff_t requested_length;
 	ssize_t done = 0;
+	loff_t *pos;
 	int ret;
 
-	if (pos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
-	pos = &filp->f_pos;
+	pos = &iocb->ki_filp->f_pos;
 
 	if (*pos < 0 ||
 	    check_add_overflow((loff_t)len, *pos, &requested_length))
@@ -702,7 +704,7 @@ static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *bu
 		goto out_unlock;
 	}
 
-	ret = copy_from_user(vf_data + *pos, buf, len);
+	ret = !copy_from_iter_full(vf_data + *pos, len, from);
 	if (ret) {
 		done = -EFAULT;
 		goto out_unlock;
@@ -721,7 +723,7 @@ static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *bu
 
 static const struct file_operations hisi_acc_vf_resume_fops = {
 	.owner = THIS_MODULE,
-	.write = hisi_acc_vf_resume_write,
+	.write_iter = hisi_acc_vf_resume_write,
 	.release = hisi_acc_vf_release_file,
 	.llseek = no_llseek,
 };
@@ -800,16 +802,17 @@ static long hisi_acc_vf_precopy_ioctl(struct file *filp,
 	return ret;
 }
 
-static ssize_t hisi_acc_vf_save_read(struct file *filp, char __user *buf, size_t len,
-				     loff_t *pos)
+static ssize_t hisi_acc_vf_save_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hisi_acc_vf_migration_file *migf = filp->private_data;
+	struct hisi_acc_vf_migration_file *migf = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t done = 0;
+	loff_t *pos;
 	int ret;
 
-	if (pos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
-	pos = &filp->f_pos;
+	pos = &iocb->ki_filp->f_pos;
 
 	mutex_lock(&migf->lock);
 	if (*pos > migf->total_length) {
@@ -826,7 +829,7 @@ static ssize_t hisi_acc_vf_save_read(struct file *filp, char __user *buf, size_t
 	if (len) {
 		u8 *vf_data = (u8 *)&migf->vf_data;
 
-		ret = copy_to_user(buf, vf_data + *pos, len);
+		ret = !copy_to_iter_full(vf_data + *pos, len, to);
 		if (ret) {
 			done = -EFAULT;
 			goto out_unlock;
@@ -841,7 +844,7 @@ static ssize_t hisi_acc_vf_save_read(struct file *filp, char __user *buf, size_t
 
 static const struct file_operations hisi_acc_vf_save_fops = {
 	.owner = THIS_MODULE,
-	.read = hisi_acc_vf_save_read,
+	.read_iter = hisi_acc_vf_save_read,
 	.unlocked_ioctl = hisi_acc_vf_precopy_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.release = hisi_acc_vf_release_file,
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 61d9b0f9146d..05552bcb7a31 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -263,6 +263,7 @@ static ssize_t mlx5vf_save_read(struct file *filp, char __user *buf, size_t len,
 	mutex_unlock(&migf->lock);
 	return done;
 }
+FOPS_READ_ITER_HELPER(mlx5vf_save_read);
 
 static __poll_t mlx5vf_save_poll(struct file *filp,
 				 struct poll_table_struct *wait)
@@ -582,7 +583,7 @@ static long mlx5vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 
 static const struct file_operations mlx5vf_save_fops = {
 	.owner = THIS_MODULE,
-	.read = mlx5vf_save_read,
+	.read_iter = mlx5vf_save_read_iter,
 	.poll = mlx5vf_save_poll,
 	.unlocked_ioctl = mlx5vf_precopy_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -995,10 +996,11 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
 	mlx5vf_state_mutex_unlock(migf->mvdev);
 	return ret ? ret : done;
 }
+FOPS_WRITE_ITER_HELPER(mlx5vf_resume_write);
 
 static const struct file_operations mlx5vf_resume_fops = {
 	.owner = THIS_MODULE,
-	.write = mlx5vf_resume_write,
+	.write_iter = mlx5vf_resume_write_iter,
 	.release = mlx5vf_release_file,
 	.llseek = no_llseek,
 };
diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
index 6b94cc0bf45b..8e86b3c39a28 100644
--- a/drivers/vfio/pci/pds/lm.c
+++ b/drivers/vfio/pci/pds/lm.c
@@ -174,15 +174,16 @@ static int pds_vfio_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t pds_vfio_save_read(struct file *filp, char __user *buf,
-				  size_t len, loff_t *pos)
+static ssize_t pds_vfio_save_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct pds_vfio_lm_file *lm_file = filp->private_data;
+	struct pds_vfio_lm_file *lm_file = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t done = 0;
+	loff_t *pos;
 
-	if (pos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
-	pos = &filp->f_pos;
+	pos = &iocb->ki_filp->f_pos;
 
 	mutex_lock(&lm_file->lock);
 
@@ -214,7 +215,7 @@ static ssize_t pds_vfio_save_read(struct file *filp, char __user *buf,
 
 		page_len = min_t(size_t, len, PAGE_SIZE - page_offset);
 		from_buff = kmap_local_page(page);
-		err = copy_to_user(buf, from_buff + page_offset, page_len);
+		err = !copy_to_iter_full(from_buff + page_offset, page_len, to);
 		kunmap_local(from_buff);
 		if (err) {
 			done = -EFAULT;
@@ -223,7 +224,6 @@ static ssize_t pds_vfio_save_read(struct file *filp, char __user *buf,
 		*pos += page_len;
 		len -= page_len;
 		done += page_len;
-		buf += page_len;
 	}
 
 out_unlock:
@@ -233,7 +233,7 @@ static ssize_t pds_vfio_save_read(struct file *filp, char __user *buf,
 
 static const struct file_operations pds_vfio_save_fops = {
 	.owner = THIS_MODULE,
-	.read = pds_vfio_save_read,
+	.read_iter = pds_vfio_save_read,
 	.release = pds_vfio_release_file,
 	.llseek = no_llseek,
 };
@@ -273,17 +273,18 @@ static int pds_vfio_get_save_file(struct pds_vfio_pci_device *pds_vfio)
 	return 0;
 }
 
-static ssize_t pds_vfio_restore_write(struct file *filp, const char __user *buf,
-				      size_t len, loff_t *pos)
+static ssize_t pds_vfio_restore_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct pds_vfio_lm_file *lm_file = filp->private_data;
+	struct pds_vfio_lm_file *lm_file = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	loff_t requested_length;
 	ssize_t done = 0;
+	loff_t *pos;
 
-	if (pos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
 
-	pos = &filp->f_pos;
+	pos = &iocb->ki_filp->f_pos;
 
 	if (*pos < 0 ||
 	    check_add_overflow((loff_t)len, *pos, &requested_length))
@@ -313,7 +314,7 @@ static ssize_t pds_vfio_restore_write(struct file *filp, const char __user *buf,
 
 		page_len = min_t(size_t, len, PAGE_SIZE - page_offset);
 		to_buff = kmap_local_page(page);
-		err = copy_from_user(to_buff + page_offset, buf, page_len);
+		err = !copy_from_iter_full(to_buff + page_offset, page_len, from);
 		kunmap_local(to_buff);
 		if (err) {
 			done = -EFAULT;
@@ -322,7 +323,6 @@ static ssize_t pds_vfio_restore_write(struct file *filp, const char __user *buf,
 		*pos += page_len;
 		len -= page_len;
 		done += page_len;
-		buf += page_len;
 		lm_file->size += page_len;
 	}
 out_unlock:
@@ -332,7 +332,7 @@ static ssize_t pds_vfio_restore_write(struct file *filp, const char __user *buf,
 
 static const struct file_operations pds_vfio_restore_fops = {
 	.owner = THIS_MODULE,
-	.write = pds_vfio_restore_write,
+	.write_iter = pds_vfio_restore_write,
 	.release = pds_vfio_release_file,
 	.llseek = no_llseek,
 };
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index e97d796a54fb..dd96d1756110 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1277,6 +1277,7 @@ static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,
 
 	return device->ops->read(device, buf, count, ppos);
 }
+FOPS_READ_ITER_HELPER(vfio_device_fops_read);
 
 static ssize_t vfio_device_fops_write(struct file *filep,
 				      const char __user *buf,
@@ -1294,6 +1295,7 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 
 	return device->ops->write(device, buf, count, ppos);
 }
+FOPS_WRITE_ITER_HELPER(vfio_device_fops_write);
 
 static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 {
@@ -1314,8 +1316,8 @@ const struct file_operations vfio_device_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vfio_device_fops_cdev_open,
 	.release	= vfio_device_fops_release,
-	.read		= vfio_device_fops_read,
-	.write		= vfio_device_fops_write,
+	.read_iter	= vfio_device_fops_read_iter,
+	.write_iter	= vfio_device_fops_write_iter,
 	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.mmap		= vfio_device_fops_mmap,
-- 
2.43.0


