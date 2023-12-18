Return-Path: <linux-kernel+bounces-4324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE60817B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67211C23326
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028176081;
	Mon, 18 Dec 2023 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GBpWaHJ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5827348C;
	Mon, 18 Dec 2023 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702929342; x=1703534142; i=w_armin@gmx.de;
	bh=vd+n3ykeVoDXsg6HoG9Wxn2uSy55W8TbILg2TIyowI0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=GBpWaHJ+bH5EaIkMJV0ZUU/NADA8IaXiCKIZM7TyssG0Hi220AiK757e0C6EaR6K
	 vgpP4HFYOREhSGXAtM+Ir/8xKL4csXVuoAbHrqcNOAn+b/ep13PyhG993Bd4YcmdY
	 mkh8s1LWQVXR+1e5+9Way8hebsWfPngAhjyFEUWaUfArCYIvGvt0em2vsKTEuPBZk
	 5D3Az1oC0zkYt0wy6RYjWHEY5J31MGIaCnvMxjkXiN2cdY/N2uvcaNdhD/Co/SdgH
	 5jTvltWTD30nbjWYVxUbrHWLN+wRyYGvnMaZLnfBpN9roOkYxbmaZ4uDpt7YfEx5+
	 6nckeaZt0ojOsqckoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MsHru-1r0PBs1vf0-00toXW; Mon, 18 Dec 2023 20:55:42 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
Date: Mon, 18 Dec 2023 20:55:30 +0100
Message-Id: <20231218195531.311179-6-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:y7okMXky5VNG+iTpPst6EOYsDtodFCWhYyJabz/08NN0B4xOJ65
 lTHMz42MEtRdxm/qqg5MQo3O0MTmwSztN0OvnJrDKy4QVQ7J9q56IMYOAjKQb2b4zmMqtG0
 6VaHlziYN857J8mplne5pi43L1UMHCaYkC4DcNN39ZRCLKnBbp65+UoSPlTl0FlSxYGUos5
 Yd/7wedmc4/7H5uUOJ25A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7lcsT6aLjgU=;YWnRXlfrHzr0DEmhBo88e4+Vhq5
 VDx/rZHS83z8zmAOkBDM6Sts+lGILyZVOmnobRjv+tacJ8aAk5/Ic6osqV4N7MJ/N3HQenUxY
 e/rPfjZsb8hnF0PHOOZT5BFTMaUsvDR6KNDMSUuJI7UCPc0vUO3yGTgckB5+5Vmb/9QCfJmyH
 pznXPyn9e5nnWtfoFKtKNLax7V4QTdr3FDLN0rZzQbEFHsRJl5IwQB3n9Urk9jTA+CYhL1aoN
 zk6XWewzXUm/uPsAugCu5s6I6EdrEF9Zs6WdBTGMatQAuUkzq75VYtXQbM8r/glYZWT2qXV23
 dav7jeihK71FD8XkydjhF6wRQCZ6VGVPedBSuy2XhCZZzts/DaA3nU20G/GB9aPHHM6rNjlT6
 eVjWKdbxZ/5K/9fKDKuqXlOjR27RmXWCA9Wd4vSC8acleZ7g3UxmvP7T5WDOwMWcW1GF0uGtC
 KYX1/9pY8OnHS5JnBiBnP1ZS7OGc2QOGNWiwY5UtBa5VKQg+z1Bxl2SPk+SY1M1+gXTasdMWb
 SOeXGUZ7Amo5w3UvNZHb4Oq57KknwVeooR5/WbqBwXYx74AwPeWg/0T9qVfr9iC2sR73dJA1y
 vDikphC2GZBcaS8aCYjOMF0tN5gqbYmb2v29MMDLDxOkqwvo9wy2ANbRl3oucGBO8OGCfgH6k
 fWyCcI4vvMW4g00J5OhWW8ajBHN5vo+hN/XBATHxQ+DWCgnd+BW1nGuPEnXBrQu77STTyQzf0
 +dlGtBmABJsz2oKjUhy1PNnYX3/L835Ro7Rf3rgiXAxabqx+wM/tf079cOl+AbkA1Ygm+sh2i
 QoC6djbnLh8J1eECGaJVKJSEi7kKFkXM023P7Y7HKqtIVIWz9xN8XoimBPX1wZ9eTQR/66wul
 Eh0QKhSxpMoVBjY6f+twBd7anYlIzYr5fFW1PuApCMXRhXFXjr7hYUZ7trKaL8RNeitnbVMWS
 7+x2q9ciifVNZ0OeCaMhHI5UJQg=

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


