Return-Path: <linux-kernel+bounces-140964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451FC8A19D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF751C20C48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683F61B904D;
	Thu, 11 Apr 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WuPgbcCE"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BA1B9020
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849828; cv=none; b=pPe7LRtsc55oO8Xo9VMqsQZIiGlI/Bf62nQKv7f12zwtCFQX8+kN9xg5eJaOkpPdsqbrRASHh0AGUCFU3X+8aCy7rpx213v96B6kPFs8qTIHAHavuInAsA9Yuv42nyq8yvyOd/erKMHC1auPm4HVEvGlOO3JuE91PHJW5ifqaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849828; c=relaxed/simple;
	bh=qK5szLXdyVuqPLYIC1jVGZl/1s22xhDB7QahhdBSXLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4efzltEbXOQWVflofZeUb7oBG1rtd4HxofGE2e82CiEjvxy0APaO2qIxH6s+TpZJnRCefd9vWDc48vIHkTbHEYfPWw8ItGwzAJLt9U9V+ARGApg+tTNWEexOIYbgfpdmXbIn6I1ttC9BlEOSSyHkFGKzn/esLVpPfUj/3nJO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WuPgbcCE; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69588939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849826; x=1713454626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+fHintiUDqQC7r/OcrhdH2zxMAxaiRiiT+9Jp+x2sQ=;
        b=WuPgbcCEp8zJ8B24Fbkb7kEFui+PM5jbkvScSTQBpgilEQg68TYbCX68mtgvAkm1Q4
         z+J+x0Fz9gQqBJcw0Kpl5EnICgAMej4urHCeVz4601VykE/AJW4LIyXbNGdV/oPVxbVN
         OxmYsHloK4GzfJHexCisPs8MrUAPkipgYjzMq9Rs7Dd+kY5MdQnO5hR3qkOdvYQV7xLL
         COxgTyqbqzSTTsLQN6fpiZ7sSjq/5KpHlk9mcRmhYwCKaT86mVwlH6zeVngWoKnsqY4n
         +JIzVKTc2sCY2Nl0ITTQ3C/RQ3oTx3xjapfQWg112kR6srvAQtVSMjiC2ilZo/CRfCxM
         wKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849826; x=1713454626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+fHintiUDqQC7r/OcrhdH2zxMAxaiRiiT+9Jp+x2sQ=;
        b=xN2GIa48Ih9sEA/W/nJEx9jUUKdAR4oAL8qmswhwVMkx40asYoShGk2jw1XERto2mm
         Ve1IvThon76CJJ+CEZ0Cyp8Jh1Vt//wsckP2pqslpE2HqoJ+CfG9IQLGnNsHu+/I7/cv
         P5h2Z8esOQCyUxDTTXLXvqgscAD8AZzflts+gmLpqH3tDs56zezZFMWNdlH5xyQpz+Jl
         7VW/f1AKzzVZ56fL4dr4+d5jGTgd1r0wPLUY+C1soVLgZJcpTIutmY4sg891LefAjHe0
         ut1nmuzjd+68mJZBJLU8LVAjw80uwt86kPDRxciHUyaSpDeaJMhAx0Ue6BQpphLfyics
         UoSA==
X-Gm-Message-State: AOJu0YzCw1vC9LPbPa9WECMtUYdWJH1vp9fuCbaSuXhR1mT0Qc4JdUiF
	lapr3JImMqZNXItF7NUfKkgqJBXRRDG2mGhdd1nunsSV/e1PlGZi6fFQqoOJQ3Mz3D0h5buAJmF
	D
X-Google-Smtp-Source: AGHT+IFPkJC1IAApA/kP2dHjjXj45ocELcpHHDLtq9Hsd4goxU+g0QQ7gHo5x3U63KY/db+7Np5yWg==
X-Received: by 2002:a92:2c10:0:b0:36a:2d25:3d82 with SMTP id t16-20020a922c10000000b0036a2d253d82mr6164390ile.0.1712849826253;
        Thu, 11 Apr 2024 08:37:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 195/437] scsi: snic: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:35 -0600
Message-ID: <20240411153126.16201-196-axboe@kernel.dk>
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
 drivers/scsi/snic/snic_debugfs.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 9dd975b36b5b..0e81688746f1 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -69,18 +69,15 @@ snic_reset_stats_open(struct inode *inode, struct file *filp)
  * This function returns the amount of data that was read.
  */
 static ssize_t
-snic_reset_stats_read(struct file *filp,
-		      char __user *ubuf,
-		      size_t cnt,
-		      loff_t *ppos)
+snic_reset_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snic *snic = (struct snic *) filp->private_data;
+	struct snic *snic = iocb->ki_filp->private_data;
 	char buf[64];
 	int len;
 
 	len = sprintf(buf, "%u\n", snic->reset_stats);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /*
@@ -98,15 +95,13 @@ snic_reset_stats_read(struct file *filp,
  * This function returns the amount of data that was written.
  */
 static ssize_t
-snic_reset_stats_write(struct file *filp,
-		       const char __user *ubuf,
-		       size_t cnt,
-		       loff_t *ppos)
+snic_reset_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct snic *snic = (struct snic *) filp->private_data;
+	struct snic *snic = iocb->ki_filp->private_data;
 	struct snic_stats *stats = &snic->s_stats;
 	u64 *io_stats_p = (u64 *) &stats->io;
 	u64 *fw_stats_p = (u64 *) &stats->fw;
+	size_t cnt = iov_iter_count(from);
 	char buf[64];
 	unsigned long val;
 	int ret;
@@ -114,7 +109,7 @@ snic_reset_stats_write(struct file *filp,
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = '\0';
@@ -143,7 +138,7 @@ snic_reset_stats_write(struct file *filp,
 			sizeof(struct snic_fw_stats) - sizeof(u64));
 	}
 
-	(*ppos)++;
+	iocb->ki_pos++;
 
 	SNIC_HOST_INFO(snic->shost, "Reset Op: Driver statistics.\n");
 
@@ -325,8 +320,8 @@ DEFINE_SHOW_ATTRIBUTE(snic_stats);
 static const struct file_operations snic_reset_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = snic_reset_stats_open,
-	.read = snic_reset_stats_read,
-	.write = snic_reset_stats_write,
+	.read_iter = snic_reset_stats_read,
+	.write_iter = snic_reset_stats_write,
 	.release = snic_reset_stats_release,
 };
 
-- 
2.43.0


