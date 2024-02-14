Return-Path: <linux-kernel+bounces-64821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE385433E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391B41F2924B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F6125D8;
	Wed, 14 Feb 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hAVtLGO5"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1BD111B7;
	Wed, 14 Feb 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894294; cv=none; b=huY+KPoWAAEq1otD9Tmwc67Lt2NX2KxyBBAJuRUe58K7g6/334ofEpm4cLJyYcsE5QSA5bQx5WkKjc8Xt8ZaHoCjxOc/da7GgP12DMRWOs9Er84nzOXOYBurRKaoc+ir6BTcfp4Uttn6hLrocTIMWV4nrzmgGzAcLTq19AL7wrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894294; c=relaxed/simple;
	bh=tO1rt9sQLpmLbk3cUV+lqq1aBMgblCUNE05HLWEb0Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8PF1jFR4cm6z7m12kbWc3SvqFg0F2u6xHkXEhlJVlPFbFt8VVtQytMrCP/OTyMeP8vxVHPCI3METpbyhoiOkhasXXTEMx0p9jK11Qu2tLZWvF40kxGWeqrmBZqV+NLeHXfdCmHLgHIdhybNbeuqJ2qoJ1zOmEHMZ3IamVb1NVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hAVtLGO5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707894281; x=1708499081; i=w_armin@gmx.de;
	bh=tO1rt9sQLpmLbk3cUV+lqq1aBMgblCUNE05HLWEb0Uk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=hAVtLGO5ThSQjP9r4m2y7axuAVSrcSwlCzxlClStIOw50BNFfTflvjnwLXiBFm5v
	 VH0BQGB9J3vY/KtEJV5u5LRsGvYj77ThoLrURuOs55tF7s7B2pWW+1X5p4XTlcE2z
	 FPu2QCs3630mLLRUCwm8SyLMaI3UG8l/4DjnkpXc8WctgqQMukBMCjwC72ScSPoIF
	 mtURnTXyV94rkOXq+5ygpOTwFtQzDY0cwbJA1+HW+3p7FqlSr7ePcJbq8sS5k0RM7
	 AqiE/l3OH/iiduSv6RKBJUebDLJXxErGf+kwIsSG5PITcFq/uBlbx+UQTF15jk/hZ
	 KJMtv2Ld+vIhax+tJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAfYm-1rgiu12ZVg-00B4mZ; Wed, 14 Feb 2024 08:04:41 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] platform/x86: wmi: Always evaluate _WED when receiving an event
Date: Wed, 14 Feb 2024 08:04:31 +0100
Message-Id: <20240214070433.2677-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214070433.2677-1-W_Armin@gmx.de>
References: <20240214070433.2677-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+6W/BQoWwYfBe5+yyoy2+YAd6wdh55BIvOs3MTRktC1NO3pmDk6
 UkhTfu0U5yI3jAfiQ96L5Vj0J5fdBzYQ0QXVBU20mdh/tTFdiRBxSDEzZ9FizC0PdxmNGj5
 A9kMcRymzVYypDaLOjSXNUw8ROHcAY93aUXBbOjlMjnN/YFMEIxwrb7LlH2Xt46eWVHcCX5
 KZvl7llDOT1IWRRD0mKHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B9+M+kARpvM=;29Yz0UMEfwr9Oh6FW9Ck93D/DSn
 mCOXS5qYb6llM41K65R9sPySimLwwLV9kpMk0rZ1ZRbPDQZ4AaGeJA6OEiR9+ZOGJb5r0CstO
 AyAknHNoPbZqV8lm3aBEcTJa26lN1eG7Z1YeJt8zf5Ft0Ip79CdAWP906tNtoiq8NZiCXXDs2
 ke3DCNMBgZzbajRaLyT6M4TKJ3jrBKexrbcfSgLnnqFVIpY0+/BbDn3EuVIDLp7qkDQpV3IuB
 FflRvIduUra2m859T0d7Cpa15SIgHaqNO76jXv8iIczMokba0CmHeoBJHkxhlbCcC+DKNhyTO
 8qMIlQVKUmAlYBQOQYukFtzJPY1PyIsizJESzCFV/ycSJvme6gXZ9pZQtf4ruAcapuiWABq0w
 JvXovOw3sVk2MDqOdhTsTUzrYy7Rqa8NXMR1udkzNlpcEfPBUx08jtQQzhSnnanK8QOLI3Uav
 qJVWStBMpVP/Pm13GCW753T2XlcbEklOI2/kDQ+6w7ObtXusZuxsgDTLrIDwXclenpA6tK0tv
 +XxO3H29Qp63dydr+ZA8OKskzoUsX8fZcZga6rXGW4oLe0ObJXOJ/wCKSVVZ/ZYDIh1m0icdl
 P8NrxvsHW7P67pWBSZ3vusFclcO2cbyB1Yqmr4Um12bUPjDCCNCISWK4qjuZi6fIR+v0TvrXb
 IBhD59LlBwayERL65Fd8kjT3ZUCCDDA567tlE9ySmzfg44dmLrQHfC/qsgG8T7QEJuU/4wh6g
 a5s7N5O0/5XK+2Y5bjrN3HipvNqqclnxwgAXT/oTn7Mj0UYoSA6yRNQQLo/vIPFj5lnmSADwa
 wlmB+A7T2jvqtHSw/WqOfGue8QZSOl73kUWBzFcZ1l6ss=

