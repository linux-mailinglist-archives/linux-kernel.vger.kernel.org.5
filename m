Return-Path: <linux-kernel+bounces-13436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C771D820698
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F32281FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC132B671;
	Sat, 30 Dec 2023 13:46:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE772B642;
	Sat, 30 Dec 2023 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJZf2-000BJJ-0F;
	Sat, 30 Dec 2023 14:45:55 +0100
Date: Sat, 30 Dec 2023 14:45:23 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 5/5] wifi: b43: Support advertising lack of QoS
 capability
Message-ID: <20231230144523.7df01ff5@barney>
In-Reply-To: <20231230045105.91351-6-sergeantsagara@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
	<20231230045105.91351-6-sergeantsagara@protonmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T.bvxtOYGsFs/DdDLs.JbJn";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/T.bvxtOYGsFs/DdDLs.JbJn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 04:51:51 +0000
Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:

> bcm4331 appears to lack QoS support.

I think that's rather unlikely.
The firmware probably is just too old for this device.

> +static const u16 b43_no_qos_chip_ids[] =3D {
> +	BCMA_CHIP_ID_BCM4331,
> +	0,
> +};
> +
> +static bool b43_qos_not_supported(struct b43_wldev *dev)
> +{
> +	int idx;
> +
> +	for (idx =3D 0; b43_no_qos_chip_ids[idx]; idx++)
> +		if (dev->dev->chip_id =3D=3D b43_no_qos_chip_ids[idx])
> +			return true;
> +
> +	return false;
> +}
> +
>  static void b43_wireless_core_exit(struct b43_wldev *dev);
>  static int b43_wireless_core_init(struct b43_wldev *dev);
>  static struct b43_wldev * b43_wireless_core_stop(struct b43_wldev *dev);
> @@ -2587,7 +2603,7 @@ static void b43_request_firmware(struct work_struct=
 *work)
> =20
>  start_ieee80211:
>  	wl->hw->queues =3D B43_QOS_QUEUE_NUM;
> -	if (!modparam_qos || dev->fw.opensource)
> +	if (!modparam_qos || dev->fw.opensource || b43_qos_not_supported(wl->cu=
rrent_dev))

This looks a bit over-engineered to me.
Can we just instead do it like this, please?

	if (!modparam_qos || dev->fw.opensource || dev->dev->chip_id =3D=3D BCMA_C=
HIP_ID_BCM4331)

>  		wl->hw->queues =3D 1;
> =20
>  	err =3D ieee80211_register_hw(wl->hw);





--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/T.bvxtOYGsFs/DdDLs.JbJn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWQHvMACgkQ9TK+HZCN
iw7KyA//RGQAAGvzcl7lHIw3Q1W8KypUU6+E78hwrtWSmRIje8kjNCUAcdrnNCti
otWZV6CJrCEL0iay0cFAoym7vfaca3qFTqUtZ47OqvnhuIk2KuW93/LBNC2i04tY
Duo5FXAGkiZob7ARyDX77QQmfWxWFwZXF3L/tgovhVyzT8PQFAPfqCAUuCT4C/8Q
7pQ+/nInlvvCCE8qyAecBZKUoRCZUrgr+sP54zqAwsIiWsbCCIgxrL28YiaLMhei
1+W0LdyZFvPMr+wIHkD5ZdF5SKGuUq9vBQiMNbtXcF3zQcKOpVm/xBRXxuFLHnwV
xB01PO2CNf4sTy6pA5yIMaKpeOk05WokKkj2vCQWFT8XzS4YkQJD350zEVOIkWa0
vYNaxilDzTb3yaSZPk28klMRvL1mKlBlktaANVEReV+jCKd9gg1xQda2B5IDBKby
rI9YAURrwcc7awcoFC7Gy0+8SYmhXuWiiLn+rocGz3fEaUzjtA1Lihk4yo/RtS3z
3k5wAaBmsj8/arV2NnVxbL/Sh7Wd9Gxmt0ofaDvIzv62LOymPJJC0fjIgP+ANX5i
nfsiPA2LrzzkT7R4+KK9Hb7xq1Wn5gACvngPc27M92LkbhiJxmJR7m5OdBWG2suY
f9JyXTTDZhooqhTirb78Ctf7vR0OLt5xcethqpATESD6qQwOmbY=
=cBPA
-----END PGP SIGNATURE-----

--Sig_/T.bvxtOYGsFs/DdDLs.JbJn--

