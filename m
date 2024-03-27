Return-Path: <linux-kernel+bounces-122052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238588F13B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A331C21534
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851E154C0C;
	Wed, 27 Mar 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="B/qEkm0D"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87295153575;
	Wed, 27 Mar 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575944; cv=none; b=hcIAzCEHk5gku5am8iMgmOHEs0aBGirXVA9SUOhGE61EwePvWMbbZi6dL4fJh61E8o4z/wWfsBzmiHuX8TwKdG19oB78d/l8YX8YW0h8+CcOMuZ0j54w/9Cns7xqjiLhy8fRBr3iBmZehXyad7ExncIxVfPhP+rrIawKpk6ixzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575944; c=relaxed/simple;
	bh=PcBp9+T7iC+YO1/DasphhHc6vLnsVnjYb5KXmsh/idM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PSNHBfnNZhBNc3XdFkz3TKTrIaLitFkfxcnXTAyicu9y2ep6VJFTrmQcFwYNwuniPhkxZA2czC9yGSPW89KwMOt60qUBG05dVFyhTxGLbt4UnnnpgmizEyEDdHY5ovNqEtEUi0qKmDl34TdgODaDx+tlWRSasYQ2gIKGOJahwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=B/qEkm0D; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711575928; x=1712180728; i=w_armin@gmx.de;
	bh=wMFL6ewHokY+yq0BxkXWXiOGv+B4gWEKwwiGwP8wdgs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=B/qEkm0D8BZSVTGnFhD4G+rUQqecKBknOj6kf4GswR6L/UI9BCitLWwKkG/VnDET
	 C6BHBcTzD106OrxX35bTwe4616yfFj7/AfvszEKcH9bDkGgx7MfN/jxvB+4TobCF5
	 kEvsG22TLKz/w4AZkGEt3kkpioXAoAiGO5iKKABLD6hf+/hZt608bKDFWmNzHTajJ
	 AkIn2VYhqicXGEp8HeRnsa2909VBdWxiSd0W8EgiVos+9S/c2W0EsyBI46QuXQbIC
	 Iceoe/5PwIjD0ieb5nosRko2QJYnw/OXEmUOrAKar0L9nQaaAGq0FTN+UDQJvfYnF
	 jpr+6qjcodwuBj8QoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M42jK-1rpb5M1OJE-00047L; Wed, 27 Mar 2024 22:45:28 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: quickstart: Fix race condition when reporting input event
Date: Wed, 27 Mar 2024 22:45:24 +0100
Message-Id: <20240327214524.123935-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HqHR9WjR1YJw5w+6ZNTv1E2cWk5Fsn63ffEcwNBKClBfq0ifa7p
 eE2pseif+AAjFJrQU7aAF8AGylnB6iIcdfd/O5ieoHZ5EK5Q8+jxKJh+LWSXjCaP4DfQvA4
 7jRKX9xX+kJW3kn6E1aA77523ECoQ8mRir9EeMrJOQZf71s5tjUJIEmGDEXKwM7l2ruyCqM
 rjKKXWDK35Qhl5BcvlvpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l7VohZ+Mi0U=;qHYGmA6f8S3wH6OloSmE0xOZGwb
 GmioLyNMQCiFBW50tsCTT1BxS2MEr1lDyCotIa7Y/cxDy96zU05zOjt1QMCI3aVjBMp8oYnRn
 XRvlveZk+IIp+j4yZsFmN2Owd216beUwXIf7DLePzATNVDHpR8ex7vAuJrUz56yoGdImTiEBM
 cc/3ecJqkjV2Mp6ZuD0WfzAczm5VUgOaim+/fo/8ZhqZ6moTNlrQgMwaqe/4m8s/sWsV5JlWO
 TK/QrRAzFkUbBY97PUKUx0YGozN0OACpTDl9LDvIVkCgrTXnIbUmKtumxZSWlmLfxhTw4rGuy
 uRc2bEB/TYz21rJN/JLDdb3i/t/n6ExnOkiuqdUFn4QOEHyxi8ssqKDCpRK1AMlJKTWxQ3ClT
 oeCRtZ4U+Xj+yV29fhrkUSoYmLARGBurOhP5SdIkUNJfeH+CHWTuQwB835ap3nwxywoXKUsEw
 MeL17BeWUljhRDSKGmqBoganLS1Mm+82VlbKx5nUaGWKvQQJW0dShTQpUYLE8fi7CJ1uRmFQ1
 giPklp84gvUSm43v5+vpuzHa5pp6JhZigJwl2HjVv3kGzTXM0I+6XSc2rYHi1mqkg31e3ZZKF
 plAYUaU+Cy9qQ5lTCDX/Epsh6EilLw9TY/3YsakvGk3KVChX68Puqv0CmyFqWMs6tqMl/HGdc
 MDFePFXh8eMke8FOCGGG5NfEa36asU4R0LaFhlumLemktx5guSE75MbVEKayOv96kBCCsTgXA
 OFAshHkDuEUrGu90dsmZslsAmL7MRZ/IRAyKtr/4tiu/YA1VNYa/nrOP1B8scZi5EzFz/+wG0
 82GwB4kvFCotcCjWRrHQmRvUck5zD7aPZxWav3bs4QlAc=

Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
on all CPUs"), the ACPI core allows multiple notify calls to be active
at the same time. This means that two instances of quickstart_notify()
running at the same time can mess which each others input sequences.

Fix this by protecting the input sequence with a mutex.

Compile-tested only.

Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) d=
river")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
This applies on the branch "review-hans". Maybe we could somehow
document the concurrency rules for ACPI notify handlers?
=2D--
 drivers/platform/x86/quickstart.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quic=
kstart.c
index ba3a7a25dda7..e40f852d42c1 100644
=2D-- a/drivers/platform/x86/quickstart.c
+++ b/drivers/platform/x86/quickstart.c
@@ -18,6 +18,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -35,6 +36,7 @@

 struct quickstart_data {
 	struct device *dev;
+	struct mutex input_lock;	/* Protects input sequence during notify */
 	struct input_dev *input_device;
 	char input_name[32];
 	char phys[32];
@@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle, u32 e=
vent, void *context)

 	switch (event) {
 	case QUICKSTART_EVENT_RUNTIME:
+		mutex_lock(&data->input_lock);
 		sparse_keymap_report_event(data->input_device, 0x1, 1, true);
+		mutex_unlock(&data->input_lock);
+
 		acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event=
, 0);
 		break;
 	default:
@@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *context)
 	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify=
);
 }

+static void quickstart_mutex_destroy(void *data)
+{
+	struct mutex *lock =3D data;
+
+	mutex_destroy(lock);
+}
+
 static int quickstart_probe(struct platform_device *pdev)
 {
 	struct quickstart_data *data;
@@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_device *p=
dev)
 	data->dev =3D &pdev->dev;
 	dev_set_drvdata(&pdev->dev, data);

+	mutex_init(&data->input_lock);
+	ret =3D devm_add_action_or_reset(&pdev->dev, quickstart_mutex_destroy, &=
data->input_lock);
+	if (ret < 0)
+		return ret;
+
 	/* We have to initialize the device wakeup before evaluating GHID becaus=
e
 	 * doing so will notify the device if the button was used to wake the ma=
chine
 	 * from S5.
=2D-
2.39.2


