Return-Path: <linux-kernel+bounces-141142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2008A1AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11FE1F215E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704C1EE297;
	Thu, 11 Apr 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AkShu8nu"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3C51C21
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850111; cv=none; b=BLBiRi/G8ZF15VcW24wQnglLXPedSiAH29rni/xb//Z0EPsq7XnyICqLr96h5iSB5IYxqypnTa8Dz5uMs+0TRMuKQYq9SQHoYuX2jQunoE+FUzBW4+SrESGHTOnWKsnknSelJeNIiCdxOm4CYLBuX0NhwPbrkJho8iVmppGTd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850111; c=relaxed/simple;
	bh=oXjTkKPohk0vS18x42aZEyvDlY206tp/5qdzhsnIPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjLYoWNX/ReaN7FtsFbUmYMFfkG0NJwFiWtLiBmpEzOk5EXKSyK+mpnyHYJbhHCCRywGfdMKzUtAKW4J49rp68p4SuHsicuhh2W5gqdAGiEtrJAI30k1L2R8JR3DYGT2SvRNqjHVVe1pxAod/zzbuSbTq35HMmfXWLmK3mfCOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AkShu8nu; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16254239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850109; x=1713454909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e84TktZWqz2ftcqRtZv7G98v4ugNTmR72ukEIS+kVtQ=;
        b=AkShu8nuTGEglEUWQkGtSQ0GOEIdbmIivQ7HagR2aK5PVQ+RfMdK4bxNUtIzmlqTkr
         TnQyfybyczmWQTevM37pda9enwAZuLOZdbWB2rfg5sa0b9/oU9uian0wIaDNOv5EmK4y
         y2h9pfyp5fGvzSqUI5ypVhQX76vp3AQHPTsIyGMfBx4PDcojASSjVFDF1bCRhuGSaFRm
         LqfBH+SvEL4ve1K3aUns/znMZ3lnZREjewpOkKgwmL69usVrUHX+QjMKc0DplRrMWYkc
         /7Tgmz3nnv4RsDZwyh5kryxGQOqPe95XZxYuqpnF3hHdD1HWS7bzdDO+plefK2ij47Zp
         988Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850109; x=1713454909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e84TktZWqz2ftcqRtZv7G98v4ugNTmR72ukEIS+kVtQ=;
        b=UT8R6rAfRPYjxPIqXjqUle7RNonq1Xcg+fQNnumphu2oQf95bLT/IPZxipeRJuU3KD
         neVWJpRKoRs5eK+ojjjnEAWsBvWHtdKmY3/XtNG5ROgjI33ZEGb+iydzPlETJ77uiN75
         +Qk63zkUsMk+5rPvE9X9QDjiNeos7bq+HO5SeEG5NJ8YreUDnqqzAQNNhDJkVrgdDVwT
         ZXEGu5ugWR6VXakg4sl+lVSPZXLQfSbmtoJ2R5yOD9eA2YSoGDhpnLVxkeE7NOSnecKM
         ad2B9raf7MoG/4gk5k2Di65cbwSb0lxltBTO9fAdYOrzNEFKqqHgufVXy4VWlhyTju86
         ++Bg==
X-Gm-Message-State: AOJu0YxDisVhFKlLSMeCcg5mWts/Lowb3legmvio7G0xkf+mHH8CVt6F
	XQIudLVPu/z6OPzIC+GkjUt2HoIIhZ+ByjT5F+hYBJsm6anEOr1G5COCt9ny/vHBcTCBSBopsBF
	l
X-Google-Smtp-Source: AGHT+IHB9iuF7+KDqIGOnDGQPqM7FMnuCddIUPQwZzYNs2JMLlsJOK6Z1STkZJeu768r6s4E3ZTvVA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr176905ioh.1.1712850108766;
        Thu, 11 Apr 2024 08:41:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 363/437] hwmon: ibm-cffps: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:23 -0600
Message-ID: <20240411153126.16201-364-axboe@kernel.dk>
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
 drivers/hwmon/pmbus/ibm-cffps.c | 35 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index 1ba4c5e95820..b64875cf6d60 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -75,12 +75,12 @@ struct ibm_cffps {
 
 #define to_psu(x, y) container_of((x), struct ibm_cffps, debugfs_entries[(y)])
 
-static ssize_t ibm_cffps_debugfs_read_input_history(struct file *file, char __user *buf,
-						    size_t count, loff_t *ppos)
+static ssize_t ibm_cffps_debugfs_read_input_history(struct kiocb *iocb,
+						    struct iov_iter *to)
 {
 	int rc;
 	u8 cmd = CFFPS_INPUT_HISTORY_CMD;
-	struct ibm_cffps *psu = file->private_data;
+	struct ibm_cffps *psu = iocb->ki_filp->private_data;
 	struct i2c_msg msg[2] = {
 		{
 			.addr = psu->client->addr,
@@ -95,7 +95,7 @@ static ssize_t ibm_cffps_debugfs_read_input_history(struct file *file, char __us
 		},
 	};
 
-	if (!*ppos) {
+	if (!iocb->ki_pos) {
 		rc = pmbus_lock_interruptible(psu->client);
 		if (rc)
 			return rc;
@@ -116,22 +116,20 @@ static ssize_t ibm_cffps_debugfs_read_input_history(struct file *file, char __us
 			return rc;
 	}
 
-	return simple_read_from_buffer(buf, count, ppos,
-				       psu->input_history + 1,
-				       psu->input_history[0]);
+	return simple_copy_to_iter(psu->input_history + 1, &iocb->ki_pos,
+				   psu->input_history[0], to);
 }
 
 static const struct file_operations ibm_cffps_input_history_fops = {
 	.llseek = noop_llseek,
-	.read = ibm_cffps_debugfs_read_input_history,
+	.read_iter = ibm_cffps_debugfs_read_input_history,
 	.open = simple_open,
 };
 
-static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ibm_cffps_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int i, rc;
-	int *idxp = file->private_data;
+	int *idxp = iocb->ki_filp->private_data;
 	int idx = *idxp;
 	struct ibm_cffps *psu = to_psu(idxp, idx);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
@@ -205,22 +203,21 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
 	data[rc] = '\n';
 	rc += 2;
 
-	return simple_read_from_buffer(buf, count, ppos, data, rc);
+	return simple_copy_to_iter(data, &iocb->ki_pos, rc, to);
 }
 
-static ssize_t ibm_cffps_debugfs_write(struct file *file,
-				       const char __user *buf, size_t count,
-				       loff_t *ppos)
+static ssize_t ibm_cffps_debugfs_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
 	u8 data;
 	ssize_t rc;
-	int *idxp = file->private_data;
+	int *idxp = iocb->ki_filp->private_data;
 	int idx = *idxp;
 	struct ibm_cffps *psu = to_psu(idxp, idx);
 
 	switch (idx) {
 	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
-		rc = simple_write_to_buffer(&data, 1, ppos, buf, count);
+		rc = simple_copy_from_iter(&data, &iocb->ki_pos, 1, from);
 		if (rc <= 0)
 			return rc;
 
@@ -250,8 +247,8 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
 
 static const struct file_operations ibm_cffps_fops = {
 	.llseek = noop_llseek,
-	.read = ibm_cffps_debugfs_read,
-	.write = ibm_cffps_debugfs_write,
+	.read_iter = ibm_cffps_debugfs_read,
+	.write_iter = ibm_cffps_debugfs_write,
 	.open = simple_open,
 };
 
-- 
2.43.0


