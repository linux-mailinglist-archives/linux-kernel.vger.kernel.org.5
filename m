Return-Path: <linux-kernel+bounces-140929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD68A19AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94451282DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B61C2332;
	Thu, 11 Apr 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a5zrAbpa"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C201C2318
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849776; cv=none; b=m7JFOfmp5OZYUbqjIlLHQWUD3BCP4YkraIxsotr5xDYbGPr6wCgg2VAklfiizbzgUX+ljalHmX2MSeC5ieLbEMJOIfSuRukWRp5jAQ+0NtvJyAhuIVFkZDixDQi4kkXvQJtKETJPEHRyN0PXCr/lgfLsxX+Aae+/+gJUoK3ne0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849776; c=relaxed/simple;
	bh=BC4YfS4UJrprHPjQHWKbdcG+YbYW3uvVEK7Blfupi04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAiA/jr9Y9EJd1Px0rSkmagSo3FEMY6KN2xoc6eHAwNavqdFL9Abs6KQM6ThAJaXu6r9+kCJ88UXVLdwboyyufMkAIWXjJHqtmtkxrx5DIn5QWAcAeLJpxZSBx/QO12blal4t963EXtgQMqq5ro9SPzIeNE8R/cCX3hlIP1Czps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a5zrAbpa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170515439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849773; x=1713454573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5wAewb/wpyAp3Mbq5eWFLi8QS3luSEPM1me2UTw1/4=;
        b=a5zrAbpa6pproFD25RLCPLfBe3PbytRtPNEfNvEwnd2qAV3IZP5KsW/WF6htVjlCxF
         PGLgf6LnOdU7EDOIqlqGRaHX466QnIBK6dfEpZ4lPoC8ef7MhzlaoUIvfZYNxdCVrYVE
         brneLEFGwuZQK298mqnose55OK9eEct83NFLOawbYWpJZ1v/jtGgIu9AOMvNIAIfSHp1
         kwJ3aMZFuGJkcRyKbSoJuLq86NggQMF/Q9fhKrz9rGS6hr2Og7l9jerDFZ1KwHYUQlDk
         BJ2G1hwMucOTjiw1N4dmQcjpN29wyLBsPnMYZP6uX/YmYwi5xhx6HWOXAvzhUnQygxDs
         G4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849773; x=1713454573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5wAewb/wpyAp3Mbq5eWFLi8QS3luSEPM1me2UTw1/4=;
        b=Ge6hhkSAKo95yUi5AD/zOHrU2Xa8GOomwyFPpcMyUGQ5mSEEAzeyeqNxrds+rBuitq
         jCYaXb3DE/u/2GSsWKY0v6VnQ6Uqm/5mmwc0/td+wVZbr10uCLSf3aI6UE4CY66CMw+v
         BNUNTZezhbTKwuZ0dAzF2P28LybH46JZTdCHW4tAJeB59la/c9mEFOa2tv16bf5G+swU
         fkws1kQkBl+D4zpILXGLwO9/ScEtvFuxaiBSnoiQCEeGukmy7vak0kE4wVsi+rlMqWnI
         VXdOJDlazwINTP/1fapZP1GWZLUghPQkYdUbD0/byL9xTC7RSBNB53qzirw3OTJNyySY
         HliQ==
X-Gm-Message-State: AOJu0Yx6ew4c3b0o46yhLe4g6i97OoCVR0AHPYDM/Zh9lL4XnYl6c9nM
	SxtsmzQ2RE8Y+gWkJmHxBrLhDExR4dcnQF6w43jjFlqUJYjS1yTfTFQqjBiwzTJDEnexov0RF8j
	c
X-Google-Smtp-Source: AGHT+IEwuj0l1bxi7wMi61akCWwp48mGax/V0582PCSWzfaTaOKdP6hFm8qscE9vaCwt61Ydi9qKEg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr15731ioc.1.1712849773401;
        Thu, 11 Apr 2024 08:36:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 161/437] usb: fotg210-hcd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:01 -0600
Message-ID: <20240411153126.16201-162-axboe@kernel.dk>
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
 drivers/usb/fotg210/fotg210-hcd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 8c5aaf860635..6a7334164ca7 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -283,27 +283,27 @@ static int debug_periodic_open(struct inode *, struct file *);
 static int debug_registers_open(struct inode *, struct file *);
 static int debug_async_open(struct inode *, struct file *);
 
-static ssize_t debug_output(struct file*, char __user*, size_t, loff_t*);
+static ssize_t debug_output(struct kiocb *, struct iov_iter *);
 static int debug_close(struct inode *, struct file *);
 
 static const struct file_operations debug_async_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_async_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
 static const struct file_operations debug_periodic_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_periodic_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
 static const struct file_operations debug_registers_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_registers_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
@@ -773,10 +773,9 @@ static int fill_buffer(struct debug_buffer *buf)
 	return ret;
 }
 
-static ssize_t debug_output(struct file *file, char __user *user_buf,
-		size_t len, loff_t *offset)
+static ssize_t debug_output(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debug_buffer *buf = file->private_data;
+	struct debug_buffer *buf = iocb->ki_filp->private_data;
 	int ret = 0;
 
 	mutex_lock(&buf->mutex);
@@ -789,9 +788,7 @@ static ssize_t debug_output(struct file *file, char __user *user_buf,
 	}
 	mutex_unlock(&buf->mutex);
 
-	ret = simple_read_from_buffer(user_buf, len, offset,
-			buf->output_buf, buf->count);
-
+	ret = simple_copy_to_iter(buf->output_buf, &iocb->ki_pos, buf->count, to);
 out:
 	return ret;
 
-- 
2.43.0


