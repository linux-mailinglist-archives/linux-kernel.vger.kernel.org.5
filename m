Return-Path: <linux-kernel+bounces-25433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D435682D033
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748AA2829FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26A1FBE;
	Sun, 14 Jan 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OZLsa+cG"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02B1FA3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id OxEsri9TbPUoqOxEsr29aG; Sun, 14 Jan 2024 10:57:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705226231;
	bh=lqzv3ZLxuAAMhNo6bpMj22uaPMyMoPdULdX0yVOZDFo=;
	h=From:To:Cc:Subject:Date;
	b=OZLsa+cGkeNE3acSjtG9Rpfl/q1SQ/ND8zZ0J8UJJ+Cv9dXcAAOWllJKok/Ycr59a
	 Hefs//IBAtWUrcGbOsR9XN9IMKLTBa1zlDpbmuH8+3SJ69AgG2dPawvayP78jPW7Yx
	 Q89X9SRD7/9wASbLVW33qKX2jE4nxhELqGJxt5h1RdZR8M4r9KMs8ILGd2TUE58m6b
	 oxeYctlUsSeW/8JDtW0omTcCn00rl8PxJCdv8qF4nJJ+hm5MEBSxaD9wM0fXneGCL7
	 NGs+ab67jwKVOI5cTpCozYurSnwzf3k/HPl5fWrJoi8kz013tEW7Lnt7Lmy5WARz0g
	 DE/pIR4ymc7Jw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 10:57:11 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org
Subject: [PATCH] greybus: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 10:57:02 +0100
Message-ID: <26425379d3eb9ba1b9af44468576ee20c77eb248.1705226208.git.christophe.jaillet@wanadoo.fr>
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
ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/greybus/es2.c       |  8 ++++----
 drivers/greybus/hd.c        | 16 ++++++++--------
 drivers/greybus/interface.c |  9 ++++-----
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index e89cca015095..1ee78d0d90b4 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -513,16 +513,16 @@ static int es2_cport_allocate(struct gb_host_device *hd, int cport_id,
 
 	if (cport_id < 0) {
 		ida_start = 0;
-		ida_end = hd->num_cports;
+		ida_end = hd->num_cports - 1;
 	} else if (cport_id < hd->num_cports) {
 		ida_start = cport_id;
-		ida_end = cport_id + 1;
+		ida_end = cport_id;
 	} else {
 		dev_err(&hd->dev, "cport %d not available\n", cport_id);
 		return -EINVAL;
 	}
 
-	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
+	return ida_alloc_range(id_map, ida_start, ida_end, GFP_KERNEL);
 }
 
 static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
@@ -535,7 +535,7 @@ static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
 		return;
 	}
 
-	ida_simple_remove(&hd->cport_id_map, cport_id);
+	ida_free(&hd->cport_id_map, cport_id);
 }
 
 static int cport_enable(struct gb_host_device *hd, u16 cport_id,
diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
index 72b21bf2d7d3..bc5fd2f53d8b 100644
--- a/drivers/greybus/hd.c
+++ b/drivers/greybus/hd.c
@@ -50,7 +50,7 @@ int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id)
 	struct ida *id_map = &hd->cport_id_map;
 	int ret;
 
-	ret = ida_simple_get(id_map, cport_id, cport_id + 1, GFP_KERNEL);
+	ret = ida_alloc_range(id_map, cport_id, cport_id, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(&hd->dev, "failed to reserve cport %u\n", cport_id);
 		return ret;
@@ -64,7 +64,7 @@ void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id)
 {
 	struct ida *id_map = &hd->cport_id_map;
 
-	ida_simple_remove(id_map, cport_id);
+	ida_free(id_map, cport_id);
 }
 EXPORT_SYMBOL_GPL(gb_hd_cport_release_reserved);
 
@@ -80,16 +80,16 @@ int gb_hd_cport_allocate(struct gb_host_device *hd, int cport_id,
 
 	if (cport_id < 0) {
 		ida_start = 0;
-		ida_end = hd->num_cports;
+		ida_end = hd->num_cports - 1;
 	} else if (cport_id < hd->num_cports) {
 		ida_start = cport_id;
-		ida_end = cport_id + 1;
+		ida_end = cport_id;
 	} else {
 		dev_err(&hd->dev, "cport %d not available\n", cport_id);
 		return -EINVAL;
 	}
 
-	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
+	return ida_alloc_range(id_map, ida_start, ida_end, GFP_KERNEL);
 }
 
 /* Locking: Caller guarantees serialisation */
@@ -100,7 +100,7 @@ void gb_hd_cport_release(struct gb_host_device *hd, u16 cport_id)
 		return;
 	}
 
-	ida_simple_remove(&hd->cport_id_map, cport_id);
+	ida_free(&hd->cport_id_map, cport_id);
 }
 
 static void gb_hd_release(struct device *dev)
@@ -111,7 +111,7 @@ static void gb_hd_release(struct device *dev)
 
 	if (hd->svc)
 		gb_svc_put(hd->svc);
-	ida_simple_remove(&gb_hd_bus_id_map, hd->bus_id);
+	ida_free(&gb_hd_bus_id_map, hd->bus_id);
 	ida_destroy(&hd->cport_id_map);
 	kfree(hd);
 }
@@ -162,7 +162,7 @@ struct gb_host_device *gb_hd_create(struct gb_hd_driver *driver,
 	if (!hd)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&gb_hd_bus_id_map, 1, 0, GFP_KERNEL);
+	ret = ida_alloc_min(&gb_hd_bus_id_map, 1, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(hd);
 		return ERR_PTR(ret);
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 9ec949a438ef..c3cfd62831ff 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -131,9 +131,8 @@ static int gb_interface_route_create(struct gb_interface *intf)
 	int ret;
 
 	/* Allocate an interface device id. */
-	ret = ida_simple_get(&svc->device_id_map,
-			     GB_SVC_DEVICE_ID_MIN, GB_SVC_DEVICE_ID_MAX + 1,
-			     GFP_KERNEL);
+	ret = ida_alloc_range(&svc->device_id_map, GB_SVC_DEVICE_ID_MIN,
+			      GB_SVC_DEVICE_ID_MAX, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(&intf->dev, "failed to allocate device id: %d\n", ret);
 		return ret;
@@ -165,7 +164,7 @@ static int gb_interface_route_create(struct gb_interface *intf)
 	 * XXX anymore.
 	 */
 err_ida_remove:
-	ida_simple_remove(&svc->device_id_map, device_id);
+	ida_free(&svc->device_id_map, device_id);
 
 	return ret;
 }
@@ -178,7 +177,7 @@ static void gb_interface_route_destroy(struct gb_interface *intf)
 		return;
 
 	gb_svc_route_destroy(svc, svc->ap_intf_id, intf->interface_id);
-	ida_simple_remove(&svc->device_id_map, intf->device_id);
+	ida_free(&svc->device_id_map, intf->device_id);
 	intf->device_id = GB_INTERFACE_DEVICE_ID_BAD;
 }
 
-- 
2.43.0


