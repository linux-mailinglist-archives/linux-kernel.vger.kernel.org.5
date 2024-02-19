Return-Path: <linux-kernel+bounces-71263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359285A2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F111C23118
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D132E40A;
	Mon, 19 Feb 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DYUV85h2"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BC2D05D;
	Mon, 19 Feb 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343980; cv=none; b=DGM4nMHG07+/d8uBv32Xvmc/BbQosT9tTJ8guraCG9jR+5XQFzJ/rSRDgVYZJvdxteqdxpUXHn4l7aj/dQJXYEvSxZFzotiiMtBhiYBJI2CtklG4tCcs/UydK/2O6siErH0qinuZimNWUcvpvFs5BoiI3Z98R0wCaHYTsWckGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343980; c=relaxed/simple;
	bh=3NUMsHCFhp+HPyULMRNk2DyEGfrEf1V/yFzXNJv+XWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXXsjtETs5xIKwhnxmLp4ncYMSOulZTWKqXBuyeCTg4+zN7+TPUrPN5cQlf5CU9+XT7fiPn8N/7DfJQNvZvdvFC73+avgBs76+B0wv9X4DrQCSCqH1FIjW8jmU1ZZQjJ7MkYUwlwwU3YVSg8S8rrtJFFyKsaGIzKpgbIg9iBf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DYUV85h2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708343968; x=1708948768; i=w_armin@gmx.de;
	bh=3NUMsHCFhp+HPyULMRNk2DyEGfrEf1V/yFzXNJv+XWI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=DYUV85h2DZgc+cjv3G7PFqNrfwPYgmWReYruGFzYw+DgIBR8C5O0i4X+LjuWwNIB
	 LD+5pxNkHMYDAYk82UkIY1LL++1C1RmbIISV8AQzDRbkHosVN2JXRsobzQbP9kt0N
	 B+rLq4yQihywCzifN7vzSOlnpu7YH50xN9p0uBx+cPrEpFOPGEhYGqmu6KAeogBXO
	 UDDaWOj/zEpq2M4C6IccD+9qbENEfNtyFjsWpyIeP7EJE7sxeGwZ6lYYYICnfqx7m
	 o2aS0/zh3amTy0qU51uspSsUimQO0xWLsUOMOI7YLe4TiNzQxRiVeCZNcmqGNXNV0
	 Vfa/iwuI/SMV/VygoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MysRk-1qgNDW1DRS-00w1J2; Mon, 19 Feb 2024 12:59:28 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] platform/x86: wmi: Check if event data is not NULL
Date: Mon, 19 Feb 2024 12:59:16 +0100
Message-Id: <20240219115919.16526-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:GxEniXaiMBwtnTOdypXb2wetZetkR8QvBVQJDGX9X6ccuNFk7m6
 X/T2yRpAp/J6kj3ktDQmKOsS3UQWwIeHPI8raVRtKtgtB/jaM7WtXroKzTk0esB3fbWf1fg
 /DUZicazwnEzi+G6++xKWDpcI+fjsU+ebc03fiY4Ua3YsvtkWZH04ylabL1lrSwLR1InVqI
 W8e7ZH4PPzc48Gw8A23cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H/CzGdRYQmU=;Z4dbjUb4eWLfbUUh7aocnglj65i
 w8woxAjzNaV4uraqxT2Ucqcxc9z57D1UOGrOOo6TL2FvR5ZxhG4fxfKLopDUzvufyPxt4WNDl
 VojMpXcXRnIlw9lCflJ735hqRsJVk3Y1u9ojYnXlCXghmBpmUr5LEuMK9goCcpA3ZYRoxuFdD
 eE+EMUJ22hf8S6MFqhsQhJVuAwbL7T229uX7x00bt0igFZITCIHsW7hER8eUpg4LLN5mE6EuW
 OOnk+rmMO1LIjPF3NPmNB77tL3zHY7C+FWMiK6yQKp2i1hZUjrzgWT3B5gnK/0nS2qqvOKz95
 4+PprIIPWCg05mx7UrZYPM7Z+JuaPE6nHWnWq6jLW0LtVRsIv2SXrTVX0Q9vWcudDGeNiVLy4
 FpwiU460H2Ig3/laZa7wR2SvH/254JjyB6dLLyS375wy6hbwJtULeQzvuLHyfmXf9M6z7XDi1
 6EcEUY4mH6zkOIU30x98TofYBDkHtRaYZYljBkjyxsWjMDSlatmKGmC4IHEnGirvk4e7Xk3SN
 vkW69i3ciEbi0ZUtOIoRPKU8zWYCn2dWRUcoGoz9RrS3385TCgg0AMlxtNaghCzQ6YyLuzxhY
 pSfEjqxfuT2En+P7r0uAD0MAjR0bpflbD0CyXdpqtmZ3pdXSS9OOvKjIZosL9WtihI+jncoYJ
 5Lq6z1BZ4wHirz8ub9vR/TAlflimRKDvLn/gujk7jLcJbDah+ldXRlL84qmQw7QxOwW7EoiYe
 X0vzvMD3yVEyDXT3kuMUSXBQSgUi9ttkkQJTZVll/zA8dKhGhIIKBExyaGXKZUi3p2VKuKhQO
 YmYBPXgVzSe2ZfGXPioNRS11I+mPVZ8HBxLp0eyZ4terE=

WMI event drivers which do not have no_notify_data set expect
that each WMI event contains valid data. Evaluating _WED however
might return no data, which can cause issues with such drivers.

Fix this by validating that evaluating _WED did return data.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8fb90b726f50..d0fe8153f803 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1210,6 +1210,7 @@ static void wmi_notify_driver(struct wmi_block *wblo=
ck)
 {
 	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
 	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj =3D NULL;
 	acpi_status status;

 	if (!driver->no_notify_data) {
@@ -1218,12 +1219,18 @@ static void wmi_notify_driver(struct wmi_block *wb=
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


