Return-Path: <linux-kernel+bounces-1941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA0A815624
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE43B22CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE94C7B;
	Sat, 16 Dec 2023 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RREV3kRO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06515C6;
	Sat, 16 Dec 2023 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691777; x=1703296577; i=w_armin@gmx.de;
	bh=zr7izhTjkkn0a454Oy25DTlJrb8p3VJ9H/oE0Z6Z/Wg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=RREV3kROqP7fP2u8f5AaGRdaI0pKoF6DDeVNKjkXPlSC9fiDdbcvjCeUNJTBP6oF
	 Ny/CLZMAdvA5T7qXQSVLWyWtxIFHMVJfkLtmo4xJlCku3coZFTcMl1Y5NdZ55fP/F
	 rHXAaeI4OhfGDb1mgvmZZpU9mD21Ttfx4YyzkqeFnNMIZlV+Sz5NjttPyIZYKBuSs
	 /z3/b98JtrTE5JGc3kkJdp/Hn0f7nW55spVRFZkZbOwK91ih66li/wrPHINmBGY6U
	 6qEY5Y6nJDDsvzhvFtQmfO9zFFzcZU+vsGx2M8QShcgwGanBYOS8Zs3SZQ91iBI+Q
	 HtKcUlC1W60GS7GA7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MrQEn-1rZgRj3ho7-00oY3T; Sat, 16 Dec 2023 02:56:16 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] platform/x86: wmi: Use devres for resource handling
Date: Sat, 16 Dec 2023 02:55:58 +0100
Message-Id: <20231216015601.395118-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216015601.395118-1-W_Armin@gmx.de>
References: <20231216015601.395118-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:reZqFpw7IzmzmySKV2Uusv4DGKgDFNh1o/n9TSrlGzKpYdc7pSe
 +AwIhLYuHqgfR/NUXW71L/Au4ajloMN9rhWvnqyOtJazH54ZNUmqgZ0dwA/O5LsziDuyCxe
 SBexaBXru+/YrCftclsuGd/n9HLkeX2JdoldgCvXPYnoYsol8qATUMHkT7NFRitXGDfUVGc
 EY2oDXIM53pN9km3YZc4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w4VBgVE+Yso=;S4CjmMeLuy959kERQ+aAlAftNH/
 P+gqeJYxkXAirK+iEqzlBm/9vIDRHygg0eDMkToFc9MIdwfYQO+Yx7HwZBUZqyOm8eaBhBwnH
 xoGSImjp9zK63scFj8ZaDRdbY3fodeUDyiLIwHnGK3eo07UvGhKKzBaYHtau3JiVlj/XIF/vX
 WhrMi37PQIT5FiWQLK3fI6vJTSwvcFcAC44AkrZnvjURWDeqKTDThtzxRZfCTyMJGn7jsO7V8
 RUrl5fIbGBBPKxyEp3KKgg5hk9ogubAEpvguR4oZi0cu+a+ic/Nu7FfJ6tCrjmRJsjNOJA3V9
 DVX+rl+zO/QOozMI4K1x3k38SXzvL0sNb6l8QWF+YYfMDNGnq2Ai/8BW8+sqgMDS3rCq6+4rf
 pxMxNq91AARxyOXuRT1JETB29WL2Kq/6ILuK66GumdQVdlUsZ0BFGbNvGtdd8Ikb/RHDjyDt9
 icoe3eTj8dXyjYItmtImpzSSRHRcIpaok6DZL97HbHjo+iHGxSucTrIqzTPcCB5hmWKkN5ptH
 bu9kcp5zdc8Fyr3LH4Cd4Y0WHht6vUZLjDAjJAK4FDuWX0bFdjP47fQh6BHGux7ixaw2QR230
 dNnSU4jWoBZk1/fA4Rf2c+k2thYtOK7/a37pppoE4yFReHOIfHkoJ7BibTN95dj3+voJcJOiF
 0Jmj6EDzUUYMnnl6IESKAuH2MyCXvwytLIUjcHrU1o+LBNQ7f6OVpbQg/G3saKSWZVA6FLIQj
 ZHoKL3Oi49p1U7nE9EABMFZa/9P+jwty2nrh6ZXFYZlO28vq8wf1XUgDOFMra2JnoMJyhiJCo
 T8Nl0LSCbjuUqHWNzV8hOyN9Wn5397HYqFTfO7qidJ2jKikYiJG6JmutHw4rI2Rdwpx+6xlsW
 VN+4rCLcDokTBomnBiKfVAI87dg1nuSwpENSqROBJeU+Nhz1/mauKcSSmSxNFwZcc+NEobH7J
 fDVyKXDa4VTkxZxGPf2VTW0xQUo=

Use devres for cleaning up the ACPI handlers and the
WMI bus device to simplify the error handling.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 54 +++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 2120c13e1676..4306a5533842 100644
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
+	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_notify_=
handler,
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
+	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_address=
_space_handler,
+					 acpi_device);
+	if (error < 0)
+		return error;

 	wmi_bus_dev =3D device_create(&wmi_bus_class, &device->dev, MKDEV(0, 0),
 				    NULL, "wmi_bus-%s", dev_name(&device->dev));
 	if (IS_ERR(wmi_bus_dev)) {
-		error =3D PTR_ERR(wmi_bus_dev);
-		goto err_remove_notify_handler;
+		return PTR_ERR(wmi_bus_dev);
 	}
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


