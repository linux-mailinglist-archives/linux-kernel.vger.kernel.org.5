Return-Path: <linux-kernel+bounces-140957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B0B8A19CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC031287B10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200021B6808;
	Thu, 11 Apr 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vx3+GN7z"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC71B5C71
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849818; cv=none; b=tAZDXfW7ZzAFWjxR3GF1v46MVUwpevXdW8eIESApz8XZA4pkcLTZ6HXuZzmdCJfMjem9WciTtysri/bySysvm3cyMSxTSRZNLuL4D1UrHX3Gdkatd0W6mRvcH12sEgvB+TXb1lso+4CG4H1zLorI8bcBlJI3PsrhyAdXQYmtmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849818; c=relaxed/simple;
	bh=CC1svicLdhaCZjlfFeGhHfz/dADQtWSLZWgsjapD24o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QePY4HY6G6NFQCi53h0kzuEsLi85+cbgRK3wijtVVim9oXifVfQftoEtYRt9PmxXE+NI3osVhpEqFEielfGEMDkbUBU86Wrr5S5iRFiKOInC4RBSlDweOCjbqE3RPIpVyDec36J5WVQggTmGZzhS9Ndd4zY7+ZoZo67E2a9pSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vx3+GN7z; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8962739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849815; x=1713454615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+P5h9EHRqAZnU4fmhFvxdCq3ZFo6GEMZOC+/tcWY+Q=;
        b=Vx3+GN7zSp9uTMXiiGovRZb166y+aQlT46eCKmK8GXOIYocDZBui/sFWKCeHuSr12N
         epp8Q2B+31/fdrAV4ZJdE+EMrHirPDgYKjApuUORoyJm2/Vad4n6NhXcjcYkTyn0Etry
         U6yjnk9MYG+drfZ7RyrQx0WsE8wtdkY2IiG4PNfq2h+sWm/yBE/dERzUFGBzgZ2FY2z+
         MwjCYS75DzUVIhQD0AaTENBlNMEz4maiyNiF71FJsL5cdG2woAP2LDc57tpCEMzIk/Tj
         9RC2Ej+X7uKY01Xs8bMQ2E465QwQWsxfoAZEPqfavA7mh1KiMnWcVNmgX9vN2og6Mxx6
         yLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849815; x=1713454615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+P5h9EHRqAZnU4fmhFvxdCq3ZFo6GEMZOC+/tcWY+Q=;
        b=NoAn46wCS2bXr5Mp3hQOiiBSW3uO5HkrXH2gLHsTPqoX+U+bX7o6K8/prhOHgrR6Pv
         XG1xEJAV6w5Z+FsDJJV8IrfB1TFFLC1M9c3KiZTz4yM8o6bHdqOfQMwKh/k+PVnYktyg
         KLDthZyzaBSO9LKdEGWnCpnGYwIrwex7Es/2epp6/CEjRtWUrEqBkmk+2TvYXSTVZePY
         Jj6DaYADgjgzIfG7PqI0bCVPVmbnk8+hA+ugicXs0tSUfQaXr6ITYbZ1O5+Uqe5pN0gk
         jXvfct3mKISZHgdq9FsuyxmfbDN+EN5CmIP3L/+vScTUUFYVQ4PiMQiS91vFrc4I+tRz
         +A9A==
X-Gm-Message-State: AOJu0Yx6JmfOv1eq4xDSWtOtKaQ4mFZ/X9l9+lbMsC+d3eC5nrSkBpbz
	8A3ltPM1UTHxaEYASMAEAgqDa5MSmjVni1iLaZeK9w9XzeqCiY/161lXjSKljdGZwVqRMOLthy9
	b
X-Google-Smtp-Source: AGHT+IGDBdNyh7jdQ201cBXvSwj8qQJzK6uSpttLxgyYt5o8rwY9vuij5Z8tDQL9xw66cbUEjXPYKg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr223815ioh.0.1712849815292;
        Thu, 11 Apr 2024 08:36:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 188/437] scsi: hisi_sas: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:28 -0600
