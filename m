Return-Path: <linux-kernel+bounces-71265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0B85A2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3B01F2230F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827742E834;
	Mon, 19 Feb 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AmGEAZzJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB22D60F;
	Mon, 19 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343981; cv=none; b=ZLXsEmZlGKYtM38JXVUWWuGHdTCu93/BRIrcRbt5sIYLO+Q9MKo8QUg5O0Kbvjfgm7FtDXN+pcD/QRk+cJEFlk0j6gg5YhsxmQg9R+iDegHzweDdV0i9TedfYdO1vAqLKCh1GsgNig1S7vkkUYNS5OF94TPkNLKcfGneL9AuLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343981; c=relaxed/simple;
	bh=gWd27/VotVWwvHrKqAHO87FjANH+9qAlu8jCJq3fQ98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp1BaypHd2KsR6gJWolKg1wVbN9Y8c1G5+Yb3cDMOveaL9Vm4SrWuJkUj3eIRRkdEm8kAm6Og1KprB4eecBzbNRWgAGszmx0AmG+WaGnyGMZk3eedlBfFDhjfKqM5r8o6UrLB0j44kDEEsQDzDks/71nwyDelOdNhyOishY8tzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AmGEAZzJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708343969; x=1708948769; i=w_armin@gmx.de;
	bh=gWd27/VotVWwvHrKqAHO87FjANH+9qAlu8jCJq3fQ98=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=AmGEAZzJ9XeAKZ011MJ3VoUnXfxqs4NyimQOoeFyyHJt6U2gJuo/Etdca2+sY0ba
	 iTYuvFBwiTSRY1DyED0kDWJ9Zz2BOXGVZzqljJN9d2vIBdd6yl+HN16pZImaRRyxn
	 4GTd28UJiIo4ddKTQ6AKLR81Avy+zbD7sazBq8BW3YdMurrvkbmeM/ULsLJcsPixO
	 UvwXEMH4u4fuunbUpt7xKXJsgSClnYhjzrjA2yhuwZ14V+RkGgHkxmq+6q/M6i948
	 +trWf9bjqoBLklqu1HRX12Ib7R4FkDTxrtfpCaNgg634R4+05rSu0R03IFBS7p7P+
	 brgeuNVanbwQlOVLDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTiU3-1rWF1Y2pi9-00U2lR; Mon, 19 Feb 2024 12:59:29 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] platform/x86: wmi: Always evaluate _WED when receiving an event
Date: Mon, 19 Feb 2024 12:59:17 +0100
Message-Id: <20240219115919.16526-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219115919.16526-1-W_Armin@gmx.de>
References: <20240219115919.16526-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KLk0r3NAs0s4FvrRV/vYtwZ7NW6r7xhwriu0AVaDpyf+UxzV9FH
 SWiehyZqOFzeCO5QFFDOIOzkWnvmYcj7f3B7GN64tRLCWNAWA9Gmg2H6rLWk+0vJ9avGDBd
 i8ZlZoghQCnyduVYVkzJ4+pqrpESMhIaIjYsL9RtDpfTTA7E4eG0Gna1Qw+u4FdlBfivy7a
 cC4RnT2MV+lrUhc5tBopw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ne3TTKFXyBQ=;x+OoDhc+wkI4HQvyka23RJvx4DS
 wkgUcV3KoSvkYZdhhhsWZ4qP1phHzskynQ+XxCIkg0OBPj8Knit6eWLagDzijsGBJk0XcrbAM
 pskz7OWZMOPB410X/0lAYFjb2OdnnKFe7FURzkNFxEgo8icgk4NrueQCXDcnwlPA68dfbNRoQ
 IcA4zDcYTbFYmSU+Ye546WeLHfjDeh+gLH2KJJTjUNMg5p420YvjLWyANulBaXcjocunZezfc
 eHvq2fOI8/c8o4ITGXVRshMqGigxqtMsi5dHrE8Y7lRn7Uqo9h36oh+HV4y2FgA5gnN0GBjmi
 znuXeLFMPhY/N8WFZa6r52rGsiyIsmdTTTHcayLIs5tpMHscOZqtTIjNyXT12af0LJMUbKvkj
 qgdEF6wa/xWuJDpI0hGehz19aUvBj1oNgnlSXD0DBXNwVAOIJ1nViVgDkHgw6+8r1IAF7jk5N
 qb+23OhqiZe4NfU9lcoct100yTO/Z5Xj9U4KAfIOeOxcwQG/PbZvh85RTXF7kGufLwAsCTlrR
 LnJG6EXuNb3LGaDf74Si9P2DPU37a1m8fIwOFdezNlDw2OU9ELgDtJMYSLHiJshC03uXLH2pf
 XOGdsrzvjtIcWt3290z+3RxUiiFozrTF3ca46OXIlTFravTe58ShTZvK0KbjXA/XSE6klJoqY
 AK9pMG8t0cnDq+6D1u+EN/suIKhjpHVLX4BK+h0AbmYKQByKS1p7LOjQmCiopPMlg0Le7zrQY
 Cmgd6hbQR1o5XyJ+Qrm5XWLk7gOWcN3TaXSnWB4mRneAjevhiVEf67pQjvnIZq6nN7ZZVCF8p
 vrhmOvFI18xIWPmRORBoD2LFWrDRM/VywumnZRFvdRzdA=

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
index d0fe8153f803..abd0183c4107 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1206,37 +1206,46 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
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
@@ -1246,10 +1255,32 @@ static int wmi_notify_device(struct device *dev, v=
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


