Return-Path: <linux-kernel+bounces-141122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB758A1A96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2519B1F22BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A8166C9C;
	Thu, 11 Apr 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uPY4Filq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72F166C68
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850072; cv=none; b=Wsvp5ZkaoIFM/P5Kwx/EyJaRgA/LzWFTXO+n+7dKTUDPEcfpPZOQHeRZclBZ2io/6abS6ypRZyngJm22jQTl605enkWKQccuWuaiDpNG+HlXN4ZEab1I+pHaAM+MWFK06u9rvnaPk9jVEIk85Y+jcQoesLpnffMA1aAS/2pDtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850072; c=relaxed/simple;
	bh=JHvAsWj1kuv+uwDxm01zwuKvRakyFwSuoZ8iTR25k1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNL9gTunSTWDHhlm++If8ec2qa4NPxC6z/7o89ouflH1YLs8pSbCLiuPT9I1PL4dwl23t51rf8YEMqP2JJkKZCvwQhg2fD7Fa5Rbn5qEOCIE3St0Nuxu06yrKV/7w9SdUfcEbiVbVB9hUg+aXK4lNdktjfXR01beQR5wanwPx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uPY4Filq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180642739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850069; x=1713454869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+LQ1n3KaSliKBjpt9vFI0T94kaPILgp3qXZvqc94zI=;
        b=uPY4Filq0vRRI+p/PnqXnksv0mw9b/bFHiARHsFJEDckJUnxb3IQlN24l+WblxmgJz
         Ps6cIZ8vYiijKVLFy/pEJFb0StGFltRDdirkQYFMFwKEJWt/Vwre0FuoS5YBgjT9U6hn
         qg6gRmmJOFdB+rqQzp/2hnZIthmn3zwPDxoJdrEn0zuOtkrQnMpJn+PML7GvQueXNfND
         18neVlsaGer3FCRc0T3/+ji4P7+55dTD9Kmdntq4n98slEabadkfeE1v5f2bz2lAQp+W
         FcGCHfnN9raM34mPPxQAjdcPtKDqgjXdxNoNALD0eazKjZ39s923KkTVK8PcYc1mGv58
         Z5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850069; x=1713454869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+LQ1n3KaSliKBjpt9vFI0T94kaPILgp3qXZvqc94zI=;
        b=RshgqhdQEPGy9t+NU8iy0z98bq6glHEsjM1jLfBKQfltaQ9YVKMF7vizGgIAmZ97pw
         e3RxIsFdXZ7jIJW3T3dgf5gnkWmtfKay6o+mpx5JO4cuW5z6yDtWbhXh/VvhE3HoLJ85
         79+Z1kX3SuV0jRECiOqU9pSl1XF6wjTEw+Fyaq1DAn1cr+rVMKw3L5GOmLW1KRz+M+88
         hKBVEqtGvCY1glzG6eLMa2W9yJQWk7aLIKIYpCLEz2OTjwv5qfBm4PC0Z8jpzG7OguXD
         wkhPpB5mv2c1nyKQyRzn/J3L1di1mYOCw9jyuKtEt1NWFVzCGof6Mr/ge0ZDSFR7X2Dp
         sVaA==
X-Gm-Message-State: AOJu0Ywrx2E/SsLSk6R6GZP2rock4zuEQ5hsytBJ8KoiCKIEmMADB4cD
	BhTW31LfFOukLPBDCXqp98xIueTIZh5X5UfMXTYa0YlFeA6jzT/r6Ti4O+lc02dhAe23sO+Fg8V
	K
X-Google-Smtp-Source: AGHT+IH3DRY2sigutqUeYs33PL8SCtIyoiezy8C3BIkLkG3Tf0fKIpVQX3Wn8zIG36I/xOlhWt+9PA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr199869iob.0.1712850069592;
        Thu, 11 Apr 2024 08:41:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 343/437] s390: hmcdrv: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:03 -0600
Message-ID: <20240411153126.16201-344-axboe@kernel.dk>
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
 drivers/s390/char/hmcdrv_dev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 8d50c894711f..df793008a390 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -56,10 +56,8 @@ struct hmcdrv_dev_node {
 static int hmcdrv_dev_open(struct inode *inode, struct file *fp);
 static int hmcdrv_dev_release(struct inode *inode, struct file *fp);
 static loff_t hmcdrv_dev_seek(struct file *fp, loff_t pos, int whence);
-static ssize_t hmcdrv_dev_read(struct file *fp, char __user *ubuf,
-			       size_t len, loff_t *pos);
-static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
-				size_t len, loff_t *pos);
+static ssize_t hmcdrv_dev_read_iter(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t hmcdrv_dev_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static ssize_t hmcdrv_dev_transfer(char __kernel *cmd, loff_t offset,
 				   char __user *buf, size_t len);
 
@@ -70,8 +68,8 @@ static const struct file_operations hmcdrv_dev_fops = {
 	.open = hmcdrv_dev_open,
 	.llseek = hmcdrv_dev_seek,
 	.release = hmcdrv_dev_release,
-	.read = hmcdrv_dev_read,
-	.write = hmcdrv_dev_write,
+	.read_iter = hmcdrv_dev_read_iter,
+	.write_iter = hmcdrv_dev_write_iter,
 };
 
 static struct hmcdrv_dev_node hmcdrv_dev; /* HMC device struct (static) */
@@ -239,6 +237,7 @@ static ssize_t hmcdrv_dev_read(struct file *fp, char __user *ubuf,
 
 	return retlen;
 }
+FOPS_READ_ITER_HELPER(hmcdrv_dev_read);
 
 /*
  * write()
@@ -276,6 +275,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 
 	return retlen;
 }
+FOPS_WRITE_ITER_HELPER(hmcdrv_dev_write);
 
 /**
  * hmcdrv_dev_init() - creates a HMC drive CD/DVD device
-- 
2.43.0


