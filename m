Return-Path: <linux-kernel+bounces-64818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00A85433A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC597286320
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7911731;
	Wed, 14 Feb 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pKqPcOHH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF1111B6;
	Wed, 14 Feb 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894293; cv=none; b=Wxu9dirwr0uS2gr7JEbnM6Wuh1zH+ywL+IEVk44S5YVBKiw8cglFgrwAX2sSRHI+5/tmOW92hNbRrdb5PBnfJWESqW+ACSl7KcflevYL5tt4JOXKc7SyEK7/BpsIEv05ZhPxC0p1qA4HPMl0brTC4GvLorJytOGOgaM47JFOEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894293; c=relaxed/simple;
	bh=8WIWWUU+GbXzNoh423yyJOXltpMWeWKv8sdpqZTjWwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ei6sQBE8jyPaEeu58RYOY8DouxbB8vm8nmuvXC9R5gAaULBhlVncdz8Mrv9RUPZ6hoCk+1dUGWgw0OUguBBZq4YCv2uHWn20rhRlJ5rZxqP+fn3GzO+EmGmi4MatZBSg1jKYLRYyw86ff7xE4uPpsbII39IRuWxXkRtIu5RczW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pKqPcOHH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707894278; x=1708499078; i=w_armin@gmx.de;
	bh=8WIWWUU+GbXzNoh423yyJOXltpMWeWKv8sdpqZTjWwc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=pKqPcOHH9qt0K+PpYwW8mhb3VRJFRZGa3L896sIU5H6DPiR8EAc72P6McNHzUFqy
	 uGK/9X2ds5XeAG4jl7Ad6ND4mDsuqv9H0ElZ5hfqAgxLlLdsdqun65kTlLvXXI3W0
	 bU+t1Lrwa8423eboTaOMNfJbJz9kR7TXJmV/gwpdW7rDaP9nZixtYSydppxo5Urt/
	 ZyJ1R9/CZj4BwBkGRxwNKqCJozR2pBNM7ZqOrsWQGelglAUhZZw50usBnSrpxEpWg
	 aivbwhlB6K9dbUTI5uAVzxKZfMUVzN/zqev2XSbLT9ZTROT1dPZOf6KOEkfNhWuBq
	 /IhSs+nVPexCsHRfVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9T1-1rjBsV2EWv-0098Vv; Wed, 14 Feb 2024 08:04:38 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] platform/x86: wmi: Prevent incompatible event driver from probing
Date: Wed, 14 Feb 2024 08:04:29 +0100
Message-Id: <20240214070433.2677-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:z0+cLwmfh32NWUP0FBmWp4fdiQOVVMcb+/mVpjhXSCfZo2sZe78
 JQsDR11z4W6ZMI9VVYH7bACwKzZVRQeFaWwxP4If9qGaEGjx+DLO/D4Za2kqnfBOnCOfY/2
 TM6P9hrJi4OU/H/tZMOeI0IFMb5Iosm35/LlF1VG29rxuuH1+An4z5Jy9ZAp6kWCL7o2DIh
 s7oAhOTtbPIFJ6ko1Vdfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5UOUuCvHEkY=;VOe8NGUwF81q+RZMe7qwYJIf7gg
 tBJIWr6iLgOyoc6tcJl13QlHE8CoPYOaDcYyMm9MyVGzB5gCjwBx4sfdGxpfLD7G4oLzL93Nx
 3r/sOr/OxKNw6solx/Y4j6ymTHCc2e/eS/UWaMYbgfSKGGRf0+aOrAaJK2Up3atLiPRHQ1Vro
 x63ZVCZ2yeGbXVNfK+LJ/YADFCtjLAUJrmqteK/cIjYnqwxCGkbf75jnc7P9xjmYL2/xSTxIP
 zVJI/vcpved4bPfX8nYZhNzKgBCeyvQip1chk+Rblv1vvp1dufiTFmy4ytyG4DFsEFXnj432s
 AOSOC1hL8OT0chg56WcjhopIRok7Pvs79NQtZT+kwndJnOBUQTk8vWNQEm/Glaa9eis3xzh4q
 WVWjzu+yOX2evHbQ8fv69QYzD8Fuib2g+Tm0nJiD8ZvzLlwqr44zTZEaL93i42jChyp52KwBB
 LhRdd+Qt7ertVuI1c3YBrz8bpYdeNttTOstnwXHxPRVdBcx4XXyXUjx0+M6Kb/EpwxdTdZOWk
 oDIZYcBBuFXnjRCn7SQ2NzMbyatAZWNklUhA9Q61txqe2tOoAqps6GCMIRtIDVXNhWo8i8dHP
 RxP8eLwzoFnKrDTGJJHgrVd0KUDO4cO8ErvKTSMFjKGYogoqK9+fF5BfGLFEQmCX7UWtBcSbe
 ggOfBhrcnK+chKa3WGzfkGJRO842ufrcg0L3qKAXxA/6GkxUupkMlFhts5ktvOqhV6rSp3Euv
 WTJPz2CkyVcopMH5yAeFj2pngWITN4zFr3OZr6xIlLJsTNLy52aoWj8bARVRjBsxglzZc/Mgd
 TbrEvjIg9z6e5G7Suz0ulBurL5M7qjuNDwkRxN9WH7y+4=

