Return-Path: <linux-kernel+bounces-92825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109E87268A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C73287642
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2718C38;
	Tue,  5 Mar 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="pwH1+BqZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008D17C6E;
	Tue,  5 Mar 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663316; cv=none; b=SuL4Kv9+dAlN5HnPlyUCqiefBkjxTi7NhL02xAIgveYA7f5YyONb35gzz0yodqC4fPgbn6M5QVMNDP+10/s5cZEuqy7gpHDM83WXgxwo93/EeSPP6h0+j5+HhZPSyIuru0zIWTP82/4CN5Q0yIjsx4/lmxGaPf4yfBanGevKEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663316; c=relaxed/simple;
	bh=Wd4nB97WkmnQ07iPZrl3fmBvoORgOZueRs6Tmd0rsew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HItcEFzlIwkEmm25HSjs0/6GawWuTptKzS2ojoBDq/Jb7Evg3QA56dZD+4mgP3Zu3Q8yEXS9c8Ev2OgxCx9ux4l7Gssxo/uo1kXDKH5LkPv7ddxJqs75U2bqX6XIrM2adphwAAJbJ9y32LmqaIMxMqfUfJceuhcKyRV9DyHlG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=pwH1+BqZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc75972f25so50230335ad.1;
        Tue, 05 Mar 2024 10:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663314; x=1710268114;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIZGrDIx2HNqEOfNMffH0xGrL4BRDNdW8vcMfCZGuqA=;
        b=RHEoEMExKYqa6b2y0xf6kqWKYVLX+W9m4z1Au0Ui4NzQRxz8ZTR/R8MgWbWfcNKDCo
         oDqYlI+4GCT/iiedv0swLP9G+clsZ9NsONa4zV4y6tY48xZXzeX1KRFutJaL1xvkUW73
         3OA2jZK5mrOk2bNH222sDHiBPLYCQ/wUCGpyGCgeQDcMPLzTE4ZGJK6Z5PmU+Ui5GJ1b
         D8jhOccb5+l1dD5fXDLVcO5wBk4shpU5zC83h4hEFOfm0XeQtjciO46uQCkNUjKI09Hg
         r3Hgo56OhKRS8MloD3dWF7EmiBEuf+fuV5eJHhzOnO2B1ko6iNSHzzoB/O80i6J1vRTg
         uUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwdYxc2ScYcTIyQ2VtPpvMS/4Up8w0yMLvSk4ZGyGYPd5F+dvcjggr3RKLEhDn9tZApBVqvZBuEdtvbPYErQob4HrnDsdVxQLyTRYp
X-Gm-Message-State: AOJu0YyaO4fH6OYWOGpc5625xrMPC7wG9CxMMv7xBl3+J1QdIyT7Si0K
	lihz9hBESNste8nAN+8oL+6ragJu6TkryNeyPwZuY77xURfoHEjdT0VyqkxWFB05bQ==
X-Google-Smtp-Source: AGHT+IGHZ4XLby3hLCKJ+4SQBWbDIl7QfHNqESZkAKfONGXTP0VxURy0xn8c+2eMS+y8x154rDPnIA==
X-Received: by 2002:a17:902:d503:b0:1dc:696d:ec6e with SMTP id b3-20020a170902d50300b001dc696dec6emr2818551plg.21.1709663313735;
        Tue, 05 Mar 2024 10:28:33 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001da1fae8a73sm10868975plg.12.2024.03.05.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:28:33 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709663312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EIZGrDIx2HNqEOfNMffH0xGrL4BRDNdW8vcMfCZGuqA=;
	b=pwH1+BqZvZEE2iKZkZ43z51F7qC9yDhes8lb/GHYHolxhALKv6pB29sRZIYyTtPseuuSGB
	86fmk0ATNcOUe0U3NNvOttx+moQhuxoDSPbCNYkk/pxsuZ5Cub8VQyxHkJ+Bq5EAAPSYxK
	ejQX9uRypsZWFKrSP1IGsrBZ3itAi8ByrolsSJN7cHLibUq49J1gsy6a6SGw73uVSpK+qN
	+y0dCI7F2Vh/GgaRbB6Ew0W49+uLiZNIo8FReCnwKVccIiJExk0oM8aCRxdDpu5VzjdEEe
	wv4Ww38Oo/z4b90vK0UxArAiRG3qvnpDYmSBVXJCSGJ+TjUuQydRz78mbSp0GQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 15:28:27 -0300
