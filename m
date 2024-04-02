Return-Path: <linux-kernel+bounces-127837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB9895190
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AA61C22014
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63737764E;
	Tue,  2 Apr 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWoqk8U/"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7974262
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056476; cv=none; b=IjGXd6kfATbqE6oxmHK9bpzZMF3gLhaOhEnhOGg2MplvumKcSe5h081H+hHk/YGYUcLTg4owLjyqJnREFWQknjNDJJiPXToOpgdAObqCmuELySB5z3sq2BYXnJ0jGp/XkZgCkoDcv+odoyIbMZpVLbtLYT/iY9J9MfmF8tqN+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056476; c=relaxed/simple;
	bh=gcpheDANWK19woUIfqj/fVqHsx2og6+K7UySgK3tvLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQcBlKf3DewthVQ0p8GlqJMsX2SYknr9berooGdd8EXM4zFGL14ehxKYn1vmEQiliJ61/B72pF7tFa205X9lejjBdAZsdyclG9TP2UH3YkhL9LwRE/iywPAEyo2GSV2FUrHfNL4M1zel0nCN/UDqOPQ4urPfv3EqmglB76OWwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWoqk8U/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-698d68337a8so24905236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056473; x=1712661273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVb/UGONQyBT+z/L6u7Z9rLkuNJQKGw42waV76KdoHg=;
        b=UWoqk8U/YTErv1PDWykdc4GQKVe99ETTFHRrWl41cJ4kN9MOtZX3DQUXIUhDeUGK1e
         68Wq/A7AHYJ9Uy0SjJVYnPJvXqrFD8+kggpCBtmog+stWn8plZMkTM7fX2A6U0IWtk2P
         yBs2r0l/mL+sIKMd/KD7j/krTqJedACrV6SmSEmPAvgT8dfdONfh3raMPV1tKeV2ftO0
         0DIz2MsTd6kw0dn6zSO7VVq+88uR/r4NWoNsOWDjiwoRiWghhk/7RWP3SLyrluE1f2Yg
         yVcesFjVSC4Uuyo3/62fthPv+8zy5/uAcKmoLoQ3az1LA7VU5cCqmiBrNCvxdB5z7IyR
         qG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056473; x=1712661273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVb/UGONQyBT+z/L6u7Z9rLkuNJQKGw42waV76KdoHg=;
        b=E983rk4KnCY79PUWK/LAMumz09LkTqR00Q9zY7FkEBk1Szk0y5S2H2m+Wbse0SPhce
         4WACedDyaYCjtrr8GkJn4+2h0bXk0NkqDy319TnfGBTA2rb+fCE3vnLZrK2ojVzj+deG
         VqyXY3Xn4nv1QNqx5hvmusOcEzx0w6XY+7EPhdL53Dm/5h95io6EpPBhGTJxNgsQfYXc
         3yUKoFs4N+0aRmYb4qUkltVARcAZGWmB9QbHoMLVdBMGOyTpDcVJb7lgfBrd78oJtweC
         /RPJTCDOgy6J/4f3149Kzf6D3mhjDKkXQByOpCxUUkWPCfP9e+OHGcJEmXN3kx1q5ww8
         WqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVMH9rD4lz25B5qZtbVjfH1f97lIidP1Lyt6b+tei/BLYQ+VD16GadpkrUuHFmQQJzUV9+WqyW7wujRB37OY+hSn6AXEaRJVvT6sI22
X-Gm-Message-State: AOJu0YxOv8k6tujBbHjqli+bOk4jF2wh9xPV1B73cNjfrim9A209p5C0
	IpUi9SXnYk7msFbQnLYU61pCFjYLolJBvGgtrzVFsOGpBg07snqO
X-Google-Smtp-Source: AGHT+IERjMFu5RgQedji7m32aGiXlcLxDQOA+nmAxLDWEk0/x7zTg44X+OPQJBASf129EwgkdSYPFg==
X-Received: by 2002:a0c:e647:0:b0:698:6f2e:623a with SMTP id c7-20020a0ce647000000b006986f2e623amr13315711qvn.56.1712056473439;
        Tue, 02 Apr 2024 04:14:33 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:33 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] staging: pi433: Remove duplicated code using the "goto" error recovery scheme.
Date: Tue,  2 Apr 2024 14:14:13 +0300
Message-Id: <20240402111414.871089-6-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402111414.871089-1-ikobh7@gmail.com>
References: <20240402111414.871089-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pi433_init had "unregister_chrdev" called twice.
Remove it using goto statements.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
v2->v1:
Followed by Dan Carpenter's <dan.carpenter@linaro.org> comments:
        - Remove empty "fail" goto tag.
        - Reorder pi433 init & exit calls so they have reverse order.
        - Add "unreg_spi_drv" goto tag.
        - Check "debugfs_create_dir" return value.
        - Update "if" statments for consistency.

 drivers/staging/pi433/pi433_if.c | 33 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 62ce75b07bf0..47e0c51ffe2e 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1399,25 +1399,32 @@ static int __init pi433_init(void)
 	 * Last, register the driver which manages those device numbers.
 	 */
 	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
-	if (status < 0)
+	if (status)
 		return status;
 
 	status = class_register(&pi433_class);
-	if (status) {
-		unregister_chrdev(MAJOR(pi433_devt),
-				  pi433_spi_driver.driver.name);
-		return status;
-	}
-
-	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (status)
+		goto unreg_chrdev;
 
 	status = spi_register_driver(&pi433_spi_driver);
-	if (status < 0) {
-		class_unregister(&pi433_class);
-		unregister_chrdev(MAJOR(pi433_devt),
-				  pi433_spi_driver.driver.name);
+	if (status)
+		goto unreg_class;
+
+	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (IS_ERR(root_dir)) {
+		status = PTR_ERR(root_dir);
+		goto unreg_spi_drv;
 	}
 
+	return 0;
+
+unreg_spi_drv:
+	spi_unregister_driver(&pi433_spi_driver);
+unreg_class:
+	class_unregister(&pi433_class);
+unreg_chrdev:
+	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
+
 	return status;
 }
 
@@ -1425,10 +1432,10 @@ module_init(pi433_init);
 
 static void __exit pi433_exit(void)
 {
+	debugfs_remove(root_dir);
 	spi_unregister_driver(&pi433_spi_driver);
 	class_unregister(&pi433_class);
 	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
-	debugfs_remove(root_dir);
 }
 module_exit(pi433_exit);
 
-- 
2.34.1


