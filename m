Return-Path: <linux-kernel+bounces-140916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD618A19CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06F5B21807
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E32319069A;
	Thu, 11 Apr 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j3avj2Wo"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B5184127
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849754; cv=none; b=nP3pRx4HGtEg7PK43LRVMmIduBuIquUIa+HeSPEJv2NHZDwbk84AdI/xzDYc3Fm/SCKlTRsYo+A0BOdKvutAH652eX14IZvExHEb7hweNVrdYtwRcI/Tkt9axLAv6ZPPm5ujgPNOGlKOVv0PRaUCJ/DtkxhxTXJ+SWM9uLD6Q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849754; c=relaxed/simple;
	bh=xAlgkDD4gE89AmYLOb110oYhrpKLrKaxG4MtCG/wHZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luCKJ960DfrJfcBPBht4XRxRblLZIqJNYGluYBzQqTH6fKjDMGt8Q6V8pDcpFV7CzLNmRG69gQLSOONfdm8s/aEJcL9s8ka5T3yci73dR0Qb9xUYsy1tP9uy6XQ+5dshB3MP86xpkoQDqRrfxpmccJhnEmKp/0DXhXhW20Q0U/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j3avj2Wo; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa16bf49f6so294506eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849751; x=1713454551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGTWiE8J7R1+2J2uKc3Kdb5J9vY+Cg6Yi1ItbsK2z1I=;
        b=j3avj2WoTHd7pNPEbQg6V0IZuP9hwNlqs77+1iUj3CYGh/4mwl7NmEG2CCEIaxKvKC
         oCA58hxsSYYwKV5J8Du3TJJnBn70Z7P0iONtUNlnygR3prLi2OzD4O4TsWSh1fbv1OVp
         Zeq3DIzzDtjsd7+CZ4Q7Cic9Zh82OjA8UfZUK8/s/h9MYdng99iQ1VxLMBcKpRLZyxYk
         kWtbDWqHtxEx4AhvfLDy7NWaY+8ASeGFSBSX+403OG00cd+nbo8wTZmvETRzOzxgyDho
         3qoVSex2xhJZyQCg438bf4YoVBfNwWKHBDambrlmGX9bMElvZjfi1mrofJ+G0nssHsRv
         7dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849751; x=1713454551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGTWiE8J7R1+2J2uKc3Kdb5J9vY+Cg6Yi1ItbsK2z1I=;
        b=Lk/GHdAKJ9MJDEl0DhndIV743Ol+IxgajcHgRSm6RDXkK6x3xRMPdpe6di4IpYYcPD
         jpPrJ6yKKNDFSdi592ch2o9Zzrk1xWNsU5C2QKpvPz7AnecxUW4Eav1FnfRc/67C+HeE
         XMxhZHW3F5qTeGpr1hbayQQqvQoW0dN/wl8g5xn+OEgYIdIlDQtvxSKQYvHOwSia4CUw
         fjWaW3bMV2yDb3696EtObJwYhLXf8sJOyaim0rWnYUivSECBUdAwSuzo4Mori7TsptEe
         zyI0cJEZXp362/GaskDeU37gSaAmTLyhWAw+ITN9orr66tAOTfxasp5gxVR+qp7FQj0K
         QOQQ==
X-Gm-Message-State: AOJu0Yw3aNdT7Os3hUk/1ci2PkdauIGcE28ctyxNwmqCzpAK75OkQEQ5
	KDhTbAdXLpp8j7veE/fPIy8Ef47xVn4tLS37aMp1EAFZK3qC3mCmuSGfmLOvQe4XnZ7UGSBpYDr
	/
X-Google-Smtp-Source: AGHT+IHKkS7fK6wyTyfU+Oktm9Gmn1cPNW5FwEAtv2gnpPHaGwq87cLkY6kD5VY6YnBgDGkwHnwglA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr159667ioh.1.1712849730170;
        Thu, 11 Apr 2024 08:35:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 137/437] drm: convert debugfs helpers to be read/write iterator based
Date: Thu, 11 Apr 2024 09:14:37 -0600
Message-ID: <20240411153126.16201-138-axboe@kernel.dk>
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
 drivers/gpu/drm/drm_debugfs.c     | 28 ++++++++++++++--------------
 drivers/gpu/drm/drm_debugfs_crc.c | 26 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 08fcefd804bc..e7d7cbd930ca 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -171,7 +171,7 @@ static int drm_debugfs_entry_open(struct inode *inode, struct file *file)
 static const struct file_operations drm_debugfs_entry_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_debugfs_entry_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -179,7 +179,7 @@ static const struct file_operations drm_debugfs_entry_fops = {
 static const struct file_operations drm_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -403,17 +403,17 @@ static int connector_open(struct inode *inode, struct file *file)
 	return single_open(file, connector_show, dev);
 }
 
