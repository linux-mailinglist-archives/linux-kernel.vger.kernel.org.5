Return-Path: <linux-kernel+bounces-140906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548418A1987
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1203B1F22B85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BEE15FA68;
	Thu, 11 Apr 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B8CtB1tx"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA615EFCD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849742; cv=none; b=I+zvuvEeNsTBheihnFCDZ1u9PHaiwsqjoR7qgp6n6JxM3AheOTRk6jLKVc0H3AkVh6Vq2yi/M0c9k6SQNVkvntCTK7MFC1OSoxShcrrpYv/TxnMqV1RWqGClmoMA/X9jCHklECNujNokvgy0apuaHMsL2WyMiYU9NgDP6wjG11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849742; c=relaxed/simple;
	bh=AP+nBrbRMwcyEgUSs3UjI9M0KSF/Nm6cAbt94qY8s0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kThR2p1EqY5OpdCl0hdti9duXGkXR1IPh+8NMQF0Q5PltrGIOgKy0c7OOB+6JOoBSiSa9zoF0kz2w87pE+C0+c/MkkVO1TjmjSA3HakwlKaunqMj1rMMqDJJt/A+NpYP9LSRsCbKfn5vi1Vx7q8bBmgCJwmnFgrF7kzvMJ1p1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B8CtB1tx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170505039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849739; x=1713454539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQCujrZigLy3u3kxVy6Esjv8r5Vg/g2Yr8TaOCRRNCU=;
        b=B8CtB1txgBEwHIJojvEqbEwCT5xsQX9A/xHRMatBA2Oh4UMfzKSjqHgoX01X2sZOFo
         SaJhGahLktphHxuzwKnnh4E7HEuJVThxgnEVRQzkXRYWsNplLKm2tl+lMqhKM81iPnom
         UD3bvFD2yieeCtxZ5sEh1L/136cP5RWSJuMbiNjyk9OFJ9nEaUSgk4hb9UQlYChf4ANQ
         5wYqmtjb7a3pfwfTpLvm1iAyDxmNkHZwJYAo3oUxD/kkfI969xnVaFUM1HphX1cSQ7F8
         pZjHy5+e/yG6nRDnfmkRpzAA2P4OunH9fYjdaOBSnB4ObJanFDKfQYvVCHuKt/bgEVFB
         W8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849739; x=1713454539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQCujrZigLy3u3kxVy6Esjv8r5Vg/g2Yr8TaOCRRNCU=;
        b=NfaVeNSr/v0ch1XC7dFWqDsxDGSgJn0nFVyJlNijQTP8IWVA1XaYeQvgNiiNOgKJTz
         6OxIer9VQRrIvRVe/05tYLa/zcpybpa5igzQSNrJEwSQ65ExHK/4GLAowbY+UEKzcGS4
         SUjw94NmQCJoB1qlaY1ejGUPLXyKNA7HdwUcq39LkpEEw6WZ8lS7vpE3lk/LAv3G4mwa
         JmaDjz4D9CzYy5VN61JA5awQe0JgGn/72jxzEg5Les07p74lFWDt5T5gUVTYKgEaJ6ee
         MzhVemQ1HaZFFBzv52Dri0FyIz+8lC8xZlApOMC6GbVVVWfk1EbTqdy3MRCSimKRDRib
         VYig==
X-Gm-Message-State: AOJu0YyDV7Hi3ZiD7Kc93TSJbY24BbWj69QEUpQDyMjXAh53XaaUph6W
	phniozWpfyuU+EC7o1Kbk5C3nSkQzsv17sHpsrL90KJHvBvbnLE8vmV/zFaEf+i0z36Hf3IWqNm
	N
X-Google-Smtp-Source: AGHT+IGuUEEAgdVg4ZgPf1OSrIZOeErBwaV5OeH/P7UvLSNpC+lMq5RxgInP8EhFFmWogQbDiFpfeQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr14001ioc.1.1712849739297;
        Thu, 11 Apr 2024 08:35:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 143/437] drm: mali: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:43 -0600
Message-ID: <20240411153126.16201-144-axboe@kernel.dk>
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
 drivers/gpu/drm/arm/malidp_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 6682131d2910..cc0490e3ae4c 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -522,10 +522,9 @@ static int malidp_debugfs_open(struct inode *inode, struct file *file)
 	return single_open(file, malidp_show_stats, inode->i_private);
 }
 
-static ssize_t malidp_debugfs_write(struct file *file, const char __user *ubuf,
-				    size_t len, loff_t *offp)
+static ssize_t malidp_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_device *drm = m->private;
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	unsigned long irqflags;
@@ -534,14 +533,14 @@ static ssize_t malidp_debugfs_write(struct file *file, const char __user *ubuf,
 	malidp_error_stats_init(&malidp->de_errors);
 	malidp_error_stats_init(&malidp->se_errors);
 	spin_unlock_irqrestore(&malidp->errors_lock, irqflags);
-	return len;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations malidp_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = malidp_debugfs_open,
-	.read = seq_read,
-	.write = malidp_debugfs_write,
+	.read_iter = seq_read_iter,
+	.write_iter = malidp_debugfs_write,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


