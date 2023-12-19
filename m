Return-Path: <linux-kernel+bounces-5663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D06818DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B2AB24348
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257DE225CE;
	Tue, 19 Dec 2023 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEDyh+3q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6B31A6E;
	Tue, 19 Dec 2023 17:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66050C433C7;
	Tue, 19 Dec 2023 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703006343;
	bh=oFlModBgHHrw6mw7QX5fJ8iZecR+dIhjZKfdEJupX78=;
	h=From:To:Cc:Subject:Date:From;
	b=gEDyh+3qajbt33sxBJRuS2q7Vhi3i6cm4LFQNegsV7joyO44Ap+b5HdAi/NfVWR3T
	 8knT3xYXfKO0e6RMQYOP3Y3lFw/outxaVb30lV21E3IJrqYqxmFjn3k0vwoS96Qp3W
	 dfnXihFT7lBnkSwsbZRDpFHsB68oU0dFfVOa9zLM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: make ssam_bus_type constant and static
Date: Tue, 19 Dec 2023 18:18:58 +0100
Message-ID: <2023121957-tapered-upswing-8326@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 60
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=oFlModBgHHrw6mw7QX5fJ8iZecR+dIhjZKfdEJupX78=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNF5oY5n3gUVu26WbCT7m3t/ezzFvW4HbCtVHVvdwv9 /SkzUfKO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTGBDuDgFYCJ1sgzzVJZ9XHxYLK7Ui+WB d1N1Z8Cr9UxvGRbMZF0dFpV5NX1pi21Ban+XTZrLcn0A
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the ssam_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

It's also never used outside of
drivers/platform/surface/aggregator/bus.c so make it static and don't
export it as no one is using it.

Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/surface/aggregator/bus.c | 5 +++--
 include/linux/surface_aggregator/device.h | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index 42ccd7f1c9b9..118caa651bec 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -35,6 +35,8 @@ static struct attribute *ssam_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ssam_device);
 
+static const struct bus_type ssam_bus_type;
+
 static int ssam_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct ssam_device *sdev = to_ssam_device(dev);
@@ -329,13 +331,12 @@ static void ssam_bus_remove(struct device *dev)
 		sdrv->remove(to_ssam_device(dev));
 }
 
-struct bus_type ssam_bus_type = {
+static const struct bus_type ssam_bus_type = {
 	.name   = "surface_aggregator",
 	.match  = ssam_bus_match,
 	.probe  = ssam_bus_probe,
 	.remove = ssam_bus_remove,
 };
-EXPORT_SYMBOL_GPL(ssam_bus_type);
 
 /**
  * __ssam_device_driver_register() - Register a SSAM client device driver.
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 42b249b4c24b..8cd8c38cf3f3 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -193,7 +193,6 @@ struct ssam_device_driver {
 
 #ifdef CONFIG_SURFACE_AGGREGATOR_BUS
 
-extern struct bus_type ssam_bus_type;
 extern const struct device_type ssam_device_type;
 
 /**
-- 
2.43.0


