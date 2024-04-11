Return-Path: <linux-kernel+bounces-140985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB38A19ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC321C21731
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C6824A9;
	Thu, 11 Apr 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zHw/Aszq"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC831BE402
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849862; cv=none; b=Oo+bgmZA6kHGA2xZLTviBL/d6RUDeYiyb/1jVk691Tfu4g21BHnJFielPYw2W5YVSsIuNrHZW+d6bIHYhbw4u6slsYIdXtQ8NF+tSHyG6wvXih0OVoj3KrvxjOJ3DL3DbaNPugnM5gMPZVkfs2wskTHle1gIXmPXkjwEMjkg7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849862; c=relaxed/simple;
	bh=XLKt5eZDBTC++5sY/reTHPqBAamAX+Hj6woXPkidhOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPwY2pXVag46vE0jUdg+x9nSRyfPVrJUPOucFkAbGOrhRqUos/MjQ8gWid1TqTLm1fryxrHUvSPcyW3/nbMtABNgBOtUNhlQg3jeD7e8C2fgzmtxsVzbfuUsMTktEHJVSFFQL10gx7Wz5a844VyUO2R4dE9g5kwHdwM83v1JX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zHw/Aszq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8976839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849859; x=1713454659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGKEb36ML3r27fIXcnvi5oJlug0A+w9Xl9vTN9Gmtag=;
        b=zHw/Aszqtd+VKhT2B8BgPzyLBQNsLqMzorWOR9e1dGjgGS/5bBaxDsZf53P44tU4cm
         ek1H2Dx7L3uJ5m7/zbT9NKPV2zL8LmWDbPNMF+hKbaxjGCSFtm55cJDfU2aILN7Xkq0x
         0CYDWrYTmUdSebxZI3MeGau5f4DhgzUBEaC98tWmtYM8sr9iipJGpki695rzpyErnyBK
         HcXRDQlZsxyKxb6Qry+aXWCOjsFJ/OPH7rwmSpW6MJ/fkir00eY3dNnzv4l54S1ZVmV+
         8uH3psAW9UXXe8ad+sRb8bPi59vmLxLVY+DQgxOu7f1UJSjWbAzsdhfxegXRk0+Pfi8W
         xwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849859; x=1713454659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGKEb36ML3r27fIXcnvi5oJlug0A+w9Xl9vTN9Gmtag=;
        b=LwogDigQbVo1Kcnv3cBJy5tzembiInkGFVGRqHZRuR5WJ/JWaZLn7qxYSTlfIjVt48
         5I40jtE+G40yIj2yCdtHqhh2rdglhFmAGKZ4i5xdNc5qL2cyU+OPlpkB1RCDKm00IrnW
         0uPolrSiog/iBWSkyOMwVSpP82m7obY0eDH7HLra8ADYZ/f6/CkJ1iXw7OJz36Izt3R8
         hnxMSWoTOoF8KhT5jrg9GrVmtsORiL4KGDEZNn4TVAr433AHHOluOuGw1rvcpIu7u2gG
         qCjKm41lLuly/t03L9Zwi9XEemchATlEQ0cMf/qD7AYZB3PjHAcR72KXxn37rTCwDFng
         tiZA==
X-Gm-Message-State: AOJu0YzphYEhDBFlmB+hr+5h1Pk3+Oz2MYb+lKvXtBlyNIAQB55+/AOB
	ccqnX4ZXwoa8F9fFTX0JYw4ojmg1gv+vba49rPQrfkSoIE8R5OlqRq2liubPLqLhqKU7aUFkc2M
	S
X-Google-Smtp-Source: AGHT+IE+1ky5a5pzX9vWbt+tq4TPiJFUTZ8+sFIEPAzFX6Mrk7iWvRZdjBYHoKhkcZHzma7LUtx7Mg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr20294ioc.1.1712849859497;
        Thu, 11 Apr 2024 08:37:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 215/437] misc: hpilo: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:55 -0600
Message-ID: <20240411153126.16201-216-axboe@kernel.dk>
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
 drivers/misc/hpilo.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 04bd34c8c506..27282629e383 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -23,6 +23,7 @@
 #include <linux/wait.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
+#include <linux/uio.h>
 #include "hpilo.h"
 
 static const struct class ilo_class = {
@@ -431,13 +432,13 @@ static void ilo_set_reset(struct ilo_hwinfo *hw)
 	}
 }
 
-static ssize_t ilo_read(struct file *fp, char __user *buf,
-			size_t len, loff_t *off)
+static ssize_t ilo_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int err, found, cnt, pkt_id, pkt_len;
-	struct ccb_data *data = fp->private_data;
+	struct ccb_data *data = iocb->ki_filp->private_data;
 	struct ccb *driver_ccb = &data->driver_ccb;
 	struct ilo_hwinfo *hw = data->ilo_hw;
+	size_t len = iov_iter_count(to);
 	void *pkt;
 
 	if (is_channel_reset(driver_ccb)) {
@@ -473,7 +474,7 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
 	if (pkt_len < len)
 		len = pkt_len;
 
-	err = copy_to_user(buf, pkt, len);
+	err = !copy_to_iter_full(pkt, len, to);
 
 	/* return the received packet to the queue */
 	ilo_pkt_enqueue(hw, driver_ccb, RECVQ, pkt_id, desc_mem_sz(1));
@@ -481,13 +482,13 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
 	return err ? -EFAULT : len;
 }
 
-static ssize_t ilo_write(struct file *fp, const char __user *buf,
-			 size_t len, loff_t *off)
+static ssize_t ilo_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int err, pkt_id, pkt_len;
-	struct ccb_data *data = fp->private_data;
+	struct ccb_data *data = iocb->ki_filp->private_data;
 	struct ccb *driver_ccb = &data->driver_ccb;
 	struct ilo_hwinfo *hw = data->ilo_hw;
+	size_t len = iov_iter_count(from);
 	void *pkt;
 
 	if (is_channel_reset(driver_ccb))
@@ -502,7 +503,7 @@ static ssize_t ilo_write(struct file *fp, const char __user *buf,
 		len = pkt_len;
 
 	/* on failure, set the len to 0 to return empty packet to the device */
-	err = copy_from_user(pkt, buf, len);
+	err = !copy_from_iter_full(pkt, len, from);
 	if (err)
 		len = 0;
 
@@ -635,8 +636,8 @@ static int ilo_open(struct inode *ip, struct file *fp)
 
 static const struct file_operations ilo_fops = {
 	.owner		= THIS_MODULE,
-	.read		= ilo_read,
-	.write		= ilo_write,
+	.read_iter	= ilo_read,
+	.write_iter	= ilo_write,
 	.poll		= ilo_poll,
 	.open 		= ilo_open,
 	.release 	= ilo_close,
-- 
2.43.0


