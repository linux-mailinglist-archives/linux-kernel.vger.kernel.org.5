Return-Path: <linux-kernel+bounces-141079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C268A1A61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E811284EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92731D9FEA;
	Thu, 11 Apr 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NPB/0CXd"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7921D6382
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850008; cv=none; b=KjSf0A320PVt3m40RD/wcqOp3GRbtzdSeGZxzcLHdsjpN7dXiDnUaCyGblz0LihlvTCyvnjA+8PU6XfXDaxtYX3u0GvaJnS+Gx4wFGK9nMIB7CPNYUif8VTruclemWtN2GZb1+YiY0xaJXMtETSglUlS+OhGl+1LVKJmnxNv5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850008; c=relaxed/simple;
	bh=safo+3KppbrfaE/ZWM9s/00ZzRe2clHcb0Hc8+WBPxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHzfM5H71zWeYk6xgi8c2GxWlIHAULETapYbKKYAeJYV9k/ijcHCmKvnsQ5v7p7+4JO6YJ1TStG/IA2uBELhanoAfxqx1SYj9VJZH+HRoq/ftUjpvAixNvwAMDg1p6JQEul7M+pnWjeFt68OQgdv6cwr6Y9VuNvMK1iQrLNPpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NPB/0CXd; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9037439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850005; x=1713454805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhrkCaU9n4JlMQVLlm18IbTnJ2di94bLnrw1MBGlhbM=;
        b=NPB/0CXdGI033JoGCqHSbtkTeFSRIvx24tofSBVoDyhItQVIZkISn+23KSiDQXrqUE
         BwZvy1PjQj/nfmhlOtyn9JoULjrQ0hKM7z4AFDF3/LyqpKnJJLDNLb2UBsYIp1WZ7+3l
         5PDHXojDghr33g9vky8PwaalyDNONCVaqvkDYcUIYfJsTpRrIE/xuzH3+c7NvTFxzbjZ
         mVteBfQuRV6y7QZW/6ykPjWxZKTD4pcXIztzNJVX7V/DLsuWHKX+eJREZHiKtxd3FN9j
         iUSEJlX1ODCibn9tBS8QH6jkhImc39s6IEsIL3MbpJBb3X/y7M8jkFSevCUnRFTYFSZL
         Vahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850005; x=1713454805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhrkCaU9n4JlMQVLlm18IbTnJ2di94bLnrw1MBGlhbM=;
        b=N58DztshToi6m/rsm//qO8kKq7KSLmpmxPd5iILp/+FIP5/Hn1kB4/YPQjb8kuMlB2
         4ljkbR4NNRkupL5mgTPlYsWA2vlPT5iwBv5ijksjV1yZNKRWkeBVTWVGX1EGZNvOscWh
         Pxl3wwkDOZfAkR3+Kx6R+xur6Ex9/EOFIhNfE9ejO6DwmG8c6pxz2mfu1XRZGLeOSnNy
         PaHuLGaYb1E919unK2GrEiHqWd1Tk4j/hPOPVMtdlccDm8cceruEkGPFx2P7q6QuyQyv
         sEPknfq+XAQY6xioDkfNKMWV0C1Q7g/hgNOFlPiW0V8zgUdAsjwkUJIfGUNDJ1g4Im//
         Ne+Q==
X-Gm-Message-State: AOJu0YwbJRmLqFPh8fIEMSgR7jiypN73BBmx7bjs7xsY5UY+WgzSqo+y
	3o2jwlyXuBh2Q6TYoMThElbHtV2Z7gJb6BCBkE2dSZ6r5IpJ6FPxvXmTbGru4A+loT2atQmC901
	Y
X-Google-Smtp-Source: AGHT+IG8xPNdFOJIoUtw12SLGrSvmzguGqSK3Mxq5YaQ+5Fgy8jkSvl1y6T1OIkeG5JBrth6ri4jcA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr191175ioj.2.1712850004693;
        Thu, 11 Apr 2024 08:40:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 302/437] drivers/net/wireless/ath/wil6210: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:22 -0600
