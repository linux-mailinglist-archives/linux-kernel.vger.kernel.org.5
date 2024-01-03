Return-Path: <linux-kernel+bounces-15911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A838823593
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81071F25143
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B351D554;
	Wed,  3 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fGM2Nqfk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC91D546;
	Wed,  3 Jan 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704310049; x=1704914849; i=w_armin@gmx.de;
	bh=/lsNj9rxTBDIeVLMp/1H0JkQqbzBFfBzbWZMu3y3Zjk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fGM2Nqfk0tZfFYqZk1ncpmaNgFNHQtfATqBEnK6Zqxo8jSuGPea/yXRP7oUTH6Nk
	 TxhAjw27h86SkrPwYxv4Oz2kf1K0OdeGWuoGAcP5t1elAvj6IIZ9bU89Z/Lsa08md
	 172w/mAUZ755j0Kuxtg9dL/DcGFxsaQiLyAhjDZ/zCA5NfMd7OsmhanKb4oecvJO1
	 i+tHl3+rzFaqGCUxBVATC+YKRlzx9WaIoItzdyY+0Ho4TpiqAO3P/g9AMLYvuodsY
	 Yis2LVDzWHpnykeSleFqlPp3oDq0wIFa1TEv+Az2/mxR2QHzBlFBW6iBogEJwn4+H
	 1LBOjDpxqNlsfGHQSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MiJVG-1qgo4d3K9m-00fP8b; Wed, 03 Jan 2024 20:27:29 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: wmi: Decouple legacy WMI notify handlers from wmi_block_list
Date: Wed,  3 Jan 2024 20:27:06 +0100
Message-Id: <20240103192707.115512-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103192707.115512-1-W_Armin@gmx.de>
References: <20240103192707.115512-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8VjvokE+057OD4NQMtuCQr7eqzWSRguTLtY8aTNcctTDHkuOaEJ
 iiWi6zPLPPMU7GPx3TsD+g4l6lvDsyZk7VeYiNcY7I3ADMj/N/U0wHNvCN0HMsphpdfGm5k
 7lvJxGsE8b2r63ocJ8X+t5dRioGN/hPRt8vhkQoA7woixuMIgqJZQV0tmxyOfO+b21od3sc
 JVDps4TaQ2Rc7pu0ToXZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4+USwOUB8iQ=;64qRjiptdFcSt8oxtlcpqgqHYKV
 Du+7dJiukKnSDpHszVn1j8p8TLK2oAqaCKTbWVGY+aOW24PrC5cJCPXn7r1wcB+6L5nzE9LGN
 q9TJwksmhL38ybCoswC/gKIimzvI4U4FGib3m/1yjriSlr5Wup2uWZoak2Ty5bjnoKFA8S0cL
 /ZoBlq8wJDoNqs7wSlC8r/hn8Y0dS1DbYdZAhvLT20O6WetXShpx8DNYt2n/YU7AgcMR7uX5A
 DCuhXE9HEApyzr9qA3X0zrGUDIq3Kh3dYpagESzPQ8PvcgV82oglQ7X02s4Ywy9QQmgSwYE4t
 jPC6nnQ10k/TS31M8PfaCiyIEhm18aVw7Iz46XmtG2Iph35SYn1U37MF0Y9tL0v0P3t9/zfkR
 4x/lBU0+bNAQPSm4JBYy6G4Tgz5IrPdNv+JCkxqdTzH9vzJaT+el4qMHPXWAgzqkP6iCiIscm
 sNcLKXuMhU7YAz5i8UUGCRdUbWV4SM7qtd7XYdhzmt1rxcyaf9oHU97csYnfc/lV02wA2HFjy
 Lhf2E9u/LF4TswoW8abPna7KfPHtyT11SYgFSL1n5WpyYYLPUk4Bz82g1TKbbcXPnxJgFu/Xy
 YSRGBXBRSgsuBs7g78hk6tK2aYxlyIl03xa2tRmEzTJpEWZvwayVBjuwidfOjPFxNSRCG8kGf
 xnS2YOMOfG0sPEXF9Of1QtTqA3PptblL/ts3wrt5/GVxsUmAonlKSImfXPYcmgtUMCM4XU0UH
 5vTGcbXfv0dpGtG7RwMJYZLMEQ1x4nalD6NOtzGbLjPJoBM24Oax3cIyhQXl1BQBAl0u62oCi
 OVJ2+47l1xLDs2eqNmUsBzaFumXtFdDvc2JDbkZ7//RnAXeEX+9qCnggVX3rSXdSmOwUcuLPl
 V+MH2jHpDeIdS8tZxKAAG6LcWuesM1hao/jlp0lU2taayXg1ZrV9g34TaXszgSYaZ4e3Eg5oa
 6QX4yQKJPlVw1ATa2gdOKBKdZjw=

Until now, legacy WMI notify handler functions where using the
wmi_block_list, which did no refcounting on the returned WMI device.
This meant that the WMI device could disappear at any moment,
potentially leading to various errors.
Fix this by using bus_find_device() which returns an actual
reference to the found WMI device.

Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 118 +++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7470a149b254..6a886635689a 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -218,6 +218,17 @@ static int wmidev_match_guid(struct device *dev, cons=
t void *data)
 	return 0;
 }

