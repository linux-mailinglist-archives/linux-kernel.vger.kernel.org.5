Return-Path: <linux-kernel+bounces-140862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A38A19E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78114B2731F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AF13A86E;
	Thu, 11 Apr 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BjaOPBD6"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FA13A3F9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849673; cv=none; b=AnYQjb+imsKrafTB4dHdiopcXCSJe2Ijrx2aTm7NyECnIfPxwd6dxIhE3qcCY3OBllBs4NgTQ1t+gFBRDphtxQB6+V6bLJ+Syo+bMKpFCFMnoX8Dqf+QjaCQ6v2l+w8ARjFhH6XD5hitRwdMoHNE44j1dwy7PkYgcD9K+xcYFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849673; c=relaxed/simple;
	bh=J4wmBK0VwnyiAyzvxgtNdd8ejgNvMcNfeaJPwCFzHl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZYej9rSzvnVncApv9kQT6VqFZ78F5zbR591OTw03r0FWmJR899Ko+znchPWui2O0JHpu9J4n2KwfoyYDepX5lRVyVxp803IgQqHLo/aE8SXaWv7JyR7cxXDCYZLTLovbv3c7KRsWF47c8w8ClK83tljaxFgq8eEwhEGZ1k8ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BjaOPBD6; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170479439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849670; x=1713454470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utVZJ3NTAroxWHBQsX8MO7HUtSAiLJiJmVVXUoSe800=;
        b=BjaOPBD6maDP2yhPp+cJo0F41uEXLeW+qZ24SRUw/olMFFm1744386/WgyvVAqd/mJ
         P0vhXfVv+cgTtj2tVwdDAjxGvBrpvgui66M0ZoZwIL/jDf+jtBtNkPS8cNqHUuN9y6pZ
         1ZFLbKFsT34CKhLheH8L0+mQI86pFYJtexL4HRPH6kfN8l17liW/CZ+zux8CZDP3z7qi
         9CoRKoM2cT+i0i5y6h7u+j2CA9yhZJENSbnTaxr+k9HLdDGkIQOHCsXa1UtUTLv0Upj3
         w3KwGxopUWFPEVq+MYM+FlHtlpI51m34zze9FJyOuhBioa2E15agoe+d2M/L4tDkv3L5
         Wy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849670; x=1713454470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utVZJ3NTAroxWHBQsX8MO7HUtSAiLJiJmVVXUoSe800=;
        b=UIsnyCAwI83YTMdzpn+/gsxYUVKRzLZijIsN9tJYXM1zctNDsyCVV9hHwjbrgapYBF
         w33E/zVUt7Btl0NnqlfEAsedUo0XejiVp06ReoUKM7mRjH/t476i1zzmtXARV/y3iZ6I
         GcJVq30bM7aa5HWw8pz3DEY2BVV2367/IcJP91AxB8S1uvslrqZuFQ+0xBPMCctBfx3v
         cdwDGTJlHVDCIalNKoSC7hxPdntjmXGRE8PUypSghj5sEkcRIBqMAUpALg8zALcUoE3G
         8YmNQ8mkY/gnaXCp3LzeyTAsFQ1G94hk5fmtUUkyou8KTxYtbzwLXWpiMYrcqiYtsFrI
         tQjw==
X-Gm-Message-State: AOJu0YyUh0EpeC6TqYsR9DoPan0y24doA6FL6fsG+d4iCt0EcdOM/Oo1
	IreF4YG83cBloMf4ViVCpYHhz039+M1tP/MV6Rdh1CRsx8zwIpFoPg09u0kxDL6BJ1ZB+QgmsOb
	F
X-Google-Smtp-Source: AGHT+IF7S1yMBXoPnurcAibsSK3Ay+DNqhdo9zwWgRNEqe7dlEE+hvNOeyCuYp8X/GVDidULS+sy1A==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr10302ioc.1.1712849670096;
        Thu, 11 Apr 2024 08:34:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 099/437] mtip32xx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:59 -0600
Message-ID: <20240411153126.16201-100-axboe@kernel.dk>
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
 drivers/block/mtip32xx/mtip32xx.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 43a187609ef7..28ea499cbbfd 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2162,13 +2162,13 @@ static const struct attribute_group *mtip_disk_attr_groups[] = {
 	NULL,
 };
 
-static ssize_t mtip_hw_read_registers(struct file *f, char __user *ubuf,
-				  size_t len, loff_t *offset)
+static ssize_t mtip_hw_read_registers(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct driver_data *dd =  (struct driver_data *)f->private_data;
+	struct driver_data *dd =  iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	char *buf;
 	u32 group_allocated;
-	int size = *offset;
+	int size = iocb->ki_pos;
 	int n, rv = 0;
 
 	if (!len || size)
@@ -2217,21 +2217,21 @@ static ssize_t mtip_hw_read_registers(struct file *f, char __user *ubuf,
 	}
 	size += sprintf(&buf[size], "]\n");
 
-	*offset = size <= len ? size : len;
-	size = copy_to_user(ubuf, buf, *offset);
-	if (size)
+	iocb->ki_pos = size <= len ? size : len;
+	size = copy_to_iter(buf, iocb->ki_pos, to);
+	if (!size)
 		rv = -EFAULT;
 
 	kfree(buf);
-	return rv ? rv : *offset;
+	return rv ? rv : iocb->ki_pos;
 }
 
-static ssize_t mtip_hw_read_flags(struct file *f, char __user *ubuf,
-				  size_t len, loff_t *offset)
+static ssize_t mtip_hw_read_flags(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct driver_data *dd =  (struct driver_data *)f->private_data;
+	struct driver_data *dd =  iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	char *buf;
-	int size = *offset;
+	int size = iocb->ki_pos;
 	int rv = 0;
 
 	if (!len || size)
@@ -2246,26 +2246,26 @@ static ssize_t mtip_hw_read_flags(struct file *f, char __user *ubuf,
 	size += sprintf(&buf[size], "Flag-dd   : [ %08lX ]\n",
 							dd->dd_flag);
 
-	*offset = size <= len ? size : len;
-	size = copy_to_user(ubuf, buf, *offset);
-	if (size)
+	iocb->ki_pos = size <= len ? size : len;
+	size = copy_to_iter(buf, iocb->ki_pos, to);
+	if (!size)
 		rv = -EFAULT;
 
 	kfree(buf);
-	return rv ? rv : *offset;
+	return rv ? rv : iocb->ki_pos;
 }
 
 static const struct file_operations mtip_regs_fops = {
 	.owner  = THIS_MODULE,
 	.open   = simple_open,
-	.read   = mtip_hw_read_registers,
+	.read_iter   = mtip_hw_read_registers,
 	.llseek = no_llseek,
 };
 
 static const struct file_operations mtip_flags_fops = {
 	.owner  = THIS_MODULE,
 	.open   = simple_open,
-	.read   = mtip_hw_read_flags,
+	.read_iter   = mtip_hw_read_flags,
 	.llseek = no_llseek,
 };
 
-- 
2.43.0


