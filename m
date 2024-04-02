Return-Path: <linux-kernel+bounces-128135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867BD8956B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D3F1C22277
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78D412BF1F;
	Tue,  2 Apr 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MnEd0QNR"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC317BCB;
	Tue,  2 Apr 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068279; cv=none; b=qgFK8cGcD1bvzhifDT8bH5OzCNw191dDPJcoo7mkiW2ldNN58Ao298HSpHZtu3bKrRYs9Ld5gxOuW0TZbaVfCrzyV9ZxXeUpKgsLoZPLuF1V/ciyg16cZ9spyWpiDdydI25xwLtwHnTJP8n/ASEJbrQ1EGsvLwfqY0pNGbFhRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068279; c=relaxed/simple;
	bh=GSGeeyds/g8pICmZBmqRu+evqxKRetteZ+3dXQU2ru0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqf9roll+jSRegPsF5o1mADCX4VAlH2RG5/BeqVTd6MVYZV4swAQ4GZ/S5k850DgS08dIyIIxpstAewH94JV9kPfMtv/WaJIpQ72R/yes34z446fV2KpooQLswMUdJnnhzQug+yRGPCyU31RxXRXzsMnPVhrpXQJS37DInQSmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MnEd0QNR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712068266; x=1712673066; i=w_armin@gmx.de;
	bh=aIeeKP7p962Be1K+3JAM/oYmuMrr0yig8x+lgmqinJs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=MnEd0QNRZ/jC43RNAdpp81FXUKA9tvAPlyOTkFTcyRVtmSB/HHGowpKtCANGG49T
	 +S0JAndgpP1vaUcUPse56hDi3fUqn+Fk8OGEWV3kcGDjTcP3De/ROeoXuNjrXSITk
	 q0hvdyO+u13vJRHzx/Y1d18t+q/GBx/qJG4LBKHEa/wIm70x3CZufHlODiu4gHiYu
	 TTug8r70SmHhdKv2SIPVCz51jw7bxKjvBzECBFOAxRDQTi01CCFppfZq+Mz/p3GXw
	 PU7SpmqxNW+iCfMc+sI0L2OYDrSBMeP2xDe+rWGh1mVw/eskNO4pkRJHXQbkm18AK
	 r48sqK43ofEL/hIpWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N1wpt-1spaGh0bt3-012Gxo; Tue, 02 Apr 2024 16:31:06 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: xiaomi-wmi: Fix race condition when reporting key events
Date: Tue,  2 Apr 2024 16:30:57 +0200
Message-Id: <20240402143059.8456-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402143059.8456-1-W_Armin@gmx.de>
References: <20240402143059.8456-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1MSHdp3U2yQqRtyM8+jE62IQ5HIy4KO3F3v21vPfr3suJPsyNdL
 oiyilsLxzYlWgFVbK/QrZFghS7d/BOrgbNuDqdaqgWhgQT8EOjVmo/8HgY1tGv0KLvGsclU
 RJOT5B1n7/VNueNCk4AEvxkB2hILtWJc8Z2IbCfveRjGE9A9ElE4DScDMCk6/gzp6d4R59i
 doChLL9cM+lOx6+BCuTVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hpZs6+gCIQk=;8nlTLCcB2sSRRih+kLDgq4cZ4Oq
 uy8cBbYWawg1CvQ57K+AvqtklCmXMOF67pk56vycDvH66m3Uzyit2xG9KXFcMksd+7BWtgSGX
 ujfjl5fbCQBNasj4PDQssiu4Qi/U6LdNEeFlAJ9POJLIiOmw2nQ9x7zY2uBgxWcX/MIRWKAug
 +bbO5degTI6eG1EmGQa83AxTZZ433e3PPfQ1BgzbdsEW14VZ5Q8XyF7k5T27q+WjoBXXKiOF+
 1aEGb9RTLpMf3lgDoklPwX0qjFDzVkeuE1Y1bgi4QZvc5s8AuCxX0IYQI1EiZeGIYyojWNRVv
 Qz3tBmu6VcWONaclHQfGj8U4Sp3grYzANE3Iw7nukl95mk+HwhOyysTGawtPD4t3mpsmjoj4P
 JKOfhiGPCbZOATdaG0tdVbUi//jEcDer87bXfEYptsYutQc0UgJ5HDaVseVn734hYHmsh/sIv
 GbAq4xHrfzKQ7+OHXRdFQ2DheqRkY0WBqgFP+JBxCvSVk9K3Dbe/VX4GDYtXuPBC4JgWvM5Hw
 sGEM/Dmy7pr+KbnihSIQuXpbiv+Pp4ALZgydNiwyeF61oS7nLloeKIW2zmnaMCmPtswE12f7g
 mL0PPyw8tj5SYJ8k90zbk945QZIjVMeKrU9li0r4WsOSbvLwdwtjD8o4qke5/sKPQTifVC15V
 PKZnMl1CQf+ghYXLSiB/gj2vceWjDaXnwY7Vz4cXpvO3312R3DD6OHRZnfiC78U3sHsDU57kD
 kB+e/0VfcYHmni9atkhO/vKPAkfGiEMt7KvncBWqzQu6Wu0TnIugYlvcIn1e3Mm5BdroEQhVU
 A7Piz1Y2EaePquVBBN3JRF+em0OLeFkbOvZKGJ6zBMw3M=

Multiple WMI events can be received concurrently, so multiple instances
of xiaomi_wmi_notify() can be active at the same time. Since the input
device is shared between those handlers, the key input sequence can be
disturbed.

Fix this by protecting the key input sequence with a mutex.

Compile-tested only.

Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/xiaomi-wmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiao=
mi-wmi.c
index 1f5f108d87c0..7efbdc111803 100644
=2D-- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -2,8 +2,10 @@
 /* WMI driver for Xiaomi Laptops */

 #include <linux/acpi.h>
+#include <linux/device.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/wmi.h>

 #include <uapi/linux/input-event-codes.h>
@@ -20,12 +22,21 @@

 struct xiaomi_wmi {
 	struct input_dev *input_dev;
+	struct mutex key_lock;	/* Protects the key event sequence */
 	unsigned int key_code;
 };

+static void xiaomi_mutex_destroy(void *data)
+{
+	struct mutex *lock =3D data;
+
+	mutex_destroy(lock);
+}
+
 static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct xiaomi_wmi *data;
+	int ret;

 	if (wdev =3D=3D NULL || context =3D=3D NULL)
 		return -EINVAL;
@@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, co=
nst void *context)
 		return -ENOMEM;
 	dev_set_drvdata(&wdev->dev, data);

+	mutex_init(&data->key_lock);
+	ret =3D devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data=
->key_lock);
+	if (ret < 0)
+		return ret;
+
 	data->input_dev =3D devm_input_allocate_device(&wdev->dev);
 	if (data->input_dev =3D=3D NULL)
 		return -ENOMEM;
@@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wdev,=
 union acpi_object *dummy)
 	if (data =3D=3D NULL)
 		return;

+	mutex_lock(&data->key_lock);
 	input_report_key(data->input_dev, data->key_code, 1);
 	input_sync(data->input_dev);
 	input_report_key(data->input_dev, data->key_code, 0);
 	input_sync(data->input_dev);
+	mutex_unlock(&data->key_lock);
 }

 static const struct wmi_device_id xiaomi_wmi_id_table[] =3D {
=2D-
2.39.2


