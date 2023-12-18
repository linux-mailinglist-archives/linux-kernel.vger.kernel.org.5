Return-Path: <linux-kernel+bounces-4288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBCB817AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DAD1F23832
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F173485;
	Mon, 18 Dec 2023 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="e+wtJy55"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AA7204D;
	Mon, 18 Dec 2023 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927474; x=1703532274; i=w_armin@gmx.de;
	bh=lZGk8ts+L3vDhJqdfupckAWAlO/09kRoQ2kBWorNNa8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=e+wtJy55FZKGPOFnwAiJLIriOGEgMURpS4TLhykjNvF0wCrHP/PzN6Iyg7NbKFR6
	 JGVqot2KCbbCAF16aX6p5GV7+YbrwQBcrf+nWv1FLSWvPWAuNifJrpaHMxOo7WAhj
	 19eWxsAli9uHHrMMCqiwxd53UbWws8ATZIpuaI5IfAaTPiM/sPM/BRtXmhFasX+0R
	 POjtuvPxoZnCLSM3Dg0y5+F8e/dg2fIfhF0+7rMLdnFDmdXESP9VtFv6pyKyDQ++6
	 Q+XuLQYNc9kLKAt/5+VrOeoAWt8i45yEZ4BrPEX1hiya+CX+v73YWAaXmp7MLget3
	 aKm7ZLYJOjSa/n5NgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MXGrE-1ro21c0tqA-00YiD1; Mon, 18 Dec 2023 20:24:34 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] platform/x86: wmi: Use devres for resource handling
Date: Mon, 18 Dec 2023 20:24:17 +0100
Message-Id: <20231218192420.305411-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218192420.305411-1-W_Armin@gmx.de>
References: <20231218192420.305411-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vZKYnjeFk2UtTrBDB+In7YfNzxAq/lfhcT1S/gYYFmwAVO1iOX9
 QP0bBQQoVPbs5kgkLSK3saIuLLo3Hn+PVTCgwu37BcM9OLbYVnCZ8we+zTHoiOhcpWOC6WA
 x3QTEnxtwtQQeczW8g+3kY7nOUp2/ktPVr+UrIVvqGI7R92i1wX8podhZ+2dy7iANrGIXJX
 rJzNrkVU/BWDZAxUjwx2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s8qAKMWLtPc=;Iu++8ZTgXY/xSOaUFYq2X3F6NSd
 Bk+PUen6I0x8UZbeUx9eowOHDHt/NZ540FyMQOcLH+kCsx+lZt4J7Swy6HRYkzkP4FBr0m2w1
 lCHToyJpk5jIWCUPHyibBdQM1PXV5YlB946uV5ykL8qQ6nYRFga1irgazLtIEAbjJsxPQ/5/i
 XNHZJ2q0QyUvf0jN0ddW2bSa9tpKsOQ+frfSkb0PkQfvBg2bBvYVyswpe1KDyi/zDnKM6fOMo
 GD/aoa89K23FBTenxi1av4DhlZvX9laPGULSYH0jujPtjDcJEYPZjCjQtrGc/4hjV80l7/Fz2
 DqW+j6fuK85vwcKmGASUw4p/002sJu4qTvw9RRnLAQVV8bPUB9fmdzlhNfM7HoCNaCbL0LI0z
 mzotFcMdHXWPfJ1tkhfP974I8Rnf7u1ZTSLXVwJnM4hAVhJADZLol5wklfgDAYHFRr7PWFmTn
 JF8TRIdbXMMhZTYnsQ27svXnEGAP25PjDCdXpiQQqiEFLML4p4Ggefd/UPMIUi1oJwEP9rXcZ
 He0g2iSyf3t495REjNQqurCEqMmsziZ3fp68X0YCvf9S/4OXsGIdpJ3dHQ/GTt0RHM+vEoOgx
 asONJDLInXldk7szdoXsHtJ+hDQ/f01EDDV1ZkN5UJoPpzcI4eYssJxXUtMHXiQdfb55FA159
 lZLbhrNVKHcS2tA6dU5VSRxcfqWhmNurd8WezTB6865HmpzWuhKfMEkth55kPPrZyeq9ab6gE
 2UcMaaiJlvyXfiYkc5snetCcnOZd61pRu9KZnAL3h0N0YGIDC5ENea3pO75ScgY12rY+RoaAc
 /jxGV8MkKikxAsIec/1qPVctKRQxsK+WVnQNCM/BhOJsBU0FInpBspL6X7mBFIt/+NX+eW+FD
 HOX7bBvzdgHC33KjrDhdt7FtScOcfkaOq1vDhF7EPAnaO9blfI8UEXrS9Kj6rx99NUJLCg4vD
 zQ/Cbq0mCVAM7PldfmAmrIJ9HTM=

