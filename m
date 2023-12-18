Return-Path: <linux-kernel+bounces-4291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07028817AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83A51C2237A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49474E06;
	Mon, 18 Dec 2023 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q40M1z8L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6573478;
	Mon, 18 Dec 2023 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927477; x=1703532277; i=w_armin@gmx.de;
	bh=vd+n3ykeVoDXsg6HoG9Wxn2uSy55W8TbILg2TIyowI0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=q40M1z8L85apvsoIEutg3OZS/aAAU5azx+5qVu0PN/3y7vobOfHEcE7O6Zuny24a
	 atNqIQAd6uvFCdwfFhM9fbK18MHxTenlrNgDFxIEYZUdYjK6ygPMmabp5cRD2FatM
	 eKfO2ikUapLxsuDfHfAP6Vr5B78aLHlrBTsayGKG71aDhANWiupCFVZYVDpB/mbnA
	 bYDMkSbSiOeaRmBqOt0GkNC+ewQfVOpcT4uZAd8pUvZyog/VpN9lfk5RXvVUW5vZt
	 a2fvVeNFQ7x+mUH+HBmc9DDw1yrpWmLaau9NoaL9mScLYugIQHgL7ZZqKp22+NU82
	 y5ni20mgvwqOxMVqSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mn2W5-1qqjRK2dwF-00k8C8; Mon, 18 Dec 2023 20:24:37 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
Date: Mon, 18 Dec 2023 20:24:19 +0100
Message-Id: <20231218192420.305411-6-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:W5xgdnKOVfKDbnxkuaVs1m5ipC0Omumkv6Nw8+kiqzsWz2uFQGy
 963QzzGnaxm9N3GbKtkaLbzhdPNzSV4MRljTq6vRMfcPyuGe7evQ0I7lloSVOOhU6QM3ism
 qndCkPHV2hLUAe6CsO1233FP8MsiW1TGom8c+2W/RekfUd1+o7qpWh/j2hMsP6rdZfoJ2VO
 hWEls8PUwKNcnGFDHcH5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3rnNqCtiyqc=;Peo1RUPq8Yka48T2bAy/0l0VKJE
 RxsJJ6gKV/eZTf6OQ//91pyDtqbbolgEZXyNcQLlRqRwfgSOORCC/1cbkCYu4xx3hBOaS4ocs
 3KKoLVMg7g5kV60C//5uB2T47taxNKp+MFpOVHXkjDSjQAC8OmWkbCgoNVVHt3tkDeEcXDoTs
 TQAbcFuxuAGAyRym/KnFIb6MBVnHmimMNXoPqogYXnYZER+ASoCpCRtd9PzS9hKislEBBlYo9
 GoHSlLvd5kaBU0OcZHoA8ekjQA8NcCDb1yS/dudKHzMQx6joXp3087JWHOx+Zy8qG6ROeSnri
 mrLM3EBUzEyk8Q58+aBb1oGz3oPvDj3PrLBxj6CzRkPJJ2JOoV/8v+uxddbJubaauFHGT79Ni
 /iOyAOUK/Y38gkYPArnu6TUWG3VBxvXdQDN9wd/mJcF/YkdKRxvQwzqyMETTy70d2ldcQi6qE
 1sTAd1RgenXTUGIbBNr18FhjboOmq3WBy3ShKBaMikYjz16S2JbBJluBdhraguXmnDtGvsJce
 lYu0vjWy2cXHlsUuPgcLIULoIU2bJ56W/yutbGOghfu3nUtbuPDlK81Bx/KpMHFGZq5QgsCmL
 fwz5d7C7inPBVVvZUVE5BkDeobdy1FJpZdG4SZErsLL5g8IqHFvDZhJ+SarzmnjLfbbMaBWFN
 9RzkX9ObenzGXlxGkpaGMNrnatLN6Y94iMmPDF2Hdf4dd55IStt/KW+/3VzNWkGOzmhJF5OBC
 kSFOrtEkskjVG6pdnfwfRzA33QY2wjnATqJM1bfuvkR2aDAoTZL8hQ9jqeRHcIcjDAhsJmcyO
 Gp9qO+HBpPb7w1THZS0bAEab4zBq5/51s9nTCxZWyKAI/CO6mK/CGWb6Qaq9ArG+x64BL040E
 +djHbWVcxgg6LCEYCZoBUDJoLHXb2sBcheL7oop6r8tFvIeRaYridNxuYSiRkeCBBCauAcX8j
 z8onX57/yuzBaalgh1SUB7v7kkc=

