Return-Path: <linux-kernel+bounces-4336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7821B817BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA20B24375
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8273493;
	Mon, 18 Dec 2023 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="t31Iw8pY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137273480;
	Mon, 18 Dec 2023 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930785; x=1703535585; i=w_armin@gmx.de;
	bh=yBaISgjLgSkrk947Vjw+ExCxzpblr64RVT6udQOT+ys=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=t31Iw8pYZJ6vnlRjAJZp/9LgxyXQ80Ndn1Xd9WttYKFbnnYHWtweY8npSEgf90N9
	 wt3o1MdDg63C2wkwJsbW+bxZsSXp5QMPkk/EDRenyoceGdlzYDmuP/d481J1lDDlD
	 X5Fx8qx8vhr+iHxXxQUFvygmb5rckXNEAecQhNtmWI+XA5rK5qsT440h53W93CRlw
	 +tvlMeQwCVa3K/GUlzQ2O3WSR0alEaRIVZcQCXA5O34sebYoxX/hcHLRWacLry1r7
	 Igkps6DImehEN0nNAtYl/s7NnKmIr6IAorefrnYmcKHVKecSu0d9mNVRNQoEejb6y
	 opYimpdmE7ZK4v0F5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MJE27-1ra0XS1rER-00KjWP; Mon, 18 Dec 2023 21:19:45 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 4/6] platform/x86: wmi: Create WMI bus device first
Date: Mon, 18 Dec 2023 21:18:47 +0100
Message-Id: <20231218201844.2860-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:r9JOtOHmt+f54yA49r9+97q4XohiJLYV+pW9iPD6pyNiksbWBvt
 qQnRvhsJx/7sBkMTBdZlGZUX5sehtCuZ4+IGGH1nKaNCYtXDJjyG5c9NgQ7/elhKsBl8+FX
 g3+RknUmC728xTTlsieoChtS3gxc8UXK8g9Xes2ByqMXQo5jgQbFTwzgFLgelVW8aDgxmwR
 Z6MkRvtALXEa5WlPFqrjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uJjfeoZUhpU=;K+q3QhbSQr1xYpHm6brduiy+YvI
 ZQgepe4fepG/9tmz9dQcVrMVhGc1l75xt8wqlgv+wJSWoBozvnTiecTmxabs5mJUAKJH1vbwf
 EZLct4sorJsbOZsM+ssnE7ZhqWCHaKomph6sqCtnODAdD/gUt2gQwU55YPj5ny5lA74YXcGW+
 s8fXF3gK8C8p9vzxBx0gtOBdHj06tMxz6FQFnjI6bRfLtCT65Gaf0Zyja3gZM29R5qWBjSoTK
 Yc12mzmlSNygmZYwQw8It+twoxH4XRZEfDafalEwRBmm6q+dYlY9jmZm0azgOniOhuKAFYGXG
 uLaLueBLkFp5QRVtnDPyQ/vidvseCOIDtUWz0zR0BD4bjrOeF/qwrwUVaNfdQkfoXxaASEJZH
 Lq9pZtRxjd4EcIXHfM4dXcBuHvc7YS4xJfA5Gsh2UToHN+rsCocYrJQ30cdw9f5TYoa2Jvd9l
 FeBkahH1C1uciChl9Te0ZFw5PmPZ0OxuCu3Jzlk/9CZs3fFZTdYb1O2fdInhw4Ht4l7nfsPb6
 08pByfGmdJp3/7NXwnkJ8XLTFk3tnQ7jtJtDajpf/bJbTkbrTDZx2MHIarqI1OOA2QP8at8bf
 FVn5RC1itAoXAcMZGhXRcL65KZRm++G61pSu/q7aiPbmt2Iub/+YVhDxyrEPSKtGsrtgGkzI+
 4o5DmRfhcdLhLjrCORWFppDx9AlcszdUM9TTdzg3hxeABgccDoR8koR4KDYUSVgD0ImaVw7qJ
 GS/7sXh51qUCaVdtsGOVj6AFGgLdKDRjzCgsg9VN4NQfj0KnwFMD72PlyWMHufugLzeT2NAcn
 I/lo7N3UuowFk76XbO95tiR8b49cXk6HeI6EbX5kgU3m4ra+xpMrMVjRwi6YU7adWs3BjFiqW
 iayOL10a8PlktGf9JHipzqbFLkCSeNO+O+5U6DZWZ7PbE6IdC/Sh9riDgUYssmp71v3+Lxpbg
 e/PRK9oE5yV7xXYtW5oFZXPiqBU=

Create the WMI bus device first so that it can be used
by the ACPI handlers.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4bc5da70c1b0..e2bfdc61c4ce 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1276,6 +1276,17 @@ static int acpi_wmi_probe(struct platform_device *d=
evice)
 		return -ENODEV;
 	}

+	wmi_bus_dev =3D device_create(&wmi_bus_class, &device->dev, MKDEV(0, 0),=
 NULL, "wmi_bus-%s",
+				    dev_name(&device->dev));
+	if (IS_ERR(wmi_bus_dev))
+		return PTR_ERR(wmi_bus_dev);
+
+	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_bus_dev=
ice, wmi_bus_dev);
+	if (error < 0)
+		return error;
+
+	dev_set_drvdata(&device->dev, wmi_bus_dev);
+
 	status =3D acpi_install_address_space_handler(acpi_device->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_wmi_ec_space_handler,
@@ -1302,17 +1313,6 @@ static int acpi_wmi_probe(struct platform_device *d=
evice)
 	if (error < 0)
 		return error;

-	wmi_bus_dev =3D device_create(&wmi_bus_class, &device->dev, MKDEV(0, 0),
-				    NULL, "wmi_bus-%s", dev_name(&device->dev));
-	if (IS_ERR(wmi_bus_dev))
-		return PTR_ERR(wmi_bus_dev);
-
-	error =3D devm_add_action_or_reset(&device->dev, acpi_wmi_remove_bus_dev=
ice, wmi_bus_dev);
-	if (error < 0)
-		return error;
-
-	dev_set_drvdata(&device->dev, wmi_bus_dev);
-
 	error =3D parse_wdg(wmi_bus_dev, device);
 	if (error) {
 		pr_err("Failed to parse WDG method\n");
=2D-
2.39.2


