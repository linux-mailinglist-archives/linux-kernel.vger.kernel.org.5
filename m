Return-Path: <linux-kernel+bounces-2288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8E815A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B13285BA3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159A30357;
	Sat, 16 Dec 2023 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NbZWaK33"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A103034C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id EY0pryseOIOhHEY0prH1vA; Sat, 16 Dec 2023 17:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702745980;
	bh=gMk6oO0NWua7+I1geY3QhXhIuX72nIXC65+3OnaHd6U=;
	h=From:To:Cc:Subject:Date;
	b=NbZWaK33+MieCc2Fvs6kEZTUXhQ7Hxm7bgyD9XSl4LF2QdGjMahfX5Vy7ZnGAOY9N
	 OSjvbaIzYsS2uoQ48s65kS6iraZrGTdQLOUVksR0YFnis5FfYr4MJhNBYY30BsZ3Cm
	 gT/1gElgjCEUpEH8UVkmhfhA6YSdtOEeDcYYt/8ZSSFsLN+WhZApYqN3PkdansG7Ge
	 YhKmzMm44LCp7RnDzr0N1rGqSt0NayKY3pc5eEnTwCIQEmS/62PxhZR49jspOobN/S
	 O9WBuPi2r8c6rWALwllhDlNxlPuDA62B+wWF86TyuvNGzNgtOIFFADP9x/U2sHOb56
	 pJNQEWzlGj8ew==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Dec 2023 17:59:40 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	chrome-platform@lists.linux.dev
Subject: [PATCH] platform/chrome/wilco_ec: Remove usage of the deprecated ida_simple_xx() API
Date: Sat, 16 Dec 2023 17:59:38 +0100
Message-Id: <898d9aa181a84f1d17725ca047004bad532c37e9.1702745959.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/chrome/wilco_ec/event.c     | 4 ++--
 drivers/platform/chrome/wilco_ec/telemetry.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index f80a7c83cfba..13291fb4214e 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -495,7 +495,7 @@ static int event_device_add(struct acpi_device *adev)
 free_dev_data:
 	hangup_device(dev_data);
 free_minor:
-	ida_simple_remove(&event_ida, minor);
+	ida_free(&event_ida, minor);
 	return error;
 }
 
@@ -504,7 +504,7 @@ static void event_device_remove(struct acpi_device *adev)
 	struct event_device_data *dev_data = adev->driver_data;
 
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
-	ida_simple_remove(&event_ida, MINOR(dev_data->dev.devt));
+	ida_free(&event_ida, MINOR(dev_data->dev.devt));
 	hangup_device(dev_data);
 }
 
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 253098bace63..b7c616f3d179 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -372,7 +372,7 @@ static int telem_device_probe(struct platform_device *pdev)
 
 	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
 	if (!dev_data) {
-		ida_simple_remove(&telem_ida, minor);
+		ida_free(&telem_ida, minor);
 		return -ENOMEM;
 	}
 
@@ -393,7 +393,7 @@ static int telem_device_probe(struct platform_device *pdev)
 	error = cdev_device_add(&dev_data->cdev, &dev_data->dev);
 	if (error) {
 		put_device(&dev_data->dev);
-		ida_simple_remove(&telem_ida, minor);
+		ida_free(&telem_ida, minor);
 		return error;
 	}
 
@@ -405,7 +405,7 @@ static void telem_device_remove(struct platform_device *pdev)
 	struct telem_device_data *dev_data = platform_get_drvdata(pdev);
 
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
-	ida_simple_remove(&telem_ida, MINOR(dev_data->dev.devt));
+	ida_free(&telem_ida, MINOR(dev_data->dev.devt));
 	put_device(&dev_data->dev);
 }
 
-- 
2.34.1


