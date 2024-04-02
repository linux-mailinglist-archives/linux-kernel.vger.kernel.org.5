Return-Path: <linux-kernel+bounces-128136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C138956B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228D8B24B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B461272C9;
	Tue,  2 Apr 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LDPSogJW"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982D12BF31;
	Tue,  2 Apr 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068283; cv=none; b=qmywwouOaW6SpsSMdxKyOv05TWXSCtkakz7DsHT42uMxuCNkp0xH0bSOwM60ZkpNUVQTJzsHbQf05ywY5ha9zf5mGXwG8O7MiEEbNwPTnERwIV+d/SNQS9eI69qNIsj0nY/u+9wZWR8IygchlXWo4qHQK85oaR/sc3Ob90tXsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068283; c=relaxed/simple;
	bh=jXpXmnj6OnVqKyhubDX5ir2p4FFes+gOgiUiATMk5OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvIJeoXRlAZ1WuLVtQ3jHb7/uLCvk9T2xN47bGZVkAcmniHMYbmWm3tzKsG/A5nqmVgcZONqxSdU1mR9G/ez4pCyPnIWclMxbHizt7gLdJolEJnPUdN53yMQYFGCtts/j4iB6GdP521Gifcne8Fba4pDcisFVod0dFBP+slWR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LDPSogJW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712068268; x=1712673068; i=w_armin@gmx.de;
	bh=NTZrA4QvJZSqwHRW+FevDxzgn/3DYV09kgKCOuqHtsM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=LDPSogJWdBc0kHIq3a8b2Bcb2m5+b2hJv/CLA32t1hjt5FfGWiDheha12QfmosBO
	 2qi/ppHqQJFekDQH89ibFeLLhS0M65pKzvcKC+tjMwT1rX/NvlzqMb1hYBWUqZTQl
	 l/GivPzNNA/cQBBEC7mZcy6tOk0Zku76WCJU0Y3W3pOQEDuZL9lXZRrvmN2JFpFz0
	 lDaBqQyVDQbdB6AoC8lF60KZ/nsA/Xx676w7Hl5U9OIQd5J9OsGVAHX++Bt610cVS
	 7Erpg0E4ZEokuiQbz2GHOhBkIflfTX/fiWmWTulITRtEX7mDiX9bvLZ013D4Xt8nZ
	 VoHXZSSHz1TMfTzWFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N5mGB-1suVxH2ZER-017E61; Tue, 02 Apr 2024 16:31:08 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: xiaomi-wmi: Drop unnecessary NULL checks
Date: Tue,  2 Apr 2024 16:30:58 +0200
Message-Id: <20240402143059.8456-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:XV7sEEbNyVZim6yBA9Y2t4HlZsMGd0xWJLofcFO5Ak01iM/6SlM
 yEYb/SpACJ0AkzZV6j40aBv70sA7mrJz3ViF52a3XcukBjWODn8j0AwhbTesPW48Gs9DCSc
 MLNxOa1qNl8s5/IDt7/NgJZUqlGEs7ZPSyF6HVpqywmIM2XiYzvcqJbWsYCiq6QAq/8E0f4
 EKPoDbxbqTVjzqhr1Ihrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cOspIHrHTEk=;M5tS7UAT8pdEkEZ/fNKPrM8LYx/
 LvFCU5LgIxZDnfY61dlgNTz8Ujj4Z95ZTkmljx6H0qMXQnRGu9M1sCSVT6AvZ+wPkW4wOdj8r
 wwqxrV/fxllsvfTF4IvWaFUCQEl3OqSC179eNOgZhA26Ia5+PabrnSq2fUVeLSDXbTo6v+RWY
 n9fRVqwtr226D4u2ql+a7NGDf3dhZaQ/d3q0N0Z4PDvNkeEyNQvoTimNyKRqWbJc0EsgjPjxT
 aiIz9YJ67h4VWD9RV1314B/SrVqabQhxl5wfN3UW5n4T+Lr/3kXRW2C1S0m/WM0fh9042mpuQ
 SdpQCKFkERPds4n3oUwfyPkYpA0J7JPKM8JbqxQ6wtlDQPGcYawh/exQrWQczAYfLVBtJ3b/t
 vPJYGKOcWWKq0ULh3F5Nt00adExqxEIeKtTme1d2BT/X5E5ZUFdvavaXjsX9Ur5ZpZ+mxn/n1
 vzZL+e7V960g62VCoqKzh5wSrKXpzQPL+OCT7BZAYWTx3LMknQ2zri23FBIEvuDtq8ya8r0uJ
 rNRjDGXylfnGJEeQDPGPqOcFLFHh2M9R3ybY+cyR9q6K6kOfdgZq8jgoG4UlJSwt3Xd5sec3h
 7d44e67are2896P7HuUw4khQjfM80ECi60dCosMhpY2MFubELmMa4MxB1OOU8ZHFRlRSE6Ugx
 Rwy57yGLZIBwy3bGtjnDX4b/fkY7fGVkAnfhwMT2Gj4Qmqikmnz2APWpHjAidIvkMzY8wOyKm
 swkw0Yk/RfYVhBGQcJxkc20cZxJ6j2JG32YnFB9vjoe7hW4V2vJ33XtxAVr5lamiym8on9B4e
 ud41QYvxAdL8zPm9YKIkCJdwpFma2AmWe2Mnz8N+kPTak=

The WMI driver core already makes sure that:

- a valid WMI device is passed to each callback
- the notify() callback runs after the probe() callback succeeds

Remove the unnecessary NULL checks.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/xiaomi-wmi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiao=
mi-wmi.c
index 7efbdc111803..cbed29ca502a 100644
=2D-- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -38,7 +38,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, con=
st void *context)
 	struct xiaomi_wmi *data;
 	int ret;

-	if (wdev =3D=3D NULL || context =3D=3D NULL)
+	if (!context)
 		return -EINVAL;

 	data =3D devm_kzalloc(&wdev->dev, sizeof(struct xiaomi_wmi), GFP_KERNEL)=
;
@@ -66,14 +66,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, co=
nst void *context)

 static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object =
*dummy)
 {
-	struct xiaomi_wmi *data;
-
-	if (wdev =3D=3D NULL)
-		return;
-
-	data =3D dev_get_drvdata(&wdev->dev);
-	if (data =3D=3D NULL)
-		return;
+	struct xiaomi_wmi *data =3D dev_get_drvdata(&wdev->dev);

 	mutex_lock(&data->key_lock);
 	input_report_key(data->input_dev, data->key_code, 1);
=2D-
2.39.2


