Return-Path: <linux-kernel+bounces-82250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D786812B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CF31C23095
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469F130AC2;
	Mon, 26 Feb 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Lnx+qlg+"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B412FF86;
	Mon, 26 Feb 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976202; cv=none; b=NYVMvIQsHyIsyqqEYU6vxiPxdLWH/T9w7kuMaBegZP7Q3XJQSU0QbtAS1c/3t1hjLKExdg0TuhbdnCOSFFWG+vc3utXYggBUxwXKLbOnEjgrnhMQolKtakQMuDDC0HWPJVwg5yfx2WqSlosGkO0Jh2aWDv1Ij/LvD641/b4ZDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976202; c=relaxed/simple;
	bh=2MBzDikgSPllH5SSceffq3hf3NNRNBuh2ZebYc9KLFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpRgGVqyrLTY9HDM6YQAPR44GCRit72d/IkgIcHSn0KMY3d/ZJ/omfIy2SjpkikR9QmFSPvA3UARm9SQY6uthU81Wiqj3MYH3+QdOcQkw7po0WoMmRJNC17wfNPA3AyyLbziJIEQndEZIGYnCFs2dvxv30Ah0lKb1LfdCh/dDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Lnx+qlg+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708976167; x=1709580967; i=w_armin@gmx.de;
	bh=2MBzDikgSPllH5SSceffq3hf3NNRNBuh2ZebYc9KLFU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Lnx+qlg+YSABALUHig+PYcEeS5yWicr2qSYBc+3Dn1SZI4de1bq1R7t+dtY4FiXi
	 h2E7D4DEErhKnr3jgGCubZkGaAeAV45cORzjk4Nz/XAildW0TfeqobGgQiz3W2reS
	 h9AFWJrNWkJctOEzL2xU6+CG1rGb5GAuEB1lHLUbp/UgjtkOrMfPMM16fvBALoIva
	 BFcyNuiyWitMxxJvqIaR94macJd8ru7+vvwtQmn28h4+ewyhdG5Sqnj+V1iHPjbN6
	 c/4RbsNn8EeHtViGotKVAmy9QiMZ+BW7c73E43W/3AO102VazHR6w0zh1khmSQ1IV
	 7wVdM1W/I4lVXqW0qQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MQvD5-1rIN602xQl-00NvOl; Mon, 26 Feb 2024 20:36:07 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jithu.joseph@intel.com,
	linux@weissschuh.net,
	pali@kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	Dell.Client.Kernel@dell.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: wmi: Do not instantiate older WMI drivers multiple times
Date: Mon, 26 Feb 2024 20:35:56 +0100
Message-Id: <20240226193557.2888-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226193557.2888-1-W_Armin@gmx.de>
References: <20240226193557.2888-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zBmwMbmkDKMJpCljEU9J9fD9nRUvemHsPHKma7Mmdk+LWv3OhMh
 Uetj7RE1fu1JkwTWW3hBPPAAZt65KegTN+8EB4xgIfRKjnNFKIgQluhJqquriD+HEYMteUL
 XVGvalSIQr21FmJMMMDqF1z3PfR+y1SPhSFCwVLvUjTRmsxRXJPlYo2aAI+dKYktkiB2A/s
 yfjfV+hptNYouNS0GPp4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lr/uKsM/SI8=;6nQ0TV7uXCpGzUwdCn1W69j6ImD
 oNilSyIzNr8wgRotQQ1hLHy+f972uYbv+Pdlwc20HP+d3SWHgs5L9XceAP/fmMmNna0qtzyij
 xNZ3zIa1jRASEAIaegrt9kKb0USGtcirwtiiAJpW49zoSmQRwh50KCZj9z4NA2ck2xLYGtb2p
 /HzbeKNg/BldgLMregyhZY0TTi8V2598LITzRU4cXRUBo+DjoFU5fpHd7m/FjX6XHxFpl3nro
 eco0o+P8VU6tTNYvKXuSr1BRCnHNOzqzCoq5Q3/okiKJ4Q9kDdjmGO+silMZaEj5PkmPsGJjP
 HCAmnpkFClsRzMv0fuC5x/KnF/fXgFzgmacyYlRjUSRZX5KPkpFxlUWwvOwyTaom8x9W243op
 w02qt8C93H/Y8vOmh+1mDDOLRJcdbZjTtE6BlHTHvHMurZklyfzxxpwt7AuOWELOLC4xhS46+
 obCdVyfqVlWGt7T/qzS2O1sBoYoYf9zTtbxE8nwLx9O6dCaRWNmAjPtR1Hbj+ZH7M7mRMmpWB
 B8ksX53kmuDXDBKehrGc1sBS6cATei73WzczQ0icfBxZN/Pmn56EuU2H5x0MG3KOzhuI4ywGh
 JKk30F5kzFbenYU3Abn4UYCXVR5vR+9NPGCiUUtHypdYteiLjwkcwXvxSnBY0hX4H2rgJRReu
 /CO8zRZ0JiIIB2YPz4D6RbKfPhEYU0yRjXKlRYEQq67hfhJ1zY2sALLW2qp9lT6Bshcuemhn3
 ReMasxI3y0Kfw8yua/YFeAU3jPwn90CSobl5GJjq/i8ZZ3Z/j+hv9ciedWjzO+rh3YLhtnJcm
 YkQke4BnqgHGJO+0c4biOzZv/S0cceGMR3+hKfUSrwzLA=

