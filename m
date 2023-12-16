Return-Path: <linux-kernel+bounces-1940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDB815622
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E739A285C57
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A193C2D;
	Sat, 16 Dec 2023 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="l2BBnWTl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39B1379;
	Sat, 16 Dec 2023 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691775; x=1703296575; i=w_armin@gmx.de;
	bh=NSlGyVo7k0F2zHFkie2jaTuoeghUD7mw6Ct1mhxllx4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=l2BBnWTlaNjjVz39M3miF1IvJLmgXP99W4x1DTIvfy0CN46C2iVB2VrUeOMzGSmf
	 kU2L1sWSZO5/G0U6zfyXAgam14gHKrzG4B9pcPKQ5M+aLMemJ90mLKrxCNRB38NAO
	 w5r5BdqVvOBzQaGAL3R+3vaSwviuSwpw9kpaZThOBoSDxnZxG3OP+YVOIKBGLAS6y
	 AHF6OYD1xP0ECyajBXunh5zJSOMseXKIREuF6HVy5wJ+iGN3Jw68+vzijTkWNOs8F
	 sZjibNxjtHDWY2m7+JnZmRUK90R5ZT5bQVejRxVx1OfHYD1qhVk451uXwq3OKSu1d
	 G4DfbYcW5eFGjFwyhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mf078-1rhd2r2WPS-00gVyk; Sat, 16 Dec 2023 02:56:15 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] platform/x86: wmi: Remove ACPI handlers after WMI devices
Date: Sat, 16 Dec 2023 02:55:57 +0100
Message-Id: <20231216015601.395118-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:/MKAnEQTHuk4hj/MDg6RZQRyElif5cXt0x3NsrSoJCXP/urgeuO
 aDubYt5H5sMViEr50Axu+g/xJdvW5ImXDxanspJzbkhvg7rshb9U1NGvrT9bMyfW2ybS0b1
 ZATWG0cH4updmQSWE2sDpRD2Ox2LtvE4WS4p0gPUNZV+omNzDKbfHzP3ihrlAusOT8h0mKl
 9/IKBt9TmNVWhbEKLhZ6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BJhUsHRAOvE=;SX/BCMEVCsHQApJnIu1iWpCQOGO
 dxVPopsTPsWNZAJ21Uxj2fhPa5LaeSgm6s7iNeOY9NHCdXbbwwoXguawNHnaaLDZbVCaSWudI
 Y/nxd4S22lZomMZY4I2JgOl96pQs+jehGVchTPHDPazHjoDcHDw92lPh+M1OBntRosMbUnmgJ
 Mx8efMVjcj0NcQqjstzeBlrRI0NF8CzEHTvyP772rhhiXlh+Uc9lzCSnudcFGb6PmkIe6h05q
 2ACp94a5ZQJJwOq/Oy4VeVMNO4pYHQIRYYCNHtvKWizzn8rSVe6S2LMLQ9QIJmEy1PGscmtZT
 4TVaaQbN7I4NefWqs55g5c4FmBDdOHLLhPCIw5JGngoZtojnZee2Vc1yV+fc5mJpKnvzrjGjY
 R8DuYjSw4sbBib4nOakOEYupPSlV/SqRUGxzKm73wEpKvMgg4AufGK1tfzUKBwNupZkOfp2BG
 7PYVV0NEbdJYVKEUCOhnGXXBoPycWtQY3JoGLFuV4bBfamTg93a4cwzi9vz5jS0J2iVTviJqF
 IJcgJFvcOPrsh4LuAhZW6wgUsPoLsLTXxT54uYHgu8mlRPAiruUID9K4wiEC43gkjUOZREo+k
 cWbyshe+9zIixc0V5tCqjLBZFObwl2JS6wFWFhJIXTxX4jyfZupC/dGLsUl3oJ7ZuAXPaz5HU
 EODyvtdtVRzZCCl/Cs839l51GON4CGIy4l19uZRFX8eOJNarCR7qv2+CC0u5iV62rxAuYiqqO
 +gSJHuQGterE0yfuli4TTSC8KmcMHBKPjoSA3dCCawsHYSN+lkT9tysq1cXHeHiwMrbUavn2g
 FrF+vTecJMeEBL9WFpoV+v+vSI7VjvBvQOF0WgMuyfMgZ3B0RkvgRCIrSLi3WJmW/ZZ/MrFg2
 E1hmoXxYc/RfHYsbPBZUDygSbNO8y2gpLQy0dqTj+WqcuQU+30T9wJr6jvnwsLLpFMtk3IlFN
 upzayQ==

When removing the ACPI notify/address space handlers, the WMI devices
are still active and might still depend on ACPI EC access or
WMI events.
Fix this by removing the ACPI handlers after all WMI devices
associated with an ACPI device have been removed.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 906d3a2831ae..2120c13e1676 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1239,13 +1239,12 @@ static void acpi_wmi_remove(struct platform_device=
 *device)
 	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
 	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);

-	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
-				   acpi_wmi_notify_handler);
-	acpi_remove_address_space_handler(acpi_device->handle,
-				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-
 	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
 	device_unregister(wmi_bus_device);
+
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wm=
i_notify_handler);
+	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC=
,
+					  &acpi_wmi_ec_space_handler);
 }

 static int acpi_wmi_probe(struct platform_device *device)
=2D-
2.39.2


