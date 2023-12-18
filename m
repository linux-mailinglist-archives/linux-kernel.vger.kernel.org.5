Return-Path: <linux-kernel+bounces-4290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05478817AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B15C1F23BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D397409C;
	Mon, 18 Dec 2023 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IRSgRbOR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C47346C;
	Mon, 18 Dec 2023 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927475; x=1703532275; i=w_armin@gmx.de;
	bh=yBaISgjLgSkrk947Vjw+ExCxzpblr64RVT6udQOT+ys=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=IRSgRbOR3YhXyUzCh7o+45Uu0tdNpbOJCOFJx72N/CE59ZckkMrtlpoXxlOOmbVy
	 K/eT36AjnKh7ULyWZuirGzLGAZoQzXySAA345qPYvpmlsvbhax02LfkvcpWEhNQUS
	 HrCJhFdlKyWINVgB5G2aCy6IYB9TF477XV3+2zDreZZn9J5QWesx9bN+ADQZvBlGm
	 sZDHaqclML4MObMCttuCUlLDGX2VGvbtyVNw5O0CM9/eD5OxHjWSc4+FJ6btH8FVa
	 SNiWjS3NDZrF69KZ/VAcQwbdnbfw0RPWviCaAwUtj7wa0WO9KgnGYiYyTPZasoXn7
	 8oLbh6NvohX7wiIKTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MwQXN-1qz0ti2jbh-00sNuR; Mon, 18 Dec 2023 20:24:35 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] platform/x86: wmi: Create WMI bus device first
Date: Mon, 18 Dec 2023 20:24:18 +0100
Message-Id: <20231218192420.305411-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:z5mGJIGngMBNMuhxr0StFE+zdHVI6DL7+DYf1/N9jov2N9xGU1c
 jAiA8HArjl1Sh18uC7zdBZec76hVx5yI9xrPbdtWpCcHUQu4CHekwzteTH8fEDk/MHEdsWh
 gbueqNEGp65xZjqagPt85+HY375Mrn4d18r05Ne1e/rvrDX2D6HJM0tw3HUjXlGMHjsEttD
 MJcIgig01RDqnl2PdEdjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fDk05zc077U=;nYkcBn+F0BztAT9FptfL1JVN1jn
 VFPNorOQwmSbGNE8Jwr0kPtqAsBJwmou5EGwTwZqqA4nLYklBzY4aUQOfBMYkwuTSNe79qo/S
 V/ZHgTFaieeMi97AtqhXzp7Bt/7RMprz3zM0ZbHiGsxDNWFBBp8lrhr4OeCwuhWfpGPnjJLP0
 1XZKUxiVDOrLKpCHY7vRo0RbXCSjqJKpO/+uRidOGXpR8nHffQUeaH8ljxOL+E9jDLKNkHVoy
 v2yvfiwtpbNyCYAME7BNIYUzJCQRh3qhCjWUXNrR52igSBfFizs5KEFLMEzQyE7ph94UeRc3W
 X0y1K4DhdU5g4qkrlZPuoPKR2cN2C6G1GAYmp0/sN7LpsXsCHB5I15vA696UXFz7jsSMn1gdY
 aHnliaqA3jY48V3ZGuXcm5Kjspn/cD6rK3UjV0WXKvEcyLSGpcdmqnjUFkX/6KGWtwjdTakOV
 c2grpi8GkK/HZEteGrD16fmWqAh6HaFuJOlA3bA3yAFtQEkIzAokxYfR0wC0v2PAMM6kCmhqB
 mYJ0n+bxUYLD9ApmszcQZH96sN1dmvYryyV/XC9tcVq93QQhOFcOxeAwKR63oTzlOHpQAVEms
 aC1FTRYdGQb/ypEZFGjc7FTr7ErLlhzTMboI9QoRJBjMc5gPskmPOGXlN9r40P0A+Ic+os19f
 a2TofqnSI5vraZOMKecfUgJMVQbtKC6PN6QIAA2ekK9HY+MUxVzE/upvEAx5kTh8ClzMh1cjw
 TylANtnOf7bYE5/DdC2KteruCHQZSAsrPLaVtL4c78/rNoL019bRUTMSST1O3D49Z9jbgZcnS
 gHq5Y15EqMK0/DB2/C2sQ84yfZY1kCe7bhLj98eIlYXVcflNC1bHNOWlwyvC8081+hQoFcNIP
 1P2SUPjYsU1qAAjO1xUBtl8fVc/6VbZYekvIinrh8PXgx1IDJR0+MXUSddFY3i85Krin8kK2q
 PBHHgRePhP2X/D7CGY7KIp2RPU0=

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


