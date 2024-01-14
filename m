Return-Path: <linux-kernel+bounces-25434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D489182D038
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F6D282643
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D31FDB;
	Sun, 14 Jan 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LBwRvL1l"
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2F1FAD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id OxRbrry6VIwxKOxRbrHroW; Sun, 14 Jan 2024 11:10:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705227021;
	bh=52Rd6d5faJ4c/W4ztruf+D+m4SC9RWyWzcn6xVRATJk=;
	h=From:To:Cc:Subject:Date;
	b=LBwRvL1lmo0J+pYr4CMZ064bd7yJzvGgTeJOFdtg92EgWa4i4z7dxsTO5VG9H6C2j
	 ISGyBX7ioUXQY+4pExpZy2tlMVuts4NGOtwM8nv/YY4SlZ5g+bXNcpduc2PLWcYOMJ
	 5CCrQfag8OM1kmKnGPodNse+LY+TS+1rPJfBGC5SMbx5YH/NNrRWFvgc3h7Xpk4Mia
	 h9BD8vwIIQDUqEJmGwef4VjnkVFi42t3xhxVUurV/83flw+OhEv33ViGVABXJh/O2C
	 c8t2ujbqS1R/gP8Q9Xy3rEBtIFxtwStUCM80AG99exOk0IkAR1s2YXlhD19Og0DIrw
	 zFliSMuH3cYxQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 11:10:21 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sven Van Asbroeck <TheSven73@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: fieldbus: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 11:10:15 +0100
Message-ID: <d305b97b1064ba7e026232fb8c2a0783ba1b1098.1705227001.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 6 +++---
 drivers/staging/fieldbus/dev_core.c            | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index 34d18b09bedd..fcd3e3722ae0 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -285,7 +285,7 @@ static int controller_probe(struct platform_device *pdev)
 		}
 	}
 
-	id = ida_simple_get(&controller_index_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&controller_index_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		goto out_reset;
@@ -318,7 +318,7 @@ static int controller_probe(struct platform_device *pdev)
 out_dev:
 	put_device(cd->class_dev);
 out_ida:
-	ida_simple_remove(&controller_index_ida, id);
+	ida_free(&controller_index_ida, id);
 out_reset:
 	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
 	return err;
@@ -330,7 +330,7 @@ static void controller_remove(struct platform_device *pdev)
 	int id = cd->class_dev->id;
 
 	device_unregister(cd->class_dev);
-	ida_simple_remove(&controller_index_ida, id);
+	ida_free(&controller_index_ida, id);
 	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
 }
 
diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index bf1812d8924f..370a229443a1 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -247,7 +247,7 @@ static void __fieldbus_dev_unregister(struct fieldbus_dev *fb)
 		return;
 	device_destroy(&fieldbus_class, fb->cdev.dev);
 	cdev_del(&fb->cdev);
-	ida_simple_remove(&fieldbus_ida, fb->id);
+	ida_free(&fieldbus_ida, fb->id);
 }
 
 void fieldbus_dev_unregister(struct fieldbus_dev *fb)
@@ -267,7 +267,7 @@ static int __fieldbus_dev_register(struct fieldbus_dev *fb)
 		return -EINVAL;
 	if (!fb->read_area || !fb->write_area || !fb->fieldbus_id_get)
 		return -EINVAL;
-	fb->id = ida_simple_get(&fieldbus_ida, 0, MAX_FIELDBUSES, GFP_KERNEL);
+	fb->id = ida_alloc_max(&fieldbus_ida, MAX_FIELDBUSES - 1, GFP_KERNEL);
 	if (fb->id < 0)
 		return fb->id;
 	devno = MKDEV(MAJOR(fieldbus_devt), fb->id);
@@ -290,7 +290,7 @@ static int __fieldbus_dev_register(struct fieldbus_dev *fb)
 err_dev_create:
 	cdev_del(&fb->cdev);
 err_cdev:
-	ida_simple_remove(&fieldbus_ida, fb->id);
+	ida_free(&fieldbus_ida, fb->id);
 	return err;
 }
 
-- 
2.43.0


