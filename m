Return-Path: <linux-kernel+bounces-140978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2108A19E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993E11C20ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF217CBC8;
	Thu, 11 Apr 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kv7FkJKC"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274341BC7B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849851; cv=none; b=J0fFOMnsDxi4yX8AnUbF6y74k7o8zD4NgINXDrF091mnbQGQoTVxGx1mDSyinc17D7Gt3uy5Wo2THjlUHhlDqGoIPio/y32LrQNQAERZpU0qSk8EFZq0HJPLu/BHip8rRlANivjRF4slitcUkJS5f7k0JwQMJAhTzm8nTSEkvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849851; c=relaxed/simple;
	bh=tV9Lv4pqB34L8dYU/gwh9Bsh+yGwTixQqfbRED942KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+ayLwU7JxLqZiMqjtkpt5oTeE86sR5Y4FT6RdGttdQPqaWqrTJH91u2E7EyW/+g7TpujQ2QGqQz9IkQAZdcJ+lEhBL2ncJiCQn1O+wu2g3/IRnTBVg8E03Mf/iD9zgHnuTTvxCMZFhaaqKn+MAAY6/0D9YgvGJhUHAUPmt1toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kv7FkJKC; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8974539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849849; x=1713454649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAF1bwapnqH/1s8SgdQui9NI3zwMPi3HaRH5YIg1/rA=;
        b=kv7FkJKCGDzhO4K94/84NGCcPs5F6w+4yeMwokt8faqoYpt70pMISsXAsWdA7CUqAa
         P6E4mEMM4GAjQTCqweoUiTMlaUXqxqDZDEKUkvvP3oDLqB5oph+7cUoiC6LHwWl98yYB
         znuOv/uDFZfstQPBmUnoJKW1gj0Lgg9oS0tWy/anECzbNSTTaDNcb/zxanPzdtxoEu/7
         aYDBkft99WfR+dVY4i/2+acvRrfzLmFHgi1LfeBfn+oC8tk8fHY+IDaKBtzdIrl379s9
         hy37kcg0+5B4XymgMtf+7irxd6JslJPmVMr3w0ygukZaFOASsVol1JNWD7D7v+dnqx3a
         bS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849849; x=1713454649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAF1bwapnqH/1s8SgdQui9NI3zwMPi3HaRH5YIg1/rA=;
        b=xSe1lYXZth9WGZLKiIkjcpsYk4lB3bI6rhQP41EWZ4s3j9KkB7VpYn+jVj9NzOxd7b
         jZCqDkmOZf/Fkzlfr2raxww2c2PkbseI+U+lJqkGmxLP2zTt/2X9+feHE8vfJMJExGfl
         Qh3vWNiHj2fcD3f4ZzAPF0iYauzU5WUIgngEVZ4FulfoE9F7EicCb1ieOG4CLuQOHGdL
         GwP21VpfdokY0nEaPdkU5Zqu8oLdfKwg9LRW+d8VT7JSdf+18p9nxKRjE4po3cV15d8p
         UBp2NbmFpS5f6zfCzp71jO8MJygakPfLTJDF5apKAmkYVNBFiEVi70IqbKgySYnKLnLe
         DXvA==
X-Gm-Message-State: AOJu0YyvZpiOes/iME0MRai4yiD6QCcX6AdRZ8YwAgIR5JQB/bGBzNj0
	x3a1vSvKco4LLPH9TG/llzcaXKEFJHANyUEVbh4/A/xBWwiH910mSrolnUO45mNABehmD+3fKQI
	c
X-Google-Smtp-Source: AGHT+IHubsdmPgrEJfXNJu5nk+o6Dc1LMsJh/xCIVrEi1kmpumXtaIlHwNhizATmCVsSKpUSZwiP2w==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr184111ioj.2.1712849848996;
        Thu, 11 Apr 2024 08:37:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 208/437] drivers/video: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:48 -0600
Message-ID: <20240411153126.16201-209-axboe@kernel.dk>
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
 drivers/video/fbdev/core/fb_chrdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 4ebd16b7e3b8..161f781912c3 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -42,6 +42,7 @@ static ssize_t fb_read(struct file *file, char __user *buf, size_t count, loff_t
 
 	return info->fbops->fb_read(info, buf, count, ppos);
 }
+FOPS_READ_ITER_HELPER(fb_read);
 
 static ssize_t fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
@@ -58,6 +59,7 @@ static ssize_t fb_write(struct file *file, const char __user *buf, size_t count,
 
 	return info->fbops->fb_write(info, buf, count, ppos);
 }
+FOPS_WRITE_ITER_HELPER(fb_write);
 
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
@@ -405,8 +407,8 @@ static unsigned long get_fb_unmapped_area(struct file *filp,
 
 static const struct file_operations fb_fops = {
 	.owner = THIS_MODULE,
-	.read = fb_read,
-	.write = fb_write,
+	.read_iter = fb_read_iter,
+	.write_iter = fb_write_iter,
 	.unlocked_ioctl = fb_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = fb_compat_ioctl,
-- 
2.43.0