Use devres for cleaning up the ACPI handlers and the
WMI bus device to simplify the error handling.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 58 +++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 2120c13e1676..4bc5da70c1b0 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1236,17 +1236,33 @@ static int wmi_remove_device(struct device *dev, v=
oid *data)

 static void acpi_wmi_remove(struct platform_device *device)
 {
-	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
 	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);

 	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
-	device_unregister(wmi_bus_device);
+}
+
+static void acpi_wmi_remove_notify_handler(void *data)
+{
+	struct acpi_device *acpi_device =3D data;

 	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wm=
i_notify_handler);
+}
+
+static void acpi_wmi_remove_address_space_handler(void *data)
+{
+	struct acpi_device *acpi_device =3D data;
+
 	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC=
,
 					  &acpi_wmi_ec_space_handler);
 }

+static void acpi_wmi_remove_bus_device(void *data)
+{
+	struct device *wmi_bus_dev =3D data;
+
+	device_unregister(wmi_bus_dev);
+}
+
 static int acpi_wmi_probe(struct platform_device *device)
 {
 	struct acpi_device *acpi_device;
@@ -1268,6 +1284,10 @@ static int acpi_wmi_probe(struct platform_device *d=
evice)
 		dev_err(&device->dev, "Error installing EC region handler\n");
 		return -ENODEV;
 	}
+	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_address=
_space_handler,
+					 acpi_device);
+	if (error < 0)
+		return error;

 	status =3D acpi_install_notify_handler(acpi_device->handle,
 					     ACPI_ALL_NOTIFY,
@@ -1275,39 +1295,31 @@ static int acpi_wmi_probe(struct platform_device *=
device)
 					     NULL);
 	if (ACPI_FAILURE(status)) {
 		dev_err(&device->dev, "Error installing notify handler\n");
-		error =3D -ENODEV;
-		goto err_remove_ec_handler;
+		return -ENODEV;
 	}
+	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_notify_=
handler,
+					 acpi_device);
+	if (error < 0)
+		return error;

 	wmi_bus_dev =3D device_create(&wmi_bus_class, &device->dev, MKDEV(0, 0),
 				    NULL, "wmi_bus-%s", dev_name(&device->dev));
-	if (IS_ERR(wmi_bus_dev)) {
-		error =3D PTR_ERR(wmi_bus_dev);
-		goto err_remove_notify_handler;
-	}
+	if (IS_ERR(wmi_bus_dev))
+		return PTR_ERR(wmi_bus_dev);
+
+	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_bus_dev=
ice, wmi_bus_dev);
+	if (error < 0)
+		return error;
+
 	dev_set_drvdata(&device->dev, wmi_bus_dev);

 	error =3D parse_wdg(wmi_bus_dev, device);
 	if (error) {
 		pr_err("Failed to parse WDG method\n");
-		goto err_remove_busdev;
+		return error;
 	}

 	return 0;
-
-err_remove_busdev:
-	device_unregister(wmi_bus_dev);
-
-err_remove_notify_handler:
-	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
-				   acpi_wmi_notify_handler);
-
-err_remove_ec_handler:
-	acpi_remove_address_space_handler(acpi_device->handle,
-					  ACPI_ADR_SPACE_EC,
-					  &acpi_wmi_ec_space_handler);
-
-	return error;
 }

 int __must_check __wmi_driver_register(struct wmi_driver *driver,
=2D-
2.39.2


