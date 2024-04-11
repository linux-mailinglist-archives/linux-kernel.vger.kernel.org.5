Return-Path: <linux-kernel+bounces-140872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884AD8A194C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D27A28464E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3581509A7;
	Thu, 11 Apr 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EvQk/zCC"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687914F9DE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849687; cv=none; b=EvpHxa40K+zSaQdi8wOXuuwKnM+G93I0hp5Viv6TaTpNd2Ueeu2J0yQR3RQK3VZPdmwLNUiVP6Myz2TDR90s7YyPjVntNBn5329YYDJ9aL8+JxAKAeHcRDtaULVW+aidF+yT9q33eWsHy2UGaL7AwNZKPxoJdTq/3GedtBsZADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849687; c=relaxed/simple;
	bh=mafGK7ArZ4CgMWc69oJvrXEr6bmtaktMynKhOq0IW24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9yINSwWMDJOb2bW/W8ncHfogKVQXtQqSAoLJrm1abgvDBKgPeeyq9QMScRR6GY9ibKEg4OOCG/qyczE/DW5ph/WtakJC0cTj74psHGZsuulx4E8+gkFMDUb+HqKexISNWXStwhfhKTEivVW4ad9qIS0TCZYnkKgOkqbLxdhh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EvQk/zCC; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a224d7414so179835ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849684; x=1713454484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjanmKNhtskVVrpiFYIE9220cXjVfSIWUIi+sU6GL7c=;
        b=EvQk/zCCEV586vQKUrJQw3pCN9BvzOYOwNBG7Na2fKeBMV/S3d2YYemMJE/zj0ystL
         BG0pwTRw8TBg/4rw1Mt6h5tdn/jeD+NNdPW9PDodm/rPvY2eBck6oNYyykaHPoEE114n
         npp0LMTkGQwXH30QtybmHIJH2dzudDaGG8pvWRnLca3FrewsR5B7pwzjsWFlUWfhIHDR
         Vx4a3TKoqECt22RzmduHtDRB53nr8RKcew6uT1XZ0Xfo2RTfz2iJqB/SY/uiXKSTPcWL
         GkCJ6fSoSsH36eYC+TKdQ+ENNY9szrNK/lqBPhPhn239O/ujZJW2ywOCi3DQ8hWS2wzR
         Mj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849684; x=1713454484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjanmKNhtskVVrpiFYIE9220cXjVfSIWUIi+sU6GL7c=;
        b=v59iOGJzCJzifyaqKRD0WmF9MK92BuWvjaRgUhaFIcnOTEKhVtSxINOp/nRJ8TphLk
         haiNK5sro9zfM/16ciBL2HD9wnqIvC/FYQO3+beJeIdFVBxohAZn14Mwf1TbN/gW2y56
         ySO7GZBun9KmvhD2OOU5d+u0Bvggu/EVAoccodcisluzTZvMJn2Pi3ToEbgdJ6oSw1dy
         I/peEvxUf7mDaPtc9r4k0P0ERkP4WAP67+Up705LvLkudAPTcfdyWdlgfIeXPOKFSWPO
         tO9vOcb0EaTlBGIbhk3G5jfcfNPWQ7qt7cXt27/P1tqhPAOozmvmT+xijMF04vJpFTmy
         kepA==
X-Gm-Message-State: AOJu0YzRcYcfA7zqZ8R9OcSHEugb8FtcAVo589EgdnSAmoggo1Q7SvFm
	b5vzxiDHZDs64eYYsTlbQJujuyrdGDIlOOEbYVIqTyqMF1FMwedQ0J7/Ps5ldbpCkfTl5PuyopS
	U
X-Google-Smtp-Source: AGHT+IFXWdGqIAW+oXfRgAYntKkHRsP+78puzHM3i9xxc0np3X7A8nuVOEUjNMoU9TubyKaosDyE9A==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr182071iob.1.1712849684534;
        Thu, 11 Apr 2024 08:34:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 109/437] crypto: cpp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:09 -0600
Message-ID: <20240411153126.16201-110-axboe@kernel.dk>
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
 drivers/crypto/ccp/ccp-debugfs.c | 51 ++++++++++++++------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-debugfs.c b/drivers/crypto/ccp/ccp-debugfs.c
index a1055554b47a..34bf31386994 100644
--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -39,10 +39,9 @@
 #define	RI_NLSB_SHIFT	19
 #define	RI_NLSB(r)	(((r) * RI_LSB_ENTRIES) >> RI_NLSB_SHIFT)
 
-static ssize_t ccp5_debugfs_info_read(struct file *filp, char __user *ubuf,
-				      size_t count, loff_t *offp)
+static ssize_t ccp5_debugfs_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ccp_device *ccp = filp->private_data;
+	struct ccp_device *ccp = iocb->ki_filp->private_data;
 	unsigned int oboff = 0;
 	unsigned int regval;
 	ssize_t ret;
