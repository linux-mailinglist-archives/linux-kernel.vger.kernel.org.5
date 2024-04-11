Return-Path: <linux-kernel+bounces-141001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B938A1A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB071C20B85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334B1C2FF7;
	Thu, 11 Apr 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qzoRC7x6"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8801C2FD1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849886; cv=none; b=ig3eyuB4WCvs5q083Yah+M1zS4lJLIslKzLzQrI66QguC3E+2tPfCilzrQD7FQwVw32TG8fStqHh/+fUZcbJgjsOSoo12Tvpcs+DGmLCmUTW8N593c039IwBu7U+5UMBTxI7T0vzFrvO2+Iu14AOYCUMDonTTDdJQzZO+b2uJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849886; c=relaxed/simple;
	bh=v8C/lvedvI6wXG2vqxwSCKy1AMIR477ttE6+t9PHQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtNx023k9F2QN44kGH8JXnhvPwqZ3emB/k/7zixQnZJOTXtoZ2WSE6IRPHM8HJllN9RJPc3YbF8PMRuv+xVfvs9kOsYaLvMEXO89kR3A8qLjVVJ0unt0eulUMrVDOrfFAHJ53MIwcGkfVUBEfPrtXby0EWA6C110vZqBkEzLHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qzoRC7x6; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58119239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849883; x=1713454683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaoK8FTbbHnEwz1cy7WsiiIGpGZVFO82Tn20A2e7QqE=;
        b=qzoRC7x6F5GixRMGzv7OjufYiiBg2ouUeVd75CSYIL6n3MewBm3NIYU27lfOZLY9Fn
         +R3IB9/8YP+qTkShWQ7T7GdexxjxDHIxKdy/DapZdzB8/udWfslj9vB5v6bRF/EIPBht
         fFJpaISvtvMP3r9q79XrdQhNAleU2602DZbZoW8GThKRah0Bfg+eHwbJbgClPyRFPJht
         kcGECPnPhhiFuFmeIBXNqDaPmd+zaws170yN8zPftEASMRFsBIZSx/XpirnCV8/ooRud
         fxZW+OhsGxVfDvZq6Gqe75ZtHMND8lysiaYGZBx/a8yJx7JoAI8H/G2qlEBDdWocxH7N
         Y4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849883; x=1713454683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaoK8FTbbHnEwz1cy7WsiiIGpGZVFO82Tn20A2e7QqE=;
        b=aiqYOTZERcMzGTwo4ip6PCL9gSt+Benoryud8MMcXco46CeL1dA3D862d+KcRHqY4r
         xGL7IYuCvI4EW9fCCSDIZ+cZOxtAr9XLXxXkx1QisqAkXxAt07BbQhjs1wtUIokECzdh
         sdmCM1uYMacUkBV2blhtkOskXCwl8BiIFA5khLGD44yLVCOA9dxzTyEsLFHnnSqq3hMj
         1S5MX4uhtfZmCiFkTHdI5XJLeAC6KItFuqUisr9gHl9ygJA9IPmwEm3rdeW/KSt1EUOf
         0eQcUbBGhV2hULJS/on51kbScxLPDm6pcsgfxVecfoZ9bV7Z1+wRwPkLwAufc1w2obQM
         cvng==
X-Gm-Message-State: AOJu0YyowwTkOTHvZT1ePBzf3RMX6fOWq/hIPN7/iJBTiceWTTS09n2/
	nsA31UjgAEOsisCQS5KUdcVqVJdPgVblDfauvh9mzBsbeha/omiJCnPN8pZrQTbxVEPmPHkWDq6
	K
X-Google-Smtp-Source: AGHT+IEbPn05+VYqd8pmO3GqN7HdKihwl2X6Tdn6pmFycduls/9U2b0zQiJfOzAHSrunkkGw8wz5cQ==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr166641ioh.1.1712849883197;
        Thu, 11 Apr 2024 08:38:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 229/437] drivers/nfc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:09 -0600
Message-ID: <20240411153126.16201-230-axboe@kernel.dk>
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
 drivers/nfc/virtual_ncidev.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 590b038e449e..59c75de758d7 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -79,10 +79,10 @@ static const struct nci_ops virtual_nci_ops = {
 	.send = virtual_nci_send
 };
 
-static ssize_t virtual_ncidev_read(struct file *file, char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t virtual_ncidev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct virtual_nci_dev *vdev = file->private_data;
+	struct virtual_nci_dev *vdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	size_t actual_len;
 
 	mutex_lock(&vdev->mtx);
@@ -95,7 +95,7 @@ static ssize_t virtual_ncidev_read(struct file *file, char __user *buf,
 
 	actual_len = min_t(size_t, count, vdev->send_buff->len);
 
-	if (copy_to_user(buf, vdev->send_buff->data, actual_len)) {
+	if (!copy_to_iter_full(vdev->send_buff->data, actual_len, to)) {
 		mutex_unlock(&vdev->mtx);
 		return -EFAULT;
 	}
@@ -110,18 +110,17 @@ static ssize_t virtual_ncidev_read(struct file *file, char __user *buf,
 	return actual_len;
 }
 
-static ssize_t virtual_ncidev_write(struct file *file,
-				    const char __user *buf,
-				    size_t count, loff_t *ppos)
+static ssize_t virtual_ncidev_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct virtual_nci_dev *vdev = file->private_data;
+	struct virtual_nci_dev *vdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct sk_buff *skb;
 
 	skb = alloc_skb(count, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	if (copy_from_user(skb_put(skb, count), buf, count)) {
+	if (!copy_from_iter_full(skb_put(skb, count), count, from)) {
 		kfree_skb(skb);
 		return -EFAULT;
 	}
@@ -191,8 +190,8 @@ static long virtual_ncidev_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations virtual_ncidev_fops = {
 	.owner = THIS_MODULE,
-	.read = virtual_ncidev_read,
-	.write = virtual_ncidev_write,
+	.read_iter = virtual_ncidev_read,
+	.write_iter = virtual_ncidev_write,
 	.open = virtual_ncidev_open,
 	.release = virtual_ncidev_close,
 	.unlocked_ioctl = virtual_ncidev_ioctl
-- 
2.43.0


