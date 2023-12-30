Return-Path: <linux-kernel+bounces-13444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 165238206AD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07291F21947
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAB8F59;
	Sat, 30 Dec 2023 14:10:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3508BED;
	Sat, 30 Dec 2023 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJZVD-000B92-1i;
	Sat, 30 Dec 2023 14:35:46 +0100
Date: Sat, 30 Dec 2023 14:34:55 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 1/5] wifi: b43: Correct OpenFW QoS capability
 warning conditional
Message-ID: <20231230143455.4d64ffc7@barney>
In-Reply-To: <20231230045105.91351-2-sergeantsagara@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
	<20231230045105.91351-2-sergeantsagara@protonmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DPVM1GyukumrzwBTrXX/GYf";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/DPVM1GyukumrzwBTrXX/GYf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 04:51:29 +0000
Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:

> Trigger the warning message should be when the OpenFW capability for QoS
> does not advertise QoS support. Previously, the warning would be
> incorrectly triggered when OpenFW reported QoS capability is present.

> --- a/drivers/net/wireless/broadcom/b43/main.c
> +++ b/drivers/net/wireless/broadcom/b43/main.c
> @@ -2713,7 +2713,7 @@ static int b43_upload_microcode(struct b43_wldev *d=
ev)
>  			dev->hwcrypto_enabled =3D false;
>  		}
>  		/* adding QoS support should use an offline discovery mechanism */
> -		WARN(fwcapa & B43_FWCAPA_QOS, "QoS in OpenFW not supported\n");
> +		WARN(!(fwcapa & B43_FWCAPA_QOS), "QoS in OpenFW not supported\n");
>  	} else {
>  		b43info(dev->wl, "Loading firmware version %u.%u "
>  			"(20%.2i-%.2i-%.2i %.2i:%.2i:%.2i)\n",

I don't think this patch is correct.
It should warn, if the firmware advertises QoS, because that is not
supported by b43 in case of OpenFW.


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/DPVM1GyukumrzwBTrXX/GYf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWQHH8ACgkQ9TK+HZCN
iw76ZxAAurASq9nsjCyeOlHYgd0pN/3LqmEX3OSxwMsOry8MP3yjmQk5xRT/mfSL
SeU4V6KqkvH3tBpHRkHhua8X3TkDRqKv2e0YvjOOAUpPm5U0qlWzdZhHQNyypum4
uAYLTUHL325m5k91mlnmC70wRrKn/GLrCewOCTdJa1g5+TUIq6Xx1J266GK2nmRl
1DTIsBoz8R9wLE5vk3UiIS3WFudddofd2A+Fwpqe601sX5CNKBlL2Leis0oZcLBR
xZ+H1f07AslPR9BR47wyohMdPXOGpyo1HloG6IeCgqp1l149mQVLlvNuw20uRGjN
JGe37rp22nc8n8qudMIobZT8+IeW2/8JRYBSeQ3eft+43c5pySkQcMEOPRhb4mLH
1CC3BYeeGoe40eCiJOVrdf1jGLtRsv8wCYUCsZ/T8jAHziKZ1dObyxTG/10JBtDi
2JuiWSHxsEFaKkbjbq5B0nsorb29YpuEQya7IYyHy7dixtP3mMdB3F4g//qHZb1S
i9YgtI0mcUaSE/0ahR4pRnbScyJV54uJfa+L9xHRTEpbp3y8toeVWcRncAOoPTQ+
x7pcqkOVQESjYfqmUfmab1zo/roXw9yN226THi5aQEv3S+uU7OpZffLOI5YkDV/a
TyOZKf75WIzDkUydwVPEqf+3J54T8tdYMZKaan4mMeF0VlA/bro=
=mRQS
-----END PGP SIGNATURE-----

--Sig_/DPVM1GyukumrzwBTrXX/GYf--

