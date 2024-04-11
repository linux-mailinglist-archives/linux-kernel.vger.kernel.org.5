Return-Path: <linux-kernel+bounces-141105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40928A1AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116FDB21416
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE91E499C;
	Thu, 11 Apr 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ju5lPKbz"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D01635DC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850045; cv=none; b=FKQE0nYA16rxV3StPm1ahfN9di28MHIhuTvgSVMw42kdksq4YxO9aVmFzpP9No1baeZfEoztIx4UaKpGuCwUdhzNuAS0hOCnbYJP3AiolAWzWrht7fA7bOlhfkFFeCiB9mE11SqUGJnZAe+sB83pYvnuEOeUuTmOt0WxOlEeO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850045; c=relaxed/simple;
	bh=91NKOE/FG0mNc/o9nQIiAdq9F5aXD0RP2DDlAVXoJpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnVBfbUxj2nc5iei6ZWv6nFsD+JIOreMGt6zqKsOJHgWI3Lu4tLNlB2e3bmj3nHFMSPdAOx89AYm47U3a9adyiLikvtm2MMZqXLHljx/n+i3TCH+9KSeyQk1dSo8RWpqs+g0ECUSFHyqUBpWqIAgZJdlo4t678udKEUO0P1HvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ju5lPKbz; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9886639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850042; x=1713454842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI1o+GEoiIwLuzXnZ4pCw0XdZU+TlzjuQbPrxSBEsbU=;
        b=Ju5lPKbzdlf4MBWrUoGoGXQRiSV6CHNr55CRT/8c924QxON4WgVT/9fTVof81NbXrW
         l3ZfrFttW9sAyX6+9MIeqZD7kO9Zak5F9XfWXqo9evpvv0FRNBMGnQBTbYERewXT17+1
         XXiEaOsqYA0HwUTjpSd+GWoFt1h0Ov6aoywD7izdWmrJP3XMQMs1lAfoTKqp9RrYQtK5
         JkLYtICCaHioMdj0lPsFR87XotbHy1Ha+HzxL0oJoTffiPMLQV9vtDSxwlDTTA+0DOPo
         anX4Z2Ft9rlq9nuaMfmwtHzddoGmSJKpfZT6BNCXX1P8zmnW+FIv0iCAWDdKhsLEmaRK
         NWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850042; x=1713454842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI1o+GEoiIwLuzXnZ4pCw0XdZU+TlzjuQbPrxSBEsbU=;
        b=pb3C5+pyavmfPO7dzy9iTbOWrDQ7NXlFWY5KJDt4qW5wKDuSOkfRPD1zedLl3xzK/J
         8Exu0yORhxFiSWNkbueDs8ve4idlw6E0NeVcTgmEMpUIuq+GUAx74twclUlrwhzoZtkA
         zqan4oJh+vTP+CmBUxtyhm8CAGgPllv0D/SGhfAiXhi19+abQrbg/60NhndxUIRYNkck
         IuSvxLM+Z/av1Zg+LeBO0yHLqyGAHdPz4TlcAFn3k9ml7kqeCwoyPvXZmIxed9ZM28D2
         GpCA+w/OGiX8WvRnNaw5jtOOKyhznJkumKFbzIQlXHmU3zshFczEMK4cweQVO1UeSMGy
         qMTw==
X-Gm-Message-State: AOJu0YwnWeoTYCZn4SiFMVY9CxkyIYZ5UrmC3xCnYauFW1UzL48ezpY4
	zNgokRHnP/X0OCMmRXqEb3uyErI5O84BDGDgYuuG10rvaHTH8vV6k+owuF7F3nlNq3e4izEjfy2
	C
X-Google-Smtp-Source: AGHT+IFhOuyUh4ilF00/p4e9pCdo3iUdycznL/pMySiLEtFfzlbqjBZwbjCVlM15EwUgVMRChjzyJg==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr204887iop.1.1712850042460;
        Thu, 11 Apr 2024 08:40:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 327/437] drivers/net/ethernet/amd-xgbe: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:47 -0600
Message-ID: <20240411153126.16201-328-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
[axboe: fix typo in xi2c_reg_value_read_iter]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c | 233 +++++++++----------
 1 file changed, 112 insertions(+), 121 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c b/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
