Return-Path: <linux-kernel+bounces-141198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC88A1AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9AA287CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156871FD5CA;
	Thu, 11 Apr 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G4mjsFhn"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7511FD5A2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850195; cv=none; b=U1cuGzuN0cCNoNnEndpEocwDUueMa/xEnsF6UL/bRG/V6CemKXGIjqoYi96hWZN+kq+xUMTmLSkELF1wbQYKuXERNMwFpNx0R7vSb2KBsiCuKzLTaZZMCMQno0C1q89aBvtdcjkPIlKIQjmri1c8kkPmg5+4YJTBmagsmKHRVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850195; c=relaxed/simple;
	bh=vKJWpzeH4oHTjqOkSHsQbE0uP4ioH/fg+FPYMY26y2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN+d92R/O0XvayuIarr1TYlpjU7VYXVuTkgewWeS3V/ooruU+ACUdxsdmRn4AmkUDYBwkqTb20ncFkG0wToD2YnZ2FiGspRR6y4qCSsicbJRRgNrS2Pceu0jFVP44/Zru4SpN19uyGFqzQ1RCUHmBgKmErciE1dPzQP5k3YYIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G4mjsFhn; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58281639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850192; x=1713454992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td/9MPXR0dX8im25L1H7fGnS4aswbcWZTrLZ/haMmCQ=;
        b=G4mjsFhnVcixhAhyNVk9jzdKE6E5Sq5PDZTcGH7OJM+HAqfRKrM2NmhYo0k92RNBky
         eegwBxQHUs+1jmXKPzOWRkKQ0G8NRgfJqOeaCktJyZG7xyNJmQb2uNaVh8qo9fxu9Cyx
         1/+qNKzzPahl8OT5RQSffCfO44Jm55/5WCPJOy8BmMvYuFiDMFIeGBM+nNGPKTs3e2Q7
         GZnKaS78jSF/m8xJZae4gheGQDbFtnY9iZ1Zd+RjwyfhPmMO+ccskMUcOw5+Sps8/cSn
         R1KwDiuvZ9360GkXNushCPDhbBkur1rAiF6SA5JEy2u/ELD6+akQ6kTpK9X3k+SUcaSh
         tzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850192; x=1713454992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td/9MPXR0dX8im25L1H7fGnS4aswbcWZTrLZ/haMmCQ=;
        b=GR8XOlXzX5rUBvWropYdVmXltMZZAVunE67N2f2kV988WtEpmQZK/Hcof7++6YMUiQ
         nZ1L5d6x0v34n63I1b7JIbfxQaKqstlTsozHWG0yKR+cmtknb2lKKbaoM5SjYh3PvnIF
         Om0dhtsQrd+7FU+mfJHBYvEIAQYuKfIEgABWYiOb0mKix0VAMwVuH/U99LvllDLNdOwN
         /eBPbTx05QVwu2KYimfHrxMEFl2480xdwJhWrnhX9QdkDl3aDPuWC9EZF2UUnFkLxZcU
         7D/deuAu1qMMu8PoILXoFDOsqJUT0UVk9Nch7m7t95bs+yoKFt0d5KFg9Szmu0WtKj+4
         GP6g==
X-Gm-Message-State: AOJu0YzeP61KR/Y4I/q033dTUcWIvHj3ooB0eur78Pm2AJyZjNc4MgCN
	fEad44zLg7OueRI6h9vhoAQX+16GwO+R0Jb52QhBUCTeXghX6uW31pxyEekZzY0l9WHzVyG2sgh
	W
X-Google-Smtp-Source: AGHT+IEQ1ocl4byBnLDsf35rzgThUQT6bc3znhQ/kgs5swMGc+d0bh3nDIPpPqq7j/eJe0dkaG4Yzg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr206403iov.2.1712850192654;
        Thu, 11 Apr 2024 08:43:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 414/437] media/dvb-core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:14 -0600
Message-ID: <20240411153126.16201-415-axboe@kernel.dk>
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
 drivers/media/dvb-core/dmxdev.c         |  9 ++++++---
 drivers/media/dvb-core/dvb_ca_en50221.c | 25 +++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 9ce5f010de3f..f30ec9c3cade 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -261,6 +261,7 @@ static ssize_t dvb_dvr_write(struct file *file, const char __user *buf,
 	mutex_unlock(&dmxdev->mutex);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dvb_dvr_write);
 
 static ssize_t dvb_dvr_read(struct file *file, char __user *buf, size_t count,
 			    loff_t *ppos)
