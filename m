Return-Path: <linux-kernel+bounces-4337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF21817BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08981F2391F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B273485;
	Mon, 18 Dec 2023 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WvYECGnD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39A740BA;
	Mon, 18 Dec 2023 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930793; x=1703535593; i=w_armin@gmx.de;
	bh=vd+n3ykeVoDXsg6HoG9Wxn2uSy55W8TbILg2TIyowI0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=WvYECGnDW1fv+Uz3F9LzaMiEzwCoYpg4VF+QTQoDtnt++fZpn6ICameiB00Jz15Q
	 6ioIKy3m8OM/0yAPNFY2NQfHn2XE/lnpLv9kLamvoDgRjMtf7FHivBwWlWUYgidJ4
	 MALt/32JBU812O2BdvPYkV5AiugNii4ro60E02zTxZLdqZfLItcrlHFidYw61D4U8
	 NH7W8vT87QVXf4+8CbcyzWhUFuQp4r/R0Ohv4dB1Lm5zhi4374Ua/YDN7gerl9uSb
	 OccvXegf398jMiyM+KSiA0Lc2c8otc/I+zlrXhm8EdVeqIkF/Dy3IgfStKZxrPD3o
	 M4YaMw/DF7rlHxX51Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4Qwg-1r84pr2BBW-011TRD; Mon, 18 Dec 2023 21:19:53 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 5/6] platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
Date: Mon, 18 Dec 2023 21:18:49 +0100
Message-Id: <20231218201844.2860-6-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:R3fFXk0UPoI6fhhBGUMusr6zixyck8kswZ6+1e1/Ps3v/C4QV3e
 N5Zf41d6+X1FGQp/4Ah8Czq7nXaZV7EvYydZx/w3thnSt5E9lzqBovMTcsGL52I/1ZqF2xj
 Bqd7Mhu2PeL453jvpKzdWedXxamiDQazquUCDHorh3Ew/4Q6vrBJY/jm5roWhUPMYf3neGx
 qWtqQxEGjVHyYQJfMCFFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mFeR0J8JWe4=;Wh2+kYxhQeagspai533jgcfCaKZ
 7MkZNE1FcZcwy2aktttO8vpUMHG+5MsJcOeNviIvSihCqs9sUoKeL9jv4qm6lidluUnuU+LXO
 arufAGvzFM1MBPkxI5tWLq5NG863UvP6g90zJkC7IEsGJ3mDzwulUwiZ1d1lHCOeP8hdG3kg8
 QXkIxVJX+LP1hHJDFdi0gDl/fALUjhywNMhCCp5VhLziix/wSjuHPYiFFSpACprsEgIBroWti
 V8a5nlVNnSgFSI5kcmhZgOkmGfXbtpniUnl5haWwaHjk7wuC3k5QDT4QyMsACdqxCo34EyEuv
 iESQHu/tl4LKtmK/lXPgzEl1Rl0rmucpzyjt0QRGmpjqSDCey21t41yPPuVunFtTA7vW9jPmQ
 AV+kT8VrUx3Nd3AwVyFriSSED6mq6uLkJ4VVLcwTrLK1lqKplBcZJivFlvC1Z2JaTxmTJxqe4
 IYbODd8GmIUqxj/LU++Ifxqpg+syJ+YYStwDCKwdLO9wtqiXxPud0NSfq1nwrJe9hvpwWYNGR
 KogYBWR2uJfo0pJgy4C2ctjyJ/5CO3hmdyY26hx7BVP75UtTXlACr4bLdn7PDaGCV40flO2Q+
 0s6qam+MQv6YyfJMEx3BZp85sYJlwTMSnDO5Nj2HMZHUBP9kuodWmJmuYSWxCd+qXpidC9PTW
 P6xnW7ldgqK9Nq/hi+vLo4YVIMcbtqn+wKuhY+DZll9WNAQ/pCmOnRXrx+MhDnKubDAtjEV4G
 Blf75tM1f58GZvpFBuwnxu5RygE+opz5Ui38KnJcvUYeYvFJY5lTms7JLn+gdi8e8N+H/BWqx
 6GFMu8G4o1owrVDR7TIY1rNEbD2zP6WsyakyASovdVMMkuf0//l5DW6PhIu+GXnK/lG9My/Xt
 hdd8hBfMwsFxwNoT9eXNyh6YmyxWxuWY9unLO89qyH5BoPL9t6Xz/Bu/NSINt4BVeGLvFtyrD
 0vujWsddNMKDITTURmW+hNfmX4A=

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