If a WMI event driver has no_notify_data set, then he indicates
support for WMI events which provide no notify data, otherwise
the notify() callback expects a valid ACPI object as notify data.

However if a WMI event driver which requires notify data is bound
to a WMI event device which cannot retrieve such data due to the
_WED ACPI method being absent, then the driver will be dysfunctional
since all WMI events will be dropped due to the missing notify data.

Fix this by not allowing such WMI event drivers to bind to WMI event
devices which do not support retrieving of notify data. Also reword
the description of no_notify_data a bit.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 10 ++++++++++
 include/linux/wmi.h        |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index b83c0f0ddd5c..34d8f55afaad 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -57,6 +57,7 @@ static_assert(__alignof__(struct guid_block) =3D=3D 1);

 enum {	/* wmi_block flags */
 	WMI_READ_TAKES_NO_ARGS,
+	WMI_NO_EVENT_DATA,
 };

 struct wmi_block {
@@ -870,6 +871,11 @@ static int wmi_dev_probe(struct device *dev)
 	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);
 	int ret =3D 0;

+	if (wdriver->notify) {
+		if (test_bit(WMI_NO_EVENT_DATA, &wblock->flags) && !wdriver->no_notify_=
data)
+			return -ENODEV;
+	}
+
 	if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
 		dev_warn(dev, "failed to enable device -- probing anyway\n");

@@ -1095,6 +1101,7 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
 	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
 	const struct guid_block *gblock;
+	bool event_data_available;
 	struct wmi_block *wblock;
 	union acpi_object *obj;
 	acpi_status status;
@@ -1114,6 +1121,7 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 		return -ENXIO;
 	}

+	event_data_available =3D acpi_has_method(device->handle, "_WED");
 	gblock =3D (const struct guid_block *)obj->buffer.pointer;
 	total =3D obj->buffer.length / sizeof(struct guid_block);

@@ -1132,6 +1140,8 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)

 		wblock->acpi_device =3D device;
 		wblock->gblock =3D gblock[i];
+		if (gblock[i].flags & ACPI_WMI_EVENT && !event_data_available)
+			set_bit(WMI_NO_EVENT_DATA, &wblock->flags);

 		retval =3D wmi_create_device(wmi_bus_dev, wblock, device);
 		if (retval) {
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 686291b87852..781958310bfb 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -48,7 +48,7 @@ u8 wmidev_instance_count(struct wmi_device *wdev);
  * struct wmi_driver - WMI driver structure
  * @driver: Driver model structure
  * @id_table: List of WMI GUIDs supported by this driver
- * @no_notify_data: WMI events provide no event data
+ * @no_notify_data: Driver supports WMI events which provide no event dat=
a
  * @probe: Callback for device binding
  * @remove: Callback for device unbinding
  * @notify: Callback for receiving WMI events
=2D-
2.39.2


