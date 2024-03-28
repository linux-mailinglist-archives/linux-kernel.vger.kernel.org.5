Return-Path: <linux-kernel+bounces-122270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEAD88F47F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CCA2994E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F921219E9;
	Thu, 28 Mar 2024 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="S/LS182F"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995208465;
	Thu, 28 Mar 2024 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589033; cv=none; b=kUg6Pnb+NXgdI6Nw913IegCo7/UzD6JGptfbqoXOiz4Xi85bgyohdXp1Itgrqp96hFR90rPre1UaP8+2A4kj6zVo9FplmcPCarKNc7cAJCIwbbRd+WpPnWlsGDHiHQxs6B18+c4cx0EhGZh8JCy+PJRjv9bHLURwNMQSJ1bXdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589033; c=relaxed/simple;
	bh=GSGeeyds/g8pICmZBmqRu+evqxKRetteZ+3dXQU2ru0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWPMF6YIFa+flgx+gYbt3n/WEMO1A9TTwPCV+o9SKsO1yd4L7pz5DqBW17SPrBmEyt6bPzeLAZH5F5ca7oTznkieq8Yd/6RwjuDMUihMkmUFinxqcesXBYJYQqXP56LSiyP6bh5qHanGtB/qAs0LVU7391Rq8tGOqSqYs6mMryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=S/LS182F; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711589020; x=1712193820; i=w_armin@gmx.de;
	bh=aIeeKP7p962Be1K+3JAM/oYmuMrr0yig8x+lgmqinJs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=S/LS182FJkFEAbKUB4GjloFSjPnlftKEOlEzT3kB6hAYIpvtuUlr5Th16hXkJWz/
	 SUm3Ve58/tJ5A1F1q3Ji7jqcvnAmmMROYryyEQwBJtwQqvzQLNHAs1fXC7O6N7BsK
	 fFUuY9HVae/S1hCjummdYIvqydsJ/l4/uoLNkCmA3y/v9gCCmdngknWqwNh+haAEE
	 AYlcxU+Kke7vpWxLLMNQHysJQsdRAnto6dF3pEvo85wp/Dcr7popuj1168xClTI2r
	 3gpiv+x+HcHK2CJI1x0BNSlKShx/swYHSe9J2xpX6kTVdG7/GLfCyx4RIwHDLxK2v
	 6l974urInnYUbgDPzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N49h5-1spLtl33nF-01092w; Thu, 28 Mar 2024 02:23:40 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: xiaomi-wmi: Fix race condition when reporting key events
Date: Thu, 28 Mar 2024 02:23:34 +0100
Message-Id: <20240328012336.145612-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328012336.145612-1-W_Armin@gmx.de>
References: <20240328012336.145612-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p3AuEUVk+XGrV+mUlP0sRJLzCXCB5pGuM1Oq/YTrKHRkhS31Isu
 /pD9my4LrxSKfzPFSHbvhwql1OGTlQZj9XBX51Qn3ffo/C7mDlUHrzFIgnmvXf4gkRwsVfs
 2Sq26m7zQcGIZ0gOTEO/W3yEgxt8yEH6DpVf6VvvMx3FPo7rhLcT/QZ6HQhA9XD+ZIZddYK
 dTzhURgMYeWfgRG7h9m5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N3a+WBUAfuI=;DQFi2oA2gGx5hW6YjsguGd5cBhD
 kGrEUOTht/4Sd/IBm7PHjCYDNZ+u/404pbhtC0DQ/N0JrPn0jvdXY31rwCpNryR17TG6kXO3K
 Nl69j7LxnZjV+GeCp21AxyaB5MyM+wpz3mJCBw0NXtLGn3XUNHZ/MZlv8cbNDUVx4GzfhUnwJ
 Q7LpWhiIEUgVvV76enUVkNDGmShHM3oeHkiO7LlWjbOgfWPhee5oBXGSDZLviDsN9JzSphzw8
 9dbxQhMoUpfrNu4h3VAFenD4UkwZhk0CkwAw/vvYKeT028xxlj4vU2Q3Q4E8UuJZ8xAyRvSLN
 y2GMqlUbVqPRpVM78rgWtssXv92UuOVXs4H83It0CZzznJVIhQbSCEYmBuvjCi8vKK5fvD4Gi
 o2c2tNydLRq+fhNYpFdM0XecBGY+0qQnlmhSq8h4gV0a+mM5p45vFKPbAkUt8a9CAUQ2OweFE
 CHZ9PeH195lqa4hmwd8QCCSRFgfLSsPR8OVJLLldxE7/aSnzKcf57j01N/UXXQhqtZRA1Rpj6
 sySpXt0vub33UgqA/OcYs5MBocK8cPtQ25BDeEH1K6SLSxXtxY54SasHN5yx5v3Abf+f8pCni
 xZkYJFzZ4KHkXNhw3XhWRlKI9oAU2ywL6Er0m2i8/baWePOz2bwHPkokcEsD/SzS1ESq1ANDb
 RgQ581gQIc89iREbw6o2BjLhloH5VXQDN+nooyDVgdpJ3anAwAKOkaTNGbv2dAa13qklzcWfR
 KpTxKy2605qeiQ3F54JkFxfMr752PLcWzfbRLB6NJJKpt/45OvXuxyEYlC2TFQ/z2fN9KZsJ4
 yDZx9gIhWVwSnIcGMjDu55ViKXHuAuIiK9oAaRMiVljtU=

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


