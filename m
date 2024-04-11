Return-Path: <linux-kernel+bounces-141192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903978A1AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15341C20BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A4B1FB096;
	Thu, 11 Apr 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iv406Xxm"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5441FB07A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850186; cv=none; b=oYccL5mTRsF8E5wMTeF4tWpjN9peaZxYbA0D/C69ivp7Cv1k/Gij6Dy1dA+gIf2zpljbRQGSanU0scwpIco0sve/79wtPqxu/ho/HONT2aitA9Soez70wh3UXeGG6Ho+11ERt2eroA9kAGlEMeDRudwg90oZbi3DDiROgqthppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850186; c=relaxed/simple;
	bh=rgdku1fyEUHuP9463v9X5w2ujARSYJXqOJoAkoBa+GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcq3VTnjGXCtQSvTpnyrjB9Be8I6IySqxZTXdOeYVA8sGy34TVOY5zk1hSPiPLC99I756EoFRmZmJMiK5Al9lzrDNYCxRVI3aiv56B+n5DRb2L0iBmGczRfNnZ4O3E3BCsDS20NT2GxL+qNs6ZF4CitYDRGL3/69jRFaUPCONQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iv406Xxm; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69696139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850183; x=1713454983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXEPzStCGxOtFI+Px06wFKYHmvuScnXZMMcQHWtcEOs=;
        b=iv406XxmJ4BTrJPH0f0IfUq2EZk6fZeIdPUxLgW1XUkOefQMQnW5I0Ymup+2KOUEue
         u+ht4p7VuPWojS8Wcz7TOH783Jb62FrBZKcwApzJ3VnzrcGGyA3OXTXngBx+Ma68MdYE
         TfywrPTiWcwJpzc8xVE43QYB1ZsWVxKHM60xXbuYihKzwrObOUu7yO+udgokUGfG3Ui/
         ogLccs0qrklPdJPAQHRGOblAFLiJhaY+CUALpywxSr9TWWWypBjdMbkCOzJcRiHVvzRm
         Xql1NhgT2sFw+JPKy5aj9+B/Ve1sc8+YA3E82h6TJp77vkorPt+yNgP54lstoLG+X43R
         nyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850183; x=1713454983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXEPzStCGxOtFI+Px06wFKYHmvuScnXZMMcQHWtcEOs=;
        b=kXM8DXH7xt7mh+rTFpJUFAOTbkHSzMX3LednZdychBLHAkeAzU4sK0+HOB/rtpd3lW
         rku630NKws8BhW3XlI9LaYYDDY1YmIorTp8xlkUU8zsY89lPks07EjlkjKuTyGmfHuUo
         mBnU88DSm8d1Oy6XcYpJZwWzB8I1o2Nnaj+QnD2ONr2BEFqCUQG1QrqHh0AWar6zpYwn
         GuTnHEFmJn1yWhAw54XYdkskt14cmN4oXABy/PvZClBC1rSzsWaNtprfrlWfI5JcbfnN
         yz9ott98yWaocPEkBIEnfvVyrg0u2eiZ2xxR88O3r9IdgTuso1uu2WXQEYmyrEQZHk5l
         yqvg==
X-Gm-Message-State: AOJu0Yzr15O2i+XamPJzLUtQ71lmtPfYOq6AV8HqnAlvI76vgIVyUOZ+
	qfHAFpwWv6RvAw+OXH6zyWTcjDI55+yDyW43/DAg1i5DaBymkwv5ZNoXcI1jfIUj76rZlQd1cex
	o
X-Google-Smtp-Source: AGHT+IEhAJ5vvcu4YDJwnQUeJDnUqe6a47wrGzyb/beVPjMFJFn01V9r9EJAle0ZjfTeVYTo5o2+ow==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr210850iop.1.1712850183587;
        Thu, 11 Apr 2024 08:43:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 408/437] infiniband/ocrdma: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:08 -0600
Message-ID: <20240411153126.16201-409-axboe@kernel.dk>
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
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 26 ++++++++++-----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index 5f831e3bdbad..687174d32365 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -631,20 +631,19 @@ static void ocrdma_update_stats(struct ocrdma_dev *dev)
 	}
 }
 
-static ssize_t ocrdma_dbgfs_ops_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t ocrdma_dbgfs_ops_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char tmp_str[32];
 	long reset;
 	int status;
-	struct ocrdma_stats *pstats = filp->private_data;
+	struct ocrdma_stats *pstats = iocb->ki_filp->private_data;
 	struct ocrdma_dev *dev = pstats->dev;
+	size_t count = iov_iter_count(from);
 
-	if (*ppos != 0 || count == 0 || count > sizeof(tmp_str))
+	if (iocb->ki_pos != 0 || count == 0 || count > sizeof(tmp_str))
 		goto err;
 
-	if (copy_from_user(tmp_str, buffer, count))
+	if (!copy_from_iter_full(tmp_str, count, from))
 		goto err;
 
 	tmp_str[count-1] = '\0';
@@ -683,16 +682,16 @@ void ocrdma_pma_counters(struct ocrdma_dev *dev, struct ib_mad *out_mad)
 	pma_cnt->port_rcv_packets  = cpu_to_be32(ocrdma_sysfs_rcv_pkts(dev));
 }
 
-static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
-					size_t usr_buf_len, loff_t *ppos)
+static ssize_t ocrdma_dbgfs_ops_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ocrdma_stats *pstats = filp->private_data;
+	struct ocrdma_stats *pstats = iocb->ki_filp->private_data;
+	size_t usr_buf_len = iov_iter_count(to);
 	struct ocrdma_dev *dev = pstats->dev;
 	ssize_t status = 0;
 	char *data = NULL;
 
 	/* No partial reads */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	mutex_lock(&dev->stats_lock);
@@ -741,8 +740,7 @@ static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
 		goto exit;
 	}
 
-	status = simple_read_from_buffer(buffer, usr_buf_len, ppos, data,
-					 strlen(data));
+	status = simple_copy_to_iter(data, &iocb->ki_pos, strlen(data), to);
 exit:
 	mutex_unlock(&dev->stats_lock);
 	return status;
@@ -751,8 +749,8 @@ static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
 static const struct file_operations ocrdma_dbg_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ocrdma_dbgfs_ops_read,
-	.write = ocrdma_dbgfs_ops_write,
+	.read_iter = ocrdma_dbgfs_ops_read,
+	.write_iter = ocrdma_dbgfs_ops_write,
 };
 
 void ocrdma_add_port_stats(struct ocrdma_dev *dev)
-- 
2.43.0


