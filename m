Return-Path: <linux-kernel+bounces-132572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010D8996BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49974283DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269A13C8E3;
	Fri,  5 Apr 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdbRbhq/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94A13C824
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302818; cv=none; b=rnm4EuwMPLjO1g+xo5qLYbm2wwZwcNQKvLT6ZawluMMIB6wzVCGCAMHhkQvVXOwBhEEuAZueqZQGKH6FX8fNwzqU3k2l3SbopFf1z3AsnG01hbWP3Nflcr/ov4Ddm2CsO1erBFZNgypno0CTzXO3+gPY2XaqTDNhIPuBsC7uPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302818; c=relaxed/simple;
	bh=HjRvMGXjDbwDSvM16WAhK4wPegt0yyIWO/1j4Z95mjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBG/3HBDTFj3JTiRGUe2USO33YOhY5tcMMEIrdi2lNfEE11ry0m7nOTIijFwbpUYnbwLDS2pv+KDSw7GSMd/RK5w6Vn3mkqFVijgqsHgaMvNmS/P4NsnIalFa/tbmyS1ti9N0fgwicTJXWMJ3SKwM1epunqzt7YBLZO+IfAMufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdbRbhq/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34356f794a5so1561673f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302814; x=1712907614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJrpsii5KxAd/+yN0rzfHDl19GAcoZcZzgV5GRtFABE=;
        b=SdbRbhq/kRtaGAEPNQjvYs2vERxUMh2dGSlRANUqcdWELhEsnJffzaArQbaqQi5826
         ZlzH1krbSuut1VWlNHLS77fR2NC642Qx+1HnWdLvRsuyhcgU0MWRl47zWMLhfaBWguFt
         yil5JJ9DX64owGxBYnzGTatl+YsWfHtRGJsvjv0KhLAZWHKM6uukpx+jM1O+rykBQPar
         vu3JFQlSJ4ku/xNV+kiItaGkzrz3VKLUdGAkXoEmVDvhr5/FELDTg0uKx7DngvT7paMD
         mA4E/QVHOyNlklM2T1IS+feD0a+rj8IPvb8x0Lu3L6/dPa3ZYyAscEKOi+Zwce/Dp7al
         sYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302814; x=1712907614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJrpsii5KxAd/+yN0rzfHDl19GAcoZcZzgV5GRtFABE=;
        b=sdgyQIPk5s7zoQEgEdBhnvR5nR23AKz5Ir4RM9+psneCJPqwfzieAnlfJj86oodyAw
         mOqEceSA964tjGGbxsoU7nDtzHx9DjRKpxz3ucHCmxaBVVbs8AvC/FBFJzmIqM41Tr+p
         5FLdJBk96TGhlsNvjEsyPNpgfY5NNtuCXjqvotyA/G/I0+Fdo3yFKT6htseW27kG2NQy
         +r/rmrwBlF6CRH4jlmg8Nfti+Ngddur8hU7GhZQO3jSCgbnuTVhbOhTMYqukaNnX8CdM
         Z38ukd944+iYFEQpD/sXSKJPRe+hP9laG2/frPiHBSw4zW2JQjbS8WP2uSAQHjtI7uGz
         B6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs9jWRFRzN/VpQd6GeKue8k6PLddQQtIA+QLfKERGGaqxOcDTpcZlBrsXO6RzvVuV354S5BVLwzYREMNO0amPssKBkbLROFDnQ73Hk
X-Gm-Message-State: AOJu0YxzmCBd4ZG7O6bDi9RyNxXiH5tFG377VWfdwTHOxQY6UXXhNZCO
	sM1UPKrQR1vPb5Z2WIVCcnylw0/AemdZQmr3Lx/7GGoHcof0SZhP
X-Google-Smtp-Source: AGHT+IEaEi2jQPgVCrw/T+VlZ/QJsDFrDO0tljJfL2LpyogJgEVc50Wraut/Somejqvdw6J/VSQQMw==
X-Received: by 2002:adf:fd91:0:b0:343:a8cb:7990 with SMTP id d17-20020adffd91000000b00343a8cb7990mr616644wrr.29.1712302814528;
        Fri, 05 Apr 2024 00:40:14 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:14 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
Date: Fri,  5 Apr 2024 10:39:57 +0300
Message-Id: <20240405074000.3481217-5-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Distinguish struct device type instances from dev_t instances
to enhance readability.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 208c0c6d3649..62ce75b07bf0 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -53,7 +53,7 @@
 #define FIFO_THRESHOLD	15		/* bytes */
 #define NUM_DIO			2
 
-static dev_t pi433_dev;
+static dev_t pi433_devt;
 static DEFINE_IDR(pi433_idr);
 static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
 static struct dentry *root_dir;	/* debugfs root directory for the driver */
@@ -1262,7 +1262,7 @@ static int pi433_probe(struct spi_device *spi)
 	}
 
 	/* create device */
-	pi433->devt = MKDEV(MAJOR(pi433_dev), pi433->minor);
+	pi433->devt = MKDEV(MAJOR(pi433_devt), pi433->minor);
 	pi433->dev = device_create(&pi433_class,
 				   &spi->dev,
 				   pi433->devt,
@@ -1276,7 +1276,7 @@ static int pi433_probe(struct spi_device *spi)
 	} else {
 		dev_dbg(pi433->dev,
 			"created device for major %d, minor %d\n",
-			MAJOR(pi433_dev),
+			MAJOR(pi433_devt),
 			pi433->minor);
 	}
 
@@ -1398,13 +1398,13 @@ static int __init pi433_init(void)
 	 * that will key udev/mdev to add/remove /dev nodes.
 	 * Last, register the driver which manages those device numbers.
 	 */
-	status = alloc_chrdev_region(&pi433_dev, 0, N_PI433_MINORS, "pi433");
+	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
 	if (status < 0)
 		return status;
 
 	status = class_register(&pi433_class);
 	if (status) {
-		unregister_chrdev(MAJOR(pi433_dev),
+		unregister_chrdev(MAJOR(pi433_devt),
 				  pi433_spi_driver.driver.name);
 		return status;
 	}
@@ -1414,7 +1414,7 @@ static int __init pi433_init(void)
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
 		class_unregister(&pi433_class);
-		unregister_chrdev(MAJOR(pi433_dev),
+		unregister_chrdev(MAJOR(pi433_devt),
 				  pi433_spi_driver.driver.name);
 	}
 
@@ -1427,7 +1427,7 @@ static void __exit pi433_exit(void)
 {
 	spi_unregister_driver(&pi433_spi_driver);
 	class_unregister(&pi433_class);
-	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
+	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
 	debugfs_remove(root_dir);
 }
 module_exit(pi433_exit);
-- 
2.34.1


