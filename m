Return-Path: <linux-kernel+bounces-141084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97FA8A1A68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6B71C22E04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48951DB55C;
	Thu, 11 Apr 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="co53fNnp"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02F1D7811
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850014; cv=none; b=UYa1ifJ4UBbgJ7R/vDnykvNRQEJ+I7TV2cRyQQKeDTeltzwFfnMHCR1AbSnzYRmVT42K21VJe+QMBBL3suJhEtb0h9j5IDOQWI3xYpAWm+rtkTkppzH5uea2hSnUneiJgC1mZuxQw7cnVx83koQ32Hsls4weP48VK5VWr2MAA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850014; c=relaxed/simple;
	bh=aMIu88ekLdpGefs281zUQd0O7lgEl6t9BsqODys3j3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwGdV2aH7zfAqNstolgu+uPhHd3Bmndr1VkmfiVHin/fKdV7B1HSQI4IV4bdOgTqzaBTLbu7ySzt85Asidg8qbHioFcEliKSoKIFLRsCMX7d8Ym4GecvKc3wUv2iEnD2xJDLgzv2hK53fbPbUs7pEDY0QJp6XWupBl+cF+0vWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=co53fNnp; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170595839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850009; x=1713454809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLS1F+lzQWz9fDSFE2ynAHTkTSFoTgkuE1xLnmiMzws=;
        b=co53fNnpTwJMZkstBb+zS/UrmI23l5v2cMLCqP+OX1tbsqw/6839OSaKc67m8FMdXA
         0OEBEhsTaqro7Fn0X8HBi7b251vnDDX9+gm8Bw/nFQicBMDsfArbF9zHJ/94tOxf5nEw
         8LYUS05UrwZ1mjhggsP7j7xK1Fd6hD5dTSeyCnYkWkVWGg5M9PF1gs3glAjPT8CPXHo3
         dEciZbMJ46qc24j5NPLtaaikTlfjTW1XlPQjpZfML/1Sd6O5bTsmfCOw+JsC17ZBF2Jw
         9vqiYW0Wp4wlYpVqtZlcf+HKao/nQCofxMOueiCtsAEdYZQxVrP6B8tCb/MgHNQtr42W
         1hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850009; x=1713454809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLS1F+lzQWz9fDSFE2ynAHTkTSFoTgkuE1xLnmiMzws=;
        b=vdGRVJ5x4x8cLMOyIFPHLTS4XY7ShDFxDvkYaNPKRbt6II03QNjxOg7i5CPGImwbtS
         Y42agVN3Fc7GQ2RbQrU+ybS9YPxyJZYOhR48gtzQmElheZkfz68mN9ZXQZ9sZIIEcuS/
         xtkWhJ+mJLwtKO1CmEypBQt5qDzca7gAJlGcShBBCrBmPxj4njGmhmIM6uCZra6MTJ7h
         QHTNL8OlLVAH39kgOCXTGv5ibSzhO1vF9GNnNVFXLcSVveyzNB8+a5AgofwmaDFhhUou
         sYld/NrPiy7tiKbadAhhcekfxdkyRNV+2I85ZKUpsweIUx7xtvYh2z8IrhmrbRRuoajs
         S5aA==
X-Gm-Message-State: AOJu0YzENEZdGzXKeW1qclqgSXqKvVpdDVE9j+7aGn8B7XncSt317Cez
	xbfmKdY14v1xT0ultHk11jw6Yw4S6/mM+NUbNsCuiXf380G1jlY5YG/V5V71xQ5WQbi3xwmSz/0
	W
X-Google-Smtp-Source: AGHT+IEVWVB1EmPB7xrC+dIzqJm9JI6bs969ROu6ucoqkEIDuxGRiyt2EC3UXHphBFsjEA7v/mfIGQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr191323ioj.2.1712850007453;
        Thu, 11 Apr 2024 08:40:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 305/437] drivers/net/wireless/ath/ath11k: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:25 -0600
