Return-Path: <linux-kernel+bounces-1943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D16815628
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC2F1C247AE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212DD511;
	Sat, 16 Dec 2023 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GpprZU2K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F03B5679;
	Sat, 16 Dec 2023 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691780; x=1703296580; i=w_armin@gmx.de;
	bh=duHpCA4cOBrSH/Azl/sNbIHKrTis7PHVleO/ty9RZmo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=GpprZU2KiWMpPjwEShF4YUHcsyJpRhktiB800789WqInZUdS2rnGb6WYXkFKq5xP
	 s1i7cJK3idleMqgCogzW2gkvqFH7wN6YbAwoHRCyw2J6zN1s5uJRps0awTHVBLp9q
	 UceKBoEN6utTZJBc0kwNdiRpU9wNfyLJC6jPVsxq+G4omb042RuyofMpEsbKQOEyE
	 6qwzNt8kGIeh6xyeQ+o0Bm6F6JR/jD0xyU2RS5uRwkb/aLmtIgabNoM8uhP5XuT+z
	 gpELwh4wh5IRMFi47FCNvkVydarFJLA0IsvEKNAXFFpzrgX8Ums/u1YUrSzLCPukB
	 w2UlYggollzfLpcNIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MOiDX-1qpONX21E7-00QF4D; Sat, 16 Dec 2023 02:56:20 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
Date: Sat, 16 Dec 2023 02:56:00 +0100
Message-Id: <20231216015601.395118-6-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:ubTPhVWqSQKfAB9dDY6lfW/JMpvW9kP1RzZke8D4rE8HeJBd6Aa
 vWU4xQ8tV5EmLlrjemCizNm8hWrFL8+d3aOXd1uBxJLGiasWURE6IIS3jfK0CkCCu/hXpi8
 gy9qesTcXJ3YCjI340HzTLrWtJEiRqz9ClEVFwAbKgy4qDjIUJakDgMsPpL09jqDWuITRHw
 clW+S3F60SENi3WCeMAFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L5925xHDSAw=;0fc22ktMDiR52HFzvVcn3UqAvGB
 5HCd1QbjUSz3jEgRNFrGvdix5tCuGbhoE5kcaHcDLv1BX2zFTkMwZuYONo7EVEua8kKiEbuQM
 igaRGnA4gj+TIMtIo9O5hE5tJCsZ2Vl6YSTC0O6EgZFHawPGw40+lMYuH6yzgSGwLQhmd+9iU
 kSS9kjO2Du2+Y1zJS+cJPrs412tQ1GWvQkAy0VqIL/+KfFoZjaQBK7JKleG57+VsuMQfFd0Sl
 srghbJwrDbzaZVhSTz/+GQ4Vhul3TewvQyjX0lxzHH3wSqphDzYHXkIPMPVOQ3cGoSnQCp9uN
 EWxR6nIfGFRV2csvV4kHmkioIisfOO9oeZHC1YiQhBL4MvULU1QnlEWLEfNFuK6HBULrXxMn5
 kwVXImQ+nO9OI4eT1LuDqZH7iioGGSVYHdwRXC28N9BNFPhOSAwl+EP0/lDlL3sEEIn/teROd
 S/W6PcJGWz3wJxPpacDG7ziIXoSP5nfJyslKvmxDico/lGn+F+UZeMqNOFjGwlsVopyNe2aHf
 hvif6oDVbIwE+Fgxl7HAcWhTk3XrO5vPqsR5K4HNX3yEcoghsW/LAniXy3pB9ImN9009Af/96
 8NJfQhGX2H/cOE7jezBeJxwxMR7tTfrjLlqpYjo0AXpd1Hy/p7vWLed+YwGPF1mDN2jLjxRGc
 wZkVsJM18x+sXFl8Nhe2DiBpZ+st7WctdgVWuPhZLbf9OYM0lTNE+WRiYFxoX8xLAf/XUYyS/
 GqG7Hxoc74nlhykr7EsKzEJ0amcI79/PcVA8t3yv1pQ3S+uviS6ACvym4hGGkMN+YTKGx+PBS
 Lx6+BuociCs3ECWZyVt9TIdCY45mtoeIkkOchR6X1/I6UsTpur99KorwBQSSTLtLgRm2DTLHm
 eUR3vNwKRcMQbSOm7nG9FSr7xe9TjLDjV/rxDu3/d9LqikneRhR6ptTvkHg7LtNONWM09GoUI
 zyonCPnVEDtKmh+PcsEQo3QXEEg=

Currently, the ACPI notify handler searches all WMI devices for
a matching WMI event device. This is inefficient since only WMI devices
associated with the notified ACPI device need to be searched.
Use the WMI bus device and device_for_each_child() to search for
a matching WMI event device instead.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 46 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 61849a43e2c2..6b581c772fd1 100644
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


