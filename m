Return-Path: <linux-kernel+bounces-4321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8F817B76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32DF1C2315A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAB74089;
	Mon, 18 Dec 2023 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GbXw383v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3827207B;
	Mon, 18 Dec 2023 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702929340; x=1703534140; i=w_armin@gmx.de;
	bh=lZGk8ts+L3vDhJqdfupckAWAlO/09kRoQ2kBWorNNa8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=GbXw383v+gfWWJcmKqB+o2nVUNURvUMhA5LlA4vL/+0J2QnlUld4S2HKWBW1zbup
	 BTmDyhXBGoUhL9vQ/aQ1pTZvZptyfnPCex2nfN7Gwvpupw7zDK+A2617xi+mC2wQ6
	 02Nnq+8tZHU9WPuG5gZBuhQI8alI/iYlgKyaSoZzrSiig1UcGgYkroN1Jpcv3iXA4
	 TO7SFzxPgnoC4OGBF4H84sCA9GnmHx7yW9dV9xcOcT0OprCBDbBltZS0IELOYKm0b
	 rsU9Om9eqARp1FfIbm8+XVhNKo98TiMYDtkVEfQ5JmljpCdeH10k5pD8c95Ra6Bpx
	 qdWvwkJwSwWuum8zFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBUm7-1rSDTA3d2l-00CxHT; Mon, 18 Dec 2023 20:55:39 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] platform/x86: wmi: Use devres for resource handling
Date: Mon, 18 Dec 2023 20:55:28 +0100
Message-Id: <20231218195531.311179-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218195531.311179-1-W_Armin@gmx.de>
References: <20231218195531.311179-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gzBHyBAQmRhJ+RI77889ysmATwtQjlPNOz6eVC9CVGHRdyZylP
 CHows3iCQX+oltbvnvJXUzSV0SjgCjnoO6HudoEuk38etAin6qGNyc+smi1P+oHAP1qGFL0
 4SZZrYteyIVWbf5wusS+mqAGloxCMkDdSKuA0S1JZUs768D3lfHr7cq4aGghX+nhcBnnbR2
 EK8nUFtCRaekIIIeeuAsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iEtNoDAEJOQ=;OMXNhHulCy0nx/c28axhZYl96YS
 1YzQEU0CtXRBlV4P/yI7hUB1evOdC3CoKwcSbz4Qtjhu/hydkQ8JBr6F3ERrWW44qhUp+Yw2V
 vE4+UF0pVOtvMMjPcJ53ola28Kz0529B3+ypaUGWUAHHOv83YR7yUL4F23Vv2qh8+gbjq9hFT
 BkMSaeMTvVfrz5McXQoPtFmlq4M6FY8FsVUaHvZw+j5hCYdwAjTK8SslzRiLijQR2zxrKvVDU
 rVkD1LVgwt04ut+B/Hgc9UiQy2LlbuV0Px71sykeVoSCQuU7tOVdaSQ7zjlK3p+MlL3ICu66J
 ey+FIW9j9HZPzYIMUploZUu1aW82ytAoLgKzhdC0CKip+bXs8p6OyV+1AExW87YiPoULzzQKo
 oqVX7OLvS/qhkSVnthwgHVGZWan/i4/4NYhyrxPQOrNuyNwMP03ly+CjN3TbyDmve7p4SAZVU
 yo4BB8dpxxJUMzAEB+KaOrqgySrXnl9GogRQKkSc9O6wa52MyHWbn8i+Cfa8JKj0slzAEKYpu
 ucO6bV/EJwu59rj2ozLl3rLNG1UKzzsLsFWmLtMhQl8Y+fyxgnXo50Tg9hZ3GKHf4qgIsTBrP
 3qDJVp/4TaEdbJkZqYX+xs2Z0AfsoDugZYUOKXl0RjP0biXguH3FNoQPwI3aPBSCcmWl+Vw5+
 QYSufJpaFd5eLDF3WQkqajW/DAoHSv3hqnn/v4HtZFr87l4jN23N8Yyx3nxT1HaKB1jo34lfx
 q2z3efvJ049z0jGehwlbkd3/rUXO2kqQin0SXWzGGjtyaP5OJi4x9JixoDu5kJDqPhzrmErUv
 TwDLTxw8N+C8cRsHNLQTSpsLBRYWcfpeYELimHdCGuPPfbtoZqL90n4XolxY2klip3QA6i74P
 DiXcAKt4Tzg/gX9gb5Tk0Uta50O+OMR50Huxl+IP5XegqoJkiP3+B1TO0z8nOhTeVqSQMM9//
 HDAB0hlDvoZzD4uvqwmFWLo9Uy0=

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