Message-ID: <20240411153126.16201-306-axboe@kernel.dk>
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
 drivers/net/wireless/ath/ath11k/debugfs.c     | 300 ++++++++----------
 .../wireless/ath/ath11k/debugfs_htt_stats.c   |  56 ++--
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 163 +++++-----
 drivers/net/wireless/ath/ath11k/spectral.c    |  69 ++--
 4 files changed, 274 insertions(+), 314 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index a48e737ef35d..f51afdf83a89 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -296,20 +296,18 @@ static int ath11k_release_pdev_stats(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath11k_read_pdev_stats(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath11k_read_pdev_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	const char *buf = file->private_data;
+	const char *buf = iocb->ki_filp->private_data;
 	size_t len = strlen(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_pdev_stats = {
 	.open = ath11k_open_pdev_stats,
 	.release = ath11k_release_pdev_stats,
-	.read = ath11k_read_pdev_stats,
+	.read_iter = ath11k_read_pdev_stats,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -367,20 +365,18 @@ static int ath11k_release_vdev_stats(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath11k_read_vdev_stats(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath11k_read_vdev_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	const char *buf = file->private_data;
+	const char *buf = iocb->ki_filp->private_data;
 	size_t len = strlen(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_vdev_stats = {
 	.open = ath11k_open_vdev_stats,
 	.release = ath11k_release_vdev_stats,
-	.read = ath11k_read_vdev_stats,
+	.read_iter = ath11k_read_vdev_stats,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -451,34 +447,31 @@ static int ath11k_release_bcn_stats(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath11k_read_bcn_stats(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath11k_read_bcn_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	const char *buf = file->private_data;
+	const char *buf = iocb->ki_filp->private_data;
 	size_t len = strlen(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_bcn_stats = {
 	.open = ath11k_open_bcn_stats,
 	.release = ath11k_release_bcn_stats,
-	.read = ath11k_read_bcn_stats,
+	.read_iter = ath11k_read_bcn_stats,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath11k_read_simulate_fw_crash(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	const char buf[] =
 		"To simulate firmware crash write one of the keywords to this file:\n"
 		"`assert` - this will send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n"
 		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 /* Simulate firmware crash:
@@ -488,11 +481,11 @@ static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
  * vdev id. This is hard firmware crash because it is recoverable only by cold
  * firmware reset.
  */
-static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_write_simulate_fw_crash(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ath11k_base *ab = file->private_data;
+	struct ath11k_base *ab = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_pdev *pdev;
 	struct ath11k *ar = ab->pdevs[0].ar;
 	char buf[32] = {0};
@@ -508,16 +501,16 @@ static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
 		}
 	}
 	/* filter partial writes and invalid commands */
-	if (*ppos != 0 || count >= sizeof(buf) || count == 0)
+	if (iocb->ki_pos != 0 || count >= sizeof(buf) || count == 0)
 		return -EINVAL;
 
-	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	rc = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (rc < 0)
 		return rc;
 
 	/* drop the possible '\n' from the end */
-	if (buf[*ppos - 1] == '\n')
-		buf[*ppos - 1] = '\0';
+	if (buf[iocb->ki_pos - 1] == '\n')
+		buf[iocb->ki_pos - 1] = '\0';
 
 	if (radioup == 0) {
 		ret = -ENETDOWN;
@@ -550,22 +543,22 @@ static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
 }
 
 static const struct file_operations fops_simulate_fw_crash = {
-	.read = ath11k_read_simulate_fw_crash,
-	.write = ath11k_write_simulate_fw_crash,
+	.read_iter = ath11k_read_simulate_fw_crash,
+	.write_iter = ath11k_write_simulate_fw_crash,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_write_enable_extd_tx_stats(struct file *file,
-						 const char __user *ubuf,
-						 size_t count, loff_t *ppos)
+static ssize_t ath11k_write_enable_extd_tx_stats(struct kiocb *iocb,
+						 struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 filter;
 	int ret;
 
-	if (kstrtouint_from_user(ubuf, count, 0, &filter))
+	if (kstrtouint_from_iter(from, count, 0, &filter))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -588,13 +581,11 @@ static ssize_t ath11k_write_enable_extd_tx_stats(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_read_enable_extd_tx_stats(struct file *file,
-						char __user *ubuf,
-						size_t count, loff_t *ppos)
-
+static ssize_t ath11k_read_enable_extd_tx_stats(struct kiocb *iocb,
+						struct iov_iter *to)
 {
 	char buf[32] = {0};
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -602,27 +593,27 @@ static ssize_t ath11k_read_enable_extd_tx_stats(struct file *file,
 			ar->debug.extd_tx_stats);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_extd_tx_stats = {
-	.read = ath11k_read_enable_extd_tx_stats,
-	.write = ath11k_write_enable_extd_tx_stats,
+	.read_iter = ath11k_read_enable_extd_tx_stats,
+	.write_iter = ath11k_write_enable_extd_tx_stats,
 	.open = simple_open
 };
 
-static ssize_t ath11k_write_extd_rx_stats(struct file *file,
-					  const char __user *ubuf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath11k_write_extd_rx_stats(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_base *ab = ar->ab;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 enable, rx_filter = 0, ring_id;
 	int i;
 	int ret;
 
-	if (kstrtouint_from_user(ubuf, count, 0, &enable))
+	if (kstrtouint_from_iter(from, count, 0, &enable))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -687,11 +678,9 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_read_extd_rx_stats(struct file *file,
-					 char __user *ubuf,
-					 size_t count, loff_t *ppos)
+static ssize_t ath11k_read_extd_rx_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	int len = 0;
 
@@ -700,12 +689,12 @@ static ssize_t ath11k_read_extd_rx_stats(struct file *file,
 			ar->debug.extd_rx_stats);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_extd_rx_stats = {
-	.read = ath11k_read_extd_rx_stats,
-	.write = ath11k_write_extd_rx_stats,
+	.read_iter = ath11k_read_extd_rx_stats,
+	.write_iter = ath11k_write_extd_rx_stats,
 	.open = simple_open,
 };
 
@@ -775,11 +764,10 @@ static ssize_t ath11k_debugfs_dump_soc_ring_bp_stats(struct ath11k_base *ab,
 	return len;
 }
 
-static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct ath11k_base *ab = file->private_data;
+	struct ath11k_base *ab = iocb->ki_filp->private_data;
 	struct ath11k_soc_dp_stats *soc_stats = &ab->soc_stats;
 	int len = 0, i, retval;
 	const int size = 4096;
@@ -839,32 +827,30 @@ static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
 
 	if (len > size)
 		len = size;
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_soc_dp_stats = {
-	.read = ath11k_debugfs_dump_soc_dp_stats,
+	.read_iter = ath11k_debugfs_dump_soc_dp_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_write_fw_dbglog(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath11k_write_fw_dbglog(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[128] = {0};
 	struct ath11k_fw_dbglog dbglog;
 	unsigned int param, mod_id_index, is_end;
 	u64 value;
 	int ret, num;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -909,7 +895,7 @@ static ssize_t ath11k_write_fw_dbglog(struct file *file,
 }
 
 static const struct file_operations fops_fw_dbglog = {
-	.write = ath11k_write_fw_dbglog,
+	.write_iter = ath11k_write_fw_dbglog,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -940,12 +926,10 @@ static int ath11k_open_sram_dump(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath11k_read_sram_dump(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath11k_read_sram_dump(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath11k_base *ab = file->f_inode->i_private;
-	const char *buf = file->private_data;
+	struct ath11k_base *ab = iocb->ki_filp->f_inode->i_private;
+	const char *buf = iocb->ki_filp->private_data;
 	int len;
 	u32 start, end;
 
@@ -953,7 +937,7 @@ static ssize_t ath11k_read_sram_dump(struct file *file,
 	end = ab->hw_params.sram_dump.end;
 	len = end - start + 1;
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static int ath11k_release_sram_dump(struct inode *inode, struct file *file)
@@ -966,7 +950,7 @@ static int ath11k_release_sram_dump(struct inode *inode, struct file *file)
 
 static const struct file_operations fops_sram_dump = {
 	.open = ath11k_open_sram_dump,
-	.read = ath11k_read_sram_dump,
+	.read_iter = ath11k_read_sram_dump,
 	.release = ath11k_release_sram_dump,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1064,11 +1048,11 @@ void ath11k_debugfs_fw_stats_init(struct ath11k *ar)
 			    &fops_bcn_stats);
 }
 
-static ssize_t ath11k_write_pktlog_filter(struct file *file,
-					  const char __user *ubuf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath11k_write_pktlog_filter(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_base *ab = ar->ab;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 rx_filter = 0, ring_id, filter, mode;
@@ -1082,7 +1066,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 		goto out;
 	}
 
-	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	rc = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (rc < 0) {
 		ret = rc;
 		goto out;
@@ -1196,13 +1180,12 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_read_pktlog_filter(struct file *file,
-					 char __user *ubuf,
-					 size_t count, loff_t *ppos)
+static ssize_t ath11k_read_pktlog_filter(struct kiocb *iocb,
+					 struct iov_iter *to)
 
 {
 	char buf[32] = {0};
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1211,20 +1194,20 @@ static ssize_t ath11k_read_pktlog_filter(struct file *file,
 			ar->debug.pktlog_mode);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_pktlog_filter = {
-	.read = ath11k_read_pktlog_filter,
-	.write = ath11k_write_pktlog_filter,
+	.read_iter = ath11k_read_pktlog_filter,
+	.write_iter = ath11k_write_pktlog_filter,
 	.open = simple_open
 };
 
-static ssize_t ath11k_write_simulate_radar(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath11k_write_simulate_radar(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
 	ret = ath11k_wmi_simulate_radar(ar);
@@ -1235,15 +1218,14 @@ static ssize_t ath11k_write_simulate_radar(struct file *file,
 }
 
 static const struct file_operations fops_simulate_radar = {
-	.write = ath11k_write_simulate_radar,
+	.write_iter = ath11k_write_simulate_radar,
 	.open = simple_open
 };
 
-static ssize_t ath11k_debug_dump_dbr_entries(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath11k_debug_dump_dbr_entries(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ath11k_dbg_dbr_data *dbr_dbg_data = file->private_data;
+	struct ath11k_dbg_dbr_data *dbr_dbg_data = iocb->ki_filp->private_data;
 	static const char * const event_id_to_string[] = {"empty", "Rx", "Replenish"};
 	int size = ATH11K_DEBUG_DBR_ENTRIES_MAX * 100;
 	char *buf;
@@ -1274,14 +1256,14 @@ static ssize_t ath11k_debug_dump_dbr_entries(struct file *file,
 
 	spin_unlock_bh(&dbr_dbg_data->lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return ret;
 }
 
 static const struct file_operations fops_debug_dump_dbr_entries = {
-	.read = ath11k_debug_dump_dbr_entries,
+	.read_iter = ath11k_debug_dump_dbr_entries,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1350,11 +1332,11 @@ static int ath11k_debugfs_dbr_dbg_init(struct ath11k *ar, int dbr_id)
 	return 0;
 }
 
-static ssize_t ath11k_debugfs_write_enable_dbr_dbg(struct file *file,
-						   const char __user *ubuf,
-						   size_t count, loff_t *ppos)
+static ssize_t ath11k_debugfs_write_enable_dbr_dbg(struct kiocb *iocb,
+						   struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32] = {0};
 	u32 dbr_id, enable;
 	int ret;
@@ -1366,7 +1348,7 @@ static ssize_t ath11k_debugfs_write_enable_dbr_dbg(struct file *file,
 		goto out;
 	}
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret < 0)
 		goto out;
 
@@ -1396,21 +1378,21 @@ static ssize_t ath11k_debugfs_write_enable_dbr_dbg(struct file *file,
 }
 
 static const struct file_operations fops_dbr_debug = {
-	.write = ath11k_debugfs_write_enable_dbr_dbg,
+	.write_iter = ath11k_debugfs_write_enable_dbr_dbg,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_write_ps_timekeeper_enable(struct file *file,
-						 const char __user *user_buf,
-						 size_t count, loff_t *ppos)
+static ssize_t ath11k_write_ps_timekeeper_enable(struct kiocb *iocb,
+						 struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 	u8 ps_timekeeper_enable;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &ps_timekeeper_enable))
+	if (kstrtou8_from_iter(from, count, 0, &ps_timekeeper_enable))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1433,11 +1415,10 @@ static ssize_t ath11k_write_ps_timekeeper_enable(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_read_ps_timekeeper_enable(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath11k_read_ps_timekeeper_enable(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	int len;
 
@@ -1445,12 +1426,12 @@ static ssize_t ath11k_read_ps_timekeeper_enable(struct file *file,
 	len = scnprintf(buf, sizeof(buf), "%d\n", ar->ps_timekeeper_enable);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_ps_timekeeper_enable = {
-	.read = ath11k_read_ps_timekeeper_enable,
-	.write = ath11k_write_ps_timekeeper_enable,
+	.read_iter = ath11k_read_ps_timekeeper_enable,
+	.write_iter = ath11k_write_ps_timekeeper_enable,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1467,15 +1448,15 @@ static void ath11k_reset_peer_ps_duration(void *data,
 	spin_unlock_bh(&ar->data_lock);
 }
 
-static ssize_t ath11k_write_reset_ps_duration(struct file *file,
-					      const  char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_write_reset_ps_duration(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u8 reset_ps_duration;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &reset_ps_duration))
+	if (kstrtou8_from_iter(from, count, 0, &reset_ps_duration))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1501,7 +1482,7 @@ static ssize_t ath11k_write_reset_ps_duration(struct file *file,
 }
 
 static const struct file_operations fops_reset_ps_duration = {
-	.write = ath11k_write_reset_ps_duration,
+	.write_iter = ath11k_write_reset_ps_duration,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1520,17 +1501,17 @@ static void ath11k_peer_ps_state_disable(void *data,
 	spin_unlock_bh(&ar->data_lock);
 }
 
-static ssize_t ath11k_write_ps_state_enable(struct file *file,
-					    const char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath11k_write_ps_state_enable(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_pdev *pdev = ar->pdev;
 	int ret;
 	u32 param;
 	u8 ps_state_enable;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &ps_state_enable))
+	if (kstrtou8_from_iter(from, count, 0, &ps_state_enable))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1566,11 +1547,10 @@ static ssize_t ath11k_write_ps_state_enable(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_read_ps_state_enable(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath11k_read_ps_state_enable(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	int len;
 
@@ -1578,12 +1558,12 @@ static ssize_t ath11k_read_ps_state_enable(struct file *file,
 	len = scnprintf(buf, sizeof(buf), "%d\n", ar->ps_state_enable);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_ps_state_enable = {
-	.read = ath11k_read_ps_state_enable,
-	.write = ath11k_write_ps_state_enable,
+	.read_iter = ath11k_read_ps_state_enable,
+	.write_iter = ath11k_write_ps_state_enable,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1671,13 +1651,13 @@ void ath11k_debugfs_unregister(struct ath11k *ar)
 	}
 }
 
-static ssize_t ath11k_write_twt_add_dialog(struct file *file,
-					   const char __user *ubuf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath11k_write_twt_add_dialog(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath11k_vif *arvif = file->private_data;
+	struct ath11k_vif *arvif = iocb->ki_filp->private_data;
 	struct wmi_twt_add_dialog_params params = { 0 };
 	struct wmi_twt_enable_params twt_params = {0};
+	size_t count = iov_iter_count(from);
 	struct ath11k *ar = arvif->ar;
 	u8 buf[128] = {0};
 	int ret;
@@ -1687,7 +1667,7 @@ static ssize_t ath11k_write_twt_add_dialog(struct file *file,
 		return -EOPNOTSUPP;
 	}
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret < 0)
 		return ret;
 
@@ -1747,11 +1727,11 @@ static ssize_t ath11k_write_twt_add_dialog(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_write_twt_del_dialog(struct file *file,
-					   const char __user *ubuf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath11k_write_twt_del_dialog(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath11k_vif *arvif = file->private_data;
+	struct ath11k_vif *arvif = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wmi_twt_del_dialog_params params = { 0 };
 	struct wmi_twt_enable_params twt_params = {0};
 	struct ath11k *ar = arvif->ar;
@@ -1763,7 +1743,7 @@ static ssize_t ath11k_write_twt_del_dialog(struct file *file,
 		return -EOPNOTSUPP;
 	}
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret < 0)
 		return ret;
 
@@ -1794,11 +1774,11 @@ static ssize_t ath11k_write_twt_del_dialog(struct file *file,
 	return count;
 }
 
-static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
-					     const char __user *ubuf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath11k_write_twt_pause_dialog(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct ath11k_vif *arvif = file->private_data;
+	struct ath11k_vif *arvif = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wmi_twt_pause_dialog_params params = { 0 };
 	u8 buf[64] = {0};
 	int ret;
@@ -1808,7 +1788,7 @@ static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
 		return -EOPNOTSUPP;
 	}
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret < 0)
 		return ret;
 
@@ -1833,11 +1813,11 @@ static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
 	return count;
 }
 
-static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
-					      const char __user *ubuf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_write_twt_resume_dialog(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ath11k_vif *arvif = file->private_data;
+	struct ath11k_vif *arvif = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wmi_twt_resume_dialog_params params = { 0 };
 	u8 buf[64] = {0};
 	int ret;
@@ -1847,7 +1827,7 @@ static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
 		return -EOPNOTSUPP;
 	}
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret < 0)
 		return ret;
 
@@ -1875,22 +1855,22 @@ static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
 }
 
 static const struct file_operations ath11k_fops_twt_add_dialog = {
-	.write = ath11k_write_twt_add_dialog,
+	.write_iter = ath11k_write_twt_add_dialog,
 	.open = simple_open
 };
 
 static const struct file_operations ath11k_fops_twt_del_dialog = {
-	.write = ath11k_write_twt_del_dialog,
+	.write_iter = ath11k_write_twt_del_dialog,
 	.open = simple_open
 };
 
 static const struct file_operations ath11k_fops_twt_pause_dialog = {
-	.write = ath11k_write_twt_pause_dialog,
+	.write_iter = ath11k_write_twt_pause_dialog,
 	.open = simple_open
 };
 
 static const struct file_operations ath11k_fops_twt_resume_dialog = {
-	.write = ath11k_write_twt_resume_dialog,
+	.write_iter = ath11k_write_twt_resume_dialog,
 	.open = simple_open
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 870e86a31bf8..d2b444ad7157 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -4601,28 +4601,27 @@ void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
 		complete(&stats_req->cmpln);
 }
 
-static ssize_t ath11k_read_htt_stats_type(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath11k_read_htt_stats_type(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	size_t len;
 
 	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.type);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath11k_write_htt_stats_type(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath11k_write_htt_stats_type(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u8 type;
 	int ret;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	ret = kstrtou8_from_iter(from, count, 0, &type);
 	if (ret)
 		return ret;
 
@@ -4640,8 +4639,8 @@ static ssize_t ath11k_write_htt_stats_type(struct file *file,
 }
 
 static const struct file_operations fops_htt_stats_type = {
-	.read = ath11k_read_htt_stats_type,
-	.write = ath11k_write_htt_stats_type,
+	.read_iter = ath11k_read_htt_stats_type,
+	.write_iter = ath11k_write_htt_stats_type,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -4812,50 +4811,47 @@ static int ath11k_release_htt_stats(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath11k_read_htt_stats(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath11k_read_htt_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debug_htt_stats_req *stats_req = file->private_data;
+	struct debug_htt_stats_req *stats_req = iocb->ki_filp->private_data;
 	char *buf;
 	u32 length = 0;
 
 	buf = stats_req->buf;
 	length = min_t(u32, stats_req->buf_len, ATH11K_HTT_STATS_BUF_SIZE);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, length);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations fops_dump_htt_stats = {
 	.open = ath11k_open_htt_stats,
 	.release = ath11k_release_htt_stats,
-	.read = ath11k_read_htt_stats,
+	.read_iter = ath11k_read_htt_stats,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_read_htt_stats_reset(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath11k_read_htt_stats_reset(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	size_t len;
 
 	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.reset);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath11k_write_htt_stats_reset(struct file *file,
-					    const char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath11k_write_htt_stats_reset(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u8 type;
 	struct htt_ext_stats_cfg_params cfg_params = { 0 };
 	int ret;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	ret = kstrtou8_from_iter(from, count, 0, &type);
 	if (ret)
 		return ret;
 
@@ -4885,8 +4881,8 @@ static ssize_t ath11k_write_htt_stats_reset(struct file *file,
 }
 
 static const struct file_operations fops_htt_stats_reset = {
-	.read = ath11k_read_htt_stats_reset,
-	.write = ath11k_write_htt_stats_reset,
+	.read_iter = ath11k_read_htt_stats_reset,
+	.write_iter = ath11k_write_htt_stats_reset,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index f56a24b6c8da..19b2e974b484 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -132,11 +132,10 @@ void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
 	ath11k_dp_tx_update_txcompl(ar, ts);
 }
 
-static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
-					    char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_dump_tx_stats(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct ath11k_htt_data_stats *stats;
@@ -225,7 +224,7 @@ static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
 
 	if (len > size)
 		len = size;
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	mutex_unlock(&ar->conf_mutex);
@@ -233,17 +232,16 @@ static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
 }
 
 static const struct file_operations fops_tx_stats = {
-	.read = ath11k_dbg_sta_dump_tx_stats,
+	.read_iter = ath11k_dbg_sta_dump_tx_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
-					    char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_dump_rx_stats(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
@@ -323,7 +321,7 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 
 	if (len > size)
 		len = size;
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	mutex_unlock(&ar->conf_mutex);
@@ -331,7 +329,7 @@ static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
 }
 
 static const struct file_operations fops_rx_stats = {
-	.read = ath11k_dbg_sta_dump_rx_stats,
+	.read_iter = ath11k_dbg_sta_dump_rx_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -388,32 +386,31 @@ ath11k_dbg_sta_release_htt_peer_stats(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath11k_dbg_sta_read_htt_peer_stats(struct file *file,
-						  char __user *user_buf,
-						  size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_read_htt_peer_stats(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	struct debug_htt_stats_req *stats_req = file->private_data;
+	struct debug_htt_stats_req *stats_req = iocb->ki_filp->private_data;
 	char *buf;
 	u32 length = 0;
 
 	buf = stats_req->buf;
 	length = min_t(u32, stats_req->buf_len, ATH11K_HTT_STATS_BUF_SIZE);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, length);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations fops_htt_peer_stats = {
 	.open = ath11k_dbg_sta_open_htt_peer_stats,
 	.release = ath11k_dbg_sta_release_htt_peer_stats,
-	.read = ath11k_dbg_sta_read_htt_peer_stats,
+	.read_iter = ath11k_dbg_sta_read_htt_peer_stats,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_write_peer_pktlog(struct file *file,
-						const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_write_peer_pktlog(struct kiocb *iocb,
+						struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	int ret, enable;
@@ -425,7 +422,7 @@ static ssize_t ath11k_dbg_sta_write_peer_pktlog(struct file *file,
 		goto out;
 	}
 
-	ret = kstrtoint_from_user(buf, count, 0, &enable);
+	ret = kstrtoint_from_iter(from, count, 0, &enable);
 	if (ret)
 		goto out;
 
@@ -449,11 +446,10 @@ static ssize_t ath11k_dbg_sta_write_peer_pktlog(struct file *file,
 	return ret;
 }
 
-static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct file *file,
-					       char __user *ubuf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[32] = {0};
@@ -465,30 +461,29 @@ static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct file *file,
 			ar->debug.pktlog_peer_addr);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_peer_pktlog = {
-	.write = ath11k_dbg_sta_write_peer_pktlog,
-	.read = ath11k_dbg_sta_read_peer_pktlog,
+	.write_iter = ath11k_dbg_sta_write_peer_pktlog,
+	.read_iter = ath11k_dbg_sta_read_peer_pktlog,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_write_delba(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_write_delba(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, initiator, reason;
 	int ret;
 	char buf[64] = {0};
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -521,25 +516,24 @@ static ssize_t ath11k_dbg_sta_write_delba(struct file *file,
 }
 
 static const struct file_operations fops_delba = {
-	.write = ath11k_dbg_sta_write_delba,
+	.write_iter = ath11k_dbg_sta_write_delba,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_write_addba_resp(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_write_addba_resp(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, status;
 	int ret;
 	char buf[64] = {0};
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -571,25 +565,24 @@ static ssize_t ath11k_dbg_sta_write_addba_resp(struct file *file,
 }
 
 static const struct file_operations fops_addba_resp = {
-	.write = ath11k_dbg_sta_write_addba_resp,
+	.write_iter = ath11k_dbg_sta_write_addba_resp,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_write_addba(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_write_addba(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 tid, buf_size;
 	int ret;
 	char buf[64] = {0};
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -622,17 +615,16 @@ static ssize_t ath11k_dbg_sta_write_addba(struct file *file,
 }
 
 static const struct file_operations fops_addba = {
-	.write = ath11k_dbg_sta_write_addba,
+	.write_iter = ath11k_dbg_sta_write_addba,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_read_aggr_mode(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_read_aggr_mode(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[64];
@@ -645,20 +637,20 @@ static ssize_t ath11k_dbg_sta_read_aggr_mode(struct file *file,
 			"auto" : "manual", "auto = 0", "manual = 1");
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath11k_dbg_sta_write_aggr_mode(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_write_aggr_mode(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u32 aggr_mode;
 	int ret;
 
-	if (kstrtouint_from_user(user_buf, count, 0, &aggr_mode))
+	if (kstrtouint_from_iter(from, count, 0, &aggr_mode))
 		return -EINVAL;
 
 	if (aggr_mode >= ATH11K_DBG_AGGR_MODE_MAX)
@@ -685,26 +677,25 @@ static ssize_t ath11k_dbg_sta_write_aggr_mode(struct file *file,
 }
 
 static const struct file_operations fops_aggr_mode = {
-	.read = ath11k_dbg_sta_read_aggr_mode,
-	.write = ath11k_dbg_sta_write_aggr_mode,
+	.read_iter = ath11k_dbg_sta_read_aggr_mode,
+	.write_iter = ath11k_dbg_sta_write_aggr_mode,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
 static ssize_t
-ath11k_write_htt_peer_stats_reset(struct file *file,
-				  const char __user *user_buf,
-				  size_t count, loff_t *ppos)
+ath11k_write_htt_peer_stats_reset(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	struct htt_ext_stats_cfg_params cfg_params = { 0 };
 	int ret;
 	u8 type;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	ret = kstrtou8_from_iter(from, count, 0, &type);
 	if (ret)
 		return ret;
 
@@ -746,17 +737,16 @@ ath11k_write_htt_peer_stats_reset(struct file *file,
 }
 
 static const struct file_operations fops_htt_peer_stats_reset = {
-	.write = ath11k_write_htt_peer_stats_reset,
+	.write_iter = ath11k_write_htt_peer_stats_reset,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_read_peer_ps_state(struct file *file,
-						 char __user *user_buf,
-						 size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_read_peer_ps_state(struct kiocb *iocb,
+						 struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[20];
@@ -768,22 +758,20 @@ static ssize_t ath11k_dbg_sta_read_peer_ps_state(struct file *file,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_peer_ps_state = {
 	.open = simple_open,
-	.read = ath11k_dbg_sta_read_peer_ps_state,
+	.read_iter = ath11k_dbg_sta_read_peer_ps_state,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_read_current_ps_duration(struct file *file,
-						       char __user *user_buf,
-						       size_t count,
-						       loff_t *ppos)
+static ssize_t ath11k_dbg_sta_read_current_ps_duration(struct kiocb *iocb,
+						       struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	u64 time_since_station_in_power_save;
@@ -803,21 +791,20 @@ static ssize_t ath11k_dbg_sta_read_current_ps_duration(struct file *file,
 			time_since_station_in_power_save);
 	spin_unlock_bh(&ar->data_lock);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_current_ps_duration = {
 	.open = simple_open,
-	.read = ath11k_dbg_sta_read_current_ps_duration,
+	.read_iter = ath11k_dbg_sta_read_current_ps_duration,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_dbg_sta_read_total_ps_duration(struct file *file,
-						     char __user *user_buf,
-						     size_t count, loff_t *ppos)
+static ssize_t ath11k_dbg_sta_read_total_ps_duration(struct kiocb *iocb,
+						     struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
 	char buf[20];
@@ -838,12 +825,12 @@ static ssize_t ath11k_dbg_sta_read_total_ps_duration(struct file *file,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_total_ps_duration = {
 	.open = simple_open,
-	.read = ath11k_dbg_sta_read_total_ps_duration,
+	.read_iter = ath11k_dbg_sta_read_total_ps_duration,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 79e091134515..77f3830dbb3a 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -266,11 +266,10 @@ static int ath11k_spectral_scan_config(struct ath11k *ar,
 	return 0;
 }
 
-static ssize_t ath11k_read_file_spec_scan_ctl(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_read_file_spec_scan_ctl(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char *mode = "";
 	size_t len;
 	enum ath11k_spectral_mode spectral_mode;
@@ -292,20 +291,20 @@ static ssize_t ath11k_read_file_spec_scan_ctl(struct file *file,
 	}
 
 	len = strlen(mode);
-	return simple_read_from_buffer(user_buf, count, ppos, mode, len);
+	return simple_copy_to_iter(mode, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath11k_write_file_spec_scan_ctl(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath11k_write_file_spec_scan_ctl(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	ssize_t len;
 	int ret;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -353,18 +352,17 @@ static ssize_t ath11k_write_file_spec_scan_ctl(struct file *file,
 }
 
 static const struct file_operations fops_scan_ctl = {
-	.read = ath11k_read_file_spec_scan_ctl,
-	.write = ath11k_write_file_spec_scan_ctl,
+	.read_iter = ath11k_read_file_spec_scan_ctl,
+	.write_iter = ath11k_write_file_spec_scan_ctl,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_read_file_spectral_count(struct file *file,
-					       char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath11k_read_file_spectral_count(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	size_t len;
 	u16 spectral_count;
@@ -374,18 +372,18 @@ static ssize_t ath11k_read_file_spectral_count(struct file *file,
 	mutex_unlock(&ar->conf_mutex);
 
 	len = sprintf(buf, "%d\n", spectral_count);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath11k_write_file_spectral_count(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath11k_write_file_spectral_count(struct kiocb *iocb,
+						struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -400,18 +398,17 @@ static ssize_t ath11k_write_file_spectral_count(struct file *file,
 }
 
 static const struct file_operations fops_scan_count = {
-	.read = ath11k_read_file_spectral_count,
-	.write = ath11k_write_file_spectral_count,
+	.read_iter = ath11k_read_file_spectral_count,
+	.write_iter = ath11k_write_file_spectral_count,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath11k_read_file_spectral_bins(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_read_file_spectral_bins(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int bins, fft_size;
 	size_t len;
@@ -424,18 +421,18 @@ static ssize_t ath11k_read_file_spectral_bins(struct file *file,
 	mutex_unlock(&ar->conf_mutex);
 
 	len = sprintf(buf, "%d\n", bins);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath11k_write_file_spectral_bins(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath11k_write_file_spectral_bins(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ath11k *ar = file->private_data;
+	struct ath11k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -454,8 +451,8 @@ static ssize_t ath11k_write_file_spectral_bins(struct file *file,
 }
 
 static const struct file_operations fops_scan_bins = {
-	.read = ath11k_read_file_spectral_bins,
-	.write = ath11k_write_file_spectral_bins,
+	.read_iter = ath11k_read_file_spectral_bins,
+	.write_iter = ath11k_write_file_spectral_bins,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
-- 
2.43.0


