Return-Path: <linux-kernel+bounces-140911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D958A1990
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90558287B24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95D17A930;
	Thu, 11 Apr 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QFPxHM6g"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11B16D309
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849748; cv=none; b=sHoHFX2a29HFWZblUJ8pURI5qQ2zdQDbMuh1sZfqZeUVoPXbudUzKizX2gz+BxyWqZiQQMwaSei8KDOsam7/Zhc/SvNY6cbW32UrP5Krb0vr4QuLfMHjSPlVdJ9KT7wh7l86sBuZq/a1BtB0Bc7b2D0Lw7B1pOsNutkXfpXkqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849748; c=relaxed/simple;
	bh=zb2jkDfRkAn1FmRm/Gyqk5S762CbYJcznomHCC6q4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN+cMgQeAgTTU6NzViM6WBAkTxbPJFNfXNleynF8kZLH9zMzf+c4NTF09lfjbVez8XGeKq7X9a5fUoFoa2K65T0v1d6QoGI2P28jGVrYCloRRr6yxQb2/gsrfdaC9d7shNkECTTE6MxEF2zVGtxLuO2VFrqrzrznaV/3XQPwDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QFPxHM6g; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a224d7414so182055ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849746; x=1713454546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls4P/6cxJrz7tnV3+FrtvdKvswGRFOABzSegkWKjQQM=;
        b=QFPxHM6g2AcQHxOGkXCmoZTZqUOM86Hs6EUm5NyLjW58VdnwbLuofMBvv6K+EZ3QCZ
         OLYTPB/bTY2gSNHzHsJ9EBTqrm8KJTyyskk8Qvixb2HErpmVDrBjSxYmKBUnLa8GWMOw
         wd9GEyTFDSIHay+6X0JLOfOIwU86LY9q2CY1rDbnm+5qCgCx/LpgnHmeliVWWs237dXw
         MunqwzPEC94NoVbH2TTx4cstpm53zZmStUBWrsWmlK2YxjTAqMrbBP2zTkLJ7N3EL+Xb
         mvWW9wmquCPOVcLzTPjd0tDV2z27qFtbH1XjCyLG+hpGNh2WGlwvP8u0h9DfbVZS8b3Y
         SEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849746; x=1713454546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls4P/6cxJrz7tnV3+FrtvdKvswGRFOABzSegkWKjQQM=;
        b=NvpUQKFhpAkO0GuFwV6y3ChyyOru4c4dNc1MUToF5n9sDvBD/vZrVpBppEVg/fjmEs
         LNl+4YQHgH326tVnfl8M++mHgbUh2iLwODOIVxIemctkWR6ScXZxOoKkcdKd10lzYZxb
         Xv8rNWc3l+WKFVFMxK/YvQN2No5Q6zQXjnx6sQFMa0djODA3Ykdes806iYtaRNL1TNI1
         +Qqhi/qCeODC0pTBzegG34N7VsmK22VtzivRCl9oo1FPBGtwuYOV3KU3Td8hDsiS6BEk
         RUx8T9+4rKAYBRL89Xx/otdrFtjPtpMIFwfXuTo0w412w1aBsqFOUgkI+bFMZGZ21r0O
         5rLg==
X-Gm-Message-State: AOJu0YyBS3figYF13IkGjGecs0j/BYfv2Od3FJji2XhnuAhgpzxOZk+h
	yAfZ5p6USELLJ1iK6D6iOE/ODx/ySzBOeACK43Le/b4M+Fxua2jX1WIYVldKstY0oX6wNFuUl/O
	d
X-Google-Smtp-Source: AGHT+IEjryjIztBnr0QgzMlIXGNvGKpK8yol92mr1u10S2EZZH0kGCTTIBEhR+gkT5ypCgXZjDBc8Q==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr185515iob.1.1712849745810;
        Thu, 11 Apr 2024 08:35:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 146/437] drm/loongson: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:46 -0600
Message-ID: <20240411153126.16201-147-axboe@kernel.dk>
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
 drivers/gpu/drm/loongson/lsdc_crtc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
index 827acab580fa..fde7c8d6cc3d 100644
--- a/drivers/gpu/drm/loongson/lsdc_crtc.c
+++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
@@ -628,20 +628,18 @@ static int lsdc_crtc_man_op_open(struct inode *inode, struct file *file)
 	return single_open(file, lsdc_crtc_man_op_show, crtc);
 }
 
-static ssize_t lsdc_crtc_man_op_write(struct file *file,
-				      const char __user *ubuf,
-				      size_t len,
-				      loff_t *offp)
+static ssize_t lsdc_crtc_man_op_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct lsdc_crtc *lcrtc = m->private;
 	const struct lsdc_crtc_hw_ops *ops = lcrtc->hw_ops;
+	size_t len = iov_iter_count(from);
 	char buf[16];
 
 	if (len > sizeof(buf) - 1)
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -663,10 +661,10 @@ static ssize_t lsdc_crtc_man_op_write(struct file *file,
 static const struct file_operations lsdc_crtc_man_op_fops = {
 	.owner = THIS_MODULE,
 	.open = lsdc_crtc_man_op_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = lsdc_crtc_man_op_write,
+	.write_iter = lsdc_crtc_man_op_write,
 };
 
 static int lsdc_crtc_late_register(struct drm_crtc *crtc)
-- 
2.43.0