@@ -85,7 +84,7 @@ static ssize_t ccp5_debugfs_info_read(struct file *filp, char __user *ubuf,
 	oboff += OSCNPRINTF("LSB Entries: %d\n",
 		   (regval & RI_LSB_ENTRIES) >> RI_NLSB_SHIFT);
 
-	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	ret = simple_copy_to_iter(obuf, &iocb->ki_pos, oboff, to);
 	kfree(obuf);
 
 	return ret;
@@ -94,10 +93,9 @@ static ssize_t ccp5_debugfs_info_read(struct file *filp, char __user *ubuf,
 /* Return a formatted buffer containing the current
  * statistics across all queues for a CCP.
  */
-static ssize_t ccp5_debugfs_stats_read(struct file *filp, char __user *ubuf,
-				       size_t count, loff_t *offp)
+static ssize_t ccp5_debugfs_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ccp_device *ccp = filp->private_data;
+	struct ccp_device *ccp = iocb->ki_filp->private_data;
 	unsigned long total_xts_aes_ops = 0;
 	unsigned long total_3des_ops = 0;
 	unsigned long total_aes_ops = 0;
@@ -147,7 +145,7 @@ static ssize_t ccp5_debugfs_stats_read(struct file *filp, char __user *ubuf,
 	oboff += OSCNPRINTF("                     ECC: %ld\n",
 			    total_ecc_ops);
 
-	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	ret = simple_copy_to_iter(obuf, &iocb->ki_pos, oboff, to);
 	kfree(obuf);
 
 	return ret;
@@ -171,27 +169,25 @@ static void ccp5_debugfs_reset_queue_stats(struct ccp_cmd_queue *cmd_q)
  * should be used to reset the queue counters across
  * that device.
  */
-static ssize_t ccp5_debugfs_stats_write(struct file *filp,
-					const char __user *ubuf,
-					size_t count, loff_t *offp)
+static ssize_t ccp5_debugfs_stats_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct ccp_device *ccp = filp->private_data;
+	struct ccp_device *ccp = iocb->ki_filp->private_data;
 	int i;
 
 	for (i = 0; i < ccp->cmd_q_count; i++)
 		ccp5_debugfs_reset_queue_stats(&ccp->cmd_q[i]);
 	ccp->total_interrupts = 0L;
 
-	return count;
+	return iov_iter_count(from);
 }
 
 /* Return a formatted buffer containing the current information
  * for that queue
  */
-static ssize_t ccp5_debugfs_queue_read(struct file *filp, char __user *ubuf,
-				       size_t count, loff_t *offp)
+static ssize_t ccp5_debugfs_queue_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ccp_cmd_queue *cmd_q = filp->private_data;
+	struct ccp_cmd_queue *cmd_q = iocb->ki_filp->private_data;
 	unsigned int oboff = 0;
 	unsigned int regval;
 	ssize_t ret;
@@ -233,7 +229,7 @@ static ssize_t ccp5_debugfs_queue_read(struct file *filp, char __user *ubuf,
 		oboff += OSCNPRINTF(" COMPLETION");
 	oboff += OSCNPRINTF("\n");
 
-	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	ret = simple_copy_to_iter(obuf, &iocb->ki_pos, oboff, to);
 	kfree(obuf);
 
 	return ret;
@@ -242,36 +238,33 @@ static ssize_t ccp5_debugfs_queue_read(struct file *filp, char __user *ubuf,
 /* A value was written to the stats variable for a
  * queue. Reset the queue counters to this value.
  */
-static ssize_t ccp5_debugfs_queue_write(struct file *filp,
-					const char __user *ubuf,
-					size_t count, loff_t *offp)
+static ssize_t ccp5_debugfs_queue_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct ccp_cmd_queue *cmd_q = filp->private_data;
+	struct ccp_cmd_queue *cmd_q = iocb->ki_filp->private_data;
 
 	ccp5_debugfs_reset_queue_stats(cmd_q);
-
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations ccp_debugfs_info_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ccp5_debugfs_info_read,
-	.write = NULL,
+	.read_iter = ccp5_debugfs_info_read,
 };
 
 static const struct file_operations ccp_debugfs_queue_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ccp5_debugfs_queue_read,
-	.write = ccp5_debugfs_queue_write,
+	.read_iter = ccp5_debugfs_queue_read,
+	.write_iter = ccp5_debugfs_queue_write,
 };
 
 static const struct file_operations ccp_debugfs_stats_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ccp5_debugfs_stats_read,
-	.write = ccp5_debugfs_stats_write,
+	.read_iter = ccp5_debugfs_stats_read,
+	.write_iter = ccp5_debugfs_stats_write,
 };
 
 static struct dentry *ccp_debugfs_dir;
-- 
2.43.0


