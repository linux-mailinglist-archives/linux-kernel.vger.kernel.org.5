Return-Path: <linux-kernel+bounces-4335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA83817BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393521C23CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BF57347A;
	Mon, 18 Dec 2023 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QRji7RRl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91272053;
	Mon, 18 Dec 2023 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930776; x=1703535576; i=w_armin@gmx.de;
	bh=lZGk8ts+L3vDhJqdfupckAWAlO/09kRoQ2kBWorNNa8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=QRji7RRlgELufMKOtksOmPb4nV7Bi6Qe2aFP3CoKs4dXgWRROj4SWapY/0+npDk/
	 DPnHvzDH0kHnpF7P0Pfdly30aOw6wyI06m9iPk6OUDWQH7FFPqsHNZUVLsiWOnPGh
	 xlgY3mnZ3keEGQTuHu2YLcTfWd1IJrXG5QBvWwFAaWHXrSqDFvFsZIFG1h9uiJuVD
	 XEkgYXdFyR+dCkRQ0r2kUhtVVM4c1WV9ElPLT9dNoSHW4u7UHtKGAODCO7q8RUub1
	 alitCt47WRWlJ5TSB7VqJItlKD7ksxLgaAbzGeqCbGKNAcGV61VvbTFYONtvPMiCD
	 mcKYcHC2csqERt5cJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MirjS-1qlVdj3ueS-00evKR; Mon, 18 Dec 2023 21:19:36 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 3/6] platform/x86: wmi: Use devres for resource handling
Date: Mon, 18 Dec 2023 21:18:45 +0100
Message-Id: <20231218201844.2860-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218201844.2860-1-W_Armin@gmx.de>
References: <20231218201844.2860-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n89GnJoBYU83A26YuUYubdU7fewU8Az77VrJA8GI/5CXOPd3JpK
 ih4SevgwckwPXAWhHpjQwstNpfJ4cceV6N885DnbfIS3sUOAi8oQNiLhP/4VrWnqSzTaoR8
 H6KEAqmePD+SokWfwzGmzJv6a3dps056gjKeHry9kfHlwYZXXRRM563cvPEe6fzi0XeQ6c/
 ouHkCOk/ymkqySb7Fs1CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r98CMytVYfk=;p6+kXa+I2N+7zMTN4hYDHW9/4vj
 jjVMRRrKuDJoIjV7bqEiNtzI2/jU2it0wMOcX3DwWivza+OkQAjQ2K8VTFy9IK44f/dXcgUxY
 mcG/LIQMTdm33MJPUXK+2T0Sven7DQpjWVyyEhtwL9RjY/u2fAIdLp5TWKzGkhHYQLCOkdA6g
 W2GlYda8OuUgwX1srQjp1aIwAAq9de/TnV++tcPCQG0k0qlDJIxUtaR/GLwYOQDJfZrzAkt9c
 EbuAyNq5/c1hK5byRBN6tgxLC9h5YCHkw7v5hRn/t2qkrbzml4huKGLdSu1RCr/MmXQdnYMyC
 RJauVH4RX+GCHDrO5WQbZN/XwxvHZLtWqcL3u6wNi95B7eIOGP16OliYfqYs9WOIIJpY+uJog
 SnRKaFgnT0I9U/DLx4w38NF9UBOE5wA2gvhQ8sjadDX1ZslfDusDOQrqXW+yklmOg0KE2S000
 sbHt4Jvj49xmkXPwwPydEcyJPxn6rYwAcV/V6XmvsQMqUGRaajfXsmMnFp/OtewIXqhDKHZVH
 4V3Pad29jk4BWHhle+coNmGtAQsyucE7mb3cUIL0B2HVrzP8q0KndyJ6moJpH2zip2EG5FI95
 pQqaW1chfkXCnaAjihGR4H8M3Wv1iP/cj1FWIuAV6mJd82KVj6uCRjEY5vTnUSPb9Mu4jmnmV
 /GEwI7a5UyVPigDCY+XUQckGpRTCI8qIsAdkteZlxO5m5M0TEWLUfRyGdLaWn+MJ6O3M2hbC0
 phnR3Y71A6T3o5oiWX2/4f1ljE8wEb4dONd4p/IQy+gF+SqteCjqi8rnR295gG6IRFEUSwqB3
 tWwTHqNvY15hJhAWwGpqJrgZvPNEaQNHqpR/TwFPiMgc9MUUNxQ2AV22hErgsQo4h0LxmJsFe
 nM+DJIPJRTIOK2N6NpxeCNYnXHftsjDDXglRsErC7AI6WZNhHk+muMfhFSLTfFKaeSMElMxcj
 f3tHqWPphitpMJjPxwRro39lLyM=

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


