Return-Path: <linux-kernel+bounces-37579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90183B1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196281F2104E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E79F13343D;
	Wed, 24 Jan 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NzAmvgtY"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70007C08C;
	Wed, 24 Jan 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123273; cv=none; b=lAl0UlUuoObplSMeBhHzDTU6z4ZwVw+Koz8TtL+JC8x/Z8umb0uYp6VSmqzGamHQiJmXy96EgeAbNgzMbJOfrKEGGMq5WiKmqQzW2r7tm1koO/PvK1qIEOGhdCt9eEO3cREaYdH7ZyVRPpcQ3/3IlJ9ovmu+bLHsfqVcgWxY+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123273; c=relaxed/simple;
	bh=wVXGIf2EGPkrJIt4m5U8IoSMrPPCGJZqkd2jEtMZKQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPCd6PQX58GWMNPGzM6540bF/tIiakcRvQVTf4XILA7EddyYA8/kvtuLEnrEd1T3+ekWHN3s4gMp9m0kPWTeRFvz+xV1SyJ1KhS++ROxe+84hUXcj2PJzTAcMn2gJW0hsgCPcCZsUq/n/sGVLMDIdXbVrxX69fFKVYGHUBtyO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NzAmvgtY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706123262; x=1706728062; i=w_armin@gmx.de;
	bh=wVXGIf2EGPkrJIt4m5U8IoSMrPPCGJZqkd2jEtMZKQ8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=NzAmvgtYln7l6r/vehj7j4/CXImtR+/XcG1WN4YVsMxD99cQn00MgeZeTvckvcI5
	 LvmMkHhdvqF01c4AnLZV2xBDLKkxbYOCcXPo3xRSNdtpMqJeDyeErTWvxVZl4Rtwd
	 /bmk5EO+ahzgcxYcBjMJqa7W2HJkWh8L503TRERrIweZj63fopTVykKepWDhTYowt
	 hUta4XHgZH+UrrWrHEBXxnxDoWqPilTTPj6bgE77bLu4LYhQYa173d7CJG6Vudci8
	 MKTYhf3y7ux8pHjJJUr3jpogiUJKyWODJfFCwRpz2vTl9kV416lcbANYX5hRii55p
	 YHG+IQk41d5SIxyw3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOiDd-1rjOEM3Ig3-00QCsv; Wed, 24 Jan 2024 20:07:41 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Initialize ACPI device class
Date: Wed, 24 Jan 2024 20:07:32 +0100
Message-Id: <20240124190732.4795-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pQiycEhhl3cwBDSl7f4ecNQAjlwdoPHL3OZcY3fjgiFJwb1qOiT
 3kbR6984FUGdlCLq6NBO+A+aONberv07cE/syq18cfCDD6DcAJqbm2LJg3Ksj2iuvsplrGG
 9cUqCxMKCsOafqcMKVfYaVmjtOqIInO/vKrhPEOxAWRhty4rwjr+FGY3E+lexplVe5uSnUB
 WE0E53uCXu7t7euqiTzEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xp4Q1QWfeIQ=;FyN/w8M9MYhCJtppqv67P4Dtevo
 3iq7hfWbbZGvWJGlOycvMz6iLkunLt9pM0ffLh6b+kKCO5JL6ZOgn+d2+keG0T679XCAQ+H17
 MM9oL1498gpRgGs2PaFNIz+BrKGuOOFC3bCTfQRz3qE3y2iKqjugCON6kfeRwZI0lR0iq9gD+
 vCIwDVxFLv8+ZxR7B4GU3xLURkLS8FzuhAk0R3qZS3DytLm8uE7kInwqnn9VcVbRTu7SwNJhY
 lo8fKIUqOx8oEOo3xLuGIzLDmtv+2lhfs2HcTr2PYRRoAIYzFgDyPpTig+I+9aTbcxDf1n2vD
 R3QrVuZ3bZ9H0/zJ1PDY4faVUTRgdE//wPk3CM1ovyU8b3bBgRQn5E+PMGKO96Bn1TwOYJd2u
 S+nXRRerPEtdUn/Usp6HaSLB5KqO7uTohFAR0iYe3ODWd/ZrCVtqn0gP0Vz7a8e635AbNfhWI
 COn5ZOPWQbCPj5qZHYS2OG65Fz0AjGiFVER0b++atphAVDhT//o8XysrzAx9PZA9IsiAqsazj
 f8kSbES/W7s7/qhx1vOw70CKESyVb/ajxta94PgjEmTquBTHYTDJCO9v5GIFNIPt31j44oEva
 GNQHszznYev2EvGu2Y6LxD7uILljfyoYYTAdl7IAABiEOHLGGpa94cXbgp10XnK33ENrjzjHr
 4kUU6L8YyunFtnnCgXp2YM6+QQ5yuNmXF8H+ey4zHjgIho2HZ1qaIutN1K5kWnkF2UzgbYNfg
 r+iafU2qz/dYC13BGUs6FXmZ/zPWaqoiZwswewnvTsenmmTZydFuarTmwMVwJrgI1oiPW104I
 BTJVYXQIfImeViBHyNsJSX9V84aqHPUMgX63Zwi5/X1Ygmr0u65n30DJYM3ra2i4B7ZcqXMhN
 y/ofrCQun0e4CQ6H/QKfiWuSg2zY5OP9LEnFjGQxwtwLfU6somU/feuvBXT9raxuX/0/hhsLn
 c6iuPM0guKm8fmI8/4PkoQyZxTA=

When an ACPI netlink event is received by acpid, the ACPI device
class is passed as its first argument. But since the class string
is not initialized, an empty string is being passed:

	netlink:  PNP0C14:01 000000d0 00000000

Fix this by initializing the ACPI device class during probe.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Note: This patch is based on commit 3f399b5d7189 ("platform/x86: wmi: Use =
ACPI device name in netlink event")
=2D--
 drivers/platform/x86/wmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7ef1e82dc61c..b92425c30a50 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -32,6 +32,8 @@
 #include <linux/wmi.h>
 #include <linux/fs.h>

+#define ACPI_WMI_DEVICE_CLASS	"wmi"
+
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
 MODULE_LICENSE("GPL");
@@ -1202,7 +1204,7 @@ static int wmi_notify_device(struct device *dev, voi=
d *data)
 		wblock->handler(*event, wblock->handler_data);
 	}

-	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
+	acpi_bus_generate_netlink_event(acpi_device_class(wblock->acpi_device),
 					acpi_dev_name(wblock->acpi_device), *event, 0);

 	return -EBUSY;
@@ -1267,6 +1269,8 @@ static int acpi_wmi_probe(struct platform_device *de=
vice)
 		return -ENODEV;
 	}

+	strscpy(acpi_device_class(acpi_device), ACPI_WMI_DEVICE_CLASS, sizeof(ac=
pi_device_class));
+
 	wmi_bus_dev =3D device_create(&wmi_bus_class, &device->dev, MKDEV(0, 0),=
 NULL, "wmi_bus-%s",
 				    dev_name(&device->dev));
 	if (IS_ERR(wmi_bus_dev))
=2D-
2.39.2