index b0a6c96b6ef4..5dfd4fc8618e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
@@ -121,36 +121,30 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
 
-static ssize_t xgbe_common_read(char __user *buffer, size_t count,
-				loff_t *ppos, unsigned int value)
+static ssize_t xgbe_common_read_iter(struct iov_iter *to, loff_t *ppos,
+				     unsigned int value)
 {
-	char *buf;
-	ssize_t len;
+	char buf[16];
+	int len;
+	size_t count = iov_iter_count(to);
 
 	if (*ppos != 0)
 		return 0;
 
-	buf = kasprintf(GFP_KERNEL, "0x%08x\n", value);
-	if (!buf)
-		return -ENOMEM;
-
-	if (count < strlen(buf)) {
-		kfree(buf);
+	len = sprintf(buf, "0x%08x\n", value);
+	if (count < len)
 		return -ENOSPC;
-	}
-
-	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
-	kfree(buf);
 
-	return len;
+	return simple_copy_to_iter(buf, ppos, len, to);
 }
 
-static ssize_t xgbe_common_write(const char __user *buffer, size_t count,
-				 loff_t *ppos, unsigned int *value)
+static ssize_t xgbe_common_write_iter(struct iov_iter *from, loff_t *ppos,
+				      unsigned int *value)
 {
 	char workarea[32];
 	ssize_t len;
 	int ret;
+	size_t count = iov_iter_count(from);
 
 	if (*ppos != 0)
 		return -EINVAL;
@@ -158,8 +152,8 @@ static ssize_t xgbe_common_write(const char __user *buffer, size_t count,
 	if (count >= sizeof(workarea))
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(workarea, sizeof(workarea) - 1, ppos,
-				     buffer, count);
+	len = simple_copy_from_iter(workarea, ppos, sizeof(workarea) - 1,
+				    from);
 	if (len < 0)
 		return len;
 
@@ -171,44 +165,43 @@ static ssize_t xgbe_common_write(const char __user *buffer, size_t count,
 	return len;
 }
 
-static ssize_t xgmac_reg_addr_read(struct file *filp, char __user *buffer,
-				   size_t count, loff_t *ppos)
+static ssize_t xgmac_reg_addr_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_read(buffer, count, ppos, pdata->debugfs_xgmac_reg);
+	return xgbe_common_read_iter(to, &iocb->ki_pos,
+				     pdata->debugfs_xgmac_reg);
 }
 
-static ssize_t xgmac_reg_addr_write(struct file *filp,
-				    const char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t xgmac_reg_addr_write_iter(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_write(buffer, count, ppos,
-				 &pdata->debugfs_xgmac_reg);
+	return xgbe_common_write_iter(from, &iocb->ki_pos,
+				      &pdata->debugfs_xgmac_reg);
 }
 
-static ssize_t xgmac_reg_value_read(struct file *filp, char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t xgmac_reg_value_read_iter(struct kiocb *iocb,
+					 struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 
 	value = XGMAC_IOREAD(pdata, pdata->debugfs_xgmac_reg);
 
-	return xgbe_common_read(buffer, count, ppos, value);
+	return xgbe_common_read_iter(to, &iocb->ki_pos, value);
 }
 
-static ssize_t xgmac_reg_value_write(struct file *filp,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos)
+static ssize_t xgmac_reg_value_write_iter(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 	ssize_t len;
 
-	len = xgbe_common_write(buffer, count, ppos, &value);
+	len = xgbe_common_write_iter(from, &iocb->ki_pos, &value);
 	if (len < 0)
 		return len;
 
@@ -220,72 +213,73 @@ static ssize_t xgmac_reg_value_write(struct file *filp,
 static const struct file_operations xgmac_reg_addr_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xgmac_reg_addr_read,
-	.write = xgmac_reg_addr_write,
+	.read_iter =  xgmac_reg_addr_read_iter,
+	.write_iter = xgmac_reg_addr_write_iter,
 };
 
 static const struct file_operations xgmac_reg_value_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xgmac_reg_value_read,
-	.write = xgmac_reg_value_write,
+	.read_iter =  xgmac_reg_value_read_iter,
+	.write_iter = xgmac_reg_value_write_iter,
 };
 
-static ssize_t xpcs_mmd_read(struct file *filp, char __user *buffer,
-			     size_t count, loff_t *ppos)
+static ssize_t xpcs_mmd_read_iter(struct kiocb *iocb,
+				  struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_read(buffer, count, ppos, pdata->debugfs_xpcs_mmd);
+	return xgbe_common_read_iter(to, &iocb->ki_pos,
+				     pdata->debugfs_xpcs_mmd);
 }
 
-static ssize_t xpcs_mmd_write(struct file *filp, const char __user *buffer,
-			      size_t count, loff_t *ppos)
+static ssize_t xpcs_mmd_write_iter(struct kiocb *iocb,
+				   struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_write(buffer, count, ppos,
-				 &pdata->debugfs_xpcs_mmd);
+	return xgbe_common_write_iter(from, &iocb->ki_pos,
+				      &pdata->debugfs_xpcs_mmd);
 }
 
-static ssize_t xpcs_reg_addr_read(struct file *filp, char __user *buffer,
-				  size_t count, loff_t *ppos)
+static ssize_t xpcs_reg_addr_read_iter(struct kiocb *iocb,
+				       struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_read(buffer, count, ppos, pdata->debugfs_xpcs_reg);
+	return xgbe_common_read_iter(to, &iocb->ki_pos,
+				     pdata->debugfs_xpcs_reg);
 }
 
-static ssize_t xpcs_reg_addr_write(struct file *filp, const char __user *buffer,
-				   size_t count, loff_t *ppos)
+static ssize_t xpcs_reg_addr_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_write(buffer, count, ppos,
-				 &pdata->debugfs_xpcs_reg);
+	return xgbe_common_write_iter(from, &iocb->ki_pos,
+				      &pdata->debugfs_xpcs_reg);
 }
 
-static ssize_t xpcs_reg_value_read(struct file *filp, char __user *buffer,
-				   size_t count, loff_t *ppos)
+static ssize_t xpcs_reg_value_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 
 	value = XMDIO_READ(pdata, pdata->debugfs_xpcs_mmd,
 			   pdata->debugfs_xpcs_reg);
 
-	return xgbe_common_read(buffer, count, ppos, value);
+	return xgbe_common_read_iter(to, &iocb->ki_pos, value);
 }
 
-static ssize_t xpcs_reg_value_write(struct file *filp,
-				    const char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t xpcs_reg_value_write_iter(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 	ssize_t len;
 
-	len = xgbe_common_write(buffer, count, ppos, &value);
+	len = xgbe_common_write_iter(from, &iocb->ki_pos, &value);
 	if (len < 0)
 		return len;
 
@@ -298,62 +292,61 @@ static ssize_t xpcs_reg_value_write(struct file *filp,
 static const struct file_operations xpcs_mmd_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xpcs_mmd_read,
-	.write = xpcs_mmd_write,
+	.read_iter =  xpcs_mmd_read_iter,
+	.write_iter = xpcs_mmd_write_iter,
 };
 
 static const struct file_operations xpcs_reg_addr_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xpcs_reg_addr_read,
-	.write = xpcs_reg_addr_write,
+	.read_iter =  xpcs_reg_addr_read_iter,
+	.write_iter = xpcs_reg_addr_write_iter,
 };
 
 static const struct file_operations xpcs_reg_value_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xpcs_reg_value_read,
-	.write = xpcs_reg_value_write,
+	.read_iter =  xpcs_reg_value_read_iter,
+	.write_iter = xpcs_reg_value_write_iter,
 };
 
-static ssize_t xprop_reg_addr_read(struct file *filp, char __user *buffer,
-				   size_t count, loff_t *ppos)
+static ssize_t xprop_reg_addr_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_read(buffer, count, ppos, pdata->debugfs_xprop_reg);
+	return xgbe_common_read_iter(to, &iocb->ki_pos,
+				     pdata->debugfs_xprop_reg);
 }
 