Many older WMI drivers cannot be instantiated multiple times for
two reasons:

- they are using the legacy GUID-based WMI API
- they are singletons (with global state)

Prevent such WMI drivers from binding to WMI devices with a duplicated
GUID, as this would mean that the WMI driver will be instantiated at
least two times (one for the original GUID and one for the duplicated
GUID).
WMI drivers which can be instantiated multiple times can signal this
by setting a flag inside struct wmi_driver.

Tested on a ASUS Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c                 |  1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c       |  1 +
 drivers/platform/x86/intel/wmi/sbl-fw-update.c |  1 +
 drivers/platform/x86/intel/wmi/thunderbolt.c   |  1 +
 drivers/platform/x86/wmi-bmof.c                |  1 +
 drivers/platform/x86/wmi.c                     | 12 ++++++++++++
 include/linux/wmi.h                            |  2 ++
 7 files changed, 19 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
c
index 6d8c0f328b7b..168d669c4eca 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1587,6 +1587,7 @@ static struct wmi_driver dell_smm_wmi_driver =3D {
 	},
 	.id_table =3D dell_smm_wmi_id_table,
 	.probe =3D dell_smm_wmi_probe,
+	.no_singleton =3D true,
 };

 /*
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index db1e9240dd02..0b2299f7a2de 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -882,6 +882,7 @@ static struct wmi_driver dell_wmi_ddv_driver =3D {
 	},
 	.id_table =3D dell_wmi_ddv_id_table,
 	.probe =3D dell_wmi_ddv_probe,
+	.no_singleton =3D true,
 };
 module_wmi_driver(dell_wmi_ddv_driver);

diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/plat=
form/x86/intel/wmi/sbl-fw-update.c
index 040153ad67c1..75c82c08117f 100644
=2D-- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
+++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
@@ -131,6 +131,7 @@ static struct wmi_driver intel_wmi_sbl_fw_update_drive=
r =3D {
 	.probe =3D intel_wmi_sbl_fw_update_probe,
 	.remove =3D intel_wmi_sbl_fw_update_remove,
 	.id_table =3D intel_wmi_sbl_id_table,
+	.no_singleton =3D true,
 };
 module_wmi_driver(intel_wmi_sbl_fw_update_driver);

diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/platfo=
rm/x86/intel/wmi/thunderbolt.c
index e2ad3f46f356..08df560a2c7a 100644
=2D-- a/drivers/platform/x86/intel/wmi/thunderbolt.c
+++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
@@ -63,6 +63,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver =
=3D {
 		.dev_groups =3D tbt_groups,
 	},
 	.id_table =3D intel_wmi_thunderbolt_id_table,
+	.no_singleton =3D true,
 };

 module_wmi_driver(intel_wmi_thunderbolt_driver);
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bm=
of.c
index 644d2fd889c0..df6f0ae6e6c7 100644
=2D-- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -94,6 +94,7 @@ static struct wmi_driver wmi_bmof_driver =3D {
 	.probe =3D wmi_bmof_probe,
 	.remove =3D wmi_bmof_remove,
 	.id_table =3D wmi_bmof_id_table,
+	.no_singleton =3D true,
 };

 module_wmi_driver(wmi_bmof_driver);
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 29dfe52eb802..349deced87e8 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -883,6 +883,18 @@ static int wmi_dev_probe(struct device *dev)
 	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);
 	int ret =3D 0;

+	/* Some older WMI drivers will break if instantiated multiple times,
+	 * so they are blocked from probing WMI devices with a duplicated GUID.
+	 *
+	 * New WMI drivers should support being instantiated multiple times.
+	 */
+	if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags) && !wdriver->no_single=
ton) {
+		dev_warn(dev, "Legacy driver %s cannot be instantiated multiple times\n=
",
+			 dev->driver->name);
+
+		return -ENODEV;
+	}
+
 	if (wdriver->notify) {
 		if (test_bit(WMI_NO_EVENT_DATA, &wblock->flags) && !wdriver->no_notify_=
data)
 			return -ENODEV;
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 781958310bfb..63cca3b58d6d 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -49,6 +49,7 @@ u8 wmidev_instance_count(struct wmi_device *wdev);
  * @driver: Driver model structure
  * @id_table: List of WMI GUIDs supported by this driver
  * @no_notify_data: Driver supports WMI events which provide no event dat=
a
+ * @no_singleton: Driver can be instantiated multiple times
  * @probe: Callback for device binding
  * @remove: Callback for device unbinding
  * @notify: Callback for receiving WMI events
@@ -59,6 +60,7 @@ struct wmi_driver {
 	struct device_driver driver;
 	const struct wmi_device_id *id_table;
 	bool no_notify_data;
+	bool no_singleton;

 	int (*probe)(struct wmi_device *wdev, const void *context);
 	void (*remove)(struct wmi_device *wdev);
=2D-
2.39.2


