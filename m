Return-Path: <linux-kernel+bounces-141180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3908A1ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814722876DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E31F8C7F;
	Thu, 11 Apr 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SAC0jewo"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041B1F82FB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850168; cv=none; b=SMD3DjFfxfzumU40OWhwP7JT0z6jZt2SL2d6jONsTD7R8EAdwNZTHMfjy6iESk+Bb4mzaT2AwjWvXcYma7ag/Fbf0oS4OMkLdiD77CviZHui++HEaXpHBZJ5kdAHK/ok6ctRkAkeUaLr53ntUA9X1HjIvEb+2Lfywo+X8lC+l1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850168; c=relaxed/simple;
	bh=VPNd7BEodQPboB1rp43ShwVSi7YJUv8EW2Nk6q7xmw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGrVtQNEb2C2rU5iN535tte1B52y6P+TCKHST3KKTwzuXE/VHeUiGUWqOGNV2WOlthR70rtZZIA2T7l9CBN25NMktsvL//cNa7Yy0daRKpwJx07lssMJgbtpBtSWwJtUi0GhxdP7SG6vmkQusam/NodFdf+75xWLTX2UM7x8hss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SAC0jewo; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69691639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850165; x=1713454965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td0z5rsJzO3TviM45pZjL/WQ8TqnLCOHJ/AeSZk7a3Q=;
        b=SAC0jewoNkjf0y2E9l7CD9wTE8+spTew3rviO9amQlZ2jrMRyoJ6yCqKf5LMARhHLt
         f/qJA6cKQ92Tt2FPmUJ9KWimQ3YA/gCpnVtgMU1uPWan0cIY+77OJkA5VaCZjD2+UAKj
         nDlaGP4XJ97j54oMXTS2XYEqMD0smXB/IVUDWZyXXWiNXBE2IePTsP3S9xot1C4iFAyW
         5pFInDT/TaX9Wr5zmxvy3Fdwj73dFfm70Wn8ad2dMYrTqeNkRwFtCbu/+jwPadsvEBGO
         +32yvsblcelga6aH7esnE+yFLa6Ylq3Pebkd5kIM3b/GYDpMGkknp5VcZiKi+iCiOmv2
         HzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850165; x=1713454965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td0z5rsJzO3TviM45pZjL/WQ8TqnLCOHJ/AeSZk7a3Q=;
        b=Eo6Vj2ea8Ibw32KAkp6BPyBM1zVelkUWcKWfbXf+gK8WEqcvc4EC7lJqC9FypNdo9g
         o4AnAUZ1k3sr48U9wx54IsXACnIrqkqmJwYcndQ2NQDyzw5IIiYF9NV5XOfQwcIu3Dce
         UxH89jlLKs/T0E3GSpyDZ5gu0NBfnprqE3hEIIL8afyV0wOo1yeYO+xYdsHJKikm7xzJ
         3cGV6O9vdXYERpK7ShJ0B0C2QiilgAHeTEWK94dF2be7GtJor+5Y1DBPEZPLqNo+Wjk6
         4miK3vOGHtN+hmmnTlhD3NMtMhFPEMycqrUFRx3K89HOQ3yEDvBK2TK95iRKhbhSXdTc
         YCOQ==
X-Gm-Message-State: AOJu0YzGSfwAOxS7YospyDGmnCRENa1Kg/RAcDMay5Qx7shDsEBqA5gE
	6onghTtRXUYRJtrhd56PYOZQhn2Ue2b3hUzCEYciFzemKGj0SCvaOI5Wq0GU1gcTGWuiFTXlgW9
	R
X-Google-Smtp-Source: AGHT+IGfHVNdqgq4P4rPw4FAyb703V2ov+ZaMHAlH0V9lNDXbBLe09yQtYTCvA6KFYRAdWwtBq03Yw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr237636iof.0.1712850165511;
        Thu, 11 Apr 2024 08:42:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 396/437] macintosh: adb: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:56 -0600
Message-ID: <20240411153126.16201-397-axboe@kernel.dk>
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
 drivers/macintosh/adb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index b0407c5fadb2..1b95911ded5d 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -713,11 +713,11 @@ static int adb_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t adb_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t adb_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int ret = 0;
-	struct adbdev_state *state = file->private_data;
+	struct adbdev_state *state = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct adb_request *req;
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
@@ -741,7 +741,7 @@ static ssize_t adb_read(struct file *file, char __user *buf,
 		if (req != NULL || ret != 0)
 			break;
 		
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -764,18 +764,18 @@ static ssize_t adb_read(struct file *file, char __user *buf,
 	ret = req->reply_len;
 	if (ret > count)
 		ret = count;
-	if (ret > 0 && copy_to_user(buf, req->reply, ret))
+	if (ret > 0 && !copy_to_iter_full(req->reply, ret, to))
 		ret = -EFAULT;
 
 	kfree(req);
 	return ret;
 }
 
-static ssize_t adb_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t adb_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret/*, i*/;
-	struct adbdev_state *state = file->private_data;
+	struct adbdev_state *state = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct adb_request *req;
 
 	if (count < 2 || count > sizeof(req->data))
@@ -794,7 +794,7 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 	req->complete = 0;
 	
 	ret = -EFAULT;
-	if (copy_from_user(req->data, buf, count))
+	if (!copy_from_iter_full(req->data, count, from))
 		goto out;
 
 	atomic_inc(&state->n_pending);
@@ -843,8 +843,8 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 static const struct file_operations adb_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= adb_read,
-	.write		= adb_write,
+	.read_iter	= adb_read,
+	.write_iter	= adb_write,
 	.open		= adb_open,
 	.release	= adb_release,
 };
-- 
2.43.0


