Return-Path: <linux-kernel+bounces-141139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599DF8A1AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EED1C238DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5D1ED729;
	Thu, 11 Apr 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JJDKSvoA"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5E1ECE78
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850106; cv=none; b=m1ejMpE4Dj5cGPTDkptipSnFdRqV4ol5Zbew/PfYS+GOzCQj3KK3o3aPVgU2z8A0/UCS8ILyMsvsWDS6qttWEJE8k1lbDNtVxYfK1Iu6SUQN/eOLdNZ/NJ1O6j5bkSmbvMUzezuf1bIC402YOzlhDxVPh1k7lJ6aGyksB+1S14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850106; c=relaxed/simple;
	bh=XA0kueIZ+W/r6Gy+vaE76A3EVkTNnTgOhktlTU+d77I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeSWS3opBQPqEOUUqlDFn3eeuTzzL/qXgSnonSOeVScN0zft/2ysHg8HDGTJLve+T389kBY33SR/D08bEhLTKtKNuaiPWaee8zK3gkATYejjk5ShP5VdDKrupl2Vt81EeufuJCNa1v4HNmq/5T92ZO8i3oqBR2VpiNKE2NOXBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JJDKSvoA; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170636139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850103; x=1713454903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGAzEWsufQPncGSyPx2VXfJ5oENgvtMIK0zKLOzyooE=;
        b=JJDKSvoA7CH+MMG06F2nv95XF3XBshB2fj8fCUHKyt8x9fN2eKQLnN7y6M+O5j4+zt
         CKcX/h5FGiOxBb2AM+vjyiyWA81cc1Pp1CgVgxtUk1Qm8bU+i2xOiwSeY7m+8RkOjIjq
         4If6DvaeKD8BJYY5h3nZ+1XNFVAnCipjd8aCMwooKGlKjPZws1vzhu2ID4NiRwl/Zv54
         0nukpL6WaBF93WJbfEqYLpv0IpxbDJng5cKdATAEVXRgfnJCUas4GKsoi0Vvigphok4W
         8DAmloYKBWIr3POfd0SFBq1W02mqSgZBjzl1TEKmyiQ9CYFjnK0bgsooE1ObSxhQRlvI
         Xvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850103; x=1713454903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGAzEWsufQPncGSyPx2VXfJ5oENgvtMIK0zKLOzyooE=;
        b=U6ecPL6K5WcpAUTnGbUCIs8D94okX4uFLTgRLmaPRbJTiECgatdXGIu1vsvZSRVvCJ
         YfJ/DFgbglG6R8ETt+Ogs+iBlp7vdBtbN0OUEL8wmKEcmbW8FkMcHMdsT3Es9HEj6n6t
         V2XbcwlN7SP3bosQHwh8Le5OlZW2ouyJS8WdYOk4vpELmRLe1rH9mNdB0ZG57lBlCEwP
         QxPXk3mFJCC/5SrG4vibtm5rrUYjl68puWLoCR330dwMuDPmZ6P5U59zAWxySaC1ItDX
         D1yU3Rx/MkUZuw83MYq7MCxRy5IhHO1SLEAIUk3sg2U1FwHRzJMK/jP89bVGcE6QeroT
         vEIw==
X-Gm-Message-State: AOJu0YxgM4B4MYtjq1EWxEKttPesnh/j9QOiQcAKy2VCIMNVAAoJfcfJ
	+SeISC8fk8my1V9heys6/eGBeQgCYD6LbR4Opq7eJTK9HWbRrTlAYCuFL2LdxgT08TgmHUPCVvJ
	6
X-Google-Smtp-Source: AGHT+IGZPLLOOf2rrYNSpL0qYe5NzOl7Q3VTQwFsLu7Qy8lAgKwjgMDaH68L+rYozvhcXePEW7Q7EQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr31252ioc.1.1712850103578;
        Thu, 11 Apr 2024 08:41:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 360/437] hwmon: asus_atk0110: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:20 -0600
Message-ID: <20240411153126.16201-361-axboe@kernel.dk>
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
 drivers/hwmon/asus_atk0110.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index d778a2aaefec..bd6eabfd7d73 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -764,13 +764,12 @@ static int atk_debugfs_ggrp_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t atk_debugfs_ggrp_read(struct file *file, char __user *buf,
-		size_t count, loff_t *pos)
+static ssize_t atk_debugfs_ggrp_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	char *str = file->private_data;
+	char *str = iocb->ki_filp->private_data;
 	size_t len = strlen(str);
 
-	return simple_read_from_buffer(buf, count, pos, str, len);
+	return simple_copy_to_iter(str, &iocb->ki_pos, len, to);
 }
 
 static int atk_debugfs_ggrp_release(struct inode *inode, struct file *file)
@@ -780,7 +779,7 @@ static int atk_debugfs_ggrp_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations atk_debugfs_ggrp_fops = {
-	.read		= atk_debugfs_ggrp_read,
+	.read_iter	= atk_debugfs_ggrp_read,
 	.open		= atk_debugfs_ggrp_open,
 	.release	= atk_debugfs_ggrp_release,
 	.llseek		= no_llseek,
-- 
2.43.0


