Return-Path: <linux-kernel+bounces-140989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFE8A19F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAF51F280EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885D1BF6E3;
	Thu, 11 Apr 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BYrp01L1"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2C1BF6C3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849869; cv=none; b=KZVIp9xSQUxKNCSesvhelE8g+B2tZfSiSyGnFgGioGAOlyqagFz3Wp0BrGAseNm6GWyfwh77hPKZL+WhyqlfTo2XdkZQHZKkNZISg4JbOMfuhfnlEb+F5OEn3ipKS7GsDttv3GPo2qloZAbE3My0p86AwJ5q6h7E7rI6JtIIY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849869; c=relaxed/simple;
	bh=v6xQDF2DsXo/J4VZREBtbRAjZJR/I2UhXb1KxbqlFZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NatEKjHsHblIYteVj6zXdLTcciwDRg4v92Mhsi819+kokM1ekBW95svkLcNEcVIsUIww82hA8KVtpnyn+9dMC/vYsFaytrj+2CNNZUHl08ec70vik8zf8XB4mbTpHj285Pd5R/8u/KJPmn29Z8wr2Vm1Z6DJCuvdGOOz4R+kuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BYrp01L1; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58111939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849867; x=1713454667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnR78Ozn/BF2UUUk9wDuww3MAd2hdQuOFs4UAEs8Yu8=;
        b=BYrp01L1EDwJE6vVRaoIa1D13BZTxgcQ7SwEq38qZyw0J6fYn7tDKTy8a91vSgJkhG
         ydPIXVPXEDlMVXRfayC7Rs6nJ+S5V6hbcPAlCAQNPVYzk3kvfihN5qFlg89k+qVrfM75
         8UZuLcMtPnRJUOZvrhtFfLIaq9cg+CdzDAzw8s6gl/Rb0ZI5aDTklSAGVZn+0s2ZTUU1
         UUqR9lEMD62dyxNZ+o/AyEYm+GW72e/eNfrPhdlXyCOHJO59YrVmDGafprOxEcjpeVj+
         VIiB7OmwdRxDepQKam50erPGDLeyY0G2M44MF9IXZMzxfLkjTcJZ8c4LBxQ4iLyp+UCz
         TdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849867; x=1713454667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnR78Ozn/BF2UUUk9wDuww3MAd2hdQuOFs4UAEs8Yu8=;
        b=H04yhy1UsFsY0lIXyb5cz10SwoNmbtw4S/Jt4O5rxtDQm+bAfX7QdOZwqwxvMFbpM8
         m/LcVDSzK/uu9zzppzHy67QuMpc0h5OLH2U2gAMSDiJ8rtRAeBKKlDOx1QbzJ2XiYCgV
         EjJAUX9hbRMsfgcxJqh9Nh7xMRYg7Y4g2EzDhQFDIlLTByFaTQxwvIjUtLaYhNaXy2Ak
         C5ykRp61d9rdBSBn29FKlGR42sgpooZgEeg2vL/PiMr/gDNUYnDl7wUXM7mhjDXUJ6x4
         NoQImvRm6Dihw4HxcuMgPLNYVIgScf2F8cz07sIJpa1Jbec0e2i8MI2I795F64fSBdxm
         bM4A==
X-Gm-Message-State: AOJu0YyyKAm2rFDywlXPw53gfCfkf8DTB1LLO4Yz5EYbQ0X/Dn/M7SOE
	EUcxfMOrpdSB3nxkK7uaijL/JV/wv1juyJvss2OA9BlzE663DNAdqB1E0mwk+Q6dwKcRkGbC4TF
	K
X-Google-Smtp-Source: AGHT+IGxGQHUg8krv6TpOiSEesmyHCH2hqEIftKoGAMVG2w33GqrNfgRNVnf9Z+omnIWbR4892NS6w==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr189835iov.2.1712849867353;
        Thu, 11 Apr 2024 08:37:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 219/437] misc: ibmvmc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:59 -0600
Message-ID: <20240411153126.16201-220-axboe@kernel.dk>
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
 drivers/misc/ibmvmc.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index e5f935b5249d..545739f1f342 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -900,21 +900,20 @@ static int ibmvmc_close(struct inode *inode, struct file *file)
  *	0 - Success
  *	Non-zero - Failure
  */
-static ssize_t ibmvmc_read(struct file *file, char *buf, size_t nbytes,
-			   loff_t *ppos)
+static ssize_t ibmvmc_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct ibmvmc_file_session *session;
 	struct ibmvmc_hmc *hmc;
 	struct crq_server_adapter *adapter;
 	struct ibmvmc_buffer *buffer;
