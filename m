Return-Path: <linux-kernel+bounces-4287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659D817AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCE81F238DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184FE73460;
	Mon, 18 Dec 2023 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ALqNN6ZR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF595D759;
	Mon, 18 Dec 2023 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927473; x=1703532273; i=w_armin@gmx.de;
	bh=Gv/3KB2nhnzbj6OabYsWChzNP4Kil+PLOJoDKQOnE44=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ALqNN6ZRnYBgDRT2qDX2BbwuoOArHd6cG0fuUcFSDNTpS5LIgaRlfljTo9WxerPZ
	 2hrVNuvAGaOcWSftbJ4DgYK2e1n9fXveFi45AmsZmqMPBdYoNJOjadOrUt1otxOq+
	 w4fPna0+2n6MQNbAtZyWnMsd8GcXUq64eWJ4vD2yNdOCSsm/WIx3eZuNUTcRI6Dvv
	 hvxHdGhVqXmECWYi+IDI+eir9MD0bj7q6Fmtw+3rEpH4Ig2cmlrBENPJ36qV+3CC+
	 NFQM1BEhKI2l7xhWZIvb+1+TUNqLBXdVobtxcE45EOYOLQL/6Yn2mYKCLIJdxyU4R
	 OotIGQ8sD7ZojqEzVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVeI2-1rguDl01ky-00RX9o; Mon, 18 Dec 2023 20:24:33 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] platform/x86: wmi: Remove ACPI handlers after WMI devices
Date: Mon, 18 Dec 2023 20:24:16 +0100
Message-Id: <20231218192420.305411-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218192420.305411-1-W_Armin@gmx.de>
References: <20231218192420.305411-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NZriEJ2nLTo8Nrgwf8erNwXAao9Mznfw8e8S0oazGGnoMW/cz8o
 70FHjtoWTvmbyq2FpODihG+LaB5dua/msT0nxOemY3rZKAMA3lEnTCbwcQq3cuCNgMAAoca
 tuonWxu8Glu5FqBgNeEvVef/xam9J53lymnWX8PaJoIiVEhtXmnvvCkmgxV5dac67J1Yu+o
 jiKYcT8C7KU16iItduetg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:apKLZAJ+RBk=;brH1j7rxmEpyoEn06tIqzwDUTTE
 34/MWNODS5IRGY7ah3lbdEvKJtdQzuB0MQX/pj9IzN21z5e6aUbF17a8/vKBlPsYfb+vlwM9g
 Dfd8ySGgVYUjPMA8GAafSDDHb2RTqr24lO3Gl91quaSP8VtXhaRSrK8bn8fVcb8tCfzz/LcHx
 B/SC3XZE2Xm5ukr40+E5Q3vdlHo3qfFMsWVvQ9MAptvzhyzbSDgJyUoVjncJOBvNR6kBdBkTr
 jgCE1u6tntf0HTPpswAYyJ+6jcgf6a8IEKFJgjNlHu7F1oQES9s9xGxxcb19veo+RP+nOkt1p
 d3iBT7KYErEvUmLYZaApVAJSmA315LUtJsdTJE+jPsrviMuMt6tN7r7heJ0thVJw+Yd6qIxen
 APti9fK6RQfnnwQQaDKCVp72CbBziNVNBmjBei/hF78mQn1siq0vWy02cuBtjB41RU3WCXecT
 dRHxvdXedBsT67v/reBMOVjOLUxR23JZGZOV6VEkriaxwhvBZwNTPrUEymEkFpU5Hsxwyecyx
 zGKu8hWa7rzV6ZBYBi7410Jh+FK3cpevo2jXb20d17fZdDwBVhjHRPZdfdxhOvuBiIw7K0l3d
 nMM0GPXElLTvA/yc1kUwaNXhqyCG74Jk2o270GGUIAT0IyuCNJI5msRX3YOCAG1tWR56m2GJx
 N30+tu1XE+lvHJrGnPlQlFgDTe57JBYkWerFGeqrP9RHoSDD3PX+hK6EVciqtdMG/OLsXSiGg
 dEMm1kjdcMk/WW45vkZU50qzEnx2aeht9GxKBwh8KWROnaL7HQHiogbM+zvfzYuObIVNoOV4i
 qUo3QATwC74qn+GXvB7qssCc0gsuLJfAgF1ca4IcLbgErrLrOri7ABt0ayTxpJwrW1RxPtlWN
 nPm5ScaTGSOQWe04GrynFBHMg/icnm7nIqgAVA27cnilZkJOW7QlwW6ikYeSd4On4kYRvp+Ga
 TZqi3w==

When removing the ACPI notify/address space handlers, the WMI devices
are still active and might still depend on ACPI EC access or
WMI events.
Fix this by removing the ACPI handlers after all WMI devices
associated with an ACPI device have been removed.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 906d3a2831ae..2120c13e1676 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1239,13 +1239,12 @@ static void acpi_wmi_remove(struct platform_device=
 *device)
 	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
 	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);

-	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
-				   acpi_wmi_notify_handler);
-	acpi_remove_address_space_handler(acpi_device->handle,
-				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-
 	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
 	device_unregister(wmi_bus_device);
+
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wm=
i_notify_handler);
+	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC=
,
+					  &acpi_wmi_ec_space_handler);
 }

 static int acpi_wmi_probe(struct platform_device *device)
=2D-
2.39.2