Currently, the ACPI notify handler searches all WMI devices for
a matching WMI event device. This is inefficient since only WMI devices
associated with the notified ACPI device need to be searched.
Use the WMI bus device and device_for_each_child() to search for
a matching WMI event device instead.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 46 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e2bfdc61c4ce..559a99ebc624 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1176,24 +1176,13 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
cal_address address,
 	}
 }

-static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
-				    void *context)
+static int wmi_notify_device(struct device *dev, void *data)
 {
-	struct wmi_block *wblock =3D NULL, *iter;
-
-	list_for_each_entry(iter, &wmi_block_list, list) {
-		struct guid_block *block =3D &iter->gblock;
-
-		if (iter->acpi_device->handle =3D=3D handle &&
-		    (block->flags & ACPI_WMI_EVENT) &&
-		    (block->notify_id =3D=3D event)) {
-			wblock =3D iter;
-			break;
-		}
-	}
+	struct wmi_block *wblock =3D dev_to_wblock(dev);
+	u32 *event =3D data;

-	if (!wblock)
-		return;
+	if (!(wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *event))
+		return 0;

 	/* If a driver is bound, then notify the driver. */
 	if (test_bit(WMI_PROBED, &wblock->flags) && wblock->dev.dev.driver) {
@@ -1205,7 +1194,7 @@ static void acpi_wmi_notify_handler(acpi_handle hand=
le, u32 event,
 			status =3D get_event_data(wblock, &evdata);
 			if (ACPI_FAILURE(status)) {
 				dev_warn(&wblock->dev.dev, "failed to get event data\n");
-				return;
+				return -EIO;
 			}
 		}

@@ -1215,13 +1204,20 @@ static void acpi_wmi_notify_handler(acpi_handle ha=
ndle, u32 event,
 		kfree(evdata.pointer);
 	} else if (wblock->handler) {
 		/* Legacy handler */
-		wblock->handler(event, wblock->handler_data);
+		wblock->handler(*event, wblock->handler_data);
 	}

-	acpi_bus_generate_netlink_event(
-		wblock->acpi_device->pnp.device_class,
-		dev_name(&wblock->dev.dev),
-		event, 0);
+	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
+					dev_name(&wblock->dev.dev), *event, 0);
+
+	return -EBUSY;
+}
+
+static void acpi_wmi_notify_handler(acpi_handle handle, u32 event, void *=
context)
+{
+	struct device *wmi_bus_dev =3D context;
+
+	device_for_each_child(wmi_bus_dev, &event, wmi_notify_device);
 }

 static int wmi_remove_device(struct device *dev, void *data)
@@ -1300,10 +1296,8 @@ static int acpi_wmi_probe(struct platform_device *d=
evice)
 	if (error < 0)
 		return error;

-	status =3D acpi_install_notify_handler(acpi_device->handle,
-					     ACPI_ALL_NOTIFY,
-					     acpi_wmi_notify_handler,
-					     NULL);
+	status =3D acpi_install_notify_handler(acpi_device->handle, ACPI_ALL_NOT=
IFY,
+					     acpi_wmi_notify_handler, wmi_bus_dev);
 	if (ACPI_FAILURE(status)) {
 		dev_err(&device->dev, "Error installing notify handler\n");
 		return -ENODEV;
=2D-
2.39.2


