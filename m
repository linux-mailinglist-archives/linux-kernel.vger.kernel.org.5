Return-Path: <linux-kernel+bounces-141000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756B8A1A51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6667FB2F059
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619F1C2FCD;
	Thu, 11 Apr 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="beUsZ5f4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485F1C1B1C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849883; cv=none; b=TLqYQVOeb6EYdYPYGGdHRt22Bz1H6wwmN6hoHrPI6PXG6ZY5z1hoiT/U4GhmMhzut0wqjalGFRVIHIQdsm+aaOA5NE2yQ433hg+whx/OmGx9qCREkwkSICaw6LwlsIhHwVLvN/wxu06NqLGiCNQGX8jeklv8zWZ8Q6j86dVUJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849883; c=relaxed/simple;
	bh=mYl5XN2Q12i1GShXzHmxni38VagWFUolvBXdQvo6NdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpwctQohZYb+RpmvZ0Up2IcwdFC/e+S04Sgwp0n8L7H/3m7ddprjHj/N6YTW3xqRsQ0XOAZdNI0TWSQy+WzQ2EHKoEhTlv3Bly3IAgG/aVbseO038+0gBVqhQuXKp5jq8Q/A/jQ9foMhPFpBHmSeaLgKg2W1KLF2gauCv16GVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=beUsZ5f4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69612939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849881; x=1713454681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jOOzNnHmJV0Fu/jL3HQdbehM157IGkalVPtNhVpP6k=;
        b=beUsZ5f4HaSYmGZ6byTqSwdqTYN0IUyu8fMQljxaWJZh3vWTXkG/eDgbXuc+qxrvXr
         ptjtbYzoJedcCTDCJhcb1dvasuucErASKFeKf+o9ljj4OfiZvRbRYKmtoufJpArEFE/D
         VujwwgEqmpCg2qWqfzGlZRQizR8th3JMprfBsL5G9HeQXbrrA4Qkb5s0U9Gw3nxYEHso
         kMR/UtSSXtrbcgteB1g7/N90LrXKUEkpCLW5hqL8r28fDzpWeMX8sqB61nQ8YiTGbckj
         lKjy7Hw18Od+Q+KKqYLtS41YUn6l0bJ+vIOU0If/0HpWyfIxj/Gsq0U73IkDjur6ZT5X
         aBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849881; x=1713454681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jOOzNnHmJV0Fu/jL3HQdbehM157IGkalVPtNhVpP6k=;
        b=Wk0sEJZrwK42vlWZ3zQ7mrjfP+N1UjajQ1zzV+bD6rxoV/1vtv/cwrX8rG9nAGeIEd
         gu9I/AR8928OV0vPA6zvD5gm+kJn9G02F+HCApcvn8F1P9gjJ1NbGGNIGKNO8qGAJmpq
         XP84qlNn86v+tMXFqDmaKLfgt9HHG1tLjXygumk8nTcbk62M7c+eAhuuSaV+2up9WVwo
         kEwiem3OOKWchqjKw+4llyVNAWrE0ltErU8f63uLCc4xdp+l6kkH9zIHQ22LTlDdZmTT
         XxHemkjGBjmN+9HJo4QO/9bhzLAuCMzCC9Zi4UV9S/0293EBxF3tJRuyBRjz6lcoaij9
         SLAw==
X-Gm-Message-State: AOJu0YytpejSodRi0ZBjEvBUy+UoDe7gVnXeP9muZ/Y9kufxdDcrC5wV
	2CWZUQ77Ac1fU6y1jffnd/MMmeFdEAWdHvnhwO8eSkrOBlnzlIG2kdbWhLf6AajORkXzTOW9qC5
	F
X-Google-Smtp-Source: AGHT+IGlR1p56kEdU8dyVq4RHJtB5RWJIu3PnVaVc0rf4t53SGUVPOHPkpHnRNc/JWTmDhdDwwkOYw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr197747iop.1.1712849881443;
        Thu, 11 Apr 2024 08:38:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 228/437] drivers/spi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:08 -0600
Message-ID: <20240411153126.16201-229-axboe@kernel.dk>
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
 drivers/spi/spidev.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 95fb5f1c91c1..1b5e13492b4d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -154,27 +154,28 @@ spidev_sync_read(struct spidev_data *spidev, size_t len)
 
 /* Read-only message with current device setup */
 static ssize_t
-spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
+spidev_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct spidev_data	*spidev;
 	ssize_t			status;
+	size_t			count = iov_iter_count(to);
 
 	/* chipselect only toggles at start or end of operation */
 	if (count > bufsiz)
 		return -EMSGSIZE;
 
-	spidev = filp->private_data;
+	spidev = iocb->ki_filp->private_data;
 
 	mutex_lock(&spidev->buf_lock);
 	status = spidev_sync_read(spidev, count);
 	if (status > 0) {
-		unsigned long	missing;
+		unsigned long	copied;
 
-		missing = copy_to_user(buf, spidev->rx_buffer, status);
-		if (missing == status)
+		copied = copy_to_iter(spidev->rx_buffer, status, to);
+		if (!copied)
 			status = -EFAULT;
 		else
-			status = status - missing;
+			status = status - copied;
 	}
 	mutex_unlock(&spidev->buf_lock);
 
@@ -183,25 +184,25 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 
 /* Write-only message with current device setup */
 static ssize_t
-spidev_write(struct file *filp, const char __user *buf,
-		size_t count, loff_t *f_pos)
+spidev_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct spidev_data	*spidev;
 	ssize_t			status;
-	unsigned long		missing;
+	unsigned long		copied;
+	size_t			count = iov_iter_count(from);
 
 	/* chipselect only toggles at start or end of operation */
 	if (count > bufsiz)
 		return -EMSGSIZE;
 
-	spidev = filp->private_data;
+	spidev = iocb->ki_filp->private_data;
 
 	mutex_lock(&spidev->buf_lock);
-	missing = copy_from_user(spidev->tx_buffer, buf, count);
-	if (missing == 0)
-		status = spidev_sync_write(spidev, count);
-	else
+	copied = copy_from_iter(spidev->tx_buffer, count, from);
+	if (copied == 0)
 		status = -EFAULT;
+	else
+		status = spidev_sync_write(spidev, count);
 	mutex_unlock(&spidev->buf_lock);
 
 	return status;
@@ -679,8 +680,8 @@ static const struct file_operations spidev_fops = {
 	 * gets more complete API coverage.  It'll simplify things
 	 * too, except for the locking.
 	 */
-	.write =	spidev_write,
-	.read =		spidev_read,
+	.write_iter =	spidev_write,
+	.read_iter =	spidev_read,
 	.unlocked_ioctl = spidev_ioctl,
 	.compat_ioctl = spidev_compat_ioctl,
 	.open =		spidev_open,
-- 
2.43.0