The ACPI WMI specification states:

	"The _WED control method is evaluated by the mapper in
	 response to receiving a notification from a control
	 method."

This means that _WED should be evaluated unconditionally even
if no WMI event consumers are present.
Some firmware implementations actually depend on this behavior
by storing the event data inside a queue which will fill up if
the WMI core stops retrieving event data items due to no
consumers being present

Fix this by always evaluating _WED even if no WMI event consumers
are present.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 67 ++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8a916887c546..8622ce3fecfd 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1207,37 +1207,46 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
cal_address address,
 	}
 }

-static void wmi_notify_driver(struct wmi_block *wblock)
+static int wmi_get_notify_data(struct wmi_block *wblock, union acpi_objec=
t **obj)
 {
-	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
 	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj =3D NULL;
 	acpi_status status;

-	if (!driver->no_notify_data) {
-		status =3D get_event_data(wblock, &data);
-		if (ACPI_FAILURE(status)) {
-			dev_warn(&wblock->dev.dev, "Failed to get event data\n");
-			return;
-		}
+	if (test_bit(WMI_NO_EVENT_DATA, &wblock->flags)) {
+		*obj =3D NULL;
+		return 0;
+	}

-		obj =3D data.pointer;
-		if (!obj) {
-			dev_warn(&wblock->dev.dev, "Event contains not event data\n");
-			return;
-		}
+	status =3D get_event_data(wblock, &data);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(&wblock->dev.dev, "Failed to get event data\n");
+		return -EIO;
+	}
+
+	*obj =3D data.pointer;
+
+	return 0;
+}
+
+static void wmi_notify_driver(struct wmi_block *wblock, union acpi_object=
 *obj)
+{
+	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
+
+	if (!obj && !driver->no_notify_data) {
+		dev_warn(&wblock->dev.dev, "Event contains no event data\n");
+		return;
 	}

 	if (driver->notify)
 		driver->notify(&wblock->dev, obj);
-
-	kfree(obj);
 }

 static int wmi_notify_device(struct device *dev, void *data)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
+	union acpi_object *obj;
 	u32 *event =3D data;
+	int ret;

 	if (!(wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *event))
 		return 0;
@@ -1247,10 +1256,32 @@ static int wmi_notify_device(struct device *dev, v=
oid *data)
 	 * Because of this the WMI driver notify handler takes precedence.
 	 */
 	if (wblock->dev.dev.driver && wblock->driver_ready) {
-		wmi_notify_driver(wblock);
+		ret =3D wmi_get_notify_data(wblock, &obj);
+		if (ret >=3D 0) {
+			wmi_notify_driver(wblock, obj);
+			kfree(obj);
+		}
 	} else {
-		if (wblock->handler)
+		if (wblock->handler) {
 			wblock->handler(*event, wblock->handler_data);
+		} else {
+			/* The ACPI WMI specification says that _WED should be
+			 * evaluated every time an notification is received, even
+			 * if no consumers are present.
+			 *
+			 * Some firmware implementations actually depend on this
+			 * by using a queue for events which will fill up if the
+			 * WMI driver core stops evaluating _WED due to missing
+			 * WMI event consumers.
+			 *
+			 * Because of this we need this seemingly useless call to
+			 * wmi_get_notify_data() which in turn evaluates _WED.
+			 */
+			ret =3D wmi_get_notify_data(wblock, &obj);
+			if (ret >=3D 0)
+				kfree(obj);
+		}
+
 	}
 	up_read(&wblock->notify_lock);

=2D-
2.39.2


