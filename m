Return-Path: <linux-kernel+bounces-122876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C188FEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D70294500
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684797EF0F;
	Thu, 28 Mar 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK+ihdK6"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A17F7C9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627980; cv=none; b=jjjT+PPsmjYnDDntht0qc3A/p2A3XSsClgIsQsqzUPUxpGSAlYPJzSmvgaAT/AZ/5AwA+K3C3JV4JsFa9XMQEaJ+VjlekZAfFxR19ySIN7XvvZRTeEqRYMVbCRsRcYHdDwnchkEkdd7obQ7G/n9exFDzSVcepJwNm94kycpAVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627980; c=relaxed/simple;
	bh=HjRvMGXjDbwDSvM16WAhK4wPegt0yyIWO/1j4Z95mjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqOYeEWUgyFvmO1BW8MwjqmoS+cpEUZVKqs0bTXc3IlZH3va/3KLtS0S45x2RAZJU5RIJEf3jWHUPVAAFH7kfkStYcBQABvwM2vHLz/RKYy8WXV7iIpM0oqjTMGtWUUo/idRg69ABMw6i3Oz6nhDI4TJcpvvO4NxHXJaEDsD1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK+ihdK6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so12378711fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627977; x=1712232777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJrpsii5KxAd/+yN0rzfHDl19GAcoZcZzgV5GRtFABE=;
        b=aK+ihdK62WQ4eoPmO3inUqzsuBDDAS9Vjj/leAv1+8nXiV+nbwkmopf3nbIDtyAl6i
         YNVD5vhQwKhh08SRDb+67zCbMi3g+8JgLVjudejemzle4i7uQ0TjNa8FlU74Ef6Ib/QK
         Ax7Tk7qCEgLI51kZhzwEG1pKtXT3SoCTJdBbyiFh/5CpCinK6RI0v1ewfzqhKYZ/vxtk
         Mo7WK56f9Xb8R+p0Tig39bH2OiQpEttcTRsKXElw1BfjfNcr7mWZym2nY9uRvGIczNbM
         y62etIpCdpOy67NERi0iqKF9exEae7uLnQ9UBM8iw5SuKOFfSL79ZQa+PRxv+tgnBcQH
         yu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627977; x=1712232777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJrpsii5KxAd/+yN0rzfHDl19GAcoZcZzgV5GRtFABE=;
        b=qRrnp6XxrFC0mR0vfaqnIcOL7Ozb85UM0XXTr6lwJatHUs9HY3K7n0IhR/NC3DLNaC
         itentpfFjpcVpUsHgFXVk5r5/bmPoPKr2P0ST+PCD+4vkZ9gbBJClUySHkyniPS2WDDG
         jtOFOPtQQ8OADPX9JX6kZyZNzTqAhjplBWAix4rrAW6Gr+04LRsb6IP00/dvGQzGtYLa
         yUVD/z4yXqm6oHiWfdhKVqj0t9HbkfkC55wkWc6SvpgBioKoa16lSYzNHtb0Dh4rxwXm
         gaJKyGuBFGUt84Ufu1A7vSLJjh4BYkaBTTMXLNpmHUt0EHkZkx1UOvFcxR8QaOY5I9iB
         0QkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsyu0+wblMoq3Ll5bAc0Z7xFoH/SLpPp3FmB4PZWm2vYSK39EI3i8Uk1Mwt24wQFe2qa//oOTJN7KKnejdZcywtpcam64Rg4h5XA0q
X-Gm-Message-State: AOJu0YwRK88tPO0Js9KTN3kEIlpkGcbK/rpvndg6C9Jr4Mgwkpz9dPNy
	0PSQPoMv+2uBprZnOUy1C8Km8i3P/4jKbsxh5+Qtwxq7P8XT1MsD
X-Google-Smtp-Source: AGHT+IFn/MiTHHRnQAcKDrcHrGTaSrb+CJwCaYVf1XK0ugL/wrsGsugJZad0dPF/R2zRCJqERrTo0w==
X-Received: by 2002:a2e:990a:0:b0:2d7:fbb:8276 with SMTP id v10-20020a2e990a000000b002d70fbb8276mr223321lji.44.1711627976886;
        Thu, 28 Mar 2024 05:12:56 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:125e:963c:4e4b:b7c5])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b00415460a63ebsm1416456wmb.29.2024.03.28.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:56 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
Date: Thu, 28 Mar 2024 14:12:43 +0200
Message-Id: <20240328121244.1244719-6-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328121244.1244719-1-ikobh7@gmail.com>
References: <20240328121244.1244719-1-ikobh7@gmail.com>
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


