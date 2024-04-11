Return-Path: <linux-kernel+bounces-141209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FA18A1AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7671E1C2364D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E3201998;
	Thu, 11 Apr 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ir7F30PZ"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DC1FFC59
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850213; cv=none; b=AEnowk7uleTdhEy8u4Iu4+/dGWWpBDxW02aa4PoKG/I1yczN2S8eQaIu0vFyAp+i4CVw3ZQkFXgjX/Ir9rUPGUtThSshmv2S+YEMjaPpsxoE3Y+Ld4uj14bVYV8l9tQp4A+GAkBkOM5ivhhIurX9CgpkTII4H6oT9p/Nfd69WRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850213; c=relaxed/simple;
	bh=+r+U7yOE2//Dm1l89AQ/p8TdVgErUnJeolAc2VuDal0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MME6w5/lnilLykrOPYyeJ1XIDjphyNIVKP+XVjefbRi5hbx4me5/rkwFy7XdUulymECE3ZNam3XrCKCGR9+3yI80K75ygt+bB3jv+9JQQk0AOyW7sBq0+O6SYsSV7J5irX1UljzPhLnwJERM7GpCSc5svL5+qWMd04m5EfXTpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ir7F30PZ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a34b68277so125125ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850210; x=1713455010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHTPq1Y3fOvLbs3hQO1iRO6uGsna0yiG5KXgQ6la0bw=;
        b=ir7F30PZJYfKhZJb0A3R0g1gvJcH1GgREnnU+6ft2DcyRlN4KDP47LC2ybuDrmpChv
         I3O9/0/26S3+LflPyeG2UsJaVud5vjlynW7t4EVYqpnBBYSGFLwdDVtCn+6ma3k8FAsR
         YVJqhwAb5TkEqnoyNRrydJ6oqHf7S7mWNECGLUDDqIzhK8i7Bb0Eq/A+Wn0q0JWpnUxG
         AG4DtZPycC7XBhBAaDN1HtRy72CsuiFFTupnOb5bev1lu5hlVdYcEpoubVCNY8XqCvrH
         NDO+1RZhg7IL8MwsXQC6pTeZMbpw3ew5okke+h7Ff0Y1GBlVSyzgJ+9/SeL0roiIs9Q/
         QEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850210; x=1713455010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHTPq1Y3fOvLbs3hQO1iRO6uGsna0yiG5KXgQ6la0bw=;
        b=LqMiv99la3YvG8Rc1dxcN/k0LFNxtan/GotjqgA8ll613yfvr99ND3eIWMoaoDnwVM
         QkT8nZRZD3hhN/8M1psvN0SZnlzIyoNlBMKx24u38hNJIewJNybubSSkStzJVG33gVHz
         WC4ssAtg+zoZH7c9iVgCPBAFtoaVtvR905ihRjm4U40I9veMqzW+vK24bzqUm0585Itt
         b5t20l4HsBNZadAzMAd/6Z2ZGVbtvf9h8Y4aBdi0/gvEibyN89XEvNXgjaN39KQ9nHxJ
         hOJV1mKltiFB56wsxPLLC8hl9eWU0FRbqbsiRiPEIIOnsnDZYLBWn13+QJw5AdktS2mL
         7ycg==
X-Gm-Message-State: AOJu0Yxsk2IwxSb+jlq+HW3i8/55nidLj808b7C+j8noz+eqvn0bCqNc
	NP74Wp6vpEyI5319ftiEwX7Qd31aooDzXclvP3hBboKyUXbPjfEokiXkA9ZZIy1t3v0fNpr1AF7
	T
X-Google-Smtp-Source: AGHT+IEsqESPkatlu+L2CquxS+m1WPOIPK0uUL6JHwp39Y3zglmUOSn8CBHF0+cYCvHFjVs09Imzug==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr207016iob.1.1712850210125;
        Thu, 11 Apr 2024 08:43:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 424/437] media: usb: uvc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:24 -0600
Message-ID: <20240411153126.16201-425-axboe@kernel.dk>
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
 drivers/media/usb/uvc/uvc_debugfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 1a1258d4ffca..2c4935a0257e 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -39,13 +39,11 @@ static int uvc_debugfs_stats_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t uvc_debugfs_stats_read(struct file *file, char __user *user_buf,
-				      size_t nbytes, loff_t *ppos)
+static ssize_t uvc_debugfs_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct uvc_debugfs_buffer *buf = file->private_data;
+	struct uvc_debugfs_buffer *buf = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(user_buf, nbytes, ppos, buf->data,
-				       buf->count);
+	return simple_copy_to_iter(buf->data, &iocb->ki_pos, buf->count, to);
 }
 
 static int uvc_debugfs_stats_release(struct inode *inode, struct file *file)
@@ -60,7 +58,7 @@ static const struct file_operations uvc_debugfs_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = uvc_debugfs_stats_open,
 	.llseek = no_llseek,
-	.read = uvc_debugfs_stats_read,
+	.read_iter = uvc_debugfs_stats_read,
 	.release = uvc_debugfs_stats_release,
 };
 
-- 
2.43.0