Subject: [PATCH] rpmsg: core: make rpmsg_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-remoteproc-v1-1-19373374e003@marliere.net>
X-B4-Tracking: v=1; b=H4sIAEpk52UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3eScxOLi+OSc1MS80gLdotTc/JLUgqL8ZF2jJFPjVCOzJCMLQ3M
 loPaCotS0zAqw0dGxtbUAalgqj2oAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3570; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Wd4nB97WkmnQ07iPZrl3fmBvoORgOZueRs6Tmd0rsew=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl52RNPaIJYQfc/KxQT5kyuo9oXac67GDElBqFC
 evHdK2QrqyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZedkTQAKCRDJC4p8Y4ZY
 ps9MEACrt0gbXM+ZWC3lrBLVvrmhKKzqvy0LwtdszQLbJN3fQm9CbVTsqpKLyssFRZDg4d54MQd
 1VAAn8Uj9TznLFOErvVl/E4KKZxupHbikT7FI9rHJAomdXZaxUKW6CbKSOiu99Ce5BQhc5fwQML
 OnpijHFbbUp8sZgxuy/nSACxoa7kPXlY7GfAVyABjBfaqIvYyOLAoBThzzoFYsaFRxHmDpGJYmG
 VItSbtUAWrd4J5ERFxUKWA0Mbj9F/zr1D5ZQiRBDImcjmf44Udh3I43t1IcuxYnwDygfxNzmTim
 HmmlY6SaODqP7rnZrvQdUbCl/kf3YElfref5UVEtWWLjNw/+ocjcfqD8S616sLLyi028dmZasR1
 2SBQ/xFZiK7vvgnkrQ7HIHs+8HK/dH5gDteaKDDJI6WDJO46uCOGlQNe532YYrNH2+xb3ueufVw
 tzDPvVjvUiTUF8QkcoXC4REMtmFzr5NbtyEmPpS/O25NoRZSWbEaUYby3kuSPjBXeUNr4nJgrJm
 oUhsnFis14G0/Hm+06P2Rc9hDxXVxlIzZ9fHnCHcR02hAQTeq+olLABovufEbyLHbgSA75wuUNZ
 bEmlW8Juo3JlIoLeXo2WH+zWmk+IdrFrBJbGSMZLg0yALzy3+ESuBcXbgDdE40ji3LSCRE4Q3B8
 W8hObVKTKXB53gA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the rpmsg_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/rpmsg/rpmsg_char.c     |  2 +-
 drivers/rpmsg/rpmsg_core.c     | 16 +++++++++-------
 drivers/rpmsg/rpmsg_ctrl.c     |  2 +-
 drivers/rpmsg/rpmsg_internal.h |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 1cb8d7474428..d7a342510902 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -423,7 +423,7 @@ static struct rpmsg_eptdev *rpmsg_chrdev_eptdev_alloc(struct rpmsg_device *rpdev
 	init_waitqueue_head(&eptdev->readq);
 
 	device_initialize(dev);
-	dev->class = rpmsg_class;
+	dev->class = &rpmsg_class;
 	dev->parent = parent;
 	dev->groups = rpmsg_eptdev_groups;
 	dev_set_drvdata(dev, eptdev);
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 4295c01a2861..0fa08266404d 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -20,7 +20,9 @@
 
 #include "rpmsg_internal.h"
 
-struct class *rpmsg_class;
+const struct class rpmsg_class = {
+	.name = "rpmsg",
+};
 EXPORT_SYMBOL(rpmsg_class);
 
 /**
@@ -715,16 +717,16 @@ static int __init rpmsg_init(void)
 {
 	int ret;
 
-	rpmsg_class = class_create("rpmsg");
-	if (IS_ERR(rpmsg_class)) {
-		pr_err("failed to create rpmsg class\n");
-		return PTR_ERR(rpmsg_class);
+	ret = class_register(&rpmsg_class);
+	if (ret) {
+		pr_err("failed to register rpmsg class\n");
+		return ret;
 	}
 
 	ret = bus_register(&rpmsg_bus);
 	if (ret) {
 		pr_err("failed to register rpmsg bus: %d\n", ret);
-		class_destroy(rpmsg_class);
+		class_destroy(&rpmsg_class);
 	}
 	return ret;
 }
@@ -733,7 +735,7 @@ postcore_initcall(rpmsg_init);
 static void __exit rpmsg_fini(void)
 {
 	bus_unregister(&rpmsg_bus);
-	class_destroy(rpmsg_class);
+	class_destroy(&rpmsg_class);
 }
 module_exit(rpmsg_fini);
 
diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index c312794ba4b3..28f57945ccd9 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -150,7 +150,7 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
 	dev = &ctrldev->dev;
 	device_initialize(dev);
 	dev->parent = &rpdev->dev;
-	dev->class = rpmsg_class;
+	dev->class = &rpmsg_class;
 
 	mutex_init(&ctrldev->ctrl_lock);
 	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b950d6f790a3..a3ba768138f1 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -18,7 +18,7 @@
 #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
-extern struct class *rpmsg_class;
+extern const struct class rpmsg_class;
 
 /**
  * struct rpmsg_device_ops - indirection table for the rpmsg_device operations

---
base-commit: b03aa6d4e9a74c4289929b6cf3c6bcc80270682d
change-id: 20240305-class_cleanup-remoteproc-2b53e26b2817

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