Message-ID: <20240411153126.16201-189-axboe@kernel.dk>
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
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 105 ++++++++++++-------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7d2a33514538..79ad1662f601 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3858,17 +3858,17 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 			    &debugfs_ras_v3_hw_fops);
 }
 
-static ssize_t debugfs_trigger_dump_v3_hw_write(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t debugfs_trigger_dump_v3_hw_write(struct kiocb *iocb,
+						struct iov_iter *from)
 {
-	struct hisi_hba *hisi_hba = file->f_inode->i_private;
+	struct hisi_hba *hisi_hba = iocb->ki_filp->f_inode->i_private;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 
 	if (count > 8)
 		return -EFAULT;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (buf[0] != '1')
@@ -3885,7 +3885,7 @@ static ssize_t debugfs_trigger_dump_v3_hw_write(struct file *file,
 }
 
 static const struct file_operations debugfs_trigger_dump_v3_hw_fops = {
-	.write = &debugfs_trigger_dump_v3_hw_write,
+	.write_iter = debugfs_trigger_dump_v3_hw_write,
 	.owner = THIS_MODULE,
 };
 
@@ -3923,12 +3923,12 @@ static int debugfs_bist_linkrate_v3_hw_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static ssize_t debugfs_bist_linkrate_v3_hw_write(struct file *filp,
-						 const char __user *buf,
-						 size_t count, loff_t *ppos)
+static ssize_t debugfs_bist_linkrate_v3_hw_write_iter(struct kiocb *iocb,
+						      struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
+	size_t count = iov_iter_count(from);
 	char kbuf[16] = {}, *pkbuf;
 	bool found = false;
 	int i;
@@ -3939,7 +3939,7 @@ static ssize_t debugfs_bist_linkrate_v3_hw_write(struct file *filp,
 	if (count >= sizeof(kbuf))
 		return -EOVERFLOW;
 
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter_full(kbuf, count, from))
 		return -EINVAL;
 
 	pkbuf = strstrip(kbuf);
@@ -3997,12 +3997,11 @@ static int debugfs_bist_code_mode_v3_hw_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
-						  const char __user *buf,
-						  size_t count,
-						  loff_t *ppos)
+static ssize_t debugfs_bist_code_mode_v3_hw_write_iter(struct kiocb *iocb,
+						       struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct hisi_hba *hisi_hba = m->private;
 	char kbuf[16] = {}, *pkbuf;
 	bool found = false;
@@ -4014,7 +4013,7 @@ static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
 	if (count >= sizeof(kbuf))
 		return -EINVAL;
 
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter_full(kbuf, count, from))
 		return -EOVERFLOW;
 
 	pkbuf = strstrip(kbuf);
@@ -4036,19 +4035,19 @@ static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_code_mode_v3_hw);
 
-static ssize_t debugfs_bist_phy_v3_hw_write(struct file *filp,
-					    const char __user *buf,
-					    size_t count, loff_t *ppos)
+static ssize_t debugfs_bist_phy_v3_hw_write_iter(struct kiocb *iocb,
+						 struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
+	size_t count = iov_iter_count(from);
 	unsigned int phy_no;
 	int val;
 
 	if (hisi_hba->debugfs_bist_enable)
 		return -EPERM;
 
-	val = kstrtouint_from_user(buf, count, 0, &phy_no);
+	val = kstrtouint_from_iter(from, count, 0, &phy_no);
 	if (val)
 		return val;
 
@@ -4070,19 +4069,19 @@ static int debugfs_bist_phy_v3_hw_show(struct seq_file *s, void *p)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_phy_v3_hw);
 
-static ssize_t debugfs_bist_cnt_v3_hw_write(struct file *filp,
-					const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t debugfs_bist_cnt_v3_hw_write_iter(struct kiocb *iocb,
+						 struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
+	size_t count = iov_iter_count(from);
 	unsigned int cnt;
 	int val;
 
 	if (hisi_hba->debugfs_bist_enable)
 		return -EPERM;
 
-	val = kstrtouint_from_user(buf, count, 0, &cnt);
+	val = kstrtouint_from_iter(from, count, 0, &cnt);
 	if (val)
 		return val;
 
@@ -4130,12 +4129,12 @@ static int debugfs_bist_mode_v3_hw_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
-					     const char __user *buf,
-					     size_t count, loff_t *ppos)
+static ssize_t debugfs_bist_mode_v3_hw_write_iter(struct kiocb *iocb,
+						  struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
+	size_t count = iov_iter_count(from);
 	char kbuf[16] = {}, *pkbuf;
 	bool found = false;
 	int i;
@@ -4146,7 +4145,7 @@ static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
 	if (count >= sizeof(kbuf))
 		return -EINVAL;
 
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter_full(kbuf, count, from))
 		return -EOVERFLOW;
 
 	pkbuf = strstrip(kbuf);
@@ -4167,16 +4166,16 @@ static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_mode_v3_hw);
 
-static ssize_t debugfs_bist_enable_v3_hw_write(struct file *filp,
-					       const char __user *buf,
-					       size_t count, loff_t *ppos)
+static ssize_t debugfs_bist_enable_v3_hw_write_iter(struct kiocb *iocb,
+						    struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
+	size_t count = iov_iter_count(from);
 	unsigned int enable;
 	int val;
 
-	val = kstrtouint_from_user(buf, count, 0, &enable);
+	val = kstrtouint_from_iter(from, count, 0, &enable);
 	if (val)
 		return val;
 
@@ -4218,15 +4217,15 @@ static const struct {
 	{ "SATA_6_0_GBPS" },
 };
 
-static ssize_t debugfs_v3_hw_write(struct file *filp,
-				   const char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t debugfs_v3_hw_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 *val = m->private;
 	int res;
 
-	res = kstrtouint_from_user(buf, count, 0, val);
+	res = kstrtouint_from_iter(from, count, 0, val);
 	if (res)
 		return res;
 
@@ -4243,16 +4242,16 @@ static int debugfs_v3_hw_show(struct seq_file *s, void *p)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_v3_hw);
 
-static ssize_t debugfs_phy_down_cnt_v3_hw_write(struct file *filp,
-						const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t debugfs_phy_down_cnt_v3_hw_write_iter(struct kiocb *iocb,
+						     struct iov_iter *from)
 {
-	struct seq_file *s = filp->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct hisi_sas_phy *phy = s->private;
+	size_t count = iov_iter_count(from);
 	unsigned int set_val;
 	int res;
 
-	res = kstrtouint_from_user(buf, count, 0, &set_val);
+	res = kstrtouint_from_iter(from, count, 0, &set_val);
 	if (res)
 		return res;
 
@@ -4370,15 +4369,15 @@ static int debugfs_update_fifo_config_v3_hw(struct hisi_sas_phy *phy)
 	return 0;
 }
 
-static ssize_t debugfs_fifo_update_cfg_v3_hw_write(struct file *filp,
-						   const char __user *buf,
-						   size_t count, loff_t *ppos)
+static ssize_t debugfs_fifo_update_cfg_v3_hw_write(struct kiocb *iocb,
+						   struct iov_iter *from)
 {
-	struct hisi_sas_phy *phy = filp->private_data;
+	struct hisi_sas_phy *phy = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool update;
 	int val;
 
-	val = kstrtobool_from_user(buf, count, &update);
+	val = kstrtobool_from_iter(from, count, &update);
 	if (val)
 		return val;
 
@@ -4394,7 +4393,7 @@ static ssize_t debugfs_fifo_update_cfg_v3_hw_write(struct file *filp,
 
 static const struct file_operations debugfs_fifo_update_cfg_v3_hw_fops = {
 	.open = simple_open,
-	.write = debugfs_fifo_update_cfg_v3_hw_write,
+	.write_iter = debugfs_fifo_update_cfg_v3_hw_write,
 	.owner = THIS_MODULE,
 };
 
-- 
2.43.0


