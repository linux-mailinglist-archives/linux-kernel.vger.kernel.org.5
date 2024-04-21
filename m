Return-Path: <linux-kernel+bounces-152522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910058ABFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170801F21049
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A391BC53;
	Sun, 21 Apr 2024 15:49:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175018044;
	Sun, 21 Apr 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713714584; cv=none; b=IRu5o0XoGtzmgrKu8BUQSReyqB0anqLjvzO9tu09yLEkdaJaS32cb2uJoRnmgFneajDqiFGhRhXXm1v494/AWcE0XMccCWnrV+aAMinsbvMMa5IOJPLJevTSz0gVO3pytM6FjBQjCLsCIk/1N9ZpzyeVGpAi4OPRoW17AR5be24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713714584; c=relaxed/simple;
	bh=24WFs+X3sJEnTrjtAmAB0Gs4PLr+xIJa+qZJSCUe6Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHHEA1+qv0nbnmHvWEcsUxgtR66Z4AcR0XcvB9MPqUWHAr966nI9zv0mqyiDTGP27UTBuo1WDMXLqk18zcrh8ahx2jOdYFBa6I8m/QKw9afNQrRJxMlBuS5R91TLlX4eTRfHS/8g2zhCT4bBTvKoPIPvOXoty74VqDPhTDtvF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,218,1708354800"; 
   d="asc'?scan'208";a="202133613"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Apr 2024 00:49:34 +0900
Received: from [10.226.92.17] (unknown [10.226.92.17])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3D8854001960;
	Mon, 22 Apr 2024 00:49:30 +0900 (JST)
Message-ID: <bcddc226-7cbf-4994-94fe-eb70331f2bfa@bp.renesas.com>
Date: Sun, 21 Apr 2024 16:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC v3 4/7] net: ravb: Refactor GbEth RX code path
To: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-5-paul.barker.ct@bp.renesas.com>
 <897c3e16-7ded-bdea-08c7-14bf497bfc05@omp.ru>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <897c3e16-7ded-bdea-08c7-14bf497bfc05@omp.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xg9Mcdri72G3bjA0s0wRnWGN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xg9Mcdri72G3bjA0s0wRnWGN
Content-Type: multipart/mixed; boundary="------------CLwMRD7GafHdis9yIYWe50yh";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <bcddc226-7cbf-4994-94fe-eb70331f2bfa@bp.renesas.com>
Subject: Re: [net-next RFC v3 4/7] net: ravb: Refactor GbEth RX code path
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-5-paul.barker.ct@bp.renesas.com>
 <897c3e16-7ded-bdea-08c7-14bf497bfc05@omp.ru>
In-Reply-To: <897c3e16-7ded-bdea-08c7-14bf497bfc05@omp.ru>

--------------CLwMRD7GafHdis9yIYWe50yh
Content-Type: multipart/mixed; boundary="------------jUX5ulVGtLBX1k006EERRKd4"

