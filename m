Return-Path: <linux-kernel+bounces-1942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85148815626
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BACC1F25982
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC776AAE;
	Sat, 16 Dec 2023 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="n9woXCgU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6A28ED;
	Sat, 16 Dec 2023 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691778; x=1703296578; i=w_armin@gmx.de;
	bh=JXqSKmcFLSyeKf7OYURl84uaiL8PV4z/6Y9EVeVg1Vc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=n9woXCgUk5pkpwrrsAXeVUw6f3vm7fO/k7OkfIrot7moVOsX2lDO/8zvYkVciW0s
	 wikaqjBdVw5eITRhGlMY5wOnrn5fGzw/eQqiwfSq3HGvUlHtFJORdBBLwp/KAplLA
	 0fhzCn10Nv9LvWwRtqvkgxiDXygMOzGZF3jO9m0Y3VGWj9pRU/KNCxuwQfzCIF9a0
	 vnQjKY+iS7xNXPiXVPQldHlvuBAGTVaJ86Fxln19rBKPlhtG/2niAG/vrwfQEB8oi
	 c4MP46+lFp03WcGDaLvi2+tEagAc5CDi8qLIBIlp4j/CsIY+fFaWKWkwD3kd2dU7W
	 ivDh5WsaNGCOFeba4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N8ob6-1rIQg02ZpW-015q1t; Sat, 16 Dec 2023 02:56:18 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] platform/x86: wmi: Create WMI bus device first
Date: Sat, 16 Dec 2023 02:55:59 +0100
Message-Id: <20231216015601.395118-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:sWKj5sipcYAyJFmd0R5+CGzUK9Ib961ca3/LW0BsFdGMwSMvakr
 FbCY7Zn0fIjO3aAK0v4KmhI+6jGTbv4KFsSn3HtdaVhU5m9P4i/2ZadIvX5pL8a23uCPZTp
 UMoZIAX0/GwDDZtwIdJNTMPrFFUXvo+lxEwzh2ikQ2KOgcemCpnyGnf4qZYrYPfi6IeFyfO
 GzuaKaIaFBZHk4WAo+jzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XSs2184x+uQ=;IMc4kWXI1OoG3Wj4ME7//yyKABh
 4u34exp+qKQJJsGJHOnon6yhF+jEmCFw0rACVzLmfI1YY+01vFB0SBl6JuGWzijPIsVS8g9Gf
 AVBy8lsRLIN2zWlTAZLkHAZ1GekZ6EPIsS09QkT+WcxLGr5ePIE/epe3z29yrz4kkRdTlABLs
 /jZ318vaPFWwJyBnLqLisewk6wepmZvSXcN7bRXI3V4kuDPNn2zZ07168K3mtzkRLW3vtUg7G
 VIWe1fTppSvCPdN3E8EwCo+EDaVxnt2y275QrYywdsEbuuOY5dVUhdnRdiNPi37Thyu2ADMs4
 VvQaPa0wotbZOo1QAq46/VP6NT73snEa8Pz2F7YvA0uBb3E5ySpjDxPvSo4YichI2mG9I4rQp
 zqLam9echWLnSw4j49tlXEkbz/czZ2XoQ6AR9XN2vdDbEtVoBkHQ4nBkZNPZbT68wmPhw8R7s
 QnGLpcfEygLsPT0vsH8nKruRnD51Lux+5scEweYXBKQDDAAz2fzWX7X2+ds9zYOioD7Yf4oE/
 P7/Ldh85yor9qa4YJbmIuPMFdXUPTHApsQ5o4vjB+7CIVP+M/cJkOJbJ6odpBUhJ5nJhl60+R
 JV7CxYG6I2zm7D1vz2yiWIBP6nFJ+AGQT+28QM85H3QEPXjfEQ3U1xPkQod+17H6dCdp0x0UP
 +TcIrWX1zXqj/PtBvJ5oIHlvWXQGZ0Cwf0ShD84n4RFUUHPodgRbePhnrqJjrGtpnc0WPtj6m
 rdNCszHSDSQU+RZNcYwBEe8NMxeIs58dyVd8+V9WKMYKxari5sLEYzIqgIbGKg3mw5R6NoPAo
 Sp+oDUuvKGXO5IcT1ENUdmul5caZ4awjQxGe0GKk8/62ynSHSaiLxfEj+3hpjFoBYhQ31NbTm
 pF6lYM/ctgBK4a5v/JiJnEKQIXeTAXxxyij3L/Skiffgrb2N0v9ifCt+YSZbNanBMiPuWsI4U
 E7L/e+CQbOyVuoWo6v5+jJQou4M=

Create the WMI bus device first so that it can be used
by the ACPI handlers.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4306a5533842..61849a43e2c2 100644
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
-	if (IS_ERR(wmi_bus_dev)) {
-		return PTR_ERR(wmi_bus_dev);
-	}
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