-static ssize_t xprop_reg_addr_write(struct file *filp,
-				    const char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t xprop_reg_addr_write_iter(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_write(buffer, count, ppos,
-				 &pdata->debugfs_xprop_reg);
+	return xgbe_common_write_iter(from, &iocb->ki_pos,
+				      &pdata->debugfs_xprop_reg);
 }
 
-static ssize_t xprop_reg_value_read(struct file *filp, char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t xprop_reg_value_read_iter(struct kiocb *iocb,
+					 struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 
 	value = XP_IOREAD(pdata, pdata->debugfs_xprop_reg);
 
-	return xgbe_common_read(buffer, count, ppos, value);
+	return xgbe_common_read_iter(to, &iocb->ki_pos, value);
 }
 
-static ssize_t xprop_reg_value_write(struct file *filp,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos)
+static ssize_t xprop_reg_value_write_iter(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 	ssize_t len;
 
-	len = xgbe_common_write(buffer, count, ppos, &value);
+	len = xgbe_common_write_iter(from, &iocb->ki_pos, &value);
 	if (len < 0)
 		return len;
 
@@ -365,55 +358,53 @@ static ssize_t xprop_reg_value_write(struct file *filp,
 static const struct file_operations xprop_reg_addr_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xprop_reg_addr_read,
-	.write = xprop_reg_addr_write,
+	.read_iter =  xprop_reg_addr_read_iter,
+	.write_iter = xprop_reg_addr_write_iter,
 };
 
 static const struct file_operations xprop_reg_value_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xprop_reg_value_read,
-	.write = xprop_reg_value_write,
+	.read_iter =  xprop_reg_value_read_iter,
+	.write_iter = xprop_reg_value_write_iter,
 };
 
-static ssize_t xi2c_reg_addr_read(struct file *filp, char __user *buffer,
-				  size_t count, loff_t *ppos)
+static ssize_t xi2c_reg_addr_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_read(buffer, count, ppos, pdata->debugfs_xi2c_reg);
+	return xgbe_common_read_iter(to, &iocb->ki_pos,
+				     pdata->debugfs_xi2c_reg);
 }
 
-static ssize_t xi2c_reg_addr_write(struct file *filp,
-				   const char __user *buffer,
-				   size_t count, loff_t *ppos)
+static ssize_t xi2c_reg_addr_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 
-	return xgbe_common_write(buffer, count, ppos,
-				 &pdata->debugfs_xi2c_reg);
+	return xgbe_common_write_iter(from, &iocb->ki_pos,
+				      &pdata->debugfs_xi2c_reg);
 }
 
