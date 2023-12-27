Return-Path: <linux-kernel+bounces-12192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E643281F123
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15FF28210D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB7A46B8E;
	Wed, 27 Dec 2023 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrman314.tech header.i=@mrman314.tech header.b="p6fZmmjC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.mrman314.tech (unknown [135.0.77.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE246540;
	Wed, 27 Dec 2023 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mrman314.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mrman314.tech
Received: from [192.168.6.27] (unknown [160.32.192.137])
	by mx.mrman314.tech (Postfix) with ESMTPSA id 932FA2F495C8;
	Wed, 27 Dec 2023 13:19:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrman314.tech;
	s=default; t=1703701181;
	bh=fZGcy7BZG167S+RHVKq7QB3BPpO7PaALkaYFRUu07bM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=p6fZmmjC343uIjMBvq+O6NtS88LEuhi9sIZ+7gsu9i7kfsRI1zp4ilC3pK80XuAuM
	 67ZWDoCT+93cH3pOygIx/O8iF1rVzhLzb5hNI3PGHXkfm33sn3yuVB20VlFyXJiLsF
	 XiBXJAQN5iG2gPCuJAbpO/G2nRygDNL3oMKqjwjU=
Message-ID: <f06dbc4d10ff5eb038228e9c7abb75c85514cf36.camel@mrman314.tech>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: do not mark valid bd_addr as
 invalid
From: Felix Zhang <mrman@mrman314.tech>
To: Johan Hovold <johan+linaro@kernel.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg <johan.hedberg@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,  linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Wed, 27 Dec 2023 13:19:39 -0500
In-Reply-To: <20231227101003.10534-1-johan+linaro@kernel.org>
References: <20231227101003.10534-1-johan+linaro@kernel.org>
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

On Wed, 2023-12-27 at 11:10 +0100, Johan Hovold wrote:
> A recent commit restored the original (and still documented)
> semantics
> for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device
> address
> is considered invalid unless an address is provided by firmware.
>=20
> This specifically means that this flag must only be set for devices
> with
> invalid addresses, but the Broadcom BCM4377 driver has so far been
> setting this flag unconditionally.
>=20
> Fortunately the driver already checks for invalid addresses during
> setup
> and sets the HCI_QUIRK_INVALID_BDADDR flag, which can simply be
> replaced
> with HCI_QUIRK_USE_BDADDR_PROPERTY to indicate that the default
> address
> is invalid but can be overridden by firmware (long term, this should
> probably just always be allowed).
>=20
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: stable@vger.kernel.org=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 6.5
> Reported-by: Felix Zhang <mrman@mrman314.tech>
> Link:
> https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.camel@=
mrman314.tech/
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> =C2=A0drivers/bluetooth/hci_bcm4377.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_bcm4377.c
> b/drivers/bluetooth/hci_bcm4377.c
> index a61757835695..9a7243d5db71 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -1417,7 +1417,7 @@ static int bcm4377_check_bdaddr(struct
> bcm4377_data *bcm4377)
> =C2=A0
> =C2=A0	bda =3D (struct hci_rp_read_bd_addr *)skb->data;
> =C2=A0	if (!bcm4377_is_valid_bdaddr(bcm4377, &bda->bdaddr))
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &bcm4377->hdev-
> >quirks);
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &bcm4377-
> >hdev->quirks);
> =C2=A0
> =C2=A0	kfree_skb(skb);
> =C2=A0	return 0;
> @@ -2368,7 +2368,6 @@ static int bcm4377_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
> =C2=A0	hdev->set_bdaddr =3D bcm4377_hci_set_bdaddr;
> =C2=A0	hdev->setup =3D bcm4377_hci_setup;
> =C2=A0
> -	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> =C2=A0	if (bcm4377->hw->broken_mws_transport_config)
> =C2=A0		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG,
> &hdev->quirks);
> =C2=A0	if (bcm4377->hw->broken_ext_scan)
Hi,

Thanks for the patch!  I have just tested the patch on my MacBookAir9,1
with some modifications to make it patch with the master branch of the
Linux kernel, and it works great!  The device is recognized by the
system; and I can scan, pair, connect, and play audio just fine.  If
you want me to send over the modified patch that I have used, please
let me know.

Thanks!

