Return-Path: <linux-kernel+bounces-98059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A695877495
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060331F2148F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A005ED8;
	Sun, 10 Mar 2024 00:35:30 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE84363;
	Sun, 10 Mar 2024 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710030929; cv=none; b=Wh4kQ73KDcSsWvN9W0CoeJ3kXLx4aw06ehzh2Miif0qSj1kjF5zG8fW0zZod5GO7RTfZNMp+xrIIL3ZmqhlSkRdn4iLXlOiDNwH87rlbT0n54OGPsKjSKX0GqejEPsu/LwNcmimuwFJbKGN5cDSZswQ8LyfBqxJN0Q3mYxFW9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710030929; c=relaxed/simple;
	bh=R8H3zZJPNckJrtz5/OGfEZLLWrMhX0eGnI2pP3CqM/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJ0QcgB5WwTdw5OG/5r+VObLIL47H80cl+xA00S8JZxAnY8baUNAXAftEmHaegGhLMRrGa0WqhTGV5nSj+lvMnpywqFTduMkDypwAvfOg9EvbQA6D9BqXbbCNezRdyEruSohF2Ito+YlXUizZ4XbM5CnQDfpZrlVVZ4IX3hqklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rj79c-0010DC-1M;
	Sun, 10 Mar 2024 01:35:02 +0100
Date: Sun, 10 Mar 2024 01:34:39 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ying Sun <sunying@isrc.iscas.ac.cn>,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol
Message-ID: <20240310013439.44682105@barney>
In-Reply-To: <20240309224540.22682-1-rdunlap@infradead.org>
References: <20240309224540.22682-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Dtc7J8BxyXU=w1FDubeq5gF";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/Dtc7J8BxyXU=w1FDubeq5gF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  9 Mar 2024 14:45:38 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> -static inline void __cold __ssb_dma_not_implemented(struct ssb_device *d=
ev)
> -{
> -#ifdef CONFIG_SSB_DEBUG
> -	printk(KERN_ERR "SSB: BUG! Calling DMA API for "
> -	       "unsupported bustype %d\n", dev->bus->bustype);
> -#endif /* DEBUG */
> -}
> -
>  #ifdef CONFIG_SSB_PCIHOST
>  /* PCI-host wrapper driver */
>  extern int ssb_pcihost_register(struct pci_driver *driver);
> diff -- a/drivers/ssb/main.c b/drivers/ssb/main.c
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -1144,7 +1144,6 @@ u32 ssb_dma_translation(struct ssb_devic
>  				return SSB_PCI_DMA;
>  		}
>  	default:
> -		__ssb_dma_not_implemented(dev);
>  	}
>  	return 0;
>  }
>=20

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Dtc7J8BxyXU=w1FDubeq5gF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXtAB8ACgkQ9TK+HZCN
iw4CEg//bOyNLseIVp8eLWwHbi4yo4y0lQrRv9KAnc2XdIMv/GCYNCsqDv3dMMS+
+/SjGPBZyD6bVQEJNRrdMARP8KuDMXGnx2ZTukXqHuSFxIr7gR422UZqCV65FLwv
MvfMJIjOB+9WwtKkihz3UbsOocrVAZF4813mOK8fJgd/k0CXhvIpirNNMCT6X92a
Bqo5eeR06Vx1ycOrwabT+a+50AlLw6OAbTL1szjyXllPJMsQukJsC0uklkhS7vS7
DubOWY6RQz47Lqn9C/mAcnh3LsPpC1sjQ3EtlxxF3XaQ9+6MUZAl+sDUhlF2qi/k
ekY8mtUbzU3rZtcb3AT0R7N5B4I1YzftKxTvwBHYv8D/oKmNSV2Fr4oYGGAwGWMO
8DGJB9a1YAnk4pY/c9htJ1+yo3uXaC6F9yaUqOvWBskvWfeJ37VRkUOXStaI7E/q
7VW+O737Uz/bVodhZk2KDo2/Z0wZeLlmxmsOVd7LPAwiePzEVfGfTTHzRVS3yCQM
jyxwFv+FBhEBTLWKN2JxeSkqKnXrrwwTjNpSomo2INuPROjugZUiSq44xmPo0Cvo
u8qtvsihKIUM3AAot260FrfRgvzKXd59wn4GsaVyNLuUP7o6G8DlB/S7EfGBuf9l
iFkv5i2PdhIt4Sx1HgRKHFKkiYeUslPZKQC3OYkH6xEEHEC3/Ac=
=Bvs/
-----END PGP SIGNATURE-----

--Sig_/Dtc7J8BxyXU=w1FDubeq5gF--