-static ssize_t connector_write(struct file *file, const char __user *ubuf,
-			       size_t len, loff_t *offp)
+static ssize_t connector_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_connector *connector = m->private;
+	size_t len = iov_iter_count(from);
 	char buf[12];
 
 	if (len > sizeof(buf) - 1)
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -444,15 +444,15 @@ static int edid_open(struct inode *inode, struct file *file)
 	return single_open(file, edid_show, dev);
 }
 
-static ssize_t edid_write(struct file *file, const char __user *ubuf,
-			  size_t len, loff_t *offp)
+static ssize_t edid_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_connector *connector = m->private;
+	size_t len = iov_iter_count(from);
 	char *buf;
 	int ret;
 
-	buf = memdup_user(ubuf, len);
+	buf = iterdup(from, len);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -504,20 +504,20 @@ DEFINE_SHOW_ATTRIBUTE(output_bpc);
 static const struct file_operations drm_edid_fops = {
 	.owner = THIS_MODULE,
 	.open = edid_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = edid_write
+	.write_iter = edid_write
 };
 
 
 static const struct file_operations drm_connector_fops = {
 	.owner = THIS_MODULE,
 	.open = connector_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = connector_write
+	.write_iter = connector_write
 };
 
 void drm_debugfs_connector_add(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index bbc3bc4ba844..85741f3eafee 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -117,12 +117,12 @@ static int crc_control_open(struct inode *inode, struct file *file)
 	return single_open(file, crc_control_show, crtc);
 }
 
-static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
-				 size_t len, loff_t *offp)
+static ssize_t crc_control_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_crtc *crtc = m->private;
 	struct drm_crtc_crc *crc = &crtc->crc;
+	size_t len = iov_iter_count(from);
 	char *source;
 	size_t values_cnt;
 	int ret;
@@ -136,7 +136,7 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
 		return -E2BIG;
 	}
 
-	source = memdup_user_nul(ubuf, len);
+	source = iterdup_nul(from, len);
 	if (IS_ERR(source))
 		return PTR_ERR(source);
 
@@ -162,17 +162,17 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
 
 	spin_unlock_irq(&crc->lock);
 
-	*offp += len;
+	iocb->ki_pos += len;
 	return len;
 }
 
 static const struct file_operations drm_crtc_crc_control_fops = {
 	.owner = THIS_MODULE,
 	.open = crc_control_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = crc_control_write
+	.write_iter = crc_control_write,
 };
 
 static int crtc_crc_data_count(struct drm_crtc_crc *crc)
@@ -281,11 +281,11 @@ static int crtc_crc_release(struct inode *inode, struct file *filep)
 #define LINE_LEN(values_cnt)	(10 + 11 * values_cnt + 1 + 1)
 #define MAX_LINE_LEN		(LINE_LEN(DRM_MAX_CRC_NR))
 
-static ssize_t crtc_crc_read(struct file *filep, char __user *user_buf,
-			     size_t count, loff_t *pos)
+static ssize_t crtc_crc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct drm_crtc *crtc = filep->f_inode->i_private;
+	struct drm_crtc *crtc = iocb->ki_filp->f_inode->i_private;
 	struct drm_crtc_crc *crc = &crtc->crc;
+	size_t count = iov_iter_count(to);
 	struct drm_crtc_crc_entry *entry;
 	char buf[MAX_LINE_LEN];
 	int ret, i;
@@ -299,7 +299,7 @@ static ssize_t crtc_crc_read(struct file *filep, char __user *user_buf,
 
 	/* Nothing to read? */
 	while (crtc_crc_data_count(crc) == 0) {
-		if (filep->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			spin_unlock_irq(&crc->lock);
 			return -EAGAIN;
 		}
@@ -335,7 +335,7 @@ static ssize_t crtc_crc_read(struct file *filep, char __user *user_buf,
 		sprintf(buf + 10 + i * 11, " 0x%08x", entry->crcs[i]);
 	sprintf(buf + 10 + crc->values_cnt * 11, "\n");
 
-	if (copy_to_user(user_buf, buf, LINE_LEN(crc->values_cnt)))
+	if (!copy_to_iter_full(buf, LINE_LEN(crc->values_cnt), to))
 		return -EFAULT;
 
 	return LINE_LEN(crc->values_cnt);
@@ -360,7 +360,7 @@ static __poll_t crtc_crc_poll(struct file *file, poll_table *wait)
 static const struct file_operations drm_crtc_crc_data_fops = {
 	.owner = THIS_MODULE,
 	.open = crtc_crc_open,
-	.read = crtc_crc_read,
+	.read_iter = crtc_crc_read,
 	.poll = crtc_crc_poll,
 	.release = crtc_crc_release,
 };
-- 
2.43.0


