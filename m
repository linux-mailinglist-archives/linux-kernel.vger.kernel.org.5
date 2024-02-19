Return-Path: <linux-kernel+bounces-71264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629AD85A2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03140B21E21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11032E63C;
	Mon, 19 Feb 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ms65bXKh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43552D60C;
	Mon, 19 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343981; cv=none; b=WaguCnGqZXHuQ8Hk7TSV2iduCGE2gwiiCjZQ/q1x+o2tdkr04KEbWpMxeaqWAaBo+HBMVtzC8tqq7gwpe97holtDvKTbNmFZ+Wd/F651xKvNJLox3yrErDdFkEPdTWAZBH7LF/Usjjiaq85I/Zfc9CTa67z131bzQBjT4ki0y5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343981; c=relaxed/simple;
	bh=Mp9hOgHSBLyn/IkdgO0pLAaR0KKQJX46nMeFoyl+HGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ub8QomU3fhbTKHDBJWp1uXtEMvOgwc2iYr1+lc4uICbi2uTWe6vbpPSip2LIxpEF5Bp2DEi/xr6CWiIwBFZgLoiEhkqjNqkQdhq23UXVanX7MOV9W/IePcj4VjDXDVGXJadgA9TRbgVgSZp4JVFJdQLg2DjxlXufU4Aa5wGJqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ms65bXKh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708343966; x=1708948766; i=w_armin@gmx.de;
	bh=Mp9hOgHSBLyn/IkdgO0pLAaR0KKQJX46nMeFoyl+HGA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Ms65bXKhzTGXO41frnXR++7fkeAcC4cH9oR5mmV0AOKnCdYG6BIBR6VU9NeFBWPH
	 OghH2LUDssNzsUYfdQfGK3xw1NsAY10evPa/FdRkWzEnLv2i8eH+UTPj7cA5Wrkru
	 e/G81k5Iz0yAUp/56M+oK0uHDVN07x+fa5lzOisNvM/OawtWbSyLBLvKjhA0HTapm
	 eAkCmcYlZZ/MkbFYj2TsS13gb/jBT6VtCgd9bw0Lq1ez/GkklufEyYbJFNMCX2H9W
	 rDmMaS/bav2xhinbtM7suBOwnhqYrFuhFZYO7AjjAKjGMHDaqJdlTCeHjS6iRLdUv
	 /P/kL3IRi+SjcuoibA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N2V0B-1qwd291vP5-013sCi; Mon, 19 Feb 2024 12:59:26 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] platform/x86: wmi: Prevent incompatible event driver from probing
Date: Mon, 19 Feb 2024 12:59:15 +0100
Message-Id: <20240219115919.16526-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:8mOAKKOQfSiI7qUYZqObHAvj7W+O+jwuXvBstGidfNlbqOkaW1v
 FGMjUDnZbFTCDGvotT188mA/iUzsuFn7+Lz4mIbOZc2zFQ5mt4o2xP7YKWXQZuTPy5YMneU
 EScEkSubl2UCFkA/yJrxLRVOBI4Q5u1yETJTYNXpxlXMdZh9lq3T/qa9JTfHEHwX+vy46VS
 +YrF5CLPC+sGCfj14FOrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v4V1t7bD45w=;MRvAHFwlkPrjiWrjqJAfBfpOjLo
 thiBgDIKGaWlqLb1MiXL9Hy/gUQaaHe5kIO5iyKm9wNxvmOB+ZjjigZ9k4ylWJ7hZe8t/3YFS
 hM99gHOMSdS1zF/Z2MIMprlISG9TA01+OMmrZfQDZOR9lRfZQIaWNKVdDJ0Ww58mPI3N7MS+H
 dLllHwZVL32gbfc6JTY2p6uGBhCP50iMbPULyyq9KYVYIYf5HexHcTjuDSsfuhPPkleeiZBl2
 NQ9jdfd2xMeX+rmHVtvXFSBjD87rkFt3av+I57Fs9vaQa8+fJ5hW54z5atvEC1oHtso4fyart
 oTTz4/A/zG56gEpV15MeRz0FZrZHi1uOIedIQv8ahvoD2GGrh+DLR/rPQhtPVZo+K91iIdptT
 8xgXBj+8aiaP7F3TuHpsYKnssPHwrG0mMg/mwmYtViSzSZoHNm3XRtdE0pex+VpklD1tCRHoo
 IgDCgbMFlqe6lD+7dVBPHIV5YxyItQhU5qFl9MzvDoc+QWNPD4fCUfwz4Ploc4+DW31kjZ7+6
 FkRV96HQft6fE0E4zApz/Ml3ZYNL06DFWhLIiRcw85Q5tsqopSJ45V/PYTOAG8Tkc2OWVcrqj
 rNX8TioQAdVh1+wdma0vkuaE0/XnQjuxC0XHvLRvyeB7cDATn8k2GUcbsZ8+ZZ8iGboItemsX
 IvrKBlInugVQ6dV+HaEBHTTLe1HTr9wgzWoyH9fgWY2J2ArHkhoWsJP3mjqzUllve28sVulSr
 dLu/VxyFKrkRFfpAyzJ8y5G06mjfvcjaRLCIyDPDf/cSB3Ubij4ABaLGXZm8mkb160/fO/OwT
 C6ro+/kP3zq43TkVoSIvlxNOeYCfrnSTeBej/XT/oAjgQ=

If a WMI event driver has no_notify_data set, then it indicates
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
index 5a613b06b269..8fb90b726f50 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -57,6 +57,7 @@ static_assert(__alignof__(struct guid_block) =3D=3D 1);

 enum {	/* wmi_block flags */
 	WMI_READ_TAKES_NO_ARGS,
+	WMI_NO_EVENT_DATA,
 };

 struct wmi_block {
@@ -869,6 +870,11 @@ static int wmi_dev_probe(struct device *dev)
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

@@ -1094,6 +1100,7 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
 	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
 	const struct guid_block *gblock;
+	bool event_data_available;
 	struct wmi_block *wblock;
 	union acpi_object *obj;
 	acpi_status status;
@@ -1113,6 +1120,7 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 		return -ENXIO;
 	}

+	event_data_available =3D acpi_has_method(device->handle, "_WED");
 	gblock =3D (const struct guid_block *)obj->buffer.pointer;
 	total =3D obj->buffer.length / sizeof(struct guid_block);

@@ -1131,6 +1139,8 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
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


