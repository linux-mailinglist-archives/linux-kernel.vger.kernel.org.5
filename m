Return-Path: <linux-kernel+bounces-92268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AA1871DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC79228A1FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562985CDDF;
	Tue,  5 Mar 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="D4MduaE/"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383E5CDC4;
	Tue,  5 Mar 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637951; cv=none; b=mqugLtr0DjHMBGr4RAe2P8Iy3qK5snScClIDAvED5jikfemZJM2TtzxGeervNyfwBbAoXnFs5BP3JTgEbhKnFe24V/wYW9h4WnPLO2tCU6xOdKczpDf2cRiAfEF3kvAu3oVPmM2OqYua77R1Tz/B9BG45e2lxzTQspD/hrzJk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637951; c=relaxed/simple;
	bh=fccvHDlP2wGkwZu2PUac398IZ8tFoVKsOKr4Pv++MoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDJC+W29WQrt6rVvWtptKJN8VtspJgOMukvdLRs0sz2vROrQRll71VVzL5XdIV7S+yfPDffyHEFRyd4feRGId+X8KawLxtvPGgPU0rFsiHOt3LRXTZqoH4djHoWh+J/gxPniQJVcuf3xxXxtm13WEIp4eFcCPuUtSKwdHoU6lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=D4MduaE/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e56787e691so4499182b3a.0;
        Tue, 05 Mar 2024 03:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637949; x=1710242749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48ofsqw6uAaMpuoCiWg7AyYGybcH87o6g1a3Dbc0CJY=;
        b=M0gjPJh8t6a9t5Uo7aEQWpU1oQGcXv9rtQUodCaP1fyZoj4UB9TNun0y+9x/2KnDxl
         eiNh5BvjZrs6gX5j/K9c0UaUL2kPmJTtc/XTlRzN0LXhACv2KXekzcTLfBXBCGj1AHBt
         GMU7hsI+F5/1bF36fb7XPOo2ytMbAcQnX4+BS8qBk0qONoVy3rb9EpGEru8K6QpNPAGj
         C4ggLxh5fG7HzZe3Tj/xveGSCeWulG/08MnlbDjbCRYgtVRcHGacBdhvySfaQS9Dw7fR
         5qphlU1RhLdy/hKegKDHY+VG25V+Ot4oGZXv6mCtXv35UCjn4cLoLStkw7fCt795t9XO
         3l6g==
X-Forwarded-Encrypted: i=1; AJvYcCXsRDIIYiWLZUrz0lKYvj/BvFZ3I+lHnWfDpsF2yODpzNYGcEPGPxL7TVFHL60zv3o8+CVp/cs9YgvqBz1SyOlrTSiuGfzACa5ixVB2
X-Gm-Message-State: AOJu0YyX8PAe13swBJoiUV2TEIaJE9lD5bSuYsNwqrdC7/1yPxDqoxtr
	waWSBA+2WIW0Cm1//kfTQBH0WjhbRs3E9R0MW+mtOXe/B5oEP5ef
X-Google-Smtp-Source: AGHT+IGf03T5X1314IqmwZvRjWw4z3cLwUPQZU3un2nNv2kbDfpL1iZLCpIpwfOKR4nuV6rnfD7mvQ==
X-Received: by 2002:a05:6a20:158b:b0:1a1:e41:3edb with SMTP id h11-20020a056a20158b00b001a10e413edbmr2105606pzj.11.1709637949238;
        Tue, 05 Mar 2024 03:25:49 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b006e58da8bb6asm8093787pfu.132.2024.03.05.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:48 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48ofsqw6uAaMpuoCiWg7AyYGybcH87o6g1a3Dbc0CJY=;
	b=D4MduaE/LUyvc9Zqaz8eGkUi8N/vH6Ugwt7wUZITQJWkPeD7ulb3utI8e1I9Ui9EeB4W38
	1Z7kgbANTbTKbwreHnOCYeruvcCur6ggav8PnJP78z7xyQaezBGOrmvk4UudnmhcvL81nC
	YV46CZJCwQL5vzHVxpTZD9nDp3ZD8StJoRA4uzPdJM9+/ofMBamFir8OZWc/9h+Llfi3kI
	CzlVe/GvAU325INn0zhc5MKoviSI4EhxkNvR/O8R7Nro57joX/T7IB0YppHd5NUf9bJ0rb
	FSNUcHU2PDrXzqHJBrkV4Dug9b9e9/PDSZF5tNX8Pm2XXs5K11yAwm8wcB+byg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:25:24 -0300