Message-ID: <20240411153126.16201-303-axboe@kernel.dk>
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
 drivers/net/wireless/ath/wil6210/debugfs.c | 235 ++++++++++-----------
 drivers/net/wireless/ath/wil6210/pmc.c     |  27 ++-
 drivers/net/wireless/ath/wil6210/pmc.h     |   2 +-
 3 files changed, 122 insertions(+), 142 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index c021ebcddee7..9cbbdd9b9b85 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -611,14 +611,14 @@ static int memread_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(memread);
 
-static ssize_t wil_read_file_ioblob(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t wil_read_file_ioblob(struct kiocb *iocb, struct iov_iter *to)
 {
 	enum { max_count = 4096 };
-	struct wil_blob_wrapper *wil_blob = file->private_data;
+	struct wil_blob_wrapper *wil_blob = iocb->ki_filp->private_data;
 	struct wil6210_priv *wil = wil_blob->wil;
-	loff_t aligned_pos, pos = *ppos;
+	loff_t aligned_pos, pos = iocb->ki_pos;
 	size_t available = wil_blob->blob.size;
+	size_t count = iov_iter_count(to);
 	void *buf;
 	size_t unaligned_bytes, aligned_count, ret;
 	int rc;
@@ -659,7 +659,7 @@ static ssize_t wil_read_file_ioblob(struct file *file, char __user *user_buf,
 	wil_memcpy_fromio_32(buf, (const void __iomem *)
 			     wil_blob->blob.data + aligned_pos, aligned_count);
 
-	ret = copy_to_user(user_buf, buf + unaligned_bytes, count);
+	ret = !copy_to_iter_full(buf + unaligned_bytes, count, to);
 
 	wil_mem_access_unlock(wil);
 	wil_pm_runtime_put(wil);
@@ -669,13 +669,12 @@ static ssize_t wil_read_file_ioblob(struct file *file, char __user *user_buf,
 		return -EFAULT;
 
 	count -= ret;
-	*ppos = pos + count;
-
+	iocb->ki_pos = pos + count;
 	return count;
 }
 
 static const struct file_operations fops_ioblob = {
-	.read =		wil_read_file_ioblob,
+	.read_iter =	wil_read_file_ioblob,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
@@ -690,15 +689,15 @@ struct dentry *wil_debugfs_create_ioblob(const char *name,
 }
 
 /*---write channel 1..4 to rxon for it, 0 to rxoff---*/
-static ssize_t wil_write_file_rxon(struct file *file, const char __user *buf,
-				   size_t len, loff_t *ppos)
+static ssize_t wil_write_file_rxon(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	int rc;
 	long channel;
 	bool on;
 
-	char *kbuf = memdup_user_nul(buf, len);
+	char *kbuf = iterdup_nul(from, len);
 
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
@@ -727,19 +726,18 @@ static ssize_t wil_write_file_rxon(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations fops_rxon = {
-	.write = wil_write_file_rxon,
+	.write_iter = wil_write_file_rxon,
 	.open  = simple_open,
 };
 
-static ssize_t wil_write_file_rbufcap(struct file *file,
-				      const char __user *buf,
-				      size_t count, loff_t *ppos)
+static ssize_t wil_write_file_rbufcap(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int val;
 	int rc;
 
-	rc = kstrtoint_from_user(buf, count, 0, &val);
+	rc = kstrtoint_from_iter(from, count, 0, &val);
 	if (rc) {
 		wil_err(wil, "Invalid argument\n");
 		return rc;
@@ -765,7 +763,7 @@ static ssize_t wil_write_file_rbufcap(struct file *file,
 }
 
 static const struct file_operations fops_rbufcap = {
-	.write = wil_write_file_rbufcap,
+	.write_iter = wil_write_file_rbufcap,
 	.open  = simple_open,
 };
 
@@ -774,10 +772,10 @@ static const struct file_operations fops_rbufcap = {
  * - "del_tx <ringid> <reason>" to trigger DELBA for Tx side
  * - "del_rx <CID> <TID> <reason>" to trigger DELBA for Rx side
  */
-static ssize_t wil_write_back(struct file *file, const char __user *buf,
-			      size_t len, loff_t *ppos)
+static ssize_t wil_write_back(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	int rc;
 	char *kbuf = kmalloc(len + 1, GFP_KERNEL);
 	char cmd[9];
@@ -786,7 +784,7 @@ static ssize_t wil_write_back(struct file *file, const char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	rc = simple_write_to_buffer(kbuf, len, ppos, buf, len);
+	rc = simple_copy_from_iter(kbuf, &iocb->ki_pos, len, from);
 	if (rc != len) {
 		kfree(kbuf);
 		return rc >= 0 ? -EIO : rc;
@@ -847,8 +845,7 @@ static ssize_t wil_write_back(struct file *file, const char __user *buf,
 	return len;
 }
 
-static ssize_t wil_read_back(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t wil_read_back(struct kiocb *iocb, struct iov_iter *to)
 {
 	static const char text[] = "block ack control, write:\n"
 	" - \"add <ringid> <agg_size> <timeout>\" to trigger ADDBA\n"
@@ -857,13 +854,12 @@ static ssize_t wil_read_back(struct file *file, char __user *user_buf,
 	" - \"del_rx <CID> <TID> <reason>\" to trigger DELBA for Rx side\n"
 	"If missing, <reason> set to \"STA_LEAVING\" (36)\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, text,
-				       sizeof(text));
+	return simple_copy_to_iter(text, &iocb->ki_pos, sizeof(text), to);
 }
 
 static const struct file_operations fops_back = {
-	.read = wil_read_back,
-	.write = wil_write_back,
+	.read_iter = wil_read_back,
+	.write_iter = wil_write_back,
 	.open  = simple_open,
 };
 
@@ -871,10 +867,10 @@ static const struct file_operations fops_back = {
  * - "alloc <num descriptors> <descriptor_size>" to allocate PMC
  * - "free" to release memory allocated for PMC
  */
-static ssize_t wil_write_pmccfg(struct file *file, const char __user *buf,
-				size_t len, loff_t *ppos)
+static ssize_t wil_write_pmccfg(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	int rc;
 	char *kbuf = kmalloc(len + 1, GFP_KERNEL);
 	char cmd[9];
@@ -883,7 +879,7 @@ static ssize_t wil_write_pmccfg(struct file *file, const char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	rc = simple_write_to_buffer(kbuf, len, ppos, buf, len);
+	rc = simple_copy_from_iter(kbuf, &iocb->ki_pos, len, from);
 	if (rc != len) {
 		kfree(kbuf);
 		return rc >= 0 ? -EIO : rc;
@@ -921,10 +917,9 @@ static ssize_t wil_write_pmccfg(struct file *file, const char __user *buf,
 	return len;
 }
 
-static ssize_t wil_read_pmccfg(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t wil_read_pmccfg(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
 	char text[256];
 	char help[] = "pmc control, write:\n"
 	" - \"alloc <num descriptors> <descriptor_size>\" to allocate pmc\n"
@@ -933,19 +928,18 @@ static ssize_t wil_read_pmccfg(struct file *file, char __user *user_buf,
 	snprintf(text, sizeof(text), "Last command status: %d\n\n%s",
 		 wil_pmc_last_cmd_status(wil), help);
 
-	return simple_read_from_buffer(user_buf, count, ppos, text,
-				       strlen(text) + 1);
+	return simple_copy_to_iter(text, &iocb->ki_pos, strlen(text) + 1, to);
 }
 
 static const struct file_operations fops_pmccfg = {
-	.read = wil_read_pmccfg,
-	.write = wil_write_pmccfg,
+	.read_iter = wil_read_pmccfg,
+	.write_iter = wil_write_pmccfg,
 	.open  = simple_open,
 };
 
 static const struct file_operations fops_pmcdata = {
 	.open		= simple_open,
-	.read		= wil_pmc_read,
+	.read_iter	= wil_pmc_read,
 	.llseek		= wil_pmc_llseek,
 };
 
@@ -957,16 +951,16 @@ static int wil_pmcring_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations fops_pmcring = {
 	.open		= wil_pmcring_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 };
 
 /*---tx_mgmt---*/
 /* Write mgmt frame to this file to send it */
-static ssize_t wil_write_file_txmgmt(struct file *file, const char __user *buf,
-				     size_t len, loff_t *ppos)
+static ssize_t wil_write_file_txmgmt(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct wiphy *wiphy = wil_to_wiphy(wil);
 	struct wireless_dev *wdev = wil->main_ndev->ieee80211_ptr;
 	struct cfg80211_mgmt_tx_params params;
@@ -978,7 +972,7 @@ static ssize_t wil_write_file_txmgmt(struct file *file, const char __user *buf,
 	if (!len)
 		return -EINVAL;
 
-	frame = memdup_user(buf, len);
+	frame = iterdup(from, len);
 	if (IS_ERR(frame))
 		return PTR_ERR(frame);
 
@@ -994,17 +988,17 @@ static ssize_t wil_write_file_txmgmt(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations fops_txmgmt = {
-	.write = wil_write_file_txmgmt,
+	.write_iter = wil_write_file_txmgmt,
 	.open  = simple_open,
 };
 
 /* Write WMI command (w/o mbox header) to this file to send it
  * WMI starts from wil6210_mbox_hdr_wmi header
  */
-static ssize_t wil_write_file_wmi(struct file *file, const char __user *buf,
-				  size_t len, loff_t *ppos)
+static ssize_t wil_write_file_wmi(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
 	struct wmi_cmd_hdr *wmi;
 	void *cmd;
@@ -1012,10 +1006,10 @@ static ssize_t wil_write_file_wmi(struct file *file, const char __user *buf,
 	u16 cmdid;
 	int rc1;
 
-	if (cmdlen < 0 || *ppos != 0)
+	if (cmdlen < 0 || iocb->ki_pos != 0)
 		return -EINVAL;
 
-	wmi = memdup_user(buf, len);
+	wmi = iterdup(from, len);
 	if (IS_ERR(wmi))
 		return PTR_ERR(wmi);
 
@@ -1031,7 +1025,7 @@ static ssize_t wil_write_file_wmi(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations fops_wmi = {
-	.write = wil_write_file_wmi,
+	.write_iter = wil_write_file_wmi,
 	.open  = simple_open,
 };
 
@@ -1484,10 +1478,9 @@ DEFINE_SHOW_ATTRIBUTE(info);
 /* mode = [manual|auto]
  * state = [idle|pending|running]
  */
-static ssize_t wil_read_file_recovery(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t wil_read_file_recovery(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
 	char buf[80];
 	int n;
 	static const char * const sstate[] = {"idle", "pending", "running"};
@@ -1498,17 +1491,16 @@ static ssize_t wil_read_file_recovery(struct file *file, char __user *user_buf,
 
 	n = min_t(int, n, sizeof(buf));
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, n);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, n, to);
 }
 
-static ssize_t wil_write_file_recovery(struct file *file,
-				       const char __user *buf_,
-				       size_t count, loff_t *ppos)
+static ssize_t wil_write_file_recovery(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
 	static const char run_command[] = "run";
 	char buf[sizeof(run_command) + 1]; /* to detect "runx" */
+	size_t count = iov_iter_count(from);
 	ssize_t rc;
 
 	if (wil->recovery_state != fw_recovery_pending) {
@@ -1516,8 +1508,8 @@ static ssize_t wil_write_file_recovery(struct file *file,
 		return -EINVAL;
 	}
 
-	if (*ppos != 0) {
-		wil_err(wil, "Offset [%d]\n", (int)*ppos);
+	if (iocb->ki_pos != 0) {
+		wil_err(wil, "Offset [%d]\n", (int)iocb->ki_pos);
 		return -EINVAL;
 	}
 
@@ -1526,7 +1518,7 @@ static ssize_t wil_write_file_recovery(struct file *file,
 		return -EINVAL;
 	}
 
-	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, buf_, count);
+	rc = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (rc < 0)
 		return rc;
 
@@ -1540,8 +1532,8 @@ static ssize_t wil_write_file_recovery(struct file *file,
 }
 
 static const struct file_operations fops_recovery = {
-	.read = wil_read_file_recovery,
-	.write = wil_write_file_recovery,
+	.read_iter = wil_read_file_recovery,
+	.write_iter = wil_write_file_recovery,
 	.open  = simple_open,
 };
 
@@ -1766,15 +1758,15 @@ static int wil_tx_latency_seq_open(struct inode *inode, struct file *file)
 			   inode->i_private);
 }
 
-static ssize_t wil_tx_latency_write(struct file *file, const char __user *buf,
-				    size_t len, loff_t *ppos)
+static ssize_t wil_tx_latency_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct wil6210_priv *wil = s->private;
 	int val, rc, i;
 	bool enable;
 
-	rc = kstrtoint_from_user(buf, len, 0, &val);
+	rc = kstrtoint_from_iter(from, len, 0, &val);
 	if (rc) {
 		wil_err(wil, "Invalid argument\n");
 		return rc;
@@ -1818,8 +1810,8 @@ static ssize_t wil_tx_latency_write(struct file *file, const char __user *buf,
 static const struct file_operations fops_tx_latency = {
 	.open		= wil_tx_latency_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
-	.write		= wil_tx_latency_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= wil_tx_latency_write,
 	.llseek		= seq_lseek,
 };
 
@@ -1930,10 +1922,10 @@ static int wil_link_stats_seq_open(struct inode *inode, struct file *file)
 	return single_open(file, wil_link_stats_debugfs_show, inode->i_private);
 }
 
-static ssize_t wil_link_stats_write(struct file *file, const char __user *buf,
-				    size_t len, loff_t *ppos)
+static ssize_t wil_link_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct wil6210_priv *wil = s->private;
 	int cid, interval, rc, i;
 	struct wil6210_vif *vif;
@@ -1942,7 +1934,7 @@ static ssize_t wil_link_stats_write(struct file *file, const char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	rc = simple_write_to_buffer(kbuf, len, ppos, buf, len);
+	rc = simple_copy_from_iter(kbuf, &iocb->ki_pos, len, from);
 	if (rc != len) {
 		kfree(kbuf);
 		return rc >= 0 ? -EIO : rc;
@@ -1982,8 +1974,8 @@ static ssize_t wil_link_stats_write(struct file *file, const char __user *buf,
 static const struct file_operations fops_link_stats = {
 	.open		= wil_link_stats_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
-	.write		= wil_link_stats_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= wil_link_stats_write,
 	.llseek		= seq_lseek,
 };
 
@@ -2009,16 +2001,16 @@ wil_link_stats_global_seq_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-wil_link_stats_global_write(struct file *file, const char __user *buf,
-			    size_t len, loff_t *ppos)
+wil_link_stats_global_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct wil6210_priv *wil = s->private;
 	int interval, rc;
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
 
 	/* specify snapshot interval in ms */
-	rc = kstrtoint_from_user(buf, len, 0, &interval);
+	rc = kstrtoint_from_iter(from, len, 0, &interval);
 	if (rc || interval < 0) {
 		wil_err(wil, "Invalid argument\n");
 		return -EINVAL;
@@ -2036,13 +2028,12 @@ wil_link_stats_global_write(struct file *file, const char __user *buf,
 static const struct file_operations fops_link_stats_global = {
 	.open		= wil_link_stats_global_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
-	.write		= wil_link_stats_global_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= wil_link_stats_global_write,
 	.llseek		= seq_lseek,
 };
 
-static ssize_t wil_read_file_led_cfg(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t wil_read_file_led_cfg(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[80];
 	int n;
@@ -2053,19 +2044,17 @@ static ssize_t wil_read_file_led_cfg(struct file *file, char __user *user_buf,
 
 	n = min_t(int, n, sizeof(buf));
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, n);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, n, to);
 }
 
-static ssize_t wil_write_file_led_cfg(struct file *file,
-				      const char __user *buf_,
-				      size_t count, loff_t *ppos)
+static ssize_t wil_write_file_led_cfg(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int val;
 	int rc;
 
-	rc = kstrtoint_from_user(buf_, count, 0, &val);
+	rc = kstrtoint_from_iter(from, count, 0, &val);
 	if (rc) {
 		wil_err(wil, "Invalid argument\n");
 		return rc;
@@ -2083,25 +2072,25 @@ static ssize_t wil_write_file_led_cfg(struct file *file,
 }
 
 static const struct file_operations fops_led_cfg = {
-	.read = wil_read_file_led_cfg,
-	.write = wil_write_file_led_cfg,
+	.read_iter = wil_read_file_led_cfg,
+	.write_iter = wil_write_file_led_cfg,
 	.open  = simple_open,
 };
 
 /* led_blink_time, write:
  * "<blink_on_slow> <blink_off_slow> <blink_on_med> <blink_off_med> <blink_on_fast> <blink_off_fast>
  */
-static ssize_t wil_write_led_blink_time(struct file *file,
-					const char __user *buf,
-					size_t len, loff_t *ppos)
+static ssize_t wil_write_led_blink_time(struct kiocb *iocb,
+					struct iov_iter *from)
 {
 	int rc;
+	size_t len = iov_iter_count(from);
 	char *kbuf = kmalloc(len + 1, GFP_KERNEL);
 
 	if (!kbuf)
 		return -ENOMEM;
 
-	rc = simple_write_to_buffer(kbuf, len, ppos, buf, len);
+	rc = simple_copy_from_iter(kbuf, &iocb->ki_pos, len, from);
 	if (rc != len) {
 		kfree(kbuf);
 		return rc >= 0 ? -EIO : rc;
@@ -2125,8 +2114,7 @@ static ssize_t wil_write_led_blink_time(struct file *file,
 	return len;
 }
 
-static ssize_t wil_read_led_blink_time(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t wil_read_led_blink_time(struct kiocb *iocb, struct iov_iter *to)
 {
 	static char text[400];
 
@@ -2143,13 +2131,12 @@ static ssize_t wil_read_led_blink_time(struct file *file, char __user *user_buf,
 		 led_blink_time[WIL_LED_TIME_FAST].on_ms,
 		 led_blink_time[WIL_LED_TIME_FAST].off_ms);
 
-	return simple_read_from_buffer(user_buf, count, ppos, text,
-				       sizeof(text));
+	return simple_copy_to_iter(text, &iocb->ki_pos, sizeof(text), to);
 }
 
 static const struct file_operations fops_led_blink_time = {
-	.read = wil_read_led_blink_time,
-	.write = wil_write_led_blink_time,
+	.read_iter = wil_read_led_blink_time,
+	.write_iter = wil_write_led_blink_time,
 	.open  = simple_open,
 };
 
@@ -2180,22 +2167,18 @@ static int fw_version_show(struct seq_file *s, void *data)
 DEFINE_SHOW_ATTRIBUTE(fw_version);
 
 /*---------suspend_stats---------*/
-static ssize_t wil_write_suspend_stats(struct file *file,
-				       const char __user *buf,
-				       size_t len, loff_t *ppos)
+static ssize_t wil_write_suspend_stats(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
 
 	memset(&wil->suspend_stats, 0, sizeof(wil->suspend_stats));
-
-	return len;
+	return iov_iter_count(from);
 }
 
-static ssize_t wil_read_suspend_stats(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t wil_read_suspend_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wil6210_priv *wil = file->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
 	char *text;
 	int n, ret, text_size = 500;
 
@@ -2226,7 +2209,7 @@ static ssize_t wil_read_suspend_stats(struct file *file,
 
 	n = min_t(int, n, text_size);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, text, n);
+	ret = simple_copy_to_iter(text, &iocb->ki_pos, n, to);
 
 	kfree(text);
 
@@ -2234,22 +2217,22 @@ static ssize_t wil_read_suspend_stats(struct file *file,
 }
 
 static const struct file_operations fops_suspend_stats = {
-	.read = wil_read_suspend_stats,
-	.write = wil_write_suspend_stats,
+	.read_iter = wil_read_suspend_stats,
+	.write_iter = wil_write_suspend_stats,
 	.open  = simple_open,
 };
 
 /*---------compressed_rx_status---------*/
-static ssize_t wil_compressed_rx_status_write(struct file *file,
-					      const char __user *buf,
-					      size_t len, loff_t *ppos)
+static ssize_t wil_compressed_rx_status_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct wil6210_priv *wil = s->private;
 	int compressed_rx_status;
 	int rc;
 
-	rc = kstrtoint_from_user(buf, len, 0, &compressed_rx_status);
+	rc = kstrtoint_from_iter(from, len, 0, &compressed_rx_status);
 	if (rc) {
 		wil_err(wil, "Invalid argument\n");
 		return rc;
@@ -2288,8 +2271,8 @@ wil_compressed_rx_status_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations fops_compressed_rx_status = {
 	.open  = wil_compressed_rx_status_seq_open,
 	.release = single_release,
-	.read = seq_read,
-	.write = wil_compressed_rx_status_write,
+	.read_iter = seq_read_iter,
+	.write_iter = wil_compressed_rx_status_write,
 	.llseek	= seq_lseek,
 };
 
diff --git a/drivers/net/wireless/ath/wil6210/pmc.c b/drivers/net/wireless/ath/wil6210/pmc.c
index a2f7b4c1da48..9bd4bcd5bbcd 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.c
+++ b/drivers/net/wireless/ath/wil6210/pmc.c
@@ -311,10 +311,10 @@ int wil_pmc_last_cmd_status(struct wil6210_priv *wil)
 /* Read from required position up to the end of current descriptor,
  * depends on descriptor size configured during alloc request.
  */
-ssize_t wil_pmc_read(struct file *filp, char __user *buf, size_t count,
-		     loff_t *f_pos)
+ssize_t wil_pmc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wil6210_priv *wil = filp->private_data;
+	struct wil6210_priv *wil = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct pmc_ctx *pmc = &wil->pmc;
 	size_t retval = 0;
 	unsigned long long idx;
@@ -334,33 +334,30 @@ ssize_t wil_pmc_read(struct file *filp, char __user *buf, size_t count,
 
 	wil_dbg_misc(wil,
 		     "pmc_read: size %u, pos %lld\n",
-		     (u32)count, *f_pos);
+		     (u32)count, iocb->ki_pos);
 
 	pmc->last_cmd_status = 0;
 
-	idx = *f_pos;
+	idx = iocb->ki_pos;
 	do_div(idx, pmc->descriptor_size);
-	offset = *f_pos - (idx * pmc->descriptor_size);
+	offset = iocb->ki_pos - (idx * pmc->descriptor_size);
 
-	if (*f_pos >= pmc_size) {
+	if (iocb->ki_pos >= pmc_size) {
 		wil_dbg_misc(wil,
 			     "pmc_read: reached end of pmc buf: %lld >= %u\n",
-			     *f_pos, (u32)pmc_size);
+			     iocb->ki_pos, (u32)pmc_size);
 		pmc->last_cmd_status = -ERANGE;
 		goto out;
 	}
 
 	wil_dbg_misc(wil,
 		     "pmc_read: read from pos %lld (descriptor %llu, offset %llu) %zu bytes\n",
-		     *f_pos, idx, offset, count);
+		     iocb->ki_pos, idx, offset, count);
 
 	/* if no errors, return the copied byte count */
-	retval = simple_read_from_buffer(buf,
-					 count,
-					 &offset,
-					 pmc->descriptors[idx].va,
-					 pmc->descriptor_size);
-	*f_pos += retval;
+	retval = simple_copy_to_iter(pmc->descriptors[idx].va, &iocb->ki_pos,
+					 pmc->descriptor_size, to);
+	iocb->ki_pos += retval;
 out:
 	mutex_unlock(&pmc->lock);
 
diff --git a/drivers/net/wireless/ath/wil6210/pmc.h b/drivers/net/wireless/ath/wil6210/pmc.h
index b3d79eb50a43..d5ea8e94ccc4 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.h
+++ b/drivers/net/wireless/ath/wil6210/pmc.h
@@ -10,6 +10,6 @@ void wil_pmc_alloc(struct wil6210_priv *wil,
 		   int num_descriptors, int descriptor_size);
 void wil_pmc_free(struct wil6210_priv *wil, int send_pmc_cmd);
 int wil_pmc_last_cmd_status(struct wil6210_priv *wil);
-ssize_t wil_pmc_read(struct file *, char __user *, size_t, loff_t *);
+ssize_t wil_pmc_read(struct kiocb *iocb, struct iov_iter *to);
 loff_t wil_pmc_llseek(struct file *filp, loff_t off, int whence);
 int wil_pmcring_read(struct seq_file *s, void *data);
-- 
2.43.0