-static ssize_t xi2c_reg_value_read(struct file *filp, char __user *buffer,
-				   size_t count, loff_t *ppos)
+static ssize_t xi2c_reg_value_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 
 	value = XI2C_IOREAD(pdata, pdata->debugfs_xi2c_reg);
 
-	return xgbe_common_read(buffer, count, ppos, value);
+	return xgbe_common_read_iter(to, &iocb->ki_pos, value);
 }
 
-static ssize_t xi2c_reg_value_write(struct file *filp,
-				    const char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t xi2c_reg_value_write_iter(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct xgbe_prv_data *pdata = filp->private_data;
+	struct xgbe_prv_data *pdata = iocb->ki_filp->private_data;
 	unsigned int value;
 	ssize_t len;
 
-	len = xgbe_common_write(buffer, count, ppos, &value);
+	len = xgbe_common_write_iter(from, &iocb->ki_pos, &value);
 	if (len < 0)
 		return len;
 
@@ -425,15 +416,15 @@ static ssize_t xi2c_reg_value_write(struct file *filp,
 static const struct file_operations xi2c_reg_addr_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xi2c_reg_addr_read,
-	.write = xi2c_reg_addr_write,
+	.read_iter =  xi2c_reg_addr_read_iter,
+	.write_iter = xi2c_reg_addr_write_iter,
 };
 
 static const struct file_operations xi2c_reg_value_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  xi2c_reg_value_read,
-	.write = xi2c_reg_value_write,
+	.read_iter =  xi2c_reg_value_read_iter,
+	.write_iter = xi2c_reg_value_write_iter,
 };
 
 void xgbe_debugfs_init(struct xgbe_prv_data *pdata)
-- 
2.43.0


