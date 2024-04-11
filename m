Return-Path: <linux-kernel+bounces-140772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7E8A18E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2519A1C21A78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E8145BFD;
	Thu, 11 Apr 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2nEmea6o"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CB446B2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849517; cv=none; b=NSzET1r+JksSbqvnvCXdNdcZuufnIMw/OnI+Gi+yyCalvG7F60xitQhqzZdtn4dmT7+ux3HLgY365zIhq5dPAdTXkPNqSua5zSRz8E+DQL5l8OUNfHsJnlxhksqVu4wWvHKwTHwpvV3By1pRJS9VygiwAffj6C9mY81xunc2j1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849517; c=relaxed/simple;
	bh=cIEXLdC2HWL+2599YuKJuBEQEfjnMr/riJhIib9YLes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzWRn33UYAiXctYg07D4OSYXw45CcTdS5r8pu4s799VI82wF1vBdvs+iBThI3IYD2FE+mXPhMPpNXF01i9FPZdVEZskd347H6t6ICVIQorcwyZktLOOlTS2g8SMoL/YRVHY1IyD9DqlFDmUTrKW+RTlk2CIlK52Lrv11sBozsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2nEmea6o; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9694839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849515; x=1713454315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqlXo04DZnbgap02/34Lt7vrJx13e1dXnLr969j/Z1o=;
        b=2nEmea6oGiavoLXMUeD5kx6HvQZiKSNjJbww/xcFL1vtr6p7/kC89VFMLiKEA7fz/5
         wmwRrzHMf/K0isptkzxozt/nYJnIb3xBRgwMhinkBjRbFKdwZ9gwDOIr8x3LNOzMPeQF
         Yt0qUGg3KAUF3wzvrfVTvExA86piaz0qjZcmddP1Z8xL4Jq0QSHVpiEwlDWyd5rNH7oA
         vaLhujD4/YVNIluXtJJfpt/CLTc1lfjt03lQnHxNyeIXdUcPCLwKZS+eliuaPEPZtYQp
         W/dN3cmyTKIh/FOCixtLiMEqkyAGLTdvX8Y0K9n88hBTHxGI+QNwohKBZ6wzXUykdnCh
         xsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849515; x=1713454315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqlXo04DZnbgap02/34Lt7vrJx13e1dXnLr969j/Z1o=;
        b=g7F6GBc2gbCfkLmelvLsOXw7DvhGFGDsLrLQIlC7K6f4PQwmGzk/hsl/9Bpy7jsCk/
         ai4VLnHX8Wq0WBaKwP+6uC0XzpzikRXamv10ZIKzO6zoIo4P4yLFCBlzdJ+OfvCbHMyn
         St5JN97RYhdVhrm7SVg2XaKoV8ZW4/8+JqokeaZvqt+yAYC7iWMgR5+WiHpiB5QZ5IzC
         X72HyZbOIQ/xaniff2kWS10UEDRaz2spTdTc63aVE5OzEybcEK+r8hD8kGqDpe+YD92d
         Vy8ogiZ0Hz146IhKcc0YwIMCarjvXz+b8m8New47uXLIiF0YmyUYoG9lupp+NuUNCrdQ
         MO0w==
X-Gm-Message-State: AOJu0YyZf3uTeViNurpA2abSsIzZuebjwvnqv2TOmDhNo3eryPlsG4EN
	UtP5lKMJD7dPzhFhXMRLekTMRI0TmLVP5Vd8bpC6e1DzFG6yFPj+dIG37DYuVv9eJYNgCE+RPV7
	f
X-Google-Smtp-Source: AGHT+IGRpLE3SAXNqdWcksFptHr0UWrot6a4oAAUBi5j/58C5txxrB905LGQwxBvfVZd086rVgi45Q==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr182167iop.1.1712849515062;
        Thu, 11 Apr 2024 08:31:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 015/437] char/nsc_gpio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:35 -0600
Message-ID: <20240411153126.16201-16-axboe@kernel.dk>
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
 drivers/char/nsc_gpio.c  | 22 ++++++++++++++++------
 include/linux/nsc_gpio.h |  8 ++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/char/nsc_gpio.c b/drivers/char/nsc_gpio.c
index da930c72bc74..0df6fb1232cd 100644
--- a/drivers/char/nsc_gpio.c
+++ b/drivers/char/nsc_gpio.c
@@ -39,8 +39,8 @@ void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index)
 		 amp->gpio_get(index), amp->gpio_current(index));
 }
 
-ssize_t nsc_gpio_write(struct file *file, const char __user *data,
-		       size_t len, loff_t *ppos)
+static ssize_t nsc_gpio_write(struct file *file, const char __user *data,
+			      size_t len, loff_t *ppos)
 {
 	unsigned m = iminor(file_inode(file));
 	struct nsc_gpio_ops *amp = file->private_data;
@@ -102,8 +102,8 @@ ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 	return len;
 }
 
-ssize_t nsc_gpio_read(struct file *file, char __user * buf,
-		      size_t len, loff_t * ppos)
+static ssize_t nsc_gpio_read(struct file *file, char __user * buf, size_t len,
+			     loff_t * ppos)
 {
 	unsigned m = iminor(file_inode(file));
 	int value;
@@ -116,9 +116,19 @@ ssize_t nsc_gpio_read(struct file *file, char __user * buf,
 	return 1;
 }
 
+ssize_t nsc_gpio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, nsc_gpio_read);
+}
+EXPORT_SYMBOL(nsc_gpio_read_iter);
+
+ssize_t nsc_gpio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, nsc_gpio_write);
+}
+EXPORT_SYMBOL(nsc_gpio_write_iter);
+
 /* common file-ops routines for both scx200_gpio and pc87360_gpio */
-EXPORT_SYMBOL(nsc_gpio_write);
-EXPORT_SYMBOL(nsc_gpio_read);
 EXPORT_SYMBOL(nsc_gpio_dump);
 
 static int __init nsc_gpio_init(void)
diff --git a/include/linux/nsc_gpio.h b/include/linux/nsc_gpio.h
index d7a04a6e3783..a97111b2e85d 100644
--- a/include/linux/nsc_gpio.h
+++ b/include/linux/nsc_gpio.h
@@ -31,11 +31,7 @@ struct nsc_gpio_ops {
 	struct device*	dev;	/* for dev_dbg() support, set in init  */
 };
 
-extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
-			      size_t len, loff_t *ppos);
-
-extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
-			     size_t len, loff_t *ppos);
-
+ssize_t nsc_gpio_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t nsc_gpio_read_iter(struct kiocb *iocb, struct iov_iter *to);
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
 
-- 
2.43.0


