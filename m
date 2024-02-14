Return-Path: <linux-kernel+bounces-64820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B53E85433D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86061B224AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E85125A4;
	Wed, 14 Feb 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eZZewW62"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE23111B5;
	Wed, 14 Feb 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894293; cv=none; b=tFyTRYjDWa7ZqwZ4W/Q5ySHEojgDRaBNh1x8iGd/lGwGZpFr2N+ELEoKwakQtPKHmpB3Bpqn/0FLuOBUmoIZ4kIaO+E/m3wjGTJnhMYu4r/mghuBoE6MMujb1Mc5XjtXyEjFI4KjPRfsnxVF3O3V/zBvHoXeQGbbAbzkjJx9Cx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894293; c=relaxed/simple;
	bh=n0AoXTw5pwtdG6PJQ2P7EZL+K7m7jLPyauFZn0/2sxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnWXfrUhubQjhmizhE0czeENYGgnBBFqAmjZg5ZfwZP9n+n7eu2IrlXYjZ/XBEd/d5mTQdR/7MTq+jkfrYScMv23DBNzIa/1J33yNnV2iECGdXxkhcoxEcySqHTG09My7UMlT3hURT6hH4Tz2z56/6CfaKMXfIUZcsqI6notOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eZZewW62; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707894280; x=1708499080; i=w_armin@gmx.de;
	bh=n0AoXTw5pwtdG6PJQ2P7EZL+K7m7jLPyauFZn0/2sxA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=eZZewW62srtwMm5iH3sDN4HDLCVQXklLcvLXHRtUc+UzR1cIfSUdu1Loy6yVRb94
	 bh2fKIuEaz6oP0NxaIdydLAjeIpWjZoOeahL+qmpvhhLYp34528ZPDZOQWgpRsroG
	 xSbAZdyGBGS1UtO1F+Kd3ySy61PxoBo3GqeqLZQVPrJyRv6owJaV/RPtGQu2nw0rI
	 R3ZaOdHYNnR83MFCcdCDVOZLRwKZNRkhtAWNKvQ2GxjUqgVtekIlskSNJKCnI4shs
	 LIMLVqYU4JB0QnJhbni4DoZP3wEptwgQBMhPRF8vNOKzs9pbcGfMD1Vd2t/V4+AN6
	 TVy71/zFaAkxsda6mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N8ofO-1qw32c1KmE-015neB; Wed, 14 Feb 2024 08:04:40 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] platform/x86: wmi: Check if event data is not NULL
Date: Wed, 14 Feb 2024 08:04:30 +0100
Message-Id: <20240214070433.2677-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:OU4EaZpwEqfAZfpMXLIc1UCV3fBEUVMSIhiMPC8c5uKng2m+npm
 zQ6emFQ6KU6ft0J10z/aiKV5+3lBKpggae5AnwFGrx7E1fMKVC/PFS+vRriZTnQLUQlbwhO
 EY4GxxwxlnaVcWcXbBM1ObOboPiLr+8k5SkhMKHKoUJqhAu52IW5TCUN/+pnPiMMX6J1K6Y
 IZ94iuXt8UxjTLLGKqb4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zfwUl0rTyrY=;LxH6kwshD00ci0S9t1hnEhECBRg
 fpszoRhtw7uPXt6Up8VOtilQRDgj6j2PRbjPGCeyEIH8SyCct8yzbM2tzRK6z/5+ALQVQ5h7d
 1jFDRTOajOK5Cd/+mM3s3vRk+GNUbFBUIDyXRaZffVf3ufFS4fF3AKfQ7K5MXzFmUSAVmmXV2
 w8yKkzgWq7QRDxouyiRVP4BDnXw3tEAxY6gADu7QnUTNY+9tasbNlakLgEmDH8zCT3E77MhQv
 uz+/7ugwc/rBswa+BqZk/dZnekhC9oM1MxdKtZnxnEEC9zQXEuafDmZVBWyk1nhb87Og/53iy
 gUyx5QMWN0YwCqm76NoUAIiYxnyw4a6vVjXBfiKedA/iMNKFL5RvNZa/7LFb1mMpAVKVJlUOi
 E5AxababXnhPrxFrHlkFt2wbWemG2ZjSC2KS688V37reoLMtTHVBonjApW/+hDJHB2P1vtV6/
 ROErV/JfahvFAHWWN0Bse2WGXVvSnQXzQxzylJpS3NefonCfZxrNhMv+ocfo3baY5Dr4R/Bxd
 dHD9IZT4VLqEahv4GgitQKi9/t25/AdkbNE7ONeX2qnPx69ThWggo1jbnWxgHI7MHKaeOGeB3
 RTcBmfZcjbvAkFM2Mfh1tYsh4CQpJaUf7soUWBQL4ms4e6997VddCSOXbXuPc9gkHm099R+w0
 HirkPXZNBglI2bWCqAe73TT/v4dsXWbck6RVEoOQ4PWA1p4kaRPcqs+aLsZLYrGf0Qof/IgPX
 i9HC70d0eRQhApoYsdrEgc/GMlNuUsLzdSRrDaZfdBeohCydqxG7ZhCpwuT/cReN39bJwItLq
 +SKB8pqM6z7D4+L1zgOBIc5qshzgtHHqJX53EfLhf4fZM=

WMI event drivers which do not have no_notify_data set expect
that each WMI event contains valid data. Evaluating _WED however
might return no data, which can cause issues with such drivers.

Fix this by validating that evaluating _WED did return data.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 34d8f55afaad..8a916887c546 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1211,6 +1211,7 @@ static void wmi_notify_driver(struct wmi_block *wblo=
ck)
 {
 	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
 	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj =3D NULL;
 	acpi_status status;

 	if (!driver->no_notify_data) {
@@ -1219,12 +1220,18 @@ static void wmi_notify_driver(struct wmi_block *wb=
lock)
 			dev_warn(&wblock->dev.dev, "Failed to get event data\n");
 			return;
 		}
+
+		obj =3D data.pointer;
+		if (!obj) {
+			dev_warn(&wblock->dev.dev, "Event contains not event data\n");
+			return;
+		}
 	}

 	if (driver->notify)
-		driver->notify(&wblock->dev, data.pointer);
+		driver->notify(&wblock->dev, obj);

-	kfree(data.pointer);
+	kfree(obj);
 }

 static int wmi_notify_device(struct device *dev, void *data)
=2D-
2.39.2


