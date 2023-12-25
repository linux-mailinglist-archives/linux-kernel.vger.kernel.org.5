Return-Path: <linux-kernel+bounces-11157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7081E244
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D948A1C20E68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771ED5381A;
	Mon, 25 Dec 2023 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrman314.tech header.i=@mrman314.tech header.b="LM/63485"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.mrman314.tech (unknown [135.0.77.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E052F93;
	Mon, 25 Dec 2023 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mrman314.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mrman314.tech
Received: from [192.168.6.27] (unknown [160.32.192.137])
	by mx.mrman314.tech (Postfix) with ESMTPSA id BCBCB2F491D8;
	Mon, 25 Dec 2023 15:21:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrman314.tech;
	s=default; t=1703535665;
	bh=yauFSrZ35qZveVfrCHmJZPgq1pMyNFwrF76x3pw4ntY=;
	h=Subject:From:To:Cc:Date;
	b=LM/63485/ppUMvKkHXbaHXSgTFr9quhNmfd7vHAbg4xOme4Wh9TcLwcmgDbvTf4GX
	 wQEcfarwbaVXxnkLSJSY9yUMd2ES+sq9TPhsR4nDVi2LJAdqv1v1t0yz9JRRF+voBT
	 koRTiG+gA2kzJNVOFMLkbMge70mVv5s+si8NPtwU=
Message-ID: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
Subject: [PATCH v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
From: Felix Zhang <mrman@mrman314.tech>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org, marcan@marcan.st, bagasdotme@gmail.com, 
	sven@svenpeter.dev, alyssa@rosenzweig.io, marcel@holtmann.org, 
	johan.hedberg@gmail.com, luiz.dentz@gmail.com, orlandoch.dev@gmail.com, 
	kekrby@gmail.com, admin@kodeit.net, j@jannau.net, gargaditya08@live.com, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 25 Dec 2023 15:21:04 -0500
Autocrypt: addr=mrman@mrman314.tech; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Starting v6.5, Bluetooth does not work at all on my T2
MacBookAir9,1 with the BCM4377 chip.=C2=A0 When I boot up the computer,
go into bluetoothctl, and then try to run commands like scan on,
show, list, it=C2=A0returns "No default controller available."=C2=A0 I have
tried reloading the kernel module, in which the log outputs
"{Added,Removed} hci0 (unconfigured)."=C2=A0 With this patch, I
am able to use Bluetooth as normal without any errors regarding
hci0 being unconfigured.=C2=A0 However, an issue is still present
where sometimes hci_bcm4377 will have to be reloaded in order to
get bluetooth to work.=C2=A0 I believe this was still present before
the previously mentioned commit.

I would also like to thank Kerem Karabay <kekrby@gmail.com> for
assisting me with this patch.

Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
Cc: <stable@vger.kernel.org>
Signed-off-by: Felix Zhang <mrman@mrman314.tech>
---
v4:
* Adjust the format to pass the CI (again).
* Shorten description
---
=C2=A0drivers/bluetooth/hci_bcm4377.c | 6 +++++-
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c
b/drivers/bluetooth/hci_bcm4377.c
index a61757835695..5c6fef1aa0f6 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -513,6 +513,7 @@ struct bcm4377_hw {
=C2=A0	unsigned long broken_ext_scan : 1;
=C2=A0	unsigned long broken_mws_transport_config : 1;
=C2=A0	unsigned long broken_le_coded : 1;
+	unsigned long use_bdaddr_property : 1;
=C2=A0
=C2=A0	int (*send_calibration)(struct bcm4377_data *bcm4377);
=C2=A0	int (*send_ptb)(struct bcm4377_data *bcm4377,
@@ -2368,5 +2369,6 @@ static int bcm4377_probe(struct pci_dev *pdev,
const struct pci_device_id *id)
=C2=A0	hdev->set_bdaddr =3D bcm4377_hci_set_bdaddr;
=C2=A0	hdev->setup =3D bcm4377_hci_setup;
=C2=A0
-	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+	if (bcm4377->hw->use_bdaddr_property)
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
=C2=A0	if (bcm4377->hw->broken_mws_transport_config)
@@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
bcm4377_hw_variants[] =3D {
=C2=A0		.has_bar0_core2_window2 =3D true,
=C2=A0		.broken_mws_transport_config =3D true,
=C2=A0		.broken_le_coded =3D true,
+		.use_bdaddr_property =3D true,
=C2=A0		.send_calibration =3D bcm4378_send_calibration,
=C2=A0		.send_ptb =3D bcm4378_send_ptb,
=C2=A0	},
@@ -2479,6 +2482,7 @@ static const struct bcm4377_hw
bcm4377_hw_variants[] =3D {
=C2=A0		.clear_pciecfg_subsystem_ctrl_bit19 =3D true,
=C2=A0		.broken_mws_transport_config =3D true,
=C2=A0		.broken_le_coded =3D true,
+		.use_bdaddr_property =3D true,
=C2=A0		.send_calibration =3D bcm4387_send_calibration,
=C2=A0		.send_ptb =3D bcm4378_send_ptb,
=C2=A0	},
--=20
2.43.0