+	size_t nbytes = iov_iter_count(to);
 	ssize_t n;
 	ssize_t retval = 0;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
 
-	pr_debug("ibmvmc: read: file = 0x%lx, buf = 0x%lx, nbytes = 0x%lx\n",
-		 (unsigned long)file, (unsigned long)buf,
-		 (unsigned long)nbytes);
+	pr_debug("ibmvmc: read: file = 0x%lx, nbytes = 0x%lx\n",
+		 (unsigned long)iocb->ki_filp, (unsigned long)nbytes);
 
 	if (nbytes == 0)
 		return 0;
@@ -925,7 +924,7 @@ static ssize_t ibmvmc_read(struct file *file, char *buf, size_t nbytes,
 		return -EINVAL;
 	}
 
-	session = file->private_data;
+	session = iocb->ki_filp->private_data;
 	if (!session) {
 		pr_warn("ibmvmc: read: no session\n");
 		return -EIO;
@@ -957,7 +956,7 @@ static ssize_t ibmvmc_read(struct file *file, char *buf, size_t nbytes,
 			retval = -EBADFD;
 			goto out;
 		}
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
 		}
@@ -977,7 +976,7 @@ static ssize_t ibmvmc_read(struct file *file, char *buf, size_t nbytes,
 	spin_unlock_irqrestore(&hmc->lock, flags);
 
 	nbytes = min_t(size_t, nbytes, buffer->msg_len);
-	n = copy_to_user((void *)buf, buffer->real_addr_local, nbytes);
+	n = !copy_to_iter_full(buffer->real_addr_local, nbytes, to);
 	dev_dbg(adapter->dev, "read: copy to user nbytes = 0x%lx.\n", nbytes);
 	ibmvmc_free_hmc_buffer(hmc, buffer);
 	retval = nbytes;
@@ -1027,27 +1026,25 @@ static unsigned int ibmvmc_poll(struct file *file, poll_table *wait)
 /**
  * ibmvmc_write - Write
  *
- * @file:	file struct
- * @buffer:	Character buffer
- * @count:	Count field
- * @ppos:	Offset
+ * @iocb:	metadata for IO
+ * @from:	Character buffer
  *
  * Return:
  *	0 - Success
  *	Non-zero - Failure
  */
-static ssize_t ibmvmc_write(struct file *file, const char *buffer,
-			    size_t count, loff_t *ppos)
+static ssize_t ibmvmc_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode;
 	struct ibmvmc_buffer *vmc_buffer;
 	struct ibmvmc_file_session *session;
 	struct crq_server_adapter *adapter;
+	size_t count = iov_iter_count(from);
 	struct ibmvmc_hmc *hmc;
 	unsigned char *buf;
 	unsigned long flags;
 	size_t bytes;
-	const char *p = buffer;
 	size_t c = count;
 	int ret = 0;
 
@@ -1109,19 +1106,17 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 	}
 	buf = vmc_buffer->real_addr_local;
 
+	ret = 0;
 	while (c > 0) {
 		bytes = min_t(size_t, c, vmc_buffer->size);
 
-		bytes -= copy_from_user(buf, p, bytes);
-		if (!bytes) {
+		if (!copy_from_iter_full(buf, bytes, from)) {
 			ret = -EFAULT;
 			goto out;
 		}
 		c -= bytes;
-		p += bytes;
+		ret += bytes;
 	}
-	if (p == buffer)
-		goto out;
 
 	inode = file_inode(file);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
@@ -1131,7 +1126,6 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 		(unsigned long)file, (unsigned long)count);
 
 	ibmvmc_send_msg(adapter, vmc_buffer, hmc, count);
-	ret = p - buffer;
  out:
 	spin_unlock_irqrestore(&hmc->lock, flags);
 	return (ssize_t)(ret);
@@ -1387,8 +1381,8 @@ static long ibmvmc_ioctl(struct file *file,
 
 static const struct file_operations ibmvmc_fops = {
 	.owner		= THIS_MODULE,
-	.read		= ibmvmc_read,
-	.write		= ibmvmc_write,
+	.read_iter	= ibmvmc_read,
+	.write_iter	= ibmvmc_write,
 	.poll		= ibmvmc_poll,
 	.unlocked_ioctl	= ibmvmc_ioctl,
 	.open           = ibmvmc_open,
-- 
2.43.0