+static int wmidev_match_notify_id(struct device *dev, const void *data)
+{
+	struct wmi_block *wblock =3D dev_to_wblock(dev);
+	const u32 *notify_id =3D data;
+
+	if (wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *notify_id)
+		return 1;
+
+	return 0;
+}
+
 static struct bus_type wmi_bus_type;

 static struct wmi_device *wmi_find_device_by_guid(const char *guid_string=
)
@@ -237,6 +248,17 @@ static struct wmi_device *wmi_find_device_by_guid(con=
st char *guid_string)
 	return dev_to_wdev(dev);
 }

+static struct wmi_device *wmi_find_event_by_notify_id(const u32 notify_id=
)
+{
+	struct device *dev;
+
+	dev =3D bus_find_device(&wmi_bus_type, NULL, &notify_id, wmidev_match_no=
tify_id);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	return to_wmi_device(dev);
+}
+
 static void wmi_device_put(struct wmi_device *wdev)
 {
 	put_device(&wdev->dev);
@@ -571,34 +593,30 @@ acpi_status wmi_install_notify_handler(const char *g=
uid,
 				       wmi_notify_handler handler,
 				       void *data)
 {
-	struct wmi_block *block;
-	guid_t guid_input;
-
-	if (!guid || !handler)
-		return AE_BAD_PARAMETER;
-
-	if (guid_parse(guid, &guid_input))
-		return AE_BAD_PARAMETER;
-
-	list_for_each_entry(block, &wmi_block_list, list) {
-		acpi_status wmi_status;
+	struct wmi_block *wblock;
+	struct wmi_device *wdev;
+	acpi_status status;

-		if (guid_equal(&block->gblock.guid, &guid_input)) {
-			if (block->handler)
-				return AE_ALREADY_ACQUIRED;
+	wdev =3D wmi_find_device_by_guid(guid);
+	if (IS_ERR(wdev))
+		return AE_ERROR;

-			block->handler =3D handler;
-			block->handler_data =3D data;
+	wblock =3D container_of(wdev, struct wmi_block, dev);
+	if (wblock->handler) {
+		status =3D AE_ALREADY_ACQUIRED;
+	} else {
+		wblock->handler =3D handler;
+		wblock->handler_data =3D data;

-			wmi_status =3D wmi_method_enable(block, true);
-			if (ACPI_FAILURE(wmi_status))
-				dev_warn(&block->dev.dev, "Failed to enable device\n");
+		if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
+			dev_warn(&wblock->dev.dev, "Failed to enable device\n");

-			return AE_OK;
-		}
+		status =3D AE_OK;
 	}

-	return AE_NOT_EXIST;
+	wmi_device_put(wdev);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_install_notify_handler);

@@ -612,34 +630,30 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
  */
 acpi_status wmi_remove_notify_handler(const char *guid)
 {
-	struct wmi_block *block;
-	guid_t guid_input;
-
-	if (!guid)
-		return AE_BAD_PARAMETER;
-
-	if (guid_parse(guid, &guid_input))
-		return AE_BAD_PARAMETER;
-
-	list_for_each_entry(block, &wmi_block_list, list) {
-		acpi_status wmi_status;
+	struct wmi_block *wblock;
+	struct wmi_device *wdev;
+	acpi_status status;

-		if (guid_equal(&block->gblock.guid, &guid_input)) {
-			if (!block->handler)
-				return AE_NULL_ENTRY;
+	wdev =3D wmi_find_device_by_guid(guid);
+	if (IS_ERR(wdev))
+		return AE_ERROR;

-			wmi_status =3D wmi_method_enable(block, false);
-			if (ACPI_FAILURE(wmi_status))
-				dev_warn(&block->dev.dev, "Failed to disable device\n");
+	wblock =3D container_of(wdev, struct wmi_block, dev);
+	if (!wblock->handler) {
+		status =3D AE_NULL_ENTRY;
+	} else {
+		if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
+			dev_warn(&wblock->dev.dev, "Failed to disable device\n");

-			block->handler =3D NULL;
-			block->handler_data =3D NULL;
+		wblock->handler =3D NULL;
+		wblock->handler_data =3D NULL;

-			return AE_OK;
-		}
+		status =3D AE_OK;
 	}

-	return AE_NOT_EXIST;
+	wmi_device_put(wdev);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);

@@ -656,15 +670,19 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
 acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 {
 	struct wmi_block *wblock;
+	struct wmi_device *wdev;
+	acpi_status status;

-	list_for_each_entry(wblock, &wmi_block_list, list) {
-		struct guid_block *gblock =3D &wblock->gblock;
+	wdev =3D wmi_find_event_by_notify_id(event);
+	if (IS_ERR(wdev))
+		return AE_NOT_FOUND;

-		if ((gblock->flags & ACPI_WMI_EVENT) && gblock->notify_id =3D=3D event)
-			return get_event_data(wblock, out);
-	}
+	wblock =3D container_of(wdev, struct wmi_block, dev);
+	status =3D get_event_data(wblock, out);

-	return AE_NOT_FOUND;
+	wmi_device_put(wdev);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_get_event_data);

=2D-
2.39.2


