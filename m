Return-Path: <linux-kernel+bounces-140935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AC8A19B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EA81C2155C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569671C9EB8;
	Thu, 11 Apr 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nGl6VDpr"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF281C8FBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849783; cv=none; b=Ukt0aiH1+zuU0WyUl5eYvVIibqh1EvbyZa4dDzBhvndaO0bziHgJ0roMhvVdKtxVxTG3LBtpXPMIWUXt+eznww1ZuNZxykMu4wag7ZwK0dxBt+E7oh4dhkVvR8oT/T6pmDPeUnm1KCdLL72w/72afvkoCrlAAYmCo0gU6oC3Ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849783; c=relaxed/simple;
	bh=tCNwQgQK9CmNxv1FGh773KunBY7kDDe5bl+LtM1G99I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0vnjO0zQ8bXd2w657oPHskA8c7SPI0XDJQ88x2jg6RD58ywQutMHbbMiVTY8/hUlMcI0BIdHNtEgt75xECOtc6Nhd/guba0OBmDFuQhaTPkUZEUy8u2MASdQ8dITryNqAI84iLcMfmTN99Fv/yHB3NlYFNr28LP0qPVWGSlbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nGl6VDpr; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8950939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849781; x=1713454581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE+QeweiNvcjh/13fo8jPtzqizzL+chR6NcoX8V8fRg=;
        b=nGl6VDprIPz1fozFi/EumzldVejd99JHkZ6vug1lSLq1jkxrszHau7Zrv0jNcrdXZS
         DPi5sGUiv0C8I7j6WdKNPK1jjw1FX/FRj4C41Y9O0lLL0/Th24+zeVW5y+DDEJ7Zuxny
         oj7GYbyP9rU6ZzsQAD6fv77d8uBqYDndojX7OXDFHLtpr8YRd2CKhh9vJiTR0VrekJ9a
         v3VNuiq2w8tuldQuf0fxDnP6hWVnVl35EtTSoA/apZ575n1Pv0qL6a2vgdmYKT1Phh8J
         f1ww0IRfIGUrTTJ3MrV++NpwlG8CH3qPg/p6UbBd9t/TQ471Lpa1l1ya/4O+2h2okbvk
         eUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849781; x=1713454581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE+QeweiNvcjh/13fo8jPtzqizzL+chR6NcoX8V8fRg=;
        b=CStbCKdEOPtoHRocHaO1AL5jH7+x4SWvGxphhjN+lgbF2qUIUVw8DMv5Q0yUGJPPIi
         OEsZyAWjr0qSZ23uVNmO3YQYdbXEfBk9tlKl66d7XzQem9g3mVJY2+UmyWBKbk+os1Kz
         Z8u3RNbhaFxNBgm/mDz80t4UCZMGw/LTFHZQTv0uKypKcoZO7s9HBr93NLclPK+6rWHJ
         Oes1QRRmkQIAe0CLa8ZpNZE6XpG2RigRytwW2LoaZcOCRLDXNbriGZXrlYXIKnoc62Xf
         wbdfsKS0jJYlXaYeBfcP/WimDGrRCjCspfAtx8Rl1qsbpn5ZAllUHNwA+RwpfJOsHaxI
         hi9w==
X-Gm-Message-State: AOJu0YxEH0uC+IxyXjT2PioY1cyRsESDB1Z5PWrUCdzWorOq7FG9Fe36
	fjSBdL3Qwfth4X4s740Yb44PmcdEcomsj061ChyD8FtHnqWvfx19LFOtFhD/tFbjiveyhm1WG10
	0
X-Google-Smtp-Source: AGHT+IESPApm7hbRL+nqvZ8faHnWCw1VXUlvr/wHJmK6d7miJ2+VnGvf8FNByVM8CX9rTg+W0SSJnw==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr222160ioh.0.1712849781055;
        Thu, 11 Apr 2024 08:36:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 166/437] usb: host: xhci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:06 -0600
Message-ID: <20240411153126.16201-167-axboe@kernel.dk>
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
 drivers/usb/host/xhci-debugfs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index f8ba15e7c225..751e48d0b555 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -251,7 +251,7 @@ static int xhci_ring_open(struct inode *inode, struct file *file)
 
 static const struct file_operations xhci_ring_fops = {
 	.open			= xhci_ring_open,
-	.read			= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -336,7 +336,7 @@ static int xhci_context_open(struct inode *inode, struct file *file)
 
 static const struct file_operations xhci_context_fops = {
 	.open			= xhci_context_open,
-	.read			= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -360,17 +360,17 @@ static int xhci_port_open(struct inode *inode, struct file *file)
 	return single_open(file, xhci_portsc_show, inode->i_private);
 }
 
-static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
-			       size_t count, loff_t *ppos)
+static ssize_t xhci_port_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file         *s = file->private_data;
+	struct seq_file         *s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct xhci_port	*port = s->private;
 	struct xhci_hcd		*xhci = hcd_to_xhci(port->rhub->hcd);
 	char                    buf[32];
 	u32			portsc;
 	unsigned long		flags;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "compliance", 10)) {
@@ -397,8 +397,8 @@ static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
 
 static const struct file_operations port_fops = {
 	.open			= xhci_port_open,
-	.write                  = xhci_port_write,
-	.read			= seq_read,
+	.write_iter             = xhci_port_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -502,10 +502,10 @@ static int xhci_stream_id_open(struct inode *inode, struct file *file)
 	return single_open(file, xhci_stream_id_show, inode->i_private);
 }
 
-static ssize_t xhci_stream_id_write(struct file *file,  const char __user *ubuf,
-			       size_t count, loff_t *ppos)
+static ssize_t xhci_stream_id_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file         *s = file->private_data;
+	struct seq_file         *s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct xhci_ep_priv	*epriv = s->private;
 	int			ret;
 	u16			stream_id; /* MaxPStreams + 1 <= 16 */
@@ -514,7 +514,7 @@ static ssize_t xhci_stream_id_write(struct file *file,  const char __user *ubuf,
 		return -EPERM;
 
 	/* Decimal number */
-	ret = kstrtou16_from_user(ubuf, count, 10, &stream_id);
+	ret = kstrtou16_from_iter(from, count, 10, &stream_id);
 	if (ret)
 		return ret;
 
@@ -529,8 +529,8 @@ static ssize_t xhci_stream_id_write(struct file *file,  const char __user *ubuf,
 
 static const struct file_operations stream_id_fops = {
 	.open			= xhci_stream_id_open,
-	.write                  = xhci_stream_id_write,
-	.read			= seq_read,
+	.write_iter             = xhci_stream_id_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
-- 
2.43.0