--------------jUX5ulVGtLBX1k006EERRKd4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19/04/2024 21:03, Sergey Shtylyov wrote:
> On 4/15/24 12:48 PM, Paul Barker wrote:
>=20
>> We can reduce code duplication in ravb_rx_gbeth() and add comments to
>> make the code flow easier to understand.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 70 ++++++++++++-----------=
-
>>  1 file changed, 35 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index baa01bd81f2d..12618171f6d5 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -818,47 +818,47 @@ static int ravb_rx_gbeth(struct net_device *ndev=
, int budget, int q)
>>  				stats->rx_missed_errors++;
>>  		} else {
>>  			die_dt =3D desc->die_dt & 0xF0;
>> -			switch (die_dt) {
>> -			case DT_FSINGLE:
>> -				skb =3D ravb_get_skb_gbeth(ndev, entry, desc);
>> +			skb =3D ravb_get_skb_gbeth(ndev, entry, desc);
>> +			if (die_dt =3D=3D DT_FSINGLE || die_dt =3D=3D DT_FSTART) {
>=20
>    No, please keep using *switch* statement here...

That's a shame - I much prefer this version with reduced code
duplication, especially when we add page pool support. Duplication with
subtle differences leads to bugs, see [1] for an example.

[1]: https://lore.kernel.org/all/20240416120254.2620-4-paul.barker.ct@bp.=
renesas.com/

An alternative would be to drop this refactor patch, then when we add
page pool support we instead use separate functions to avoid code
duplication. At the end of the series, the switch would then look
something like this:

	switch (die_dt) {
	case DT_FSINGLE:
		skb =3D ravb_rx_build_skb(ndev, q, rx_buff, desc_len);
		if (!skb)
			break;
		ravb_rx_finish_skb(ndev, q, skb);
		rx_packets++;
		break;
	case DT_FSTART:
		priv->rx_1st_skb =3D ravb_rx_build_skb(ndev, q, rx_buff, desc_len);
		break;
	case DT_FMID:
		ravb_rx_add_frag(ndev, q, rx_buff, desc_len);
		break;
	case DT_FEND:
		if (ravb_rx_add_frag(ndev, q, rx_buff, desc_len))
			break;
		ravb_rx_finish_skb(ndev, q, priv->rx_1st_skb);
		rx_packets++;
		priv->rx_1st_skb =3D NULL;
	}

Would you prefer that approach?

>=20
>> +				/* Start of packet:
>> +				 * Set initial data length.
>> +				 */
>>  				skb_put(skb, desc_len);
>> +
>> +				/* Save this SKB if the packet spans multiple
>> +				 * descriptors.
>> +				 */
>> +				if (die_dt =3D=3D DT_FSTART)
>> +					priv->rx_1st_skb =3D skb;
>=20
>    Hm, looks like we can do that under *case* DT_FSTART: and do
> a fallthru to *case* DT_FSINGLE: after that...

A fallthrough would just have to be removed again when page pool support
is added in a later patch in this series, since we will need to call
napi_build_skb() before the skb is valid.

>=20
>> +			} else {
>> +				/* Continuing a packet:
>> +				 * Move data into the saved SKB.
>> +				 */
>> +				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
>> +							       priv->rx_1st_skb->len,
>> +							       skb->data,
>> +							       desc_len);
>> +				skb_put(priv->rx_1st_skb, desc_len);
>> +				dev_kfree_skb(skb);
>> +
>> +				/* Set skb to point at the whole packet so that
>> +				 * we only need one code path for finishing a
>> +				 * packet.
>> +				 */
>> +				skb =3D priv->rx_1st_skb;
>> +			}
>> +
>> +			if (die_dt =3D=3D DT_FSINGLE || die_dt =3D=3D DT_FEND) {
>=20
>    Again, keep using *switch*, please...
>=20
>> +				/* Finishing a packet:
>> +				 * Determine protocol & checksum, hand off to
>> +				 * NAPI and update our stats.
>> +				 */
>>  				skb->protocol =3D eth_type_trans(skb, ndev);
>>  				if (ndev->features & NETIF_F_RXCSUM)
>>  					ravb_rx_csum_gbeth(skb);
>> +				stats->rx_bytes +=3D skb->len;
>>  				napi_gro_receive(&priv->napi[q], skb);
>>  				rx_packets++;
> [...]
>=20
> MBR, Sergey

Thanks,

--=20
Paul Barker
--------------jUX5ulVGtLBX1k006EERRKd4
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------jUX5ulVGtLBX1k006EERRKd4--

--------------CLwMRD7GafHdis9yIYWe50yh--

--------------xg9Mcdri72G3bjA0s0wRnWGN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZiU1iQUDAAAAAAAKCRDbaV4Vf/JGvTlw
AQDnB3KfNdwO0lfg0Wjfr8CyCnsYeU29PwI2i+uC1EkArQD/cd8yye5Erq8Vg9UrCX5yeI0lKjWo
JeOmFYWWE+73jQ8=
=sNrl
-----END PGP SIGNATURE-----

--------------xg9Mcdri72G3bjA0s0wRnWGN--