Subject: [PATCH 6/6] s390: raw3270: make class3270 constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-s390-v1-6-c4ff1ec49ffd@marliere.net>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
In-Reply-To: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
To: Harald Freudenberger <freude@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3662; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=fccvHDlP2wGkwZu2PUac398IZ8tFoVKsOKr4Pv++MoI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEhFlxuWtMsVrh4RgujSRXzUXXQuBbvxzFXC
 /mNEDVhuOGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIQAKCRDJC4p8Y4ZY
 pig+D/9YdkQCwCoWzIvQ2HiHdeg4Yd6ZmJAwSEKE5sEzEhAWxFolNU1wf5IHnhoHJkZnLgKiT16
 40CVxEKPYy9rmSwbkShM+g7ME8cZsNFli3biyBQtnMKRgeBpE/2NE5QrkL87z4aSa2ySrYgF3y+
 FdkDaT38Fdbk9LE/6liOOz+nO6GRpOgIrYERTnw157VtYIdFVwaJ4DmvjSCP+XtQ5Aa8obXcqI/
 cOA1wlW7k+ecNtws1Ae9LQiLkITq2yzEn9w8Kvhqae+AOzkBNdksz3mCiWBkdrDmHz2I9D9m1rC
 IZXLrpqRZiZk4S3c0FiPDEhLLwWHVdU1Iz+ZRu6On7xKWsM1tVzI+J6arcXGb8iWBMfjGZsLCGr
 kgrfm89LlEiwBpfERE/d46qHzYIqQM2/RAB5h3mv5t+MBACkWrdChQoiig7OXROUOsWb46Zp1kB
 ULK0VgcjcalD5hOUwNuJraypMCDJJIi5/P0K2opPB8Gaq752kXMQ3g0xZ8av7Gs1Z2+UkVQfImJ
 Gg5/1hR/XgTVDeNJ5VaSdO0dqvQIP8t7PyQeccBEISarlK74A8jH1mY7aD5urQP1OmPJCxhrYxs
 LlNv8QXOxDRYc8ajnjJp+PB3w51CYf8v8ISsBRD1WJkOLo/KG1iwD7UyNiWpuIWlmbQqqRU4Kpt
 eR4aJAkHsWOvoEA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the class3270 structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/char/fs3270.c  |  8 ++++----
 drivers/s390/char/raw3270.c | 13 ++++++++-----
 drivers/s390/char/raw3270.h |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 4f26b0a55620..f83ec248e68e 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -521,13 +521,13 @@ static const struct file_operations fs3270_fops = {
 static void fs3270_create_cb(int minor)
 {
 	__register_chrdev(IBM_FS3270_MAJOR, minor, 1, "tub", &fs3270_fops);
-	device_create(class3270, NULL, MKDEV(IBM_FS3270_MAJOR, minor),
+	device_create(&class3270, NULL, MKDEV(IBM_FS3270_MAJOR, minor),
 		      NULL, "3270/tub%d", minor);
 }
 
 static void fs3270_destroy_cb(int minor)
 {
-	device_destroy(class3270, MKDEV(IBM_FS3270_MAJOR, minor));
+	device_destroy(&class3270, MKDEV(IBM_FS3270_MAJOR, minor));
 	__unregister_chrdev(IBM_FS3270_MAJOR, minor, 1, "tub");
 }
 
@@ -546,7 +546,7 @@ static int __init fs3270_init(void)
 	rc = __register_chrdev(IBM_FS3270_MAJOR, 0, 1, "fs3270", &fs3270_fops);
 	if (rc)
 		return rc;
-	device_create(class3270, NULL, MKDEV(IBM_FS3270_MAJOR, 0),
+	device_create(&class3270, NULL, MKDEV(IBM_FS3270_MAJOR, 0),
 		      NULL, "3270/tub");
 	raw3270_register_notifier(&fs3270_notifier);
 	return 0;
@@ -555,7 +555,7 @@ static int __init fs3270_init(void)
 static void __exit fs3270_exit(void)
 {
 	raw3270_unregister_notifier(&fs3270_notifier);
-	device_destroy(class3270, MKDEV(IBM_FS3270_MAJOR, 0));
+	device_destroy(&class3270, MKDEV(IBM_FS3270_MAJOR, 0));
 	__unregister_chrdev(IBM_FS3270_MAJOR, 0, 1, "fs3270");
 }
 
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index acc4cb37a9d8..8e9868581e0a 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -29,7 +29,9 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 
-struct class *class3270;
+const struct class class3270 = {
+	.name = "3270",
+};
 EXPORT_SYMBOL(class3270);
 
 /* The main 3270 data structure. */
@@ -1315,13 +1317,14 @@ static int raw3270_init(void)
 	if (raw3270_registered)
 		return 0;
 	raw3270_registered = 1;
+
 	rc = ccw_driver_register(&raw3270_ccw_driver);
 	if (rc)
 		return rc;
 
-	class3270 = class_create("3270");
-	if (IS_ERR(class3270))
-		return PTR_ERR(class3270);
+	rc = class_register(&class3270);
+	if (rc)
+		return rc;
 
 	/* Create attributes for early (= console) device. */
 	mutex_lock(&raw3270_mutex);
@@ -1337,7 +1340,7 @@ static int raw3270_init(void)
 static void raw3270_exit(void)
 {
 	ccw_driver_unregister(&raw3270_ccw_driver);
-	class_destroy(class3270);
+	class_unregister(&class3270);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/s390/char/raw3270.h b/drivers/s390/char/raw3270.h
index b1beecc7a0a9..5040c7e0e051 100644
--- a/drivers/s390/char/raw3270.h
+++ b/drivers/s390/char/raw3270.h
@@ -14,7 +14,7 @@
 
 struct raw3270;
 struct raw3270_view;
-extern struct class *class3270;
+extern const struct class class3270;
 
 /* 3270 CCW request */
 struct raw3270_request {

-- 
2.43.0