@@ -275,6 +276,7 @@ static ssize_t dvb_dvr_read(struct file *file, char __user *buf, size_t count,
 				      file->f_flags & O_NONBLOCK,
 				      buf, count, ppos);
 }
+FOPS_READ_ITER_HELPER(dvb_dvr_read);
 
 static int dvb_dvr_set_buffer_size(struct dmxdev *dmxdev,
 				      unsigned long size)
@@ -1025,6 +1027,7 @@ dvb_demux_read(struct file *file, char __user *buf, size_t count,
 	mutex_unlock(&dmxdevfilter->mutex);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(dvb_demux_read);
 
 static int dvb_demux_do_ioctl(struct file *file,
 			      unsigned int cmd, void *parg)
@@ -1258,7 +1261,7 @@ static int dvb_demux_release(struct inode *inode, struct file *file)
 
 static const struct file_operations dvb_demux_fops = {
 	.owner = THIS_MODULE,
-	.read = dvb_demux_read,
+	.read_iter = dvb_demux_read_iter,
 	.unlocked_ioctl = dvb_demux_ioctl,
 	.compat_ioctl = dvb_demux_ioctl,
 	.open = dvb_demux_open,
@@ -1385,8 +1388,8 @@ static int dvb_dvr_mmap(struct file *file, struct vm_area_struct *vma)
 
 static const struct file_operations dvb_dvr_fops = {
 	.owner = THIS_MODULE,
-	.read = dvb_dvr_read,
-	.write = dvb_dvr_write,
+	.read_iter = dvb_dvr_read_iter,
+	.write_iter = dvb_dvr_write_iter,
 	.unlocked_ioctl = dvb_dvr_ioctl,
 	.open = dvb_dvr_open,
 	.release = dvb_dvr_release,
diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index baf64540dc00..ccb9bff21304 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1436,19 +1436,16 @@ static long dvb_ca_en50221_io_ioctl(struct file *file,
 /**
  * dvb_ca_en50221_io_write - Implementation of write() syscall.
  *
- * @file: File structure.
- * @buf: Source buffer.
- * @count: Size of source buffer.
- * @ppos: Position in file (ignored).
+ * @iocb: metadata for IO
+ * @from: buffer to read from
  *
  * return: Number of bytes read, or <0 on error.
  */
-static ssize_t dvb_ca_en50221_io_write(struct file *file,
-				       const char __user *buf, size_t count,
-				       loff_t *ppos)
+static ssize_t dvb_ca_en50221_io_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_device *dvbdev = iocb->ki_filp->private_data;
 	struct dvb_ca_private *ca = dvbdev->priv;
+	size_t count = iov_iter_count(from);
 	struct dvb_ca_slot *sl;
 	u8 slot, connection_id;
 	int status;
@@ -1468,11 +1465,10 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 		return -EINVAL;
 
 	/* extract slot & connection id */
-	if (copy_from_user(&slot, buf, 1))
+	if (!copy_from_iter_full(&slot, 1, from))
 		return -EFAULT;
-	if (copy_from_user(&connection_id, buf + 1, 1))
+	if (!copy_from_iter_full(&connection_id, 1, from))
 		return -EFAULT;
-	buf += 2;
 	count -= 2;
 
 	if (slot >= ca->slot_count)
@@ -1496,7 +1492,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 		fragbuf[0] = connection_id;
 		fragbuf[1] = ((fragpos + fraglen) < count) ? 0x80 : 0x00;
-		status = copy_from_user(fragbuf + 2, buf + fragpos, fraglen);
+		status = !copy_from_iter_full(fragbuf + 2, fraglen, from);
 		if (status) {
 			status = -EFAULT;
 			goto exit;
@@ -1699,6 +1695,7 @@ static ssize_t dvb_ca_en50221_io_read(struct file *file, char __user *buf,
 exit:
 	return status;
 }
+FOPS_READ_ITER_HELPER(dvb_ca_en50221_io_read);
 
 /**
  * dvb_ca_en50221_io_open - Implementation of file open syscall.
@@ -1834,8 +1831,8 @@ static __poll_t dvb_ca_en50221_io_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations dvb_ca_fops = {
 	.owner = THIS_MODULE,
-	.read = dvb_ca_en50221_io_read,
-	.write = dvb_ca_en50221_io_write,
+	.read_iter = dvb_ca_en50221_io_read_iter,
+	.write_iter = dvb_ca_en50221_io_write,
 	.unlocked_ioctl = dvb_ca_en50221_io_ioctl,
 	.open = dvb_ca_en50221_io_open,
 	.release = dvb_ca_en50221_io_release,
-- 
2.43.0


